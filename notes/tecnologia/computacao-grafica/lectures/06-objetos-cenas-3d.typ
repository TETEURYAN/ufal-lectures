#import "@preview/mousse-notes:1.1.0": *
= 20.6 -- Definição de Objetos e Cenas 3D: Modelos Poliedrais e Malhas de Polígonos

== Introdução

Antes de transformar, projetar ou iluminar uma cena, é preciso representar os
objetos que a compõem. A representação mais comum em computação gráfica em
tempo real é a *malha de polígonos*: uma aproximação da superfície de um
objeto por um conjunto de polígonos planos (quase sempre triângulos). A
POSCOMP costuma cobrar a fórmula de Euler para poliedros e conceitos de
orientação de faces.

== Malhas de polígonos e poliedros

#definition(id: "def-malha-poligonos")[
  Uma *malha de polígonos* (polygon mesh) é uma representação de fronteira
  ("boundary representation", B-rep) de um sólido, formada por um conjunto de
  *vértices* $V$, *arestas* $E$ (segmentos entre pares de vértices) e *faces*
  $F$ (polígonos planos delimitados por arestas). Um *poliedro* é um sólido
  cuja fronteira é uma malha de polígonos planos fechada (sem buracos na
  superfície), formando uma região sólida do espaço.
]

#definition(id: "def-representacao-malha")[
  Na prática, uma malha é armazenada como:
  - uma *lista de vértices*, cada um com suas coordenadas $(x,y,z)$;
  - uma *lista de faces*, cada face referenciando (por índice) os vértices
    que a compõem, na ordem em que aparecem ao redor do polígono.
  A ordem dos vértices de uma face (*winding order*, sentido horário ou
  anti-horário quando vista de fora) determina, pela regra da mão direita, a
  direção da *normal da face* -- usada para saber qual lado do polígono é
  "de fora" e para os cálculos de iluminação em 20.7.
]

#remark[
  Não confundir *normal de face* (um vetor por polígono, perpendicular ao seu
  plano -- produz sombreamento "facetado") com *normal de vértice* (a média
  ponderada das normais das faces adjacentes a um vértice -- usada para
  simular uma superfície suave, como no sombreamento de Gouraud/Phong, tema de
  20.7). A malha continua sendo a mesma; o que muda é qual normal se usa no
  cálculo de iluminação.
]

== Fórmula de Euler

#theorem(id: "thm-euler-poliedros")[
  Para todo poliedro convexo (mais geralmente, simplesmente conexo, sem
  "buracos" -- gênero topológico $0$), o número de vértices $V$, arestas $E$ e
  faces $F$ satisfaz a *fórmula de Euler*:
  $ V - E + F = 2. $
  Para uma superfície fechada de gênero $g$ (com $g$ "alças" ou buracos), a
  relação generaliza para $V - E + F = 2 - 2g$.
]

#example(id: "ex-euler-cubo")[
  Verifique a fórmula de Euler para um cubo.
]

#solution[
  Um cubo tem $V=8$ vértices, $E=12$ arestas e $F=6$ faces:
  $ V - E + F = 8 - 12 + 6 = 2. checkmark $
]

#example(id: "q-euler-icosaedro")[
  Um poliedro convexo tem todas as faces triangulares, totalizando $20$
  faces, e cada vértice é compartilhado por exatamente $5$ faces. Usando a
  fórmula de Euler, determine o número de vértices e de arestas.
]

#solution[
  Cada face triangular tem $3$ arestas, e cada aresta é compartilhada por $2$
  faces, logo
  $ E = (3 dot F)/2 = (3 dot 20)/2 = 30. $
  Pela fórmula de Euler, $V - E + F = 2 arrow.r.double V = 2 + E - F = 2 + 30 - 20 = 12$.
  Isso descreve exatamente um *icosaedro*: $V=12$, $E=30$, $F=20$.
]

#example(id: "q-winding-order")[
  (Múltipla escolha) Em uma malha de polígonos, a ordem (sentido) em que os
  vértices de uma face são listados serve principalmente para:
  + Determinar a cor base do polígono antes da iluminação.
  + Definir a direção da normal da face, e assim distinguir a face "de fora"
    da "de dentro".
  + Otimizar a busca de arestas compartilhadas entre faces.
  + Garantir que o poliedro seja convexo.
]

#solution[
  Resposta: alternativa *(2)*. O winding order, junto com a regra da mão
  direita, define a normal da face -- essencial para *back-face culling* e
  para os cálculos de iluminação (20.7). Não tem relação direta com cor,
  busca de adjacência ou convexidade do sólido.
]

== Referências

- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Cap. sobre
  representação de objetos geométricos (B-rep, malhas de polígonos).
- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Cap. sobre
  representação de objetos 3D.
- cienciadacomputacao.wiki.br -- Tópico 20.6.
