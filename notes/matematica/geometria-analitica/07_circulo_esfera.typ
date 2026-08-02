#import "@preview/mousse-notes:1.1.0": *

= Círculo e Esfera
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.9]

== Introdução

Círculo e esfera são os exemplos mais simples de curva/superfície quádrica -- o conjunto de pontos a uma distância fixa (raio) de um centro. A técnica de completar quadrados para extrair centro e raio da forma geral é o cálculo mais cobrado desta subseção.

== Definições formais

#definition(name: "Círculo (equação reduzida e geral)", id: "def-circulo-equacao")[
  A *equação reduzida* do círculo de centro $(a,b)$ e raio $r$ é $(x-a)^2+(y-b)^2=r^2$. Expandindo, obtém-se a *equação geral*: $x^2+y^2 - 2a x - 2b y + (a^2+b^2-r^2) = 0$ -- sempre com coeficientes iguais para $x^2$ e $y^2$, e sem termo $x y$.
]

#definition(name: "Esfera (equação reduzida e geral)", id: "def-esfera-equacao")[
  Analogamente em $RR^3$: a *equação reduzida* da esfera de centro $(a,b,c)$ e raio $r$ é $(x-a)^2+(y-b)^2+(z-c)^2=r^2$, com a correspondente equação geral expandida.
]

== Exemplo resolvido

#example(name: "Encontrando centro e raio por completamento de quadrados", id: "ex-completar-quadrados")[
  *Círculo*: dado $x^2+y^2-4x+6y-3=0$. Reagrupando e completando quadrados:
  $ (x^2-4x+4) + (y^2+6y+9) = 3+4+9 $
  $ (x-2)^2 + (y+3)^2 = 16 $
  Centro $(2,-3)$, raio $r=sqrt(16)=4$.

  *Esfera*: dado $x^2+y^2+z^2-2x+4z-4=0$. Completando quadrados:
  $ (x^2-2x+1) + y^2 + (z^2+4z+4) = 4+1+4 $
  $ (x-1)^2+y^2+(z+2)^2 = 9 $
  Centro $(1,0,-2)$, raio $r=sqrt(9)=3$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Coeficientes de x² e y² devem ser iguais a 1 (ou iguais entre si) antes de completar quadrados")[
  Se a equação geral tiver a forma $2x^2+2y^2 - dots = 0$ (coeficientes diferentes de 1, mas iguais entre si), é preciso dividir toda a equação por esse coeficiente comum *antes* de completar quadrados -- esquecer esse passo produz um raio incorreto.
]

#remark(name: "Nem toda equação da forma x²+y²+...=0 representa um círculo real")[
  Após completar quadrados, se o lado direito resultar em um valor *negativo*, não existe círculo real (conjunto vazio); se resultar exatamente em zero, o "círculo" degenera em um único ponto (o centro, com raio zero) -- casos que a prova explora conceitualmente.
]

== Questões estilo POSCOMP

*Questão 1.* O raio do círculo de equação $x^2+y^2-4x+6y-3=0$ (do exemplo desta seção) é:
- a) $3$.
- b) $4$.
- c) $16$.
- d) $2$.
- e) $9$.

*Questão 2.* A equação $(x-1)^2+(y+2)^2+(z-3)^2=0$ representa:
- a) Uma esfera de raio $1$.
- b) Um único ponto: o centro $(1,-2,3)$.
- c) O conjunto vazio.
- d) Uma esfera de raio $0$, mas com infinitos pontos.
- e) Um plano.

*Questão 3.* Para encontrar o centro e o raio de um círculo a partir de sua equação geral, a técnica usada é:
- a) Regra de Sarrus.
- b) Completamento de quadrados.
- c) Produto vetorial.
- d) Eliminação de Gauss.
- e) Regra de Laplace.

== Gabarito comentado

1. *(b)* -- calculado explicitamente no exemplo desta seção: $r=sqrt(16)=4$.
2. *(b)* -- soma de quadrados igual a zero só é possível se cada termo for zero: um único ponto, o centro.
3. *(b)* -- completamento de quadrados é a técnica padrão para extrair centro/raio da forma geral.

== Referências

- WINTERLE, P. *Vetores e Geometria Analítica*. Cap. 9 (Círculo e esfera).
- LEDESMA, D. S. *Apostila de Geometria Analítica*. UNICAMP.
