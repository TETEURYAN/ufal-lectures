#import "@preview/mousse-notes:1.1.0": *

= Planos
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.7]

== Introdução

Assim como uma reta é determinada por ponto + direção, um plano é determinado por ponto + vetor *normal* (perpendicular ao plano) -- e o produto vetorial (03) é a ferramenta natural para encontrar essa normal a partir de três pontos.

== Definições formais

#definition(name: "Equação geral do plano", id: "def-equacao-geral-plano")[
  Um plano passando por $P_0=(x_0,y_0,z_0)$ com vetor normal $n=(a,b,c)$ (não nulo) satisfaz $n dot (P-P_0) = 0$ para qualquer ponto $P=(x,y,z)$ do plano, o que se expande para a *equação geral*:
  $ a x + b y + c z + d = 0, quad "onde" d = -(a x_0+b y_0+c z_0) $
]

#definition(name: "Plano por três pontos", id: "def-plano-por-tres-pontos")[
  Dados três pontos não colineares $A,B,C$, dois vetores no plano são $u=B-A$ e $v=C-A$; o vetor normal é $n = u times v$ (03) -- perpendicular a ambos, logo perpendicular ao plano que os contém.
]

== Exemplo resolvido

#example(name: "Equação do plano por três pontos", id: "ex-plano-por-tres-pontos")[
  Encontrar a equação do plano por $A=(1,0,0)$, $B=(0,1,0)$, $C=(0,0,1)$.

  $u = B-A = (-1,1,0)$, $v=C-A=(-1,0,1)$.

  $ n = u times v = (1(1)-0(0), 0(-1)-(-1)(1), (-1)(0)-1(-1)) = (1,1,1) $

  Equação: $1(x-1)+1(y-0)+1(z-0)=0 arrow.r.double x+y+z-1=0$, ou seja, $x+y+z=1$.
]

== Atenção -- pegadinhas comuns

#remark(name: "O vetor normal, como o diretor de uma reta, não é único")[
  Qualquer múltiplo escalar não nulo de $n$ também é normal ao mesmo plano -- diferentes escolhas de pontos (ou ordem $u times v$ vs. $v times u$) podem produzir normais opostas ($n$ ou $-n$), representando o *mesmo* plano geometricamente.
]

#remark(name: "Os coeficientes a,b,c da equação geral SÃO as coordenadas do vetor normal")[
  Dado $a x+b y+c z+d=0$, o vetor normal é lido diretamente como $n=(a,b,c)$ -- sem cálculo adicional. Esse atalho é frequentemente esquecido, levando a recalcular a normal via produto vetorial quando a equação já a fornece diretamente.
]

== Questões estilo POSCOMP

*Questão 1.* O vetor normal ao plano $2x-3y+z-5=0$ é:
- a) $(2,-3,1)$.
- b) $(2,3,1)$.
- c) $(-5,0,0)$.
- d) $(1,-3,2)$.
- e) $(5,5,5)$.

*Questão 2.* Para encontrar a equação de um plano por três pontos não colineares $A,B,C$, o vetor normal é obtido por:
- a) $(B-A) dot (C-A)$.
- b) $(B-A) times (C-A)$.
- c) $A+B+C$.
- d) A soma das normas de $A$, $B$ e $C$.
- e) $B-C$.

*Questão 3.* No exemplo desta seção, a equação do plano por $(1,0,0)$, $(0,1,0)$, $(0,0,1)$ é:
- a) $x+y+z=0$.
- b) $x+y+z=1$.
- c) $x-y+z=1$.
- d) $x+y-z=1$.
- e) $2x+2y+2z=1$.

== Gabarito comentado

1. *(a)* -- os coeficientes de $x,y,z$ na equação geral são diretamente as coordenadas do vetor normal.
2. *(b)* -- definição direta: normal via produto vetorial de dois vetores do plano.
3. *(b)* -- resultado calculado explicitamente no exemplo desta seção.

== Referências

- WINTERLE, P. *Vetores e Geometria Analítica*. Cap. 7 (O plano).
- LEDESMA, D. S. *Apostila de Geometria Analítica*. UNICAMP.
