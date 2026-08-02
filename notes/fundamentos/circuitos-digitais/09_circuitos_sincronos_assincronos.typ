#import "@preview/mousse-notes:1.1.0": *

= Circuitos Sequenciais Síncronos e Assíncronos
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.9]

== Introdução

Todo circuito sequencial visto até aqui (06--08) assumiu implicitamente um clock comum. Esta subseção formaliza essa suposição e trata da alternativa -- circuitos assíncronos -- e do problema central que a motivou: hazards.

== Definições formais

#definition(name: "Circuito síncrono", id: "def-circuito-sincrono")[
  Circuito sequencial em que *todos* os flip-flops compartilham um sinal de *clock* comum, e mudam de estado apenas em uma borda específica do clock (subida ou descida) -- todas as atualizações de estado acontecem simultaneamente, em instantes discretos e previsíveis.
]

#definition(name: "Circuito assíncrono", id: "def-circuito-assincrono")[
  Circuito sequencial sem clock comum: elementos de memória mudam de estado em resposta direta a mudanças de entrada (ou de outros sinais internos), a qualquer momento -- potencialmente mais rápido (sem esperar uma borda de clock), mas muito mais difícil de projetar corretamente, pois a ordem relativa de eventos que chegam quase simultaneamente pode afetar o resultado.
]

#definition(name: "Hazards (glitches)", id: "def-hazards-glitches")[
  Transições momentâneas e indesejadas na saída de um circuito, causadas por diferentes atrasos de propagação em caminhos diferentes até a mesma saída (mesmo quando a entrada muda para um único novo valor consistente). Em circuitos síncronos, hazards são geralmente inofensivos (a saída se estabiliza antes da próxima borda de clock relevante); em circuitos *assíncronos*, um hazard pode ser interpretado erroneamente como uma transição real, causando um erro de estado permanente.
]

== Exemplo resolvido

#example(name: "Hazard estático em uma mudança de entrada", id: "ex-hazard-estatico")[
  Considere $F = A B + A' C$, com $B=C=1$ e $A$ transitando de 1 para 0. Antes: $F = 1 dot 1 + 0 dot 1 = 1$. Depois: $F = 0 dot 1 + 1 dot 1 = 1$ -- o valor final é o mesmo (1), mas durante a transição, se o caminho via $A B$ desliga *antes* de o caminho via $A' C$ ligar (devido a atrasos de porta diferentes), a saída pode cair momentaneamente para 0 antes de voltar a 1 -- um *hazard estático-1* (deveria permanecer em 1, mas glitcha para 0). Adicionar um termo redundante $B C$ (cobrindo a transição) eliminaria esse hazard, ao custo de uma porta extra.
]

== Atenção -- pegadinhas comuns

#remark(name: "Síncrono vs. assíncrono não é o mesmo que combinacional vs. sequencial")[
  Ambos os termos desta seção (síncrono, assíncrono) descrevem *como* um circuito sequencial é temporizado -- não têm relação direta com a distinção combinacional/sequencial de 06. Um circuito combinacional não tem clock nem estado, então a dicotomia síncrono/assíncrono simplesmente não se aplica a ele.
]

#remark(name: "Hazards são um problema de temporização física, não de lógica booleana incorreta")[
  A expressão booleana do exemplo desta seção está *matematicamente correta* (o valor final é o esperado) -- o hazard é um artefato físico de atrasos de propagação diferentes entre portas, não um erro na simplificação ou na lógica. Por isso circuitos síncronos são preferidos na maioria dos projetos digitais modernos: o clock "espera" os hazards se resolverem antes de capturar o valor.
]

== Questões estilo POSCOMP

*Questão 1.* A principal diferença entre um circuito sequencial síncrono e um assíncrono é que o síncrono:
- a) Não possui nenhum elemento de memória.
- b) Usa um sinal de clock comum para sincronizar todas as mudanças de estado.
- c) É sempre mais lento que o assíncrono.
- d) Não pode apresentar hazards em nenhuma hipótese.
- e) É equivalente a um circuito puramente combinacional.

*Questão 2.* Um hazard (glitch) em um circuito digital é causado por:
- a) Um erro na tabela-verdade da função.
- b) Diferentes atrasos de propagação em caminhos distintos até a mesma saída.
- c) Ausência de portas lógicas no circuito.
- d) Uso exclusivo de flip-flops tipo D.
- e) Uma simplificação booleana incorreta.

*Questão 3.* Circuitos assíncronos são geralmente mais difíceis de projetar corretamente que os síncronos porque:
- a) Não podem ser implementados com portas lógicas.
- b) A ausência de um clock comum exige tratar cuidadosamente a ordem relativa de eventos quase simultâneos, incluindo hazards.
- c) São sempre mais lentos.
- d) Não podem armazenar estado.
- e) Não existem na prática.

== Gabarito comentado

1. *(b)* -- clock comum sincronizando todas as transições é a definição de circuito síncrono.
2. *(b)* -- diferença de atraso entre caminhos é a causa raiz de hazards, conforme o exemplo desta seção.
3. *(b)* -- ausência de sincronização exige lidar diretamente com ordenação de eventos e hazards, tornando o projeto assíncrono mais delicado.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 8--9 (Circuitos síncronos, assíncronos e hazards).
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 9.
