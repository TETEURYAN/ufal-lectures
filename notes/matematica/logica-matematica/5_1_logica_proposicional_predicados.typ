#import "@preview/mousse-notes:1.1.0": *

= 5.1 --- Lógica Proposicional e de Predicados

== Introdução

A Lógica Matemática formaliza o raciocínio válido. A Lógica Proposicional trata da estrutura de sentenças combinadas por conectivos; a Lógica de Predicados estende isso permitindo falar sobre propriedades de objetos e quantificá-los. É a base sobre a qual todo o resto da disciplina (linguagem formal, sistemas dedutivos, semântica) se apoia.

== Definições formais

#definition(name: "Proposição e conectivos lógicos", id: "def-proposicao-conectivos")[
  Uma *proposição* é uma sentença declarativa à qual se pode atribuir exatamente um valor-verdade (verdadeiro ou falso). Proposições atômicas são combinadas por *conectivos*:
  - Negação: $not p$ ("não $p$").
  - Conjunção: $p and q$ ("$p$ e $q$").
  - Disjunção: $p or q$ ("$p$ ou $q$", inclusivo).
  - Condicional (implicação): $p -> q$ ("se $p$ então $q$").
  - Bicondicional: $p <-> q$ ("$p$ se e somente se $q$").
]

#definition(name: "Predicado e quantificadores", id: "def-predicado-quantificadores")[
  Um *predicado* $P(x)$ é uma sentença cujo valor-verdade depende de um ou mais argumentos $x$, variando sobre um *domínio* $D$ explícito. Os *quantificadores* fecham essa dependência:
  - Universal: $forall x in D, P(x)$ ("para todo $x$ em $D$, $P(x)$").
  - Existencial: $exists x in D, P(x)$ ("existe pelo menos um $x$ em $D$ tal que $P(x)$").
]

== Exemplo resolvido

#example(name: "Traduzindo sentenças para lógica proposicional e de predicados", id: "ex-traducao-logica")[
  - "Se chove, então a rua fica molhada": seja $p$ = "chove", $q$ = "a rua fica molhada" $arrow.r$ $p -> q$ (proposicional).
  - "Todo número natural par é divisível por 2", com domínio $D = NN$: seja $P(x)$ = "$x$ é par", $Q(x)$ = "$x$ é divisível por 2" $arrow.r$ $forall x in NN, (P(x) -> Q(x))$ (predicados).
  - "Existe um número primo par", domínio $D = NN$: seja $R(x)$ = "$x$ é primo", $P(x)$ = "$x$ é par" $arrow.r$ $exists x in NN, (R(x) and P(x))$ -- verdadeira, testemunhada por $x=2$.
]

#figure(
  image("figures/venn-intersection.svg", width: 40%),
  caption: [Diagrama de Venn da interseção $A inter B$: a área sombreada corresponde à semântica conjuntista de $p and q$ (verdadeiro exatamente onde ambos os conjuntos/proposições valem). Fonte: Wikimedia Commons, domínio público.],
)

== Atenção -- pegadinhas comuns

#remark(name: "\"Ou\" lógico é inclusivo, não exclusivo")[
  Em lógica, $p or q$ é verdadeiro quando *pelo menos um* dos dois é verdadeiro (inclusive quando ambos são) -- diferente do "ou exclusivo" do português coloquial ("ou vai, ou fica"), que corresponde ao operador XOR, não à disjunção lógica padrão.
]

#remark(name: "O domínio do quantificador nunca deve ficar implícito na formalização")[
  "$forall x, P(x)$" só tem significado preciso quando o domínio de $x$ está claro -- a mesma sentença em português pode ser verdadeira sobre um domínio e falsa sobre outro. A prova costuma explicitar (ou exigir que você explicite) o domínio corretamente.
]

== Questões estilo POSCOMP

*Questão 1.* A sentença "$p or q$", com $p$ falso e $q$ verdadeiro, tem valor-verdade:
- a) Falso.
- b) Verdadeiro.
- c) Indeterminado.
- d) Depende do domínio.
- e) Nenhuma das anteriores.

*Questão 2.* A formalização correta de "todo número inteiro tem um sucessor", com domínio $ZZ$, é:
- a) $exists x in ZZ, exists y in ZZ, y = x+1$.
- b) $forall x in ZZ, exists y in ZZ, y = x+1$.
- c) $exists x in ZZ, forall y in ZZ, y = x+1$.
- d) $forall x in ZZ, forall y in ZZ, y = x+1$.
- e) $not exists x in ZZ, y = x+1$.

*Questão 3.* A sentença "existe um número real cujo quadrado é negativo" é:
- a) Verdadeira, para o domínio dos reais.
- b) Falsa, para o domínio dos reais.
- c) Verdadeira, apenas para o domínio dos complexos, e a formalização exige explicitar isso.
- d) Uma proposição, não uma fórmula de predicados.
- e) Indecidível.

== Gabarito comentado

1. *(b)* -- disjunção inclusiva: basta um dos dois ser verdadeiro.
2. *(b)* -- "todo... existe" traduz-se com $forall$ externo e $exists$ interno, nessa ordem.
3. *(b)/(c)* -- falsa no domínio dos reais (quadrado de real é sempre $>=0$); a questão ilustra exatamente a observação desta seção sobre a importância de explicitar o domínio.

== Referências

- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 1 (Lógica proposicional).
- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 1--2.
- cienciadacomputacao.wiki.br -- Tópico 5, subtópico 5.1.
