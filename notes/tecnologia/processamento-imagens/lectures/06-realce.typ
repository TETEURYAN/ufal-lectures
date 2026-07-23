#import "@preview/mousse-notes:1.1.0": *
= 23.6 -- Realce

== Introdução

*Realce* (enhancement) reúne técnicas que melhoram a aparência de uma
imagem para um observador ou tarefa específica -- sem um critério objetivo
único de "correto", ao contrário da *restauração* (23.7), que busca
reverter uma degradação conhecida. O realce pode atuar no *domínio
espacial* (transformando diretamente os valores de pixel) ou no *domínio da
frequência* (filtrando o espectro obtido via DFT, 23.5); dentro do domínio
espacial, distingue-se ainda entre operações *pontuais* (por pixel,
independentes da vizinhança) e *espaciais/de vizinhança* (dependem dos
pixels ao redor).

== Transformações de intensidade pontuais

#definition(id: "def-transformacao-pontual")[
  Uma *transformação de intensidade pontual* é uma função $s = T(r)$ que
  mapeia cada valor de entrada $r$ para uma saída $s$, aplicada
  independentemente a cada pixel (não usa vizinhança).
]

#definition(id: "def-negativo")[
  O *negativo* de uma imagem com níveis em $[0, L-1]$ é
  $ s = (L-1) - r. $
]

#definition(id: "def-transformacao-log")[
  A *transformação logarítmica* é
  $ s = c dot log(1+r), $
  com $c$ constante de normalização. Ela *expande* a faixa de valores
  baixos de intensidade e *comprime* a faixa de valores altos -- útil para
  realçar detalhes em regiões escuras de imagens com grande faixa dinâmica
  (ex.: espectros de Fourier, cuja componente DC domina a escala).
]

#definition(id: "def-transformacao-potencia")[
  A *transformação de potência* (correção gama) é
  $ s = c dot r^gamma. $
  Para $gamma < 1$, expande tons escuros e comprime tons claros (efeito
  semelhante ao log); para $gamma > 1$, o efeito é o oposto -- comprime tons
  escuros e expande tons claros.
]

#remark[
  *Correção gama de monitores*: dispositivos de exibição historicamente têm
  resposta não linear ($"saída" prop "entrada"^gamma$, com $gamma approx 2.2$
  em CRTs); por isso imagens são pré-corrigidas com $gamma' = 1\/2.2$ antes
  de serem exibidas, para que a percepção final seja aproximadamente linear.
  É um erro comum confundir a direção da correção (compensar o gama do
  monitor exige o gama *inverso* na imagem).
]

#definition(id: "def-alargamento-contraste")[
  *Alargamento de contraste* (contrast stretching) é uma transformação
  linear por partes que expande a faixa dinâmica de uma imagem de baixo
  contraste, mapeando o intervalo de intensidades efetivamente usado
  $[r_min, r_max]$ para toda a faixa $[0, L-1]$.
]

== Processamento de histograma

#definition(id: "def-histograma")[
  O *histograma* de uma imagem digital com níveis $r_k$, $k=0,dots,L-1$, é
  a função $h(r_k) = n_k$, em que $n_k$ é o número de pixels com
  intensidade $r_k$. O histograma *normalizado* $p(r_k) = n_k \/ (M N)$
  estima a probabilidade de ocorrência de cada nível.
]

#theorem(id: "thm-equalizacao-histograma", name: "Equalização de Histograma")[
  A transformação
  $ s_k = (L-1) sum_(j=0)^(k) p(r_j) $
  (a *função de distribuição acumulada* do histograma, escalada) produz uma
  imagem cujo histograma tende a se aproximar de uma distribuição uniforme,
  redistribuindo o contraste para as regiões de intensidade mais frequentes
  na imagem original.
]

#remark[
  Equalização de histograma é *automática* e *global* -- não permite
  controlar o formato final desejado. Quando se quer um histograma-alvo
  específico (não necessariamente uniforme), usa-se *especificação de
  histograma* (histogram matching): equaliza-se a imagem original e a
  distribuição-alvo, e compõe-se a equalização da entrada com a inversa da
  equalização do alvo.
]

== Realce espacial: filtros de nitidez

#definition(id: "def-laplaciano")[
  O *laplaciano* discreto, usado para detectar regiões de variação abrupta
  de intensidade (bordas e detalhes finos), é aproximado pela máscara
  $ nabla^2 f approx mat(0,1,0; 1,-4,1; 0,1,0) * f. $
]

#definition(id: "def-unsharp-masking")[
  *Unsharp masking* realça bordas subtraindo uma versão borrada da imagem da
  imagem original, amplificando o resultado:
  $ f_"realçada" (x,y) = f(x,y) + k [f(x,y) - overline(f)(x,y)], $
  em que $overline(f)$ é uma versão suavizada (ex.: filtro de média) de
  $f$ e $k>0$ controla a intensidade do realce ($k=1$: unsharp masking
  clássico; $k>1$: *high-boost filtering*).
]

#remark[
  O laplaciano realça bordas em *todas* as direções simultaneamente (é
  isotrópico), mas é muito sensível a ruído -- por isso raramente é usado
  puro; costuma-se somar a imagem original ao laplaciano ($g = f - nabla^2 f$,
  com sinal que depende da máscara usada) para realçar bordas preservando o
  fundo, em vez de exibir só as bordas.
]

== Realce no domínio da frequência

#remark[
  Todo realce espacial de nitidez tem um análogo no domínio da frequência
  (@thm-convolucao-frequencia, tópico 23.5): realçar bordas equivale a
  aplicar um filtro *passa-alta* (atenua $F(u,v)$ perto da origem, preserva
  frequências altas); suavizar equivale a um filtro *passa-baixa* (o
  inverso). Os três filtros passa-baixa/passa-alta clássicos diferem na
  transição entre as faixas mantida e atenuada:
  - *Ideal*: corte abrupto em um raio $D_0$ -- introduz um artefato de
    "ringing" (oscilações) na imagem, por sua descontinuidade brusca.
  - *Butterworth*: transição suave, controlada por uma ordem $n$; sem
    corte abrupto, produz menos ringing que o filtro ideal.
  - *Gaussiano*: transição suave em forma de gaussiana; não introduz
    ringing algum, ao custo de uma transição mais gradual entre as faixas.
]

== Exemplo resolvido

#example(id: "ex-equalizacao-histograma")[
  Uma imagem $8 times 8$ ($64$ pixels) com apenas $4$ níveis de cinza
  possíveis ($L=4$) tem histograma $n_0=32$, $n_1=16$, $n_2=12$, $n_3=4$.
  Calcule os novos níveis $s_0,dots,s_3$ após equalização de histograma.
]

#solution[
  Histograma normalizado: $p_0=32/64=0.5$, $p_1=16/64=0.25$,
  $p_2=12/64=0.1875$, $p_3=4/64=0.0625$.

  $ s_0 = 3 dot 0.5 = 1.5 approx 2, quad
    s_1 = 3 dot 0.75 = 2.25 approx 2, $
  $ s_2 = 3 dot 0.9375 = 2.8125 approx 3, quad
    s_3 = 3 dot 1 = 3. $

  Os quatro níveis originais colapsam para essencialmente três níveis de
  saída (${2,2,3,3}$) -- um efeito colateral comum da equalização em
  imagens com poucos níveis de cinza: níveis próximos podem se fundir.
]

== Questões estilo POSCOMP

#example(id: "q-realce-1")[
  (Múltipla escolha) Sobre técnicas de realce de imagens, é correto
  afirmar que:
  + A transformação logarítmica comprime valores baixos de intensidade e
    expande valores altos.
  + A equalização de histograma sempre produz um histograma exatamente
    uniforme, pixel a pixel.
  + O filtro passa-alta ideal, apesar do corte abrupto, não introduz
    nenhum artefato visível.
  + Unsharp masking realça bordas subtraindo uma versão suavizada da
    imagem da imagem original e somando o resultado de volta.
]

#solution[
  Resposta: alternativa *(4)*, conforme @def-unsharp-masking. A (1) inverte
  o efeito real da transformação log (@def-transformacao-log); a (2) é
  falsa pois a equalização é uma aproximação estatística, não uma garantia
  exata de uniformidade (imagens discretas raramente atingem um histograma
  perfeitamente uniforme); a (3) ignora o artefato de ringing do filtro
  ideal.
]

#example(id: "q-realce-2")[
  Um filtro passa-alta ideal, um Butterworth e um gaussiano são aplicados,
  separadamente, à mesma imagem, todos com a mesma frequência de corte.
  Ordene os três pelo grau de artefato de "ringing" esperado, do maior
  para o menor, e justifique brevemente.
]

#solution[
  Ideal > Butterworth > Gaussiano. O filtro ideal tem transição
  perfeitamente abrupta no domínio da frequência, o que corresponde no
  espaço a uma função sinc de suporte infinito (muitas oscilações); o
  Butterworth suaviza essa transição (ringing reduzido, mas ainda presente,
  dependendo da ordem); o gaussiano tem transição suave sem descontinuidade,
  e sua transformada inversa também é gaussiana, sem oscilações -- por isso
  não produz ringing.
]

== Referências

- GONZALEZ, R. C.; WOODS, R. E. *Digital Image Processing*. Cap. sobre
  realce no domínio espacial e da frequência.
- MARQUES FILHO, O.; VIEIRA NETO, H. *Processamento Digital de Imagens*.
  Cap. sobre realce de imagens.
- cienciadacomputacao.wiki.br -- Tópico 23.6.
