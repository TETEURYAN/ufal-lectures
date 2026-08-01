#import "@preview/mousse-notes:1.1.0": *

= 7.2 --- Experimentos Aleatórios

== Introdução

Antes de falar em espaço amostral ou probabilidade, é preciso classificar o experimento que gera os dados. A distinção entre experimento determinístico e aleatório é conceitual, mas aparece com frequência em questões de POSCOMP que pedem para identificar se um cenário descrito é ou não um experimento aleatório.

== Definições formais

#definition(name: "Experimento determinístico", id: "def-exp-deterministico")[
  Experimento em que, repetido sob as mesmas condições, o resultado é *sempre o mesmo* e pode ser previsto com certeza a partir das condições iniciais (ex.: aquecer água ao nível do mar até 100°C -- ela ferve).
]

#definition(name: "Experimento aleatório", id: "def-exp-aleatorio")[
  Experimento que, mesmo repetido sob condições essencialmente idênticas, pode produzir resultados diferentes, e cujo resultado individual não pode ser previsto com certeza -- apenas descrito por um conjunto de resultados possíveis. Suas características essenciais são:
  - É repetível (em princípio, indefinidamente) sob as mesmas condições.
  - O resultado individual é imprevisível antes da realização.
  - Ao ser repetido um grande número de vezes, os resultados exibem *regularidade estatística* -- a proporção de ocorrência de cada resultado se estabiliza (base intuitiva da definição frequentista de probabilidade e da Lei dos Grandes Números).
]

== Exemplo resolvido

#example(name: "Determinístico vs. aleatório", id: "ex-deterministico-aleatorio")[
  - *Determinístico*: soltar um objeto em queda livre no vácuo, de uma altura $h$ conhecida -- o tempo de queda é determinado exatamente por $t = sqrt(2h\/g)$, sem variação entre repetições.
  - *Aleatório*: lançar uma moeda -- mesmo mantendo força e altura de lançamento "essencialmente" constantes, o resultado (cara ou coroa) varia entre repetições, e só se estabiliza em torno de 50% após muitas repetições.
]

== Atenção -- pegadinhas comuns

#remark(name: "\"Aleatório\" não é sinônimo de \"sem padrão nenhum\"")[
  Um erro comum é achar que um experimento aleatório não tem regularidade alguma. Na prática, é exatamente o oposto: o que caracteriza um experimento aleatório -- e permite construir uma teoria matemática sobre ele -- é a regularidade estatística que emerge com a repetição, mesmo sendo imprevisível resultado a resultado.
]

#remark(name: "Fatores não controlados não tornam um experimento aleatório")[
  Um experimento determinístico cujo resultado é difícil de calcular na prática (por exemplo, por depender de muitas variáveis) continua sendo determinístico em princípio. Aleatoriedade é uma propriedade do modelo do experimento, não apenas da dificuldade de cálculo.
]

== Questões estilo POSCOMP

*Questão 1.* Qual das situações a seguir é um exemplo de experimento aleatório?
- a) Verificar se um triângulo com lados 3, 4 e 5 é retângulo.
- b) Lançar um dado honesto e observar a face voltada para cima.
- c) Calcular a soma dos ângulos internos de um polígono convexo de 6 lados.
- d) Medir o tempo de queda livre de um objeto no vácuo a partir de uma altura conhecida.
- e) Verificar se um número inteiro dado é primo.

*Questão 2.* A característica que permite tratar matematicamente um experimento aleatório, apesar da imprevisibilidade de cada resultado individual, é:
- a) A ausência total de padrão nos resultados.
- b) A regularidade estatística observada com a repetição do experimento.
- c) A impossibilidade de repetir o experimento.
- d) A dependência exclusiva de fatores humanos.
- e) A garantia de que todo resultado é igualmente provável.

== Gabarito comentado

1. *(b)* -- lançar um dado é o exemplo clássico de experimento aleatório; as demais alternativas têm resultado determinado por cálculo ou verificação, sem variação possível.
2. *(b)* -- é a regularidade estatística a longo prazo que fundamenta a definição frequentista de probabilidade.

== Referências

- MEYER, P. L. *Probabilidade: Aplicações à Estatística*. Cap. 2 (Experimentos aleatórios).
- MAGALHÃES, M. N. *Probabilidade e Variáveis Aleatórias*. Cap. 1.
