#import "@preview/mousse-notes:1.1.0": *

= Autômatos Finitos

== Conceito de Autômato

Um *autômato* é um modelo matemático de uma máquina abstrata. Ele lê uma palavra símbolo por símbolo e, ao final, decide se a palavra pertence ou não a uma linguagem.

Pense em um autômato como uma _máquina de estados_: a qualquer momento, ela está em um determinado *estado*, e ao ler um símbolo, ela muda para outro estado (ou permanece no mesmo).

== Estados e Transições

- *Estado*: representa uma "situação" ou "memória" da máquina em um dado momento.
- *Estado inicial*: onde a máquina começa a processar a entrada.
- *Estado(s) final(is)* (ou de aceitação): se a máquina terminar aqui, ela *aceita* a palavra.
- *Transição*: ao ler um símbolo, a máquina muda de estado conforme uma função definida.

Graficamente, estados são representados por círculos. O estado inicial possui uma seta de entrada sem origem, e os estados finais são indicados com círculo duplo.

== Autômatos Finitos Determinísticos (AFD)

#definition[
  Um *Autômato Finito Determinístico (AFD)* é uma quíntupla:
  $ M = (Q, Sigma, delta, q_0, F) $
  onde:
  - $Q$: conjunto finito de estados
  - $Sigma$: alfabeto de entrada
  - $delta: Q times Sigma -> Q$: função de transição (determinística)
  - $q_0 in Q$: estado inicial
  - $F subset.eq Q$: conjunto de estados finais (de aceitação)
]

Em linguagem simples: em cada estado, ao ler cada símbolo, existe *exatamente uma* transição possível — por isso é "determinístico".

=== Exemplo de AFD

AFD que aceita palavras sobre $Sigma = {a, b}$ que *terminam em $b$*.

Estados: $Q = {q_0, q_1}$, inicial: $q_0$, final: $F = {q_1}$

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$q_0$ (inicial)], [$q_0$], [$q_1$],
  [$q_1$ (final)],   [$q_0$], [$q_1$],
)

*Trace de execução* para a palavra $a b b$:
$ q_0 ->^a q_0 ->^b q_1 ->^b q_1 $
Termina em $q_1$ (estado final) → palavra *aceita* ✓

*Trace* para a palavra $b a$:
$ q_0 ->^b q_1 ->^a q_0 $
Termina em $q_0$ (não é final) → palavra *rejeitada* ✗

== Autômatos Finitos Não Determinísticos (AFN)

#definition[
  Um *Autômato Finito Não Determinístico (AFN)* é uma quíntupla:
  $ M = (Q, Sigma, delta, q_0, F) $
  onde a função de transição é:
  $ delta: Q times (Sigma union {epsilon}) -> cal(P)(Q) $

  Ou seja, ela retorna um *conjunto* de estados (possivelmente vazio), e pode haver transições por $epsilon$ (sem consumir símbolo).
]

Em linguagem simples: o autômato pode estar em vários estados ao mesmo tempo, ou pular para outro estado sem ler nenhum símbolo. Ele *aceita* uma palavra se _alguma_ sequência de escolhas levar a um estado final.

*Propriedade fundamental:* Todo AFN pode ser convertido em um AFD equivalente que aceita a mesma linguagem. Os AFNs são geralmente mais fáceis de projetar.

=== Exemplo de AFN

AFN que aceita palavras sobre $Sigma = {a, b}$ que contêm $a b$ como subcadeia.

#table(
  columns: (auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$], [$epsilon$]),
  [$q_0$ (inicial)], [$\{q_0, q_1\}$], [$\{q_0\}$], [$emptyset$],
  [$q_1$],           [$emptyset$],      [$\{q_2\}$], [$emptyset$],
  [$q_2$ (final)],   [$\{q_2\}$],      [$\{q_2\}$], [$emptyset$],
)

*Intuição:* Em $q_0$, ao ler $a$, o autômato "aposta" que encontrou o início de $a b$ (vai para $q_1$) e também continua lendo do início (fica em $q_0$). Se em seguida vier $b$, chega em $q_2$ (aceitação) e lá permanece para qualquer símbolo lido.
