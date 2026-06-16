#import "@preview/mousse-notes:1.1.0": *

= Relação entre Expressões Regulares e Autômatos

== Equivalência Conceitual

Um dos resultados mais elegantes da teoria é que expressões regulares e autômatos finitos são *igualmente poderosos* — eles descrevem exatamente a mesma classe de linguagens: as *linguagens regulares*.

#definition[
  O *Teorema de Kleene* estabelece:

  Uma linguagem $L$ é regular *se e somente se* existe:
  - uma expressão regular que a descreve, *ou equivalentemente*,
  - um AFD (ou AFN) que a reconhece.
]

Isso significa que qualquer linguagem que você possa escrever com uma expressão regular pode ser reconhecida por um autômato finito, e vice-versa.

== As Três Conversões Principais

+ *ER → AFN* (algoritmo de Thompson): constrói um AFN a partir de uma ER por indução na estrutura da expressão. Cada operador ($|$, concatenação, $*$) tem uma construção de autômato correspondente.

+ *AFN → AFD* (construção de subconjuntos): cada estado do AFD corresponde a um *conjunto* de estados do AFN. Se o AFN tem $n$ estados, o AFD pode ter até $2^n$ estados.

+ *AFD → ER* (eliminação de estados): transforma o autômato em um sistema de equações de Arden e resolve, obtendo uma expressão regular.

== Exemplos Práticos

=== Exemplo 1: ER $a^* b$ e seu autômato

A expressão $a^* b$ (zero ou mais $a$'s seguidos de um $b$) corresponde a um AFD com 2 estados:

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$q_0$ (inicial)], [$q_0$], [$q_1$],
  [$q_1$ (final)],   [—],     [—],
)

Estado $q_0$: loop por $a$; ao ler $b$, vai para $q_1$ (final). Após $q_1$, não há mais transições definidas — qualquer símbolo adicional seria rejeitado.

=== Exemplo 2: ER $(a | b)^* a$ e seu AFD

Palavras que terminam em $a$. O AFD correspondente:

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$q_0$ (inicial)],       [$q_1$], [$q_0$],
  [$q_1$ (final)],         [$q_1$], [$q_0$],
)

*Intuição:* $q_1$ representa "o último símbolo lido foi $a$". Qualquer $b$ nos devolve ao estado "o último símbolo não foi $a$" ($q_0$).

=== Exemplo 3: Convertendo um AFD em ER

Dado o AFD do Exemplo 2, podemos recuperar a expressão regular eliminando $q_1$:

A equação de estado de $q_0$ é: $q_0 = b q_0 | a q_1$, e de $q_1$: $q_1 = a q_1 | b q_0 | epsilon$ (pois $q_1$ é final).

Resolvendo: $q_1 = a^*(b q_0 | epsilon)$, e substituindo: chegamos à ER $(a | b)^* a$. ✓
