#import "@preview/mousse-notes:1.1.0": *

// ══════════════════════════════════════════════
// CAPA
// ══════════════════════════════════════════════

#align(center)[
  #v(6em)
  #text(size: 28pt, weight: "bold")[Introdução às Linguagens Formais e Autômatos]
  #v(1em)
  #text(size: 16pt, style: "italic")[Fundamentos da Computação Teórica]
  #v(3em)
  #line(length: 60%)
  #v(2em)
  #text(size: 12pt)[Disciplina: Linguagens Formais e Autômatos]
  #v(0.5em)
  #text(size: 12pt)[Ciência da Computação — 1º Período]
  #v(6em)
  #text(size: 11pt, style: "italic")[Material didático introdutório para estudantes iniciantes]
]

#pagebreak()

// ══════════════════════════════════════════════
// 1. INTRODUÇÃO
// ══════════════════════════════════════════════

= Introdução

== O que são Linguagens Formais?

Imagine que você quer ensinar um robô a entender comandos. Você precisa definir _exatamente_ quais sequências de palavras ele pode aceitar — sem ambiguidade. Esse é, em essência, o problema que as **linguagens formais** resolvem.

Uma linguagem formal é um conjunto de cadeias (sequências de símbolos) construídas a partir de um alfabeto definido, seguindo regras precisas. Ao contrário das linguagens naturais (como o português), as linguagens formais não admitem ambiguidade: cada sentença ou pertence à linguagem, ou não pertence.

#definition[
  Uma **linguagem formal** é um conjunto de palavras (cadeias de símbolos) definido sobre um alfabeto finito, especificado por meio de regras matemáticas precisas.
]

== Motivação Histórica

A teoria das linguagens formais tem raízes na matemática e na lógica do século XX. Os principais marcos históricos são:

- **Anos 1930 — Alan Turing e Alonzo Church**: investigaram o que pode ou não ser computado, formalizando os limites da computação.
- **Anos 1950 — Noam Chomsky**: linguista que criou a *Hierarquia de Chomsky*, classificando linguagens em quatro tipos (regulares, livres de contexto, sensíveis ao contexto e recursivamente enumeráveis).
- **Anos 1950–60 — Kleene, Rabin e Scott**: desenvolveram os autômatos finitos e as expressões regulares como ferramentas matemáticas para descrever linguagens regulares.
- **Anos 1960–70 — Knuth e outros**: aplicaram a teoria às linguagens de programação e compiladores.

Essa teoria, aparentemente abstrata, tornou-se a base de praticamente toda a computação moderna.

== Aplicações Práticas

#definition[
  *Por que estudar linguagens formais?*
  
  Porque elas fundamentam ferramentas que você usa todo dia como programador.
]

As principais áreas de aplicação são:

/ *Compiladores e interpretadores*: Toda linguagem de programação (Python, Java, C) é uma linguagem formal. O compilador usa autômatos e gramáticas para analisar o código-fonte.

/ *Editores de texto e buscas*: Ferramentas como `grep`, `sed`, e as funções de busca em editores usam *expressões regulares* — um dos tópicos centrais desta disciplina.

/ *Processamento de linguagem natural (PLN)*: Chatbots, tradutores automáticos e assistentes de voz utilizam gramáticas formais para analisar frases.

/ *Verificação de protocolos*: Sistemas de comunicação e segurança são modelados por autômatos para verificar seu comportamento.

/ *Bioinformática*: A análise de sequências de DNA é modelada como um problema de linguagens formais.

#pagebreak()

// ══════════════════════════════════════════════
// 2. CONCEITOS FUNDAMENTAIS
// ══════════════════════════════════════════════

= Conceitos Fundamentais

== Alfabeto ($Sigma$)

#definition[
  Um **alfabeto** $Sigma$ é um conjunto *finito e não vazio* de símbolos.
]

Em linguagem simples: um alfabeto é a "coleção de letras" que usaremos para formar palavras. Exemplos:

- $Sigma_1 = {0, 1}$ — o alfabeto binário (usado em computadores)
- $Sigma_2 = {a, b, c, ..., z}$ — o alfabeto latino minúsculo
- $Sigma_3 = {(, )}$ — alfabeto de parênteses

== Símbolo

#definition[
  Um **símbolo** (ou *letra*) é qualquer elemento individual pertencente a um alfabeto.
]

Por exemplo, no alfabeto $Sigma_1 = {0, 1}$, os símbolos são $0$ e $1$.

== Palavra ou Cadeia

#definition[
  Uma **palavra** (ou *cadeia*, *string*) sobre um alfabeto $Sigma$ é uma sequência *finita* de símbolos de $Sigma$.
]

Exemplos com $Sigma = {a, b}$:

- $w_1 = ab$ — palavra de comprimento 2
- $w_2 = aabba$ — palavra de comprimento 5
- $epsilon$ — a **palavra vazia** (sem nenhum símbolo, comprimento 0)

O comprimento de uma palavra $w$ é denotado $|w|$. Assim, $|ab| = 2$ e $|epsilon| = 0$.

O conjunto de *todas* as palavras possíveis sobre $Sigma$ é denotado $Sigma^*$ (lê-se "Sigma estrela"). Por exemplo:

${0, 1}^* = {epsilon, 0, 1, 00, 01, 10, 11, 000, ...}$

== Linguagem

#definition[
  Uma **linguagem** $L$ sobre um alfabeto $Sigma$ é qualquer subconjunto de $Sigma^*$:
  $L subset.eq Sigma^*$
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
  [União], [$L_1 union L_2$], [Palavras em $L_1$ *ou* em $L_2$],
  [Interseção], [$L_1 sect L_2$], [Palavras em $L_1$ *e* em $L_2$],
  [Complemento], [$overline(L_1)$], [Palavras em $Sigma^*$ que *não* estão em $L_1$],
  [Concatenação], [$L_1 dot L_2$], [Palavras $xy$ onde $x in L_1, y in L_2$],
  [Fecho de Kleene], [$L_1^*$], [Zero ou mais concatenações de palavras de $L_1$],
)

*Exemplo de concatenação:* Se $L_1 = {a}$ e $L_2 = {b, bb}$, então:
$L_1 dot L_2 = {ab, abb}$

*Exemplo de fecho:* Se $L = {01}$, então:
$L^* = {epsilon, 01, 0101, 010101, ...}$

#pagebreak()

// ══════════════════════════════════════════════
// 3. EXPRESSÕES REGULARES
// ══════════════════════════════════════════════

= Expressões Regulares

== Definição

Uma **expressão regular** (ER) é uma notação compacta para descrever linguagens regulares. Pense nelas como "receitas" que especificam padrões de palavras.

#definition[
  Dado um alfabeto $Sigma$, as **expressões regulares** sobre $Sigma$ são definidas recursivamente:
  - $emptyset$ é uma ER (denota a linguagem vazia)
  - $epsilon$ é uma ER (denota a linguagem ${epsilon}$)
  - Para cada $a in Sigma$, $a$ é uma ER (denota ${a}$)
  - Se $r$ e $s$ são ERs, então $(r | s)$, $(r dot s)$ e $r^*$ também são ERs
]

== Operadores Básicos

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: (left, left, left),
  table.header([*Operador*], [*Símbolo*], [*Significado*]),
  [União (ou alternância)], [$r | s$], [Palavras de $r$ *ou* de $s$],
  [Concatenação], [$r s$ ou $r dot s$], [Uma palavra de $r$ seguida de uma de $s$],
  [Fecho de Kleene], [$r^*$], [Zero ou mais repetições de $r$],
  [Fecho positivo], [$r^+$], [Uma ou mais repetições de $r$],
  [Opcional], [$r?$], [Zero ou uma ocorrência de $r$],
)

A *precedência* dos operadores (do maior para o menor) é: $*$ (fecho) $>$ concatenação $>$ $|$ (união).

== Exemplos Comentados

*Exemplo 1:* A ER $a^*b$ sobre $Sigma = {a, b}$

Denota palavras com zero ou mais $a$'s seguidas de exatamente um $b$:
$L = {b, ab, aab, aaab, ...}$

*Exemplo 2:* A ER $(0 | 1)^*$ sobre $Sigma = {0, 1}$

Denota _todas_ as palavras binárias (incluindo $epsilon$):
$L = {epsilon, 0, 1, 00, 01, 10, 11, ...} = {0, 1}^*$

*Exemplo 3:* A ER $(a b)^* a$ sobre $Sigma = {a, b}$

Denota palavras que alternam $a$ e $b$ e terminam em $a$:
$L = {a, aba, ababa, abababa, ...}$

*Exemplo 4 (aplicação prática):* Um número inteiro não-negativo pode ser descrito como:

$[1-9][0-9]^* | 0$

Ou seja: começa com um dígito de 1 a 9 e é seguido de quaisquer dígitos, ou é simplesmente $0$.

#pagebreak()

// ══════════════════════════════════════════════
// 4. AUTÔMATOS FINITOS
// ══════════════════════════════════════════════

= Autômatos Finitos

== Conceito de Autômato

Um **autômato** é um modelo matemático de uma máquina abstrata. Ele lê uma palavra símbolo por símbolo e, ao final, decide se a palavra pertence ou não a uma linguagem.

Pense em um autômato como uma _máquina de estados_: a qualquer momento, ela está em um determinado **estado**, e ao ler um símbolo, ela muda para outro estado (ou permanece no mesmo).

== Estados e Transições

- **Estado**: representa uma "situação" ou "memória" da máquina em um dado momento.
- **Estado inicial**: onde a máquina começa.
- **Estado(s) final(is)** (ou de aceitação): se a máquina terminar aqui, ela *aceita* a palavra.
- **Transição**: ao ler um símbolo, a máquina muda de estado conforme uma função definida.

Graficamente, estados são representados por círculos, o estado inicial tem uma seta de entrada, e estados finais têm círculo duplo.

== Autômatos Finitos Determinísticos (AFD)

#definition[
  Um **Autômato Finito Determinístico (AFD)** é uma quíntupla:
  $M = (Q, Sigma, delta, q_0, F)$
  onde:
  - $Q$: conjunto finito de estados
  - $Sigma$: alfabeto de entrada
  - $delta: Q times Sigma -> Q$: função de transição (determinística)
  - $q_0 in Q$: estado inicial
  - $F subset.eq Q$: conjunto de estados finais (de aceitação)
]

*Em linguagem simples:* em cada estado, ao ler cada símbolo, existe *exatamente uma* transição possível — por isso é "determinístico".

*Exemplo:* AFD que aceita palavras sobre $Sigma = {a, b}$ que terminam em $b$.

Estados: $Q = {q_0, q_1}$, inicial: $q_0$, final: $F = {q_1}$

Tabela de transições:

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$q_0$], [$q_0$], [$q_1$],
  [$q_1$], [$q_0$], [$q_1$],
)

*Diagrama (representação textual):*

```
     a           b
  ┌─────┐   a  ┌─────┐
  │ q₀  │─────▶│ q₁  │◀╗
  │     │◀─────│(aceit)│ ║ b
  └─────┘  b   └──────┘ ║
    ║  (ini)              ║
    ╚════════════════════╝ (a de q₁ volta para q₀)
```

*Trace de execução* para a palavra $"abb"$:

$q_0 ->^a q_0 ->^b q_1 ->^b q_1$

A máquina termina em $q_1$ (estado final) → palavra *aceita*.

*Trace* para $"ba"$:

$q_0 ->^b q_1 ->^a q_0$

Termina em $q_0$ (não é final) → palavra *rejeitada*.

== Autômatos Finitos Não Determinísticos (AFN)

#definition[
  Um **Autômato Finito Não Determinístico (AFN)** é uma quíntupla:
  $M = (Q, Sigma, delta, q_0, F)$
  onde a função de transição é:
  $delta: Q times (Sigma union {epsilon}) -> cal(P)(Q)$
  
  Ou seja, ela retorna um *conjunto* de estados (possivelmente vazio), e pode haver transições por $epsilon$ (sem consumir símbolo).
]

*Em linguagem simples:* o autômato pode estar em vários estados ao mesmo tempo, ou pular para outro estado sem ler nenhum símbolo. Ele *aceita* uma palavra se *alguma* sequência de escolhas levar a um estado final.

*Propriedade fundamental:* Todo AFN pode ser convertido em um AFD equivalente (que aceita a mesma linguagem). Os AFNs são geralmente mais fáceis de projetar.

*Exemplo:* AFN que aceita palavras sobre $Sigma = {a, b}$ que contêm $"ab"$ como subcadeia.

#table(
  columns: (auto, auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$], [$epsilon$]),
  [$q_0$], [$\{q_0, q_1\}$], [$\{q_0\}$], [$emptyset$],
  [$q_1$], [$emptyset$], [$\{q_2\}$], [$emptyset$],
  [$q_2$], [$\{q_2\}$], [$\{q_2\}$], [$emptyset$],
)

Estado inicial: $q_0$. Estado final: $F = {q_2}$.

*Intuição:* Em $q_0$, ao ler $a$, o autômato "aposta" que encontrou o início de $"ab"$ (vai para $q_1$) e também continua lendo do começo (fica em $q_0$). Se em seguida vier $b$, chega em $q_2$ (aceitação) e lá permanece.

#pagebreak()

// ══════════════════════════════════════════════
// 5. RELAÇÃO ENTRE ERs E AUTÔMATOS
// ══════════════════════════════════════════════

= Relação entre Expressões Regulares e Autômatos

== Equivalência Conceitual

Um dos resultados mais belos da teoria é que expressões regulares e autômatos finitos são *igualmente poderosos* — eles descrevem exatamente a mesma classe de linguagens: as **linguagens regulares**.

#definition[
  O *Teorema de Kleene* estabelece:
  Uma linguagem $L$ é regular *se e somente se* existe:
  - uma expressão regular que a descreve, *ou equivalentemente*,
  - um AFD (ou AFN) que a reconhece.
]

Isso significa que qualquer linguagem que você possa escrever com uma expressão regular pode ser reconhecida por um autômato finito, e vice-versa.

== Conversões

As três conversões principais são:

+ *ER → AFN*: algoritmo de Thompson — constrói um AFN a partir de uma ER por indução na estrutura da expressão.
+ *AFN → AFD*: algoritmo de construção de subconjuntos — cada estado do AFD corresponde a um conjunto de estados do AFN.
+ *AFD → ER*: eliminação de estados — transforma o autômato em um sistema de equações e resolve.

== Exemplos Práticos

*Exemplo 1:* A ER $a^*b$ corresponde a um autômato com 2 estados:

```
  ─▶ [q₀] ──b──▶ ((q₁))
      ╔╝ a
```

Estado $q_0$: loop por $a$; ao ler $b$, vai para $q_1$ (final).

*Exemplo 2:* A ER $(a | b)^* a$ (palavras que terminam em $a$) corresponde ao seguinte AFD:

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$q_0$ (ini)], [$q_1$], [$q_0$],
  [$q_1$ (final)], [$q_1$], [$q_0$],
)

#pagebreak()

// ══════════════════════════════════════════════
// 6. EXEMPLOS RESOLVIDOS
// ══════════════════════════════════════════════

= Exemplos Resolvidos

== Exemplo 1: AFD para palavras com número par de $a$'s

*Problema:* Construir um AFD sobre $Sigma = {a, b}$ que aceite exatamente as palavras com um número *par* de ocorrências do símbolo $a$ (zero é par).

*Solução passo a passo:*

*Passo 1 — Identificar os estados necessários.* O autômato precisa "lembrar" se o número de $a$'s lidos até agora é par ou ímpar. Logo, dois estados:
- $q_{"par"}$: número de $a$'s lido até aqui é par (estado inicial e final)
- $q_{"impar"}$: número de $a$'s lido até aqui é ímpar

*Passo 2 — Definir as transições.*

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$q_{"par"}$ (ini, final)], [$q_{"impar"}$], [$q_{"par"}$],
  [$q_{"impar"}$], [$q_{"par"}$], [$q_{"impar"}$],
)

*Passo 3 — Verificação.* Palavra $"aabaa"$:

$q_{"par"} ->^a q_{"impar"} ->^a q_{"par"} ->^b q_{"par"} ->^a q_{"impar"} ->^a q_{"par"}$

Termina em $q_{"par"}$ → aceita (4 ocorrências de $a$, que é par). ✓

== Exemplo 2: ER para identificadores simples

*Problema:* Escrever uma ER para identificadores de linguagens de programação: começam com letra e são seguidos por letras ou dígitos.

*Solução passo a passo:*

*Passo 1:* Defina os componentes:
- $"letra"$ = $a | b | ... | z | A | ... | Z$
- $"digito"$ = $0 | 1 | ... | 9$

*Passo 2:* Um identificador começa com uma letra:
$"letra"$

*Passo 3:* Seguido de zero ou mais letras *ou* dígitos:
$("letra" | "digito")^*$

*Passo 4:* ER completa:
$"letra" dot ("letra" | "digito")^*$

*Exemplos de palavras aceitas:* $"x"$, $"var1"$, $"nome23"$, $"ABC"$

*Exemplos de palavras rejeitadas:* $"1var"$ (começa com dígito), $"\_x"$ (começa com sublinhado)

== Exemplo 3: AFN para palavras que terminam em $"01"$

*Problema:* Construir um AFN sobre $Sigma = {0, 1}$ que aceite exatamente as palavras que terminam com a subcadeia $"01"$.

*Solução passo a passo:*

*Passo 1 — Estados:*
- $q_0$: estado inicial (qualquer prefixo)
- $q_1$: acabamos de ler um $0$ que pode ser o início de $"01"$
- $q_2$: acabamos de ler $"01"$ (estado final)

*Passo 2 — Transições:*

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$0$], [$1$]),
  [$q_0$ (ini)], [$\{q_0, q_1\}$], [$\{q_0\}$],
  [$q_1$], [$emptyset$], [$\{q_2\}$],
  [$q_2$ (final)], [$emptyset$], [$emptyset$],
)

*Passo 3 — Verificação* para $"1001"$:

O AFN explorará múltiplos caminhos simultaneamente. Um caminho bem-sucedido:

$q_0 ->^1 q_0 ->^0 q_1 ->^0 ? $ (bloqueado)

Outro caminho:

$q_0 ->^1 q_0 ->^0 q_0 ->^0 q_1 ->^1 q_2$ ← aceito ✓

#pagebreak()

// ══════════════════════════════════════════════
// 7. EXERCÍCIOS PROPOSTOS
// ══════════════════════════════════════════════

= Exercícios Propostos

Os exercícios a seguir estão organizados em dificuldade crescente.

== Nível Básico

*Exercício 1.* Dado o alfabeto $Sigma = {0, 1}$, escreva três palavras de comprimento 3 que pertencem a $Sigma^*$. Qual é o valor de $|Sigma^*|$?

*Exercício 2.* Seja $L = {w in {a,b}^* | |w| <= 2}$. Liste *todos* os elementos de $L$.

*Exercício 3.* Dadas $L_1 = {ab, ba}$ e $L_2 = {a, b}$, calcule:
- $L_1 union L_2$
- $L_1 dot L_2$
- $L_2^*$ (descreva o padrão geral)

*Exercício 4.* Descreva em português o que as seguintes expressões regulares representam sobre $Sigma = {a, b}$:
- (a) $a^+$
- (b) $(a | b)^* b$
- (c) $(ab)^*$

== Nível Intermediário

*Exercício 5.* Construa um AFD sobre $Sigma = {a, b}$ que aceite as palavras que *começam e terminam* com o mesmo símbolo. Apresente a tabela de transições e indique os estados inicial e finais.

*Exercício 6.* Construa um AFD sobre $Sigma = {0, 1}$ que aceite as palavras cujo número de $0$'s é divisível por 3. (_Dica:_ use 3 estados representando o resto da divisão.)

*Exercício 7.* Escreva uma expressão regular para cada uma das linguagens abaixo sobre $Sigma = {a, b}$:
- (a) Palavras que contêm pelo menos dois $b$'s.
- (b) Palavras que *não* contêm $aa$ como subcadeia.
- (c) Palavras de comprimento exatamente 3.

*Exercício 8.* Trace a execução do seguinte AFD para as palavras $"ab"$, $"ba"$, $"aab"$ e $"bba"$, indicando se são aceitas ou rejeitadas:

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$q_0$ (ini)], [$q_1$], [$q_2$],
  [$q_1$ (final)], [$q_1$], [$q_0$],
  [$q_2$], [$q_0$], [$q_2$],
)

== Nível Avançado

*Exercício 9.* Converta o AFN abaixo em um AFD equivalente usando a construção de subconjuntos:

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$p$ (ini)], [$\{p, q\}$], [$\{p\}$],
  [$q$ (final)], [$emptyset$], [$\{q\}$],
)

*Exercício 10.* Prove ou refute: a linguagem $L = {a^n b^n | n >= 1}$ (isto é, $n$ letras $a$ seguidas de $n$ letras $b$, com $n >= 1$) é regular. _Justifique_ sua resposta argumentando sobre o que um autômato finito precisaria "lembrar".

#pagebreak()

// ══════════════════════════════════════════════
// 8. CONCLUSÃO
// ══════════════════════════════════════════════

= Conclusão

== Resumo dos Principais Conceitos

Ao longo deste material, estudamos os fundamentos da teoria das linguagens formais e dos autômatos. Recapitulando:

- Um **alfabeto** $Sigma$ é um conjunto finito de símbolos; palavras são sequências finitas de símbolos; uma **linguagem** é qualquer conjunto de palavras.

- As **operações sobre linguagens** (união, concatenação e fecho de Kleene) permitem construir linguagens complexas a partir de linguagens simples.

- As **expressões regulares** fornecem uma notação compacta e expressiva para descrever linguagens regulares, usando os operadores $|$, concatenação e $*$.

- Os **autômatos finitos determinísticos (AFDs)** reconhecem linguagens regulares: para cada estado e símbolo, há exatamente uma transição definida.

- Os **autômatos finitos não determinísticos (AFNs)** também reconhecem as mesmas linguagens, mas com maior flexibilidade de projeto; todo AFN pode ser convertido em um AFD equivalente.

- O **Teorema de Kleene** garante a equivalência entre expressões regulares e autômatos finitos — ambos descrevem exatamente as **linguagens regulares**.

== Preparação para Tópicos Avançados

Os conceitos apresentados aqui são a base para tópicos mais avançados que você encontrará ao longo do curso:

/ *Gramáticas Livres de Contexto (GLCs)*: descrevem linguagens mais complexas, como linguagens de programação, usando regras de produção. São reconhecidas por *autômatos com pilha (AP)*.

/ *Autômatos com Pilha (AP)*: autômatos finitos equipados com uma pilha de memória infinita, capazes de reconhecer linguagens que os autômatos finitos não conseguem (por exemplo, $a^n b^n$).

/ *Máquinas de Turing*: o modelo mais poderoso de computação, capaz de reconhecer qualquer linguagem computável.

/ *Hierarquia de Chomsky*: uma classificação das linguagens em quatro tipos (regulares, livres de contexto, sensíveis ao contexto e recursivamente enumeráveis), cada um com seu modelo de autômato correspondente.

/ *Algoritmos de análise sintática (Parsing)*: essenciais em compiladores, usam as gramáticas livres de contexto para analisar código-fonte.

#definition[
  *Mensagem final:* A aparente abstração desta teoria se transforma, à medida que você avança no curso, em ferramentas concretas e indispensáveis para a Ciência da Computação. Cada compilador, cada analisador léxico, cada protocolo de comunicação formal tem, em sua essência, os conceitos que você acabou de estudar.
]
