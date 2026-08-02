#import "@preview/mousse-notes:1.1.0": *

= Vetores
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.3]

== Introdução

Vetores formalizam grandezas com magnitude *e* direção (deslocamento, força, velocidade) -- em contraste com escalares, que têm só magnitude. Toda a geometria analítica do espaço (retas, planos, distâncias) é construída sobre a álgebra de vetores.

== Definições formais

#definition(name: "Vetor: definição geométrica e algébrica", id: "def-vetor-geometrico-algebrico")[
  Geometricamente, um vetor é uma classe de segmentos orientados *equipolentes* (mesmo comprimento, direção e sentido, independente do ponto de aplicação). Algebricamente, fixado um sistema de coordenadas, um vetor em $RR^3$ é representado por uma tripla ordenada $v = (v_1,v_2,v_3)$, com *norma* (comprimento) $norm(v) = sqrt(v_1^2+v_2^2+v_3^2)$.
]

= Álgebra Vetorial
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.5]

== Definições formais

#definition(name: "Operações com vetores", id: "def-operacoes-vetoriais")[
  - *Soma*: $u+v = (u_1+v_1, u_2+v_2, u_3+v_3)$ -- geometricamente, regra do paralelogramo (ou "cabeça-cauda").
  - *Multiplicação por escalar*: $k v = (k v_1, k v_2, k v_3)$ -- escala o comprimento por $abs(k)$, invertendo o sentido se $k<0$.
  - *Vetor unitário*: $hat(v) = v\/norm(v)$, na mesma direção de $v$, com norma 1.
]

#definition(name: "Vetores colineares e coplanares", id: "def-vetores-colineares-coplanares")[
  Dois vetores não nulos $u,v$ são *colineares (paralelos)* se $v = k u$ para algum escalar $k$ (múltiplos um do outro). Três vetores são *coplanares* se um deles é combinação linear dos outros dois -- equivalentemente (04.4), se seu produto misto é zero.
]

== Exemplo resolvido

#example(name: "Operações vetoriais e teste de colinearidade", id: "ex-operacoes-vetoriais-colinearidade")[
  Sejam $u=(1,2,2)$ e $v=(3,4,0)$.

  *Soma*: $u+v = (4,6,2)$. *Norma de $u$*: $norm(u) = sqrt(1+4+4) = sqrt(9)=3$. *Vetor unitário de $u$*: $hat(u) = (1\/3, 2\/3, 2\/3)$.

  *Teste de colinearidade* com $w = (2,4,4)$: $w = 2u$ (verificando cada coordenada: $2(1)=2$, $2(2)=4$, $2(2)=4$ ✓) -- $w$ e $u$ são *colineares*. Já $v$ não é múltiplo escalar de $u$ (não existe $k$ com $3=k(1)$ e $4=k(2)$ simultaneamente, pois daria $k=3$ e $k=2$, contraditório) -- $u$ e $v$ *não* são colineares.
]

== Atenção -- pegadinhas comuns

#remark(name: "Vetor não tem posição fixa -- só magnitude e direção")[
  Dois segmentos orientados com pontos de aplicação diferentes representam o *mesmo* vetor, desde que tenham mesmo comprimento, direção e sentido -- vetor não é um objeto "localizado" no espaço, ao contrário de um ponto.
]

#remark(name: "Colinear é caso particular de coplanar, não conceitos disjuntos")[
  Dois vetores colineares são automaticamente coplanares com qualquer terceiro vetor (uma reta está sempre contida em algum plano) -- a pegadinha é achar que "colinear" e "coplanar" descrevem situações mutuamente exclusivas.
]

== Questões estilo POSCOMP

*Questão 1.* A norma do vetor $v=(3,4,0)$ é:
- a) $3$.
- b) $4$.
- c) $5$.
- d) $7$.
- e) $12$.

*Questão 2.* Dois vetores não nulos $u,v$ são colineares quando:
- a) $u+v=0$.
- b) $v = k u$ para algum escalar $k$.
- c) $norm(u) = norm(v)$.
- d) $u$ e $v$ têm coordenadas todas positivas.
- e) $u dot v = 0$ (produto escalar nulo).

*Questão 3.* O vetor unitário na direção de $v=(0,3,4)$ é:
- a) $(0,3,4)$.
- b) $(0, 3\/5, 4\/5)$.
- c) $(0,1,1)$.
- d) $(0,3,4)\/2$.
- e) $(1,1,1)$.

== Gabarito comentado

1. *(c)* -- $norm(v) = sqrt(9+16+0)=sqrt(25)=5$.
2. *(b)* -- definição direta de vetores colineares (paralelos).
3. *(b)* -- $norm(v)=sqrt(0+9+16)=5$; $hat(v) = (0,3,4)\/5 = (0,3\/5,4\/5)$.

== Referências

- WINTERLE, P. *Vetores e Geometria Analítica*. Cap. 2--3 (Vetores e operações).
- LEDESMA, D. S. *Apostila de Geometria Analítica*. UNICAMP.
- Álgebra Linear (1.2, Espaços Vetoriais) -- generalização abstrata de vetor.
