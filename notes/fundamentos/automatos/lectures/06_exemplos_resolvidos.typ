#import "@preview/mousse-notes:1.1.0": *

= Exemplos Resolvidos

== Exemplo 1: AFD para palavras com número par de $a$'s

*Problema:* Construir um AFD sobre $Sigma = {a, b}$ que aceite exatamente as palavras com um número *par* de ocorrências do símbolo $a$ (zero é considerado par).

=== Passo 1 — Identificar os estados necessários

O autômato precisa "lembrar" se o número de $a$'s lidos até agora é par ou ímpar. São necessários dois estados:

- $q_"par"$: número de $a$'s lidos até aqui é *par* (estado inicial e final)
- $q_"impar"$: número de $a$'s lidos até aqui é *ímpar*

=== Passo 2 — Definir as transições

Ao ler $a$: a paridade muda (par → ímpar, ímpar → par). Ao ler $b$: a paridade não muda.

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$q_"par"$ (inicial, final)], [$q_"impar"$], [$q_"par"$],
  [$q_"impar"$],                [$q_"par"$],   [$q_"impar"$],
)

=== Passo 3 — Verificação

Trace para a palavra $a a b a a$ (4 ocorrências de $a$ → par → deve aceitar):

$ q_"par" ->^a q_"impar" ->^a q_"par" ->^b q_"par" ->^a q_"impar" ->^a q_"par" $

Termina em $q_"par"$ → *aceita* ✓

Trace para $a b a$ (2 ocorrências de $a$ → par → deve aceitar):

$ q_"par" ->^a q_"impar" ->^b q_"impar" ->^a q_"par" $

Termina em $q_"par"$ → *aceita* ✓

Trace para $a b$ (1 ocorrência de $a$ → ímpar → deve rejeitar):

$ q_"par" ->^a q_"impar" ->^b q_"impar" $

Termina em $q_"impar"$ → *rejeita* ✓

== Exemplo 2: ER para identificadores simples

*Problema:* Escrever uma ER para identificadores de linguagens de programação: começam com uma letra e são seguidos por zero ou mais letras ou dígitos.

=== Passo 1 — Definir os componentes

- $"letra"$ representa qualquer letra: $a | b | ... | z | A | ... | Z$
- $"digito"$ representa qualquer dígito: $0 | 1 | ... | 9$

=== Passo 2 — Estrutura do identificador

Um identificador começa com exatamente uma letra, depois pode ter zero ou mais letras *ou* dígitos.

=== Passo 3 — Montar a ER

$ "letra" dot ("letra" | "digito")^* $

=== Verificação

- $x$ → aceita (uma letra, zero sufixos) ✓
- $"var1"$ → aceita ($v$, seguido de $a$, $r$, $1$) ✓
- $"nome23"$ → aceita ✓
- $1"var"$ → *rejeita* (começa com dígito) ✓

== Exemplo 3: AFN para palavras que terminam em $01$

*Problema:* Construir um AFN sobre $Sigma = {0, 1}$ que aceite exatamente as palavras que terminam com a subcadeia $0 1$.

=== Passo 1 — Identificar os estados

- $q_0$: estado inicial — processando qualquer prefixo
- $q_1$: acabamos de ler um $0$ que pode ser o início de $0 1$
- $q_2$: acabamos de completar $0 1$ (estado final)

=== Passo 2 — Definir as transições

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$0$], [$1$]),
  [$q_0$ (inicial)], [$\{q_0, q_1\}$], [$\{q_0\}$],
  [$q_1$],           [$emptyset$],      [$\{q_2\}$],
  [$q_2$ (final)],   [$emptyset$],      [$emptyset$],
)

=== Passo 3 — Verificação para $1 0 0 1$

O AFN explora múltiplos caminhos. Um caminho bem-sucedido:

$ q_0 ->^1 q_0 ->^0 q_0 ->^0 q_1 ->^1 q_2 quad arrow.r "aceito" checkmark $

Outro caminho (bloqueado):

$ q_0 ->^1 q_0 ->^0 q_1 ->^0 ? quad arrow.r "bloqueado" $

Como *existe* pelo menos um caminho de aceitação, a palavra é *aceita* ✓
