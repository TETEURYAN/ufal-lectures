#import "@preview/mousse-notes:1.1.0": *

= Comandos de uma Linguagem de Programação

== Introdução

Independentemente da linguagem concreta (C, Python, Pascal, Java...), todo algoritmo imperativo é
expresso combinando um pequeno conjunto de *estruturas de controle*: sequência, seleção e repetição.
Esse é o conteúdo do teorema da estruturação de Böhm-Jacopini, base teórica da programação
estruturada e pré-requisito para entender qualquer pseudocódigo usado nas seções seguintes.

== Definições formais

#definition(id: "def-comando-sequencial")[
  Um *comando* é uma unidade executável de um algoritmo (atribuição, entrada, saída, chamada de
  sub-rotina). A *estrutura sequencial* executa uma lista de comandos $c_1, c_2, ..., c_n$ na ordem
  em que aparecem, um após o outro.
]

#definition(id: "def-selecao")[
  A *estrutura de seleção* (condicional) desvia o fluxo de execução com base no valor de uma
  expressão booleana:
  - *Simples*: `se` $p$ `então` $S$ — executa $S$ apenas se $p$ é verdadeiro.
  - *Composta*: `se` $p$ `então` $S_1$ `senão` $S_2$ — executa $S_1$ se $p$, senão $S_2$.
  - *Múltipla*: `caso` $x$ `de` $v_1: S_1; v_2: S_2; ...; "default": S_n$ — generaliza a seleção
    composta para múltiplos valores discretos de $x$.
]

#definition(id: "def-repeticao")[
  A *estrutura de repetição* (laço/loop) executa um bloco de comandos $S$ enquanto uma condição
  $p$ se mantém verdadeira:
  - *Pré-testada* (`enquanto`): testa $p$ antes de cada iteração; $S$ pode executar zero vezes.
  - *Pós-testada* (`repita ... até`): testa $p$ depois de cada iteração; $S$ executa ao menos uma vez.
  - *Contada* (`para`): variação sintática de `enquanto` com contador implícito, útil quando o
    número de iterações é conhecido antecipadamente.
]

== Teorema da estruturação (Böhm–Jacopini)

#theorem(name: "Böhm–Jacopini", id: "thm-bohm-jacopini")[
  Qualquer função computável (todo *fluxograma*, ou programa com desvios `goto` arbitrários) pode
  ser expressa por um programa que utiliza apenas as três estruturas de controle: *sequência*,
  *seleção* (`se-então-senão`) e *repetição* (`enquanto`), sem uso de `goto`.
]

#remark[
  Esse teorema (1966) é o fundamento teórico da *programação estruturada*: justifica por que
  linguagens modernas dispensam `goto` como mecanismo primário de controle de fluxo — as três
  estruturas básicas já têm poder computacional equivalente. A demonstração é construtiva: mostra
  como simular qualquer desvio arbitrário usando variáveis de controle e laços aninhados.
]

== Exemplo resolvido

#example(id: "ex-comandos-fatorial")[
  Calcule $n!$ usando apenas as três estruturas do @thm-bohm-jacopini (sem recursão, que é tratada
  no próximo tópico):

  ```
  função fatorial(n)
      resultado ← 1                    // sequência
      i ← 1                            // sequência
      enquanto i ≤ n faça              // repetição (pré-testada)
          resultado ← resultado * i
          i ← i + 1
      fim-enquanto
      se n < 0 então                   // seleção
          erro("entrada inválida")
      fim-se
      retorne resultado
  fim-função
  ```

  Note a combinação das três estruturas: duas atribuições em sequência, um laço `enquanto` para
  acumular o produto, e uma seleção para tratar entrada inválida.
]

== Armadilhas comuns

#remark[
  - *Laço pré vs. pós-testado*: um `repita...até` executa o corpo *pelo menos uma vez*, mesmo que a
    condição já seja falsa inicialmente — isso é fonte comum de erro de contagem em questões que
    pedem o número de iterações para um dado laço.
  - *`dangling else`*: em `se A então se B então X senão Y`, a que `se` pertence o `senão`? Pela
    convenção usual, ao `se` mais interno (mais próximo) — ambiguidade que motiva o uso de blocos
    explícitos (`fim-se`, `\{\}`) nas provas de banca.
  - *Laço `para` com passo negativo ou variável alterada dentro do corpo*: alterar a variável de
    controle de um `para` dentro do próprio laço tem comportamento definido de forma diferente entre
    linguagens (em Pascal é proibido: em C é permitido e comum fonte de bugs).
]

== Questões

#example(id: "q-comandos-1")[
  *(Múltipla escolha)* Quantas vezes o corpo do laço abaixo é executado?

  ```
  i ← 5
  repita
      i ← i - 1
  até i = 0
  ```

  (a) 0 #h(1em) (b) 4 #h(1em) (c) 5 #h(1em) (d) 6 #h(1em) (e) o laço nunca termina
]

#example(id: "q-comandos-2")[
  *(Dissertativa curta)* Enuncie o teorema de Böhm–Jacopini e explique sua importância para a
  eliminação do `goto` na programação estruturada.
]

#solution[
  *Q1*: (c) — o laço é pós-testado, então executa ao menos uma vez; $i$ decresce de 5 até 0,
  totalizando 5 execuções do corpo ($i = 4,3,2,1,0$).

  *Q2*: Ver @thm-bohm-jacopini. O teorema garante que sequência + seleção + repetição bastam para
  expressar qualquer algoritmo computável, tornando o `goto` teoricamente desnecessário — o que
  fundamenta a prática de programação estruturada, mais legível e menos propensa a erros do que
  "código espaguete" baseado em desvios arbitrários.
]

== Referências

- Böhm, C.; Jacopini, G. *Flow diagrams, Turing machines and languages with only two formation
  rules*, 1966.
- Ziviani, N. *Projeto de Algoritmos*, cap. 2.
- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 2.
