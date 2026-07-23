#import "@preview/mousse-notes:1.1.0": *
= 20.1 -- Transformações Geométricas 2D/3D: Coordenadas Homogêneas

== Introdução

Transformações geométricas são a base de toda a pipeline gráfica: mover, girar,
redimensionar e distorcer objetos são operações que aparecem desde a modelagem de
uma cena até o posicionamento final da câmera. A POSCOMP cobra sobretudo a
capacidade de montar e compor matrizes de transformação em coordenadas
homogêneas -- é o subtópico com maior densidade de questões de cálculo direto de
toda a disciplina.

== Coordenadas homogêneas

#definition(id: "def-coord-homog")[
  Um ponto $(x, y)$ do plano é representado em *coordenadas homogêneas* como a
  tripla $(x, y, w)$, com $w != 0$, tal que o ponto cartesiano correspondente é
  $ (x/w, y/w). $
  Por convenção, usa-se $w = 1$ para representar pontos:
  $ p = mat(x; y; 1). $
  Em três dimensões, o ponto $(x,y,z)$ é representado como o vetor-coluna
  $ p = mat(x; y; z; 1). $
]

#remark[
  A quarta coordenada (ou terceira, em 2D) também serve para distinguir *pontos*
  de *vetores*: um ponto usa $w=1$, um vetor de deslocamento/direção usa $w=0$.
  Isso é o que torna a translação -- que não faz sentido para vetores de direção
  -- representável como matriz: a coluna de translação de uma matriz homogênea é
  multiplicada por $w$, e some quando $w=0$. É um erro comum de prova confundir
  "ponto" com "vetor" nesse contexto.
]

O uso de coordenadas homogêneas permite representar *todas* as transformações
afins (translação, rotação, escala, cisalhamento) como *multiplicação de
matrizes*, o que não é possível em coordenadas cartesianas puras (a translação
é uma soma, não um produto). Isso permite compor várias transformações em uma
única matriz.

== Transformações elementares em 2D

Adotando a convenção de *vetor-coluna* e transformação por multiplicação à
esquerda ($p' = M p$), as matrizes elementares em coordenadas homogêneas 2D
são:

#definition(id: "def-translacao-2d")[
  *Translação* por $(d_x, d_y)$:
  $ T(d_x, d_y) = mat(1, 0, d_x; 0, 1, d_y; 0, 0, 1). $
]

#definition(id: "def-escala-2d")[
  *Escala* com fatores $(s_x, s_y)$ em relação à origem:
  $ S(s_x, s_y) = mat(s_x, 0, 0; 0, s_y, 0; 0, 0, 1). $
]

#definition(id: "def-rotacao-2d")[
  *Rotação* de ângulo $theta$ (sentido anti-horário) em torno da origem:
  $ R(theta) = mat(cos theta, -sin theta, 0; sin theta, cos theta, 0; 0, 0, 1). $
]

#definition(id: "def-cisalhamento-2d")[
  *Cisalhamento* ("shear") horizontal e vertical:
  $ SH_x (a) = mat(1, a, 0; 0, 1, 0; 0, 0, 1), quad
    SH_y (b) = mat(1, 0, 0; b, 1, 0; 0, 0, 1). $
]

== Transformações em 3D

As mesmas transformações se estendem para matrizes homogêneas $4 times 4$:

$ T(d_x,d_y,d_z) = mat(
  1,0,0,d_x;
  0,1,0,d_y;
  0,0,1,d_z;
  0,0,0,1
), quad
S(s_x,s_y,s_z) = mat(
  s_x,0,0,0;
  0,s_y,0,0;
  0,0,s_z,0;
  0,0,0,1
). $

#indent
As rotações em 3D dependem do eixo. Em torno do eixo $z$ (análoga à rotação 2D):

$ R_z (theta) = mat(
  cos theta, -sin theta, 0, 0;
  sin theta, cos theta, 0, 0;
  0,0,1,0;
  0,0,0,1
). $

#indent
Em torno de $x$ e $y$ (sinais trocam por causa da orientação da base, regra da
mão direita):

$ R_x (theta) = mat(
  1,0,0,0;
  0,cos theta,-sin theta,0;
  0,sin theta,cos theta,0;
  0,0,0,1
), quad
R_y (theta) = mat(
  cos theta,0,sin theta,0;
  0,1,0,0;
  -sin theta,0,cos theta,0;
  0,0,0,1
). $

== Composição de transformações

#theorem(id: "thm-composicao")[
  Se um ponto sofre a transformação $M_1$ seguida de $M_2$, a transformação
  composta equivalente é a matriz produto $M = M_2 M_1$, isto é,
  $ p' = M_2 (M_1 p) = (M_2 M_1) p. $
  Em geral, várias transformações aplicadas em sequência ($M_1$ primeiro, ...,
  $M_n$ por último) correspondem à matriz composta
  $ M = M_n dots.c M_2 M_1. $
]

#remark[
  *Armadilha clássica de prova*: com vetor-coluna e $p' = M p$, a matriz da
  transformação aplicada *primeiro* fica mais à *direita* do produto -- lê-se o
  produto da direita para a esquerda. Além disso, multiplicação de matrizes
  *não é comutativa*: girar e depois transladar produz, em geral, um resultado
  diferente de transladar e depois girar. Rotação e escala em torno da origem
  comutam entre si, mas translação não comuta com nenhuma das duas.
]

#example(id: "ex-rotacao-ponto-fixo")[
  Como rotacionar uma figura por um ângulo $theta$ em torno de um ponto
  arbitrário $p_0 = (a,b)$, e não da origem?
]

#solution[
  Compõe-se três transformações: translada-se $p_0$ até a origem, roda-se em
  torno da origem, e translada-se de volta:
  $ M = T(a,b) space R(theta) space T(-a,-b). $
  Note a ordem: $T(-a,-b)$ é aplicada primeiro (mais à direita), depois
  $R(theta)$, depois $T(a,b)$ desfaz a translação inicial.
]

== Questão estilo POSCOMP

#example(id: "q-transf-2d-1")[
  Um ponto $P = (2,3)$ sofre, nesta ordem, uma escala uniforme de fator $2$ em
  relação à origem e, em seguida, uma translação de $(1,-1)$. Calcule as
  coordenadas do ponto resultante $P'$ usando matrizes homogêneas.
]

#solution[
  A matriz composta é $M = T(1,-1) S(2,2)$, pois a escala é aplicada primeiro:
  $ M = mat(1,0,1;0,1,-1;0,0,1) mat(2,0,0;0,2,0;0,0,1)
      = mat(2,0,1;0,2,-1;0,0,1). $
  Aplicando a $P = (2,3,1)^T$:
  $ P' = mat(2,0,1;0,2,-1;0,0,1) mat(2;3;1)
       = mat(2 dot 2 + 0 dot 3 + 1; 0 dot 2 + 2 dot 3 - 1; 1)
       = mat(5; 5; 1). $
  Logo $P' = (5, 5)$.
]

#example(id: "q-transf-2d-2")[
  (Múltipla escolha) Em coordenadas homogêneas 2D com a convenção de
  vetor-coluna, qual matriz representa uma rotação de $90°$ no sentido
  anti-horário em torno da origem?
  + $mat(0,1,0;-1,0,0;0,0,1)$
  + $mat(0,-1,0;1,0,0;0,0,1)$
  + $mat(1,0,0;0,-1,0;0,0,1)$
  + $mat(-1,0,0;0,-1,0;0,0,1)$
]

#solution[
  Com $theta = 90°$, $cos theta = 0$ e $sin theta = 1$, logo
  $ R(90°) = mat(0,-1,0;1,0,0;0,0,1). $
  Resposta: alternativa *(2)*. A alternativa (1) é a rotação de $-90°$ (sentido
  horário), um erro de sinal comum.
]

== Referências

- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Cap. sobre
  transformações geométricas 2D/3D.
- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Cap. sobre
  transformações geométricas e coordenadas homogêneas.
- cienciadacomputacao.wiki.br -- Tópico 20.1.
