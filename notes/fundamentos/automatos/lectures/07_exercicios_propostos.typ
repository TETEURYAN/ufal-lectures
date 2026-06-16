#import "@preview/mousse-notes:1.1.0": *

= Exercícios Propostos

Os exercícios a seguir estão organizados em dificuldade crescente.

== Nível Básico

*Exercício 1.* Dado o alfabeto $Sigma = {0, 1}$, escreva três palavras de comprimento 3 que pertencem a $Sigma^*$. O conjunto $Sigma^*$ é finito ou infinito? Justifique.

*Exercício 2.* Seja $L = {w in {a, b}^* | |w| <= 2}$. Liste *todos* os elementos de $L$.

*Exercício 3.* Dadas $L_1 = {a b, b a}$ e $L_2 = {a, b}$, calcule:

- (a) $L_1 union L_2$
- (b) $L_1 dot L_2$
- (c) $L_2^*$ — descreva o padrão geral sem listar todos os elementos

*Exercício 4.* Descreva em português o conjunto de palavras que cada expressão regular representa sobre $Sigma = {a, b}$:

- (a) $a^+$
- (b) $(a | b)^* b$
- (c) $(a b)^*$
- (d) $a? b^*$

== Nível Intermediário

*Exercício 5.* Construa um AFD sobre $Sigma = {a, b}$ que aceite as palavras que *começam e terminam* com o mesmo símbolo. Apresente a tabela de transições e indique os estados inicial e finais. (_Dica:_ considere casos: começa com $a$, começa com $b$, e palavra vazia.)

*Exercício 6.* Construa um AFD sobre $Sigma = {0, 1}$ que aceite as palavras cujo número de $0$'s é divisível por 3. (_Dica:_ use 3 estados representando os restos $0$, $1$ e $2$ da divisão por 3.)

*Exercício 7.* Escreva uma expressão regular para cada linguagem abaixo sobre $Sigma = {a, b}$:

- (a) Palavras que contêm pelo menos dois $b$'s.
- (b) Palavras que *não* contêm $a a$ como subcadeia.
- (c) Palavras de comprimento exatamente 3.

*Exercício 8.* Trace a execução do AFD abaixo para as palavras $a b$, $b a$, $a a b$ e $b b a$, indicando se cada uma é aceita ou rejeitada:

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$q_0$ (inicial)], [$q_1$], [$q_2$],
  [$q_1$ (final)],   [$q_1$], [$q_0$],
  [$q_2$],           [$q_0$], [$q_2$],
)

== Nível Avançado

*Exercício 9.* Converta o AFN abaixo em um AFD equivalente usando a *construção de subconjuntos*. Apresente a tabela de transições do AFD resultante e indique seus estados finais.

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: center,
  table.header([$delta$], [$a$], [$b$]),
  [$p$ (inicial)], [$\{p, q\}$], [$\{p\}$],
  [$q$ (final)],   [$emptyset$], [$\{q\}$],
)

*Exercício 10.* Considere a linguagem $L = {a^n b^n | n >= 1}$, isto é, $n$ letras $a$ seguidas de exatamente $n$ letras $b$, para algum $n >= 1$.

- (a) Escreva pelo menos 4 palavras que pertencem a $L$.
- (b) Escreva pelo menos 4 palavras que *não* pertencem a $L$.
- (c) Argumente *informalmente* por que $L$ não pode ser reconhecida por um autômato finito. (_Dica:_ pense em quantas informações distintas o autômato precisaria memorizar ao processar a parte de $a$'s.)
