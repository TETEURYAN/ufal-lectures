#import "@preview/mousse-notes:1.1.0": *

= Modelo de Máquinas de Estado Finito (FSM)
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.8]

== Introdução

A definição formal de autômato finito (estados, alfabeto, função de transição) é tratada em Linguagens Formais, Autômatos e Computabilidade, subtópico 13.6 -- ainda sem material escrito neste repositório no momento desta seção. Aqui o foco é a *implementação em hardware*: como uma FSM abstrata vira registradores e lógica combinacional em um circuito real.

== Definições formais

#definition(name: "Máquina de Mealy", id: "def-maquina-mealy")[
  Modelo de FSM em que a *saída* é função do *estado atual e das entradas atuais* -- $"saída" = lambda("estado", "entrada")$. A saída pode mudar assim que a entrada muda, sem esperar a próxima borda de clock.
]

#definition(name: "Máquina de Moore", id: "def-maquina-moore")[
  Modelo de FSM em que a *saída* é função *apenas do estado atual* -- $"saída" = lambda("estado")$. A saída só muda em sincronia com transições de estado (bordas de clock), nunca instantaneamente em resposta a uma mudança de entrada.
]

== Exemplo resolvido

#example(name: "Detector de sequência: Mealy vs. Moore", id: "ex-detector-sequencia-mealy-moore")[
  Projetar um detector que sinaliza (saída=1) ao reconhecer a sequência de entrada `...1 1` (dois 1's consecutivos), sem sobreposição.

  #figure(
    image("figures/mealy-machine.svg", width: 45%),
    caption: [Exemplo de diagrama de estados de uma máquina de Mealy: as transições são rotuladas com "entrada/saída", pois a saída depende de ambos. Fonte: Wikimedia Commons, domínio público (Jake Choules).],
  )

  - *Versão Mealy*: estados $S_0$ (nenhum 1 visto), $S_1$ (um 1 visto). Transição $S_1 -->^(1\/1) S_1$ (na *própria transição*, ao ler o segundo 1, já emite saída 1). A saída aparece assim que a entrada correta chega, sem esperar um novo ciclo de clock.
  - *Versão Moore*: precisa de um *terceiro* estado $S_2$ ("dois 1's detectados"), com saída 1 associada a $S_2$ (não à transição). A saída só aparece no ciclo *seguinte* à chegada do segundo 1, quando o circuito efetivamente transita para $S_2$.

  Mealy tipicamente usa *menos estados* e reage mais rápido; Moore tem saída mais "limpa" (estável durante todo o ciclo de clock, sem depender da entrada instantânea) -- um trade-off clássico de projeto.
]

== Atenção -- pegadinhas comuns

#remark(name: "Mealy reage mais rápido; Moore é mais \"estável\" -- não existe uma sempre superior")[
  Mealy pode responder no mesmo ciclo em que a entrada muda (útil quando latência importa), mas isso também significa que sua saída pode ter *glitches* transitórios se a entrada for ruidosa dentro do ciclo. Moore atrasa a resposta em um ciclo, mas garante uma saída estável, sincronizada exatamente com o clock -- a escolha depende dos requisitos do projeto, não existe uma opção universalmente melhor.
]

#remark(name: "FSM em hardware é a FSM abstrata mais um clock e registradores concretos")[
  A definição formal de autômato (Linguagens Formais, 13.6) já captura estados e transições em abstrato -- a implementação em circuito digital acrescenta: um *registrador* (flip-flops) para armazenar o estado atual, e *lógica combinacional* para calcular o próximo estado e a saída, exatamente o fluxo de projeto de 07.
]

== Questões estilo POSCOMP

*Questão 1.* Em uma máquina de Mealy, a saída do circuito é função de:
- a) Apenas o estado atual.
- b) Apenas as entradas atuais, ignorando o estado.
- c) O estado atual e as entradas atuais simultaneamente.
- d) Apenas o estado anterior.
- e) Nenhuma das anteriores; Mealy não tem saída.

*Questão 2.* Uma vantagem típica da máquina de Moore sobre a de Mealy é:
- a) Sempre usa menos estados.
- b) A saída é mais estável, mudando apenas em sincronia com o clock, sem depender diretamente da entrada instantânea.
- c) Responde mais rapidamente a mudanças de entrada, no mesmo ciclo.
- d) Não pode ser implementada com flip-flops.
- e) É equivalente, em todos os aspectos, a um circuito puramente combinacional.

*Questão 3.* Na implementação em hardware de uma FSM, o registrador de estado é tipicamente construído com:
- a) Portas AND e OR exclusivamente, sem memória.
- b) Flip-flops.
- c) Apenas fios de conexão direta.
- d) Multiplexadores, sem nenhum elemento de memória.
- e) Comparadores.

== Gabarito comentado

1. *(c)* -- definição direta de máquina de Mealy: saída depende de estado e entrada.
2. *(b)* -- estabilidade da saída (mudando só com o clock) é a vantagem clássica da máquina de Moore.
3. *(b)* -- flip-flops são o componente padrão para armazenar o estado atual em uma FSM em hardware.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 6 (Máquinas de estado: Mealy e Moore).
- MEALY, G. H. *A Method for Synthesizing Sequential Circuits* (1955); MOORE, E. F. *Gedanken-Experiments on Sequential Machines* (1956) -- artigos originais.
- Linguagens Formais, Autômatos e Computabilidade (13.6) -- definição formal de autômato finito, ainda sem material escrito neste repositório no momento desta seção.
