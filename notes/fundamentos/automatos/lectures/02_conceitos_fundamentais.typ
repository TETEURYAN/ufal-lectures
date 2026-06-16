#import "@preview/mousse-notes:1.1.0": *

= Conceitos Fundamentais

== Alfabeto ($Sigma$)

#definition[
  Um *alfabeto* $Sigma$ é um conjunto *finito e não vazio* de símbolos.
]

Em linguagem simples: um alfabeto é a "coleção de letras" que usaremos para formar palavras. Exemplos:

- $Sigma_1 = {0, 1}$ — o alfabeto binário (usado em computadores)
- $Sigma_2 = {a, b, c, ..., z}$ — o alfabeto latino minúsculo
- $Sigma_3 = {(, )}$ — alfabeto de parênteses

== Símbolo

#definition[
  Um *símbolo* (ou _letra_) é qualquer elemento individual pertencente a um alfabeto.
]

Por exemplo, no alfabeto $Sigma_1 = {0, 1}$, os símbolos são $0$ e $1$.

== Palavra ou Cadeia

#definition[
  Uma *palavra* (ou _cadeia_, _string_) sobre um alfabeto $Sigma$ é uma sequência *finita* de símbolos de $Sigma$.
]

Exemplos com $Sigma = {a, b}$:

- $w_1 = a b$ — palavra de comprimento 2
- $w_2 = a a b b a$ — palavra de comprimento 5
- $epsilon$ — a *palavra vazia* (sem nenhum símbolo, comprimento 0)

O comprimento de uma palavra $w$ é denotado $|w|$. Assim, $|a b| = 2$ e $|epsilon| = 0$.

O conjunto de _todas_ as palavras possíveis sobre $Sigma$ é denotado $Sigma^*$ (lê-se "Sigma estrela"). Por exemplo:

${0, 1}^* = {epsilon, 0, 1, 00, 01, 10, 11, 000, ...}$

== Linguagem

#definition[
  Uma *linguagem* $L$ sobre um alfabeto $Sigma$ é qualquer subconjunto de $Sigma^*$:
  $ L subset.eq Sigma^* $
]

Exemplos de linguagens sobre $Sigma = {0, 1}$:

- $L_1 = {01, 10, 11}$ — linguagem finita com 3 palavras
- $L_2 = {w in {0,1}^* | w "começa com" 0}$ — infinita
- $L_3 = emptyset$ — a linguagem vazia (sem palavras)
- $L_4 = Sigma^*$ — a linguagem com todas as palavras

== Operações sobre Linguagens

Dadas linguagens $L_1$ e $L_2$ sobre $Sigma$, definimos:

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: (left, left, left),
  table.header([*Operação*], [*Notação*], [*Definição*]),
  [União],          [$L_1 union L_2$],    [Palavras em $L_1$ *ou* em $L_2$],
  [Interseção],     [$L_1 sect L_2$],     [Palavras em $L_1$ *e* em $L_2$],
  [Complemento],    [$overline(L_1)$],    [Palavras em $Sigma^*$ que *não* estão em $L_1$],
  [Concatenação],   [$L_1 dot L_2$],      [Palavras $x y$ onde $x in L_1, y in L_2$],
  [Fecho de Kleene],[$L_1^*$],            [Zero ou mais concatenações de palavras de $L_1$],
)

*Exemplo de concatenação:* Se $L_1 = {a}$ e $L_2 = {b, b b}$, então:
$ L_1 dot L_2 = {a b, a b b} $

*Exemplo de fecho:* Se $L = {01}$, então:
$ L^* = {epsilon, 01, 0101, 010101, ...} $
