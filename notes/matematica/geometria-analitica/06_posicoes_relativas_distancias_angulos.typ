#import "@preview/mousse-notes:1.1.0": *

= Posições Relativas, Interseções, Distâncias e Ângulos
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.8]

== Introdução

Com retas (04) e planos (05) formalizados, esta subseção fecha o núcleo da disciplina: como duas retas, dois planos, ou uma reta e um plano se relacionam no espaço -- e como medir distâncias e ângulos entre eles.

== Definições formais

#definition(name: "Posições relativas de duas retas no espaço", id: "def-posicoes-relativas-retas")[
  Duas retas no espaço podem ser:
  - *Paralelas*: vetores diretores múltiplos escalares (02), sem ponto em comum (ou coincidentes, se compartilham um ponto).
  - *Concorrentes*: vetores diretores não paralelos, mas as retas se cruzam em exatamente um ponto (coplanares).
  - *Reversas (skew)*: vetores diretores não paralelos *e* as retas não se cruzam -- não existem em um mesmo plano. Só é possível no espaço (nunca no plano, onde duas retas não paralelas sempre se cruzam).
]

#definition(name: "Distância de ponto a plano", id: "def-distancia-ponto-plano")[
  A distância do ponto $P_0=(x_0,y_0,z_0)$ ao plano $a x+b y+c z+d=0$ é:
  $ d(P_0, pi) = abs(a x_0+b y_0+c z_0+d)/sqrt(a^2+b^2+c^2) $
]

#definition(name: "Ângulo entre retas e entre planos", id: "def-angulo-retas-planos")[
  O ângulo entre duas retas (ou entre dois planos) é calculado via produto escalar (03) entre seus vetores diretores (ou normais, no caso de planos), tomando o valor absoluto do cosseno para garantir o ângulo agudo convencional: $cos(theta) = abs(u dot v)/(norm(u) norm(v))$.
]

== Exemplo resolvido

#example(name: "Distância de um ponto a um plano e classificação de retas reversas", id: "ex-distancia-retas-reversas")[
  *Distância*: do ponto $Q=(2,2,2)$ ao plano $x+y+z=1$ (05): $d = abs(2+2+2-1)/sqrt(1+1+1) = 5/sqrt(3) = (5sqrt(3))/3 approx 2.89$.

  #figure(
    image("figures/plane-point-distance.svg", width: 45%),
    caption: [Distância de um ponto a um plano em $RR^3$, medida perpendicularmente ao plano ao longo da direção do vetor normal. Fonte: Wikimedia Commons, CC BY-SA (Svjo).],
  )

  *Retas reversas*: $r_1$ passa por $(0,0,0)$ com direção $(1,0,0)$ (eixo $x$); $r_2$ passa por $(0,1,1)$ com direção $(0,1,0)$. Os vetores diretores $(1,0,0)$ e $(0,1,0)$ não são paralelos. Testando interseção: um ponto de $r_1$ é $(t,0,0)$; um ponto de $r_2$ é $(0,1+s,1)$ -- para coincidirem, precisaríamos $t=0$, $0=1+s$ e $0=1$ simultaneamente -- a última condição ($0=1$) é impossível. Não há interseção, e as retas não são paralelas: são *reversas*.
]

== Atenção -- pegadinhas comuns

#remark(name: "Retas reversas só existem no espaço (RR³), nunca no plano")[
  No plano $RR^2$, duas retas são sempre paralelas ou concorrentes -- não existe a possibilidade de "reversas" (não há terceira dimensão para elas "passarem uma pela outra" sem se cruzar). É um erro comum tentar classificar retas do plano como reversas.
]

#remark(name: "Ângulo entre retas/planos usa valor absoluto do cosseno")[
  Por convenção, o ângulo entre duas retas (ou planos) é sempre reportado como o ângulo *agudo* (entre $0°$ e $90°$) -- por isso a fórmula usa $abs(u dot v)$, evitando reportar o ângulo obtuso suplementar que resultaria de escolher os vetores diretores/normais com sentido oposto.
]

== Questões estilo POSCOMP

*Questão 1.* Duas retas no espaço cujos vetores diretores não são paralelos e que não possuem ponto em comum são chamadas de:
- a) Paralelas.
- b) Concorrentes.
- c) Reversas.
- d) Coincidentes.
- e) Perpendiculares, necessariamente.

*Questão 2.* A distância do ponto $(1,1,1)$ ao plano $x+y+z=0$ é:
- a) $0$.
- b) $sqrt(3)$.
- c) $3$.
- d) $1$.
- e) $9$.

*Questão 3.* Duas retas no plano ($RR^2$), com vetores diretores não paralelos, são necessariamente:
- a) Reversas.
- b) Concorrentes (se cruzam em exatamente um ponto).
- c) Paralelas.
- d) Coincidentes.
- e) Perpendiculares.

== Gabarito comentado

1. *(c)* -- ausência de interseção e de paralelismo simultaneamente caracteriza retas reversas.
2. *(b)* -- $d = abs(1+1+1+0)/sqrt(3) = 3/sqrt(3) = sqrt(3)$.
3. *(b)* -- no plano, retas não paralelas sempre se cruzam em um único ponto (não há reversas em 2D).

== Referências

- WINTERLE, P. *Vetores e Geometria Analítica*. Cap. 8 (Posições relativas, distâncias e ângulos).
- LEDESMA, D. S. *Apostila de Geometria Analítica*. UNICAMP.
