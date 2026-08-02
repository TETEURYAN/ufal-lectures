#import "@preview/mousse-notes:1.1.0": *

= Projeto de Circuitos Sequenciais
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.7]

== Introdução

Assim como 05 fechou o fluxo de projeto combinacional, esta subseção fecha o fluxo para circuitos sequenciais: de uma especificação de comportamento ao longo do tempo até flip-flops e lógica combinacional interconectados.

== Definições formais

#definition(name: "Fluxo de projeto de circuito sequencial", id: "def-fluxo-projeto-sequencial")[
  + Especificar o comportamento desejado como um *diagrama ou tabela de estados* (08).
  + Atribuir uma codificação binária a cada estado (*atribuição de estados*).
  + Escolher o tipo de flip-flop e usar a *tabela de excitação* (06) para derivar as equações de entrada de cada flip-flop, em função do estado atual e das entradas externas.
  + Derivar a *lógica de próximo estado* e a *lógica de saída* (equações combinacionais) e simplificá-las (04).
  + Implementar: flip-flops + lógica combinacional de próximo estado/saída interligados.
]

== Exemplo resolvido

#example(name: "Projetando um contador binário de 2 bits", id: "ex-projeto-contador-2bit")[
  Contador que avança $00 -> 01 -> 10 -> 11 -> 00 -> dots$ a cada pulso de clock, usando flip-flops D (mais simples: $D = Q^+$ diretamente, já que D copia o valor desejado no próximo ciclo).

  #table(
    columns: 4,
    [*$Q_1 Q_0$ (atual)*], [*$Q_1^+ Q_0^+$ (próximo)*], [*$D_1$*], [*$D_0$*],
    [00], [01], [0], [1],
    [01], [10], [1], [0],
    [10], [11], [1], [1],
    [11], [00], [0], [0],
  )

  Extraindo diretamente (com flip-flops D, $D_i = Q_i^+$): $D_0 = Q_0'$ (inverte a cada ciclo) e $D_1 = Q_1 xor Q_0$ (por inspeção da tabela, ou via mapa de Karnaugh sobre $Q_1, Q_0$). Cada flip-flop D recebe sua equação de entrada; a cada borda de clock, ambos atualizam simultaneamente, avançando o contador.
]

== Atenção -- pegadinhas comuns

#remark(name: "A escolha do tipo de flip-flop afeta a complexidade da lógica de entrada, não o comportamento final")[
  O mesmo contador poderia ser projetado com flip-flops JK ou T em vez de D -- o comportamento observável (a sequência de estados) seria idêntico, mas as equações de entrada derivadas via tabela de excitação (06) seriam diferentes, podendo resultar em mais ou menos lógica combinacional necessária.
]

#remark(name: "Atribuição de estados não é única -- afeta a complexidade do circuito final")[
  Para um mesmo diagrama de estados abstrato, diferentes codificações binárias dos estados produzem circuitos com complexidades de lógica combinacional diferentes -- parte do "projeto" é escolher uma atribuição que minimize essa complexidade, não apenas seguir a primeira codificação óbvia.
]

== Questões estilo POSCOMP

*Questão 1.* No fluxo de projeto de um circuito sequencial, a tabela de excitação do flip-flop escolhido é usada para:
- a) Definir a especificação inicial do comportamento.
- b) Derivar as equações de entrada dos flip-flops a partir das transições de estado desejadas.
- c) Substituir a necessidade de um diagrama de estados.
- d) Minimizar apenas a lógica de saída, nunca a de próximo estado.
- e) Determinar a frequência do clock.

*Questão 2.* No exemplo do contador de 2 bits desta seção, usando flip-flops D, a equação $D_0 = Q_0'$ significa que:
- a) O bit menos significativo nunca muda.
- b) O bit menos significativo inverte de valor a cada pulso de clock.
- c) $D_0$ depende de $Q_1$.
- d) O contador não é síncrono.
- e) É necessário um flip-flop SR, não D.

*Questão 3.* Sobre a atribuição de estados no projeto de circuitos sequenciais, é correto afirmar que:
- a) É sempre única para um dado diagrama de estados.
- b) Não afeta a complexidade do circuito final.
- c) Diferentes atribuições podem resultar em circuitos de complexidade de lógica combinacional diferente.
- d) É irrelevante para o projeto, servindo apenas de documentação.
- e) Deve sempre seguir a ordem alfabética dos nomes dos estados.

== Gabarito comentado

1. *(b)* -- é exatamente a função da tabela de excitação no fluxo de projeto desta seção.
2. *(b)* -- $D_0 = Q_0'$ significa que o próximo valor de $Q_0$ é sempre o oposto do atual, isto é, alterna (toggle) a cada ciclo.
3. *(c)* -- escolha de atribuição de estados é um grau de liberdade de projeto que afeta a complexidade da lógica final.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 6--7 (Projeto de circuitos sequenciais síncronos).
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 8--9.
