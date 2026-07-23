#import "@preview/mousse-notes:1.1.0": *
= 20.2 -- Transformação entre Sistemas de Coordenadas 2D e Recorte

== Introdução

Depois de definir e transformar objetos no espaço do mundo, é preciso mapear
essa cena para a tela (dispositivo de saída) e descartar o que fica fora da
área visível. Esses dois problemas -- mapeamento janela-viewport e recorte
("clipping") -- costumam aparecer juntos na POSCOMP, geralmente como questões
conceituais sobre os algoritmos de recorte de retas e polígonos.

== Janela e viewport

#definition(id: "def-janela-viewport")[
  A *janela* ("window") é uma região retangular do sistema de coordenadas do
  mundo (world coordinates) que delimita o que será exibido. O *viewport* é a
  região retangular correspondente no dispositivo de saída (coordenadas de
  tela/normalizadas) onde a janela será desenhada.
]

#theorem(id: "thm-mapeamento-janela-viewport")[
  Um ponto $(x_w, y_w)$ dentro da janela $[x_(w m i n), x_(w m a x)] times
  [y_(w m i n), y_(w m a x)]$ é mapeado ao ponto correspondente
  $(x_v, y_v)$ do viewport $[x_(v m i n), x_(v m a x)] times [y_(v m i n),
  y_(v m a x)]$ pela composição
  $ M = T(x_(v m i n), y_(v m i n)) space S(s_x, s_y) space
      T(-x_(w m i n), -y_(w m i n)), $
  em que os fatores de escala são
  $ s_x = (x_(v m a x) - x_(v m i n)) / (x_(w m a x) - x_(w m i n)), quad
    s_y = (y_(v m a x) - y_(v m i n)) / (y_(w m a x) - y_(w m i n)). $
]

#remark[
  Se $s_x != s_y$, objetos circulares na janela aparecem elípticos no
  viewport -- distorção de aspecto. Manter a proporção da janela igual à do
  viewport (mesmo *aspect ratio*) evita esse problema; é um ponto clássico de
  pegadinha conceitual em prova.
]

#example(id: "ex-janela-viewport-numerico")[
  Uma janela $[0,10] times [0,10]$ deve ser mapeada para um viewport
  $[0,400] times [0,300]$ (uma tela $400 times 300$). Calcule as coordenadas de
  tela do ponto $(5,5)$.
]

#solution[
  $ s_x = 400/10 = 40, quad s_y = 300/10 = 30. $
  Como $x_(w m i n) = y_(w m i n) = 0$ e $x_(v m i n) = y_(v m i n) = 0$, a
  transformação se reduz à escala:
  $ x_v = 5 dot 40 = 200, quad y_v = 5 dot 30 = 150. $
  O ponto $(5,5)$ mapeia para $(200,150)$ -- note que $s_x != s_y$, então a
  janela quadrada vira um viewport retangular (distorção de aspecto).
]

== Recorte de retas: algoritmo de Cohen-Sutherland

#definition(id: "def-outcode")[
  O algoritmo de *Cohen-Sutherland* associa a cada ponto um *código de região*
  (outcode) de 4 bits, um para cada lado do retângulo de recorte (topo,
  base, direita, esquerda), indicando se o ponto está além daquele lado:

  #figure(
    tablef(
      columns: 5,
      [Bit], [Topo], [Base], [Direita], [Esquerda],
      table.hline(),
      [posição], [$y > y_(m a x)$], [$y < y_(m i n)$], [$x > x_(m a x)$], [$x < x_(m i n)$],
    ),
    caption: [Bits do outcode de Cohen-Sutherland.],
  )
  O código $0000$ indica ponto dentro da janela.
]

#theorem(id: "thm-cohen-sutherland")[
  Dada uma reta com extremos de outcodes $c_1$ e $c_2$:
  - se $c_1 = c_2 = 0000$ (aceitação trivial), a reta inteira está dentro e é
    desenhada sem modificação;
  - se $c_1 "AND" c_2 != 0000$ (bitwise AND, rejeição trivial), os dois pontos
    estão do mesmo lado externo, e a reta inteira está fora;
  - caso contrário, um dos pontos externos é substituído pela interseção da
    reta com a borda correspondente, e o teste é repetido.
]

#remark[
  A rejeição trivial exige o *AND* bit a bit, não a soma dos códigos -- um erro
  comum é acreditar que "ambos diferentes de zero" já basta para rejeitar,
  mas dois pontos podem estar fora por lados opostos (ex.: um à esquerda, outro
  à direita) e a reta ainda cruzar a janela.
]

== Recorte de polígonos: algoritmo de Sutherland-Hodgman

#definition(id: "def-sutherland-hodgman")[
  O algoritmo de *Sutherland-Hodgman* recorta um polígono contra uma janela
  convexa processando a lista de vértices *uma aresta do polígono de recorte
  por vez*: para cada aresta da janela, percorre-se o polígono de entrada e
  geram-se vértices de saída segundo quatro casos (para cada aresta do
  polígono sendo recortado, com vértices $p_1 -> p_2$):
  + se $p_1$ e $p_2$ estão dentro: emite $p_2$;
  + se $p_1$ dentro e $p_2$ fora: emite o ponto de interseção;
  + se $p_1$ fora e $p_2$ dentro: emite interseção e depois $p_2$;
  + se ambos fora: não emite nada.
]

#remark[
  Diferente do Cohen-Sutherland (que recorta retas isoladas), Sutherland-Hodgman
  recorta o *polígono inteiro contra cada borda da janela em sequência*,
  reaproveitando a saída de uma borda como entrada da próxima. O algoritmo só é
  garantidamente correto para janelas de recorte *convexas*.
]

#example(id: "q-clipping-1")[
  (Múltipla escolha) Qual das afirmações sobre os algoritmos clássicos de
  recorte 2D é *correta*?
  + Cohen-Sutherland recorta polígonos; Sutherland-Hodgman recorta retas.
  + Sutherland-Hodgman processa o polígono de entrada uma vez para cada aresta
    da janela de recorte, produzindo uma lista intermediária de vértices.
  + O outcode de Cohen-Sutherland usa 8 bits, dois para cada lado da janela.
  + A rejeição trivial em Cohen-Sutherland ocorre quando a soma dos outcodes é
    diferente de zero.
]

#solution[
  Resposta: alternativa *(2)*. As demais invertem os algoritmos, erram o número
  de bits (são 4, um por lado) ou trocam o AND bit a bit pela soma.
]

== Referências

- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Cap. sobre
  recorte 2D (Cohen-Sutherland, Sutherland-Hodgman).
- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Cap. sobre
  mapeamento janela-viewport e recorte.
- cienciadacomputacao.wiki.br -- Tópico 20.2.
