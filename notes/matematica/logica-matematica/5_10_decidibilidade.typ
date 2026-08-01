#import "@preview/mousse-notes:1.1.0": *

= 5.10 --- Decidibilidade

== Introdução

Completude (5.7) garante que toda verdade semântica *tem* uma prova; decidibilidade pergunta algo diferente e mais forte: existe um *algoritmo* que, para qualquer fórmula dada, sempre termina e responde corretamente se ela é válida (ou pertence a um dado conjunto)? A distinção entre esses conceitos é seguidamente cobrada na POSCOMP, junto com o contraste conceitual entre lógica e computabilidade (13.10--13.14 em Linguagens Formais/Computabilidade).

== Definições formais

#definition(name: "Decidibilidade", id: "def-decidibilidade")[
  Um conjunto de fórmulas (ou uma teoria) $T$ é *decidível* se existe um algoritmo que, para *qualquer* fórmula $phi$ dada como entrada, sempre *termina* e responde corretamente "sim" (se $phi in T$) ou "não" (caso contrário). Se nenhum tal algoritmo existe, $T$ é *indecidível*.
]

== Exemplo resolvido

#example(name: "Decidível vs. indecidível em lógica", id: "ex-decidivel-indecidivel-logica")[
  - *Decidível*: validade de fórmulas da *lógica proposicional* -- basta construir a tabela-verdade (finita, 5.4) e checar se a fórmula é verdadeira em toda linha. Algoritmo simples, sempre termina.
  - *Decidível*: a *aritmética de Presburger* (naturais com adição, sem multiplicação) -- resultado clássico de que esse fragmento restrito da aritmética admite um algoritmo de decisão.
  - *Indecidível*: validade de fórmulas da *lógica de primeira ordem em geral* -- Alonzo Church e Alan Turing mostraram independentemente (1936) que não existe algoritmo que decida, para toda fórmula de primeira ordem, se ela é válida. Este é o *Entscheidungsproblem* (problema da decisão), proposto por Hilbert e respondido negativamente por Church e Turing.
]

== Atenção -- pegadinhas comuns

#remark(name: "Decidibilidade não é o mesmo que completude, nem que corretude")[
  - *Corretude/completude* (5.6/5.7) são propriedades sobre a *relação entre* $tack.r$ e $models$ -- dizem que toda prova é verdade e vice-versa, mas nada garantem sobre *encontrar* essa prova algoritmicamente.
  - *Decidibilidade* exige um procedimento efetivo que sempre termina com a resposta certa.
  Um resultado sutil (mas cobrado com frequência): a lógica de primeira ordem *é* completa (Gödel, 5.7) -- toda fórmula válida *tem* uma prova -- mas é *indecidível*: não existe algoritmo que, para uma fórmula *arbitrária*, sempre termine dizendo se ela é válida ou não. Um procedimento de busca de provas pode enumerar todas as provas possíveis e eventualmente encontrar uma prova de uma fórmula válida (*semidecidibilidade*), mas, se a fórmula for inválida, esse procedimento pode nunca terminar.
]

#remark(name: "Semidecidibilidade: o meio-termo importante")[
  A validade em lógica de primeira ordem é *semidecidível*: existe um algoritmo que termina e diz "sim" para toda fórmula válida (por completude, a prova sempre existe e pode ser enumerada), mas que pode não terminar para fórmulas inválidas. Isso é diferente de ser plenamente decidível (que exigiria terminar sempre, em ambos os casos).
]

== Questões estilo POSCOMP

*Questão 1.* Um problema é dito decidível quando:
- a) Existe uma prova formal para toda fórmula verdadeira.
- b) Existe um algoritmo que sempre termina e responde corretamente para qualquer entrada.
- c) O problema é completo, no sentido lógico.
- d) O problema é indecidível apenas em casos finitos.
- e) Toda fórmula do problema é uma tautologia.

*Questão 2.* Sobre a lógica de primeira ordem, é correto afirmar que ela é:
- a) Completa e decidível.
- b) Completa, mas indecidível (embora semidecidível).
- c) Incompleta e indecidível.
- d) Decidível, mas incompleta.
- e) Nem completa, nem decidível, nem semidecidível.

*Questão 3.* O resultado de Church e Turing (1936) sobre o Entscheidungsproblem mostrou que:
- a) Toda fórmula de primeira ordem é decidível individualmente.
- b) Não existe algoritmo geral que decida a validade de fórmulas arbitrárias de primeira ordem.
- c) A lógica proposicional é indecidível.
- d) A aritmética de Presburger é indecidível.
- e) A lógica de primeira ordem é incompleta.

== Gabarito comentado

1. *(b)* -- definição direta de decidibilidade: algoritmo que sempre termina com resposta correta.
2. *(b)* -- é exatamente o resultado sutil discutido nesta seção: completa (Gödel) mas indecidível (Church-Turing), sendo semidecidível.
3. *(b)* -- é o enunciado do resultado de Church/Turing sobre o Entscheidungsproblem.

== Referências

- CHURCH, A. *An Unsolvable Problem of Elementary Number Theory* (1936); TURING, A. *On Computable Numbers* (1936) -- resultados originais sobre indecidibilidade.
- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 3 (Decidibilidade).
- Conteúdo relacionado de computabilidade (máquinas de Turing, problema da parada) está em Linguagens Formais, Autômatos e Computabilidade, subtópicos 13.10--13.14 -- ainda sem material escrito neste repositório no momento desta seção.
