#import "@preview/mousse-notes:1.1.0": *
= 20.10 -- Visualização

== Introdução

Este último subtópico amarra a disciplina inteira: a *pipeline de
visualização* é a sequência completa de transformações que leva um objeto
descrito em coordenadas de modelo (20.6) até pixels acesos na tela, passando
por câmera (20.4), projeção (20.3), recorte (20.2) e, por fim, *rasterização*
-- a conversão de primitivas geométricas contínuas (retas, polígonos) em
pixels discretos, o único estágio da pipeline ainda não tratado nos tópicos
anteriores.

== A pipeline de visualização

#definition(id: "def-pipeline-visualizacao")[
  A pipeline de visualização gráfica encadeia os seguintes estágios, cada um
  já estudado individualmente nos subtópicos anteriores:
  + *Transformação de modelagem*: leva coordenadas locais do objeto (20.6)
    para coordenadas do mundo, via matrizes de 20.1/20.5;
  + *Transformação de visualização*: leva coordenadas do mundo para
    coordenadas da câmera, via a view matrix de 20.4;
  + *Projeção*: leva coordenadas da câmera para coordenadas de projeção
    (paralela ou perspectiva, 20.3);
  + *Recorte*: descarta (ou corta) geometria fora do volume de visualização,
    em coordenadas normalizadas (20.2, generalizado para 3D);
  + *Transformação de viewport*: mapeia as coordenadas normalizadas para
    coordenadas de tela (pixels), análoga ao mapeamento janela-viewport 2D
    de 20.2;
  + *Rasterização*: converte as primitivas 2D resultantes (retas, polígonos
    com suas cores/texturas de 20.7/20.8) em pixels no *framebuffer*, aplicando
    também remoção de superfícies ocultas e antialiasing (20.7, 20.9).
]

#remark[
  Essa pipeline é exatamente a ordem em que os subtópicos 20.1 a 20.9 foram
  apresentados nesta disciplina -- não por coincidência, mas porque o edital
  da POSCOMP segue o fluxo real de uma GPU/API gráfica (como OpenGL): cada
  etapa produz a entrada da próxima.
]

== Rasterização de retas: algoritmo de Bresenham

#definition(id: "def-bresenham")[
  O *algoritmo de Bresenham* desenha uma reta entre dois pontos de coordenadas
  inteiras usando apenas aritmética inteira (somas e comparações, sem divisão
  ou ponto flutuante), escolhendo a cada passo o pixel que melhor aproxima a
  reta real. Para uma reta com $0 < "inclinação" < 1$ entre $(x_1,y_1)$ e
  $(x_2,y_2)$, com $Delta x = x_2 - x_1$ e $Delta y = y_2 - y_1$, o parâmetro
  de decisão inicial é
  $ p_0 = 2 Delta y - Delta x, $
  e a cada passo $k$ (incrementando sempre $x$ em $1$):
  - se $p_k < 0$: o próximo pixel mantém $y$, e
    $p_(k+1) = p_k + 2 Delta y$;
  - se $p_k >= 0$: o próximo pixel incrementa $y$ em $1$, e
    $p_(k+1) = p_k + 2 Delta y - 2 Delta x$.
]

#example(id: "q-bresenham-trace")[
  Trace o algoritmo de Bresenham para a reta de $(2,2)$ a $(6,5)$.
]

#solution[
  $ Delta x = 6-2=4, quad Delta y = 5-2=3, quad p_0 = 2 dot 3 - 4 = 2. $

  #figure(
    tablef(
      columns: 4,
      [$k$], [$p_k$], [decisão], [pixel],
      table.hline(),
      [--], [--], [--], [$(2,2)$ (inicial)],
      [$0$], [$2$], [$p_0 >= 0 arrow.r.double y "++"$], [$(3,3)$, $p_1 = 2+6-8=0$],
      [$1$], [$0$], [$p_1 >= 0 arrow.r.double y "++"$], [$(4,4)$, $p_2 = 0+6-8=-2$],
      [$2$], [$-2$], [$p_2 < 0 arrow.r.double y$ mantém], [$(5,4)$, $p_3 = -2+6=4$],
      [$3$], [$4$], [$p_3 >= 0 arrow.r.double y "++"$], [$(6,5)$, fim],
    ),
    caption: [Traço do algoritmo de Bresenham de $(2,2)$ a $(6,5)$.],
  )

  Os pixels acesos são $(2,2), (3,3), (4,4), (5,4), (6,5)$ -- exatamente $Delta x + 1 = 5$
  pixels, um por incremento de $x$, terminando no ponto final correto.
]

== Preenchimento de polígonos e framebuffer

#definition(id: "def-scanline-fill")[
  O *preenchimento por varredura* ("scanline fill") rasteriza o interior de um
  polígono processando uma linha horizontal (scanline) de pixels por vez:
  para cada scanline, calculam-se as interseções com as arestas do polígono,
  ordenam-se por $x$, e os pixels são preenchidos nos intervalos entre pares
  consecutivos de interseção (regra par-ímpar) ou conforme a regra de
  *non-zero winding*, para polígonos com autointerseção.
]

#definition(id: "def-framebuffer")[
  O *framebuffer* é a região de memória que armazena a cor final de cada
  pixel da imagem a ser exibida -- o destino de todos os estágios anteriores
  da pipeline. A profundidade de cor (ex.: $24$ bits para RGB, $8$ por canal)
  determina quantas cores distintas podem ser representadas por pixel; um
  *z-buffer* (20.7) é tipicamente um buffer adicional, paralelo ao
  framebuffer de cor, com a mesma resolução em pixels.
]

#example(id: "q-pipeline-ordem")[
  (Múltipla escolha) Na pipeline de visualização gráfica, qual é a ordem
  correta dos estágios?
  + Rasterização, projeção, recorte, transformação de visualização.
  + Transformação de modelagem, transformação de visualização, projeção,
    recorte, rasterização.
  + Recorte, projeção, transformação de modelagem, rasterização.
  + Projeção, transformação de visualização, transformação de modelagem,
    recorte.
]

#solution[
  Resposta: alternativa *(2)*. É a ordem apresentada em @def-pipeline-visualizacao:
  modelo -> mundo -> câmera -> projeção -> recorte -> rasterização.
]

== Referências

- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Caps.
  sobre a pipeline de visualização e algoritmos de rasterização.
- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Cap. sobre
  rasterização de retas e polígonos (Bresenham, scanline fill).
- cienciadacomputacao.wiki.br -- Tópico 20.10.
