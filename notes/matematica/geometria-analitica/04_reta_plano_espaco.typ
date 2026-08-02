#import "@preview/mousse-notes:1.1.0": *

= Reta no Plano e no Espaço
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.6]

== Introdução

Uma reta é determinada por um ponto e uma direção -- a partir dessa ideia simples, derivam-se três formas equivalentes de equação, cada uma mais conveniente para um tipo de cálculo diferente.

== Definições formais

#definition(name: "Equação paramétrica da reta", id: "def-equacao-parametrica-reta")[
  A reta que passa por $P_0=(x_0,y_0,z_0)$ com vetor diretor $v=(a,b,c)$ (não nulo) é o conjunto de pontos:
  $ (x,y,z) = (x_0,y_0,z_0) + t(a,b,c), quad t in RR $
  Cada valor de $t$ produz um ponto da reta; $t=0$ dá $P_0$.
]

#definition(name: "Equações simétricas da reta", id: "def-equacoes-simetricas-reta")[
  Quando $a,b,c$ são todos não nulos, eliminando o parâmetro $t$ das equações paramétricas obtém-se a forma simétrica:
  $ (x-x_0)/a = (y-y_0)/b = (z-z_0)/c $
  Se alguma componente de $v$ for zero (ex.: $c=0$), a reta é paralela a um plano coordenado, e a forma simétrica precisa ser adaptada (a equação correspondente vira $z=z_0$ isolada, fora da cadeia de frações).
]

== Exemplo resolvido

#example(name: "Equações de uma reta por dois pontos", id: "ex-reta-por-dois-pontos")[
  Encontrar as equações da reta por $P_1=(1,0,2)$ e $P_2=(3,4,6)$.

  Vetor diretor: $v = P_2-P_1 = (2,4,4)$.

  *Paramétrica*: $(x,y,z) = (1,0,2)+t(2,4,4)$, isto é, $x=1+2t$, $y=4t$, $z=2+4t$.

  *Simétrica*: $(x-1)/2 = y/4 = (z-2)/4$.
]

== Atenção -- pegadinhas comuns

#remark(name: "O vetor diretor não é único -- qualquer múltiplo escalar serve")[
  Qualquer vetor não nulo paralelo a $v$ (ex.: $2v$, $-v$, $v\/2$) descreve a *mesma* reta, apenas reparametrizada -- não há um "vetor diretor correto único"; comparar retas exige checar se os vetores diretores são múltiplos escalares um do outro (colinearidade, 02), não se são idênticos.
]

== Questões estilo POSCOMP

*Questão 1.* A reta que passa por $(2,1,0)$ com vetor diretor $(1,0,3)$ tem equação paramétrica:
- a) $(x,y,z) = (1,0,3)+t(2,1,0)$.
- b) $(x,y,z) = (2,1,0)+t(1,0,3)$.
- c) $(x,y,z) = (2,1,0)+t(2,1,0)$.
- d) $(x,y,z) = (0,0,0)+t(1,0,3)$.
- e) $(x,y,z) = (1,1,1)+t(1,0,3)$.

*Questão 2.* As equações simétricas de uma reta exigem que:
- a) O ponto $P_0$ seja a origem.
- b) Todas as componentes do vetor diretor sejam não nulas.
- c) A reta esteja no plano $x y$.
- d) O parâmetro $t$ seja sempre positivo.
- e) A reta seja paralela a um eixo coordenado.

*Questão 3.* Os vetores diretores $(2,4,4)$ e $(1,2,2)$ de duas retas dadas indicam que essas retas são:
- a) Necessariamente a mesma reta.
- b) Paralelas (mesma direção, pois um é múltiplo escalar do outro).
- c) Perpendiculares.
- d) Reversas.
- e) Sem relação alguma entre si.

== Gabarito comentado

1. *(b)* -- ponto $P_0=(2,1,0)$ soma parametrizada pelo vetor diretor $(1,0,3)$.
2. *(b)* -- forma simétrica exige divisão por cada componente do vetor diretor, logo todas não nulas.
3. *(b)* -- $(2,4,4) = 2(1,2,2)$: vetores diretores múltiplos escalares indicam retas paralelas (podem ser a mesma reta ou distintas, mas paralelas em direção).

== Referências

- WINTERLE, P. *Vetores e Geometria Analítica*. Cap. 6 (A reta).
- LEDESMA, D. S. *Apostila de Geometria Analítica*. UNICAMP.
