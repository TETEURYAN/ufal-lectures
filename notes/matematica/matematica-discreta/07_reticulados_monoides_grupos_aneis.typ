#import "@preview/mousse-notes:1.1.0": *

= Reticulados, Monóides, Grupos, Anéis
#text(size: 9pt, style: "italic")[Edital POSCOMP: 6.7]

== Introdução

Esta subseção reúne as estruturas algébricas discretas fundamentais, cada uma exigindo um subconjunto crescente de propriedades sobre uma operação. Reconhecer *qual* estrutura um conjunto com uma operação forma -- verificando cada propriedade sistematicamente -- é o formato de questão mais comum desta parte da disciplina.

== Definições formais

#definition(name: "Reticulado (lattice)", id: "def-reticulado")[
  Um conjunto parcialmente ordenado (06) $(L, <=)$ é um *reticulado* se todo par de elementos $a,b in L$ tem um *supremo* (menor cota superior, $a or.big b$, "join") e um *ínfimo* (maior cota inferior, $a and.big b$, "meet") em $L$. Exemplo clássico: o conjunto das partes de um conjunto $S$, ordenado por $subset.eq$, com $or.big = union$ e $and.big = inter$.
]

#definition(name: "Monoide", id: "def-monoide")[
  Uma estrutura $(M, *)$ com $*: M times M -> M$ é um *monoide* se: (i) *fechamento* ($*$ sempre resulta em um elemento de $M$, garantido por ser uma função para $M$); (ii) *associatividade* ($(a*b)*c = a*(b*c)$ para todos $a,b,c$); (iii) existe *elemento neutro* $e in M$ tal que $a*e=e*a=a$ para todo $a$.
]

#definition(name: "Grupo", id: "def-grupo")[
  Um monoide $(G, *)$ em que, além disso, todo elemento tem *inverso*: para todo $a in G$, existe $a^(-1) in G$ tal que $a*a^(-1)=a^(-1)*a=e$. Se além disso $*$ é comutativa ($a*b=b*a$ para todos $a,b$), o grupo é *abeliano (comutativo)*.
]

#definition(name: "Anel", id: "def-anel")[
  Uma estrutura $(R, +, dot)$ é um *anel* se $(R,+)$ é um *grupo abeliano*, $(R, dot)$ é um *monoide* (ou apenas semigrupo associativo, em definições mais fracas -- a exigência de elemento neutro multiplicativo varia por autor), e $dot$ é *distributiva* sobre $+$: $a dot (b+c) = a dot b + a dot c$ e $(a+b) dot c = a dot c + b dot c$.
]

== Comparação de propriedades algébricas

#table(
  columns: 6,
  [*Estrutura*], [*Fechamento*], [*Associatividade*], [*Elemento neutro*], [*Inverso*], [*Comutatividade*],
  [Monoide], [Sim], [Sim], [Sim], [Não exigido], [Não exigido],
  [Grupo], [Sim], [Sim], [Sim], [Sim (todo elemento)], [Não exigido],
  [Grupo abeliano], [Sim], [Sim], [Sim], [Sim], [Sim],
  [Anel (op. $+$)], [Sim], [Sim], [Sim], [Sim], [Sim (sempre abeliano em $+$)],
  [Anel (op. $dot$)], [Sim], [Sim], [Varia por definição], [Não exigido], [Varia (nem todo anel é comutativo em $dot$)],
)

== Exemplo resolvido

#example(name: "(ℤ,+) como grupo e (ℤ,+,×) como anel", id: "ex-inteiros-grupo-anel")[
  - $(ZZ, +)$: fechado (soma de inteiros é inteiro), associativo, elemento neutro $0$, todo $a$ tem inverso $-a$, comutativo -- *grupo abeliano*.
  - $(ZZ, +, times)$: $(ZZ,+)$ já é grupo abeliano (acima); $(ZZ, times)$ é fechado, associativo, com elemento neutro $1$ (mas *sem* inverso multiplicativo geral -- ex.: $2$ não tem inverso inteiro); $times$ distribui sobre $+$ -- satisfaz a definição de *anel* (mesmo sem inversos multiplicativos, o que tornaria um *corpo*, estrutura fora do escopo direto desta seção).

  #figure(
    image("figures/cayley-table-s3.svg", width: 40%),
    caption: [Tábua de Cayley do grupo simétrico $S_3$ (permutações de 3 elementos): cada célula mostra o resultado da operação entre o elemento da linha e o da coluna -- forma padrão de verificar as propriedades de grupo em estruturas finitas pequenas. Fonte: Wikimedia Commons, CC BY-SA 4.0 (Matthias Zipper).],
  )

  #figure(
    image("figures/hasse-diagram.svg", width: 35%),
    caption: [Diagrama de Hasse de um reticulado de divisores: a ordem é dada por divisibilidade, com join/meet correspondendo a mínimo múltiplo comum/máximo divisor comum. Fonte: Wikimedia Commons, domínio público.],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "Verificar TODAS as propriedades, uma por vez, sistematicamente")[
  O erro mais comum é concluir apertadamente que uma estrutura "parece" um grupo sem checar cada propriedade individualmente -- em especial, esquecer de verificar a existência de inverso para *todo* elemento (não só alguns), ou assumir comutatividade sem prová-la (grupos não abelianos existem e são comuns, como $S_3$ do exemplo).
]

#remark(name: "Nem todo monoide é grupo; nem todo grupo é abeliano; nem todo anel exige inverso multiplicativo")[
  A hierarquia é estritamente crescente em exigências: monoide ⊂ grupo ⊂ grupo abeliano, em termos de propriedades exigidas -- mas cada seta é uma implicação em um único sentido. $(NN, +)$ é monoide (elemento neutro $0$), mas não é grupo (nenhum natural positivo tem inverso aditivo natural).
]

== Questões estilo POSCOMP

*Questão 1.* A estrutura $(NN, +)$ (naturais com adição) é:
- a) Um grupo, pois é fechada e associativa.
- b) Um monoide, mas não um grupo (falta inverso aditivo para elementos positivos).
- c) Um anel.
- d) Um reticulado.
- e) Não satisfaz nem fechamento nem associatividade.

*Questão 2.* Para que $(G, *)$ seja um grupo, é necessário que, além de fechamento e associatividade:
- a) $*$ seja comutativa.
- b) Exista elemento neutro e todo elemento tenha inverso.
- c) $G$ seja finito.
- d) Exista apenas elemento neutro, sem necessidade de inverso.
- e) $G$ seja um conjunto de números reais.

*Questão 3.* Em um reticulado $(L, <=)$, o supremo (join, $or.big$) de dois elementos $a,b$ é:
- a) O produto de $a$ e $b$.
- b) A menor cota superior de $\{a,b\}$ em $L$.
- c) A maior cota inferior de $\{a,b\}$ em $L$.
- d) Sempre igual a $a$.
- e) Indefinido para todo par de elementos.

== Gabarito comentado

1. *(b)* -- $(NN,+)$ tem elemento neutro ($0$) mas não inverso aditivo para naturais positivos: monoide, não grupo.
2. *(b)* -- definição direta de grupo, acrescentando elemento neutro e inverso universal ao monoide.
3. *(b)* -- definição direta de supremo (join) em um reticulado.

== Referências

- ROSEN, K. H. *Matemática Discreta e suas Aplicações*. Cap. 13 (Estruturas algébricas).
- HERSTEIN, I. N. *Topics in Algebra*. Cap. 2 (Grupos) e Cap. 3 (Anéis).
- SCHEINERMAN, E. R. *Matemática Discreta: Uma Introdução*. Cap. 10 (Reticulados e ordens).
