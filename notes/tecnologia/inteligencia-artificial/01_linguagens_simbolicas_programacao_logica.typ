#import "@preview/mousse-notes:1.1.0": *

= 22.1 --- Linguagens Simbólicas

== Introdução

A IA clássica ("simbólica" ou "GOFAI" -- Good Old-Fashioned AI) manipula símbolos e estruturas discretas (listas, árvores, regras), não apenas números -- o que exigiu linguagens de programação com características específicas, diferentes das linguagens imperativas tradicionais da época.

== Definições formais

#definition(name: "Linguagem simbólica", id: "def-linguagem-simbolica")[
  Linguagem de programação projetada para manipular *símbolos e estruturas simbólicas* (listas, árvores, expressões) como dados de primeira classe, favorecendo recursão e representações declarativas sobre laços e estado mutável explícito. *LISP* (LISt Processing, McCarthy, 1958) é a linguagem simbólica clássica de IA: todo programa e todo dado é uma *s-expression* (lista aninhada entre parênteses), propriedade conhecida como *homoiconicidade* -- código e dado compartilham a mesma representação, permitindo que programas manipulem outros programas como dados.
]

== Exemplo resolvido

#example(name: "Uma s-expression e sua leitura", id: "ex-s-expression")[
  Em LISP, a expressão `(+ 1 (* 2 3))` é uma lista com três elementos: o símbolo `+`, o número `1`, e a sublista `(* 2 3)` -- interpretada como "some 1 ao resultado de multiplicar 2 por 3", avaliando para 7. A mesma estrutura de lista usada para representar esse cálculo poderia, em outro contexto, representar o próprio *código* de uma função -- não há distinção sintática entre "programa" e "dado em forma de lista".
]

= 22.2 --- Programação em Lógica

== Introdução

Programação em lógica é um paradigma *declarativo*: em vez de especificar *como* calcular um resultado (passo a passo, como em linguagens imperativas), o programador declara *fatos* e *regras* lógicas, e um mecanismo de inferência genérico deriva as respostas. *Prolog* é a linguagem clássica desse paradigma. A base teórica -- resolução e unificação -- já foi tratada formalmente em Lógica Matemática, subtópico 5.11 (Prova Automática de Teoremas); aqui o foco é no paradigma de programação que resulta dessa base, não na teoria da resolução em si.

== Definições formais

#definition(name: "Cláusula de Horn e programa lógico", id: "def-clausula-horn-programa-logico")[
  Uma *cláusula de Horn* tem no máximo um literal positivo: $A_1, dots, A_n -> B$ (lida "se $A_1$ e ... e $A_n$, então $B$"), escrita em Prolog como `B :- A1, ..., An.` (uma *regra*) ou apenas `B.` quando não há condições (um *fato*). Um *programa lógico* é um conjunto de cláusulas de Horn (fatos e regras); executar o programa consiste em submeter uma *consulta* (goal) e deixar o interpretador buscar, por *resolução SLD* (resolução linear com função de seleção, restrita a cláusulas definidas) e *unificação* (5.11), uma sequência de regras que a satisfaça.
]

== Exemplo resolvido

#example(name: "Um pequeno programa Prolog: relações de parentesco", id: "ex-prolog-parentesco")[
  ```prolog
  pai(joao, maria).
  pai(joao, pedro).
  pai(pedro, ana).

  avo(X, Z) :- pai(X, Y), pai(Y, Z).
  ```

  A consulta `?- avo(joao, ana).` é resolvida assim: o interpretador tenta unificar `avo(joao, ana)` com a cabeça da regra, obtendo `X=joao`, `Z=ana`; precisa então provar `pai(joao, Y), pai(Y, ana)`. Unifica `pai(joao, Y)` com o fato `pai(joao, pedro)` (logo `Y=pedro`), e então verifica `pai(pedro, ana)` -- que é exatamente um fato da base. Ambas as condições são satisfeitas, logo a consulta é *verdadeira*: `joao` é avô de `ana`.
]

== Atenção -- pegadinhas comuns

#remark(name: "Programação em lógica é declarativa, não procedural")[
  Um programa Prolog não descreve uma sequência de instruções -- descreve relações lógicas *verdadeiras*. É o mecanismo de resolução SLD do interpretador, não o programador, que decide a ordem de busca (embora a ordem das cláusulas no programa afete a ordem em que soluções são encontradas, via *backtracking*).
]

#remark(name: "LISP é funcional/simbólico; Prolog é lógico -- não confundir os dois paradigmas de IA clássica")[
  Ambos são associados à IA simbólica histórica, mas resolvem o problema de forma diferente: LISP estrutura a computação em torno de funções e listas (ênfase em manipulação simbólica geral); Prolog estrutura em torno de fatos, regras e um motor de inferência lógica (ênfase em dedução automática). A prova gosta de testar se o candidato sabe associar cada linguagem ao paradigma certo.
]

== Questões estilo POSCOMP

*Questão 1.* A propriedade de LISP que permite que código seja manipulado como dado, por compartilharem a mesma representação em lista, é chamada de:
- a) Recursão.
- b) Homoiconicidade.
- c) Tipagem estática.
- d) Resolução SLD.
- e) Encadeamento para trás.

*Questão 2.* Uma cláusula de Horn com zero condições no corpo (apenas a cabeça) representa, em um programa lógico:
- a) Uma regra condicional.
- b) Um fato.
- c) Uma consulta.
- d) Uma contradição.
- e) Um erro de sintaxe.

*Questão 3.* No exemplo de Prolog desta seção, a consulta `?- avo(joao, X).` retornaria como solução(ões):
- a) Apenas `X=pedro`.
- b) Apenas `X=ana`.
- c) `X=maria` e `X=pedro`.
- d) Nenhuma solução.
- e) `X=joao`.

*Questão 4.* Sobre o paradigma de programação em lógica, é correto afirmar que:
- a) O programador especifica passo a passo como calcular o resultado.
- b) O programador declara fatos e regras, e um mecanismo de resolução genérico deriva respostas às consultas.
- c) É equivalente, em todos os aspectos, à programação imperativa.
- d) Não pode representar relações recursivas, como "avô".
- e) Não utiliza nenhum mecanismo de unificação.

== Gabarito comentado

1. *(b)* -- homoiconicidade é exatamente essa propriedade de código e dado compartilharem representação.
2. *(b)* -- cláusula sem corpo (só cabeça) é, por definição, um fato.
3. *(b)* -- só `pai(joao,pedro)` seguido de `pai(pedro,ana)` satisfaz a regra `avo`; `ana` é a única neta de `joao` via `pedro`.
4. *(b)* -- definição direta do paradigma declarativo da programação em lógica.

== Referências

- MCCARTHY, J. *Recursive Functions of Symbolic Expressions* (1960) -- artigo original de LISP.
- CLOCKSIN, W.; MELLISH, C. *Programming in Prolog*. Cap. 1--3.
- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. sobre representação lógica e programação em lógica.
- Lógica Matemática (5.11, Prova Automática de Teoremas) -- base formal de resolução e unificação usada nesta seção.
