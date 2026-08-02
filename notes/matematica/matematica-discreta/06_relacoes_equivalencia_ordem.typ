#import "@preview/mousse-notes:1.1.0": *

= Relações sobre Conjuntos, Relações de Equivalência e Ordem
#text(size: 9pt, style: "italic")[Edital POSCOMP: 6.6]

== Introdução

Toda função (04) é uma relação, mas relações são um conceito mais geral -- e suas propriedades (reflexividade, simetria, transitividade...) definem duas famílias centrais: relações de *equivalência* e relações de *ordem*, facilmente confundidas em prova.

== Definições formais

#definition(name: "Relação (binária)", id: "def-relacao-binaria")[
  Uma relação binária $R$ sobre um conjunto $A$ é simplesmente um subconjunto $R subset.eq A times A$ (03) -- escreve-se $a R b$ para $(a,b) in R$. Diferente de uma função (04), uma relação não exige totalidade nem unicidade.
]

#definition(name: "Propriedades de relações", id: "def-propriedades-relacoes")[
  Para $R subset.eq A times A$:
  - *Reflexiva*: $forall a in A, a R a$.
  - *Simétrica*: $forall a,b in A, a R b arrow.r.double b R a$.
  - *Antissimétrica*: $forall a,b in A, (a R b " e " b R a) arrow.r.double a=b$.
  - *Transitiva*: $forall a,b,c in A, (a R b " e " b R c) arrow.r.double a R c$.
]

#definition(name: "Relação de equivalência", id: "def-relacao-equivalencia")[
  Relação reflexiva, simétrica e transitiva simultaneamente. Toda relação de equivalência $R$ sobre $A$ *particiona* $A$ em *classes de equivalência* disjuntas: $[a]_R = \{b in A : a R b\}$, com $A = union.big_a [a]_R$ e classes distintas sempre disjuntas.
]

#definition(name: "Relação de ordem (parcial)", id: "def-relacao-ordem-parcial")[
  Relação reflexiva, antissimétrica e transitiva simultaneamente. Não particiona o conjunto -- em vez disso, *ordena* (parcialmente, pois nem todo par precisa ser comparável) os elementos de $A$, permitindo falar em "menor ou igual" ($<=$) de forma abstrata.
]

== Exemplo resolvido

#example(name: "Classificando duas relações", id: "ex-classificando-relacoes")[
  - $R_1$ sobre $ZZ$: $a R_1 b arrow.l.r.double a - b$ é múltiplo de $3$. É reflexiva ($a-a=0$, múltiplo de 3), simétrica (se $a-b$ é múltiplo de 3, $b-a$ também é), transitiva (se $a-b$ e $b-c$ são múltiplos de 3, $a-c=(a-b)+(b-c)$ também é) -- *relação de equivalência*. Classes de equivalência: $[0]=\{dots,-3,0,3,6,dots\}$, $[1]=\{dots,-2,1,4,dots\}$, $[2]=\{dots,-1,2,5,dots\}$ -- particiona $ZZ$ em exatamente 3 classes.
  - $R_2$ sobre o conjunto de subconjuntos de $\{1,2,3\}$: $A R_2 B arrow.l.r.double A subset.eq B$. É reflexiva ($A subset.eq A$), antissimétrica ($A subset.eq B " e " B subset.eq A arrow.r.double A=B$), transitiva -- *relação de ordem parcial* (parcial pois, ex., $\{1\}$ e $\{2\}$ não são comparáveis por $subset.eq$ em nenhuma direção).
]

== Atenção -- pegadinhas comuns

#remark(name: "Equivalência particiona; ordem ordena -- a pegadinha mais clássica desta seção")[
  As duas famílias compartilham reflexividade e transitividade, mas divergem exatamente no terceiro axioma: equivalência exige *simetria* (produzindo classes que particionam o conjunto, sem noção de "maior/menor"); ordem exige *antissimetria* (produzindo uma hierarquia/ordenação, sem agrupar elementos em classes). Uma relação não pode ser simétrica e antissimétrica ao mesmo tempo sobre um conjunto com mais de um elemento relacionado de forma não trivial -- exceto no caso degenerado da igualdade.
]

#remark(name: "Ordem \"parcial\" significa que nem todo par precisa ser comparável")[
  Diferente de uma *ordem total* (onde quaisquer dois elementos são comparáveis, como $<=$ nos reais), uma ordem parcial permite pares incomparáveis -- como $\{1\}$ e $\{2\}$ no exemplo desta seção. Tratar toda ordem parcial como se fosse total é um erro recorrente.
]

== Questões estilo POSCOMP

*Questão 1.* Uma relação de equivalência sobre um conjunto $A$ satisfaz simultaneamente:
- a) Reflexividade, antissimetria e transitividade.
- b) Reflexividade, simetria e transitividade.
- c) Apenas simetria.
- d) Apenas transitividade.
- e) Simetria e antissimetria, sem reflexividade.

*Questão 2.* A relação $subset.eq$ sobre o conjunto das partes de um conjunto $S$ é um exemplo de:
- a) Relação de equivalência.
- b) Relação de ordem parcial.
- c) Função bijetora.
- d) Relação não reflexiva.
- e) Relação simétrica.

*Questão 3.* Se uma relação de equivalência sobre um conjunto $A$ tem exatamente 4 classes de equivalência distintas, é correto afirmar que:
- a) As 4 classes se sobrepõem parcialmente.
- b) As 4 classes são disjuntas e sua união é o próprio $A$.
- c) $A$ tem exatamente 4 elementos.
- d) A relação não é transitiva.
- e) A relação é uma ordem parcial, não uma equivalência.

== Gabarito comentado

1. *(b)* -- reflexividade, simetria e transitividade definem exatamente uma relação de equivalência.
2. *(b)* -- inclusão de conjuntos é reflexiva, antissimétrica e transitiva, mas não total: relação de ordem parcial.
3. *(b)* -- classes de equivalência são sempre disjuntas e cobrem todo o conjunto, por definição de partição.

== Referências

- ROSEN, K. H. *Matemática Discreta e suas Aplicações*. Cap. 9 (Relações).
- SCHEINERMAN, E. R. *Matemática Discreta: Uma Introdução*. Cap. 6.
