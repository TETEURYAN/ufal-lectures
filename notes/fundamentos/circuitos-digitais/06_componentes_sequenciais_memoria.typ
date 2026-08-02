#import "@preview/mousse-notes:1.1.0": *

= Análise e Síntese de Componentes Sequenciais e de Memória
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.6]

== Introdução

Até aqui, todo circuito foi combinacional (03--05): sem memória. Esta subseção introduz o segundo grande tipo de circuito digital -- o *sequencial*, capaz de armazenar estado -- e seus blocos fundamentais, os flip-flops. É a pegadinha mais clássica da disciplina: combinacional vs. sequencial.

== Definições formais

#definition(name: "Circuito sequencial", id: "def-circuito-sequencial")[
  Circuito cuja saída depende *não apenas* das entradas atuais, mas também de um *estado interno* armazenado (memória) -- o mesmo conjunto de entradas pode produzir saídas diferentes em momentos diferentes, dependendo do estado. Contrasta diretamente com circuito *combinacional* (03), cuja saída é função exclusiva das entradas presentes.
]

#definition(name: "Flip-flops: SR, D, JK, T", id: "def-flip-flops")[
  Elementos básicos de memória de 1 bit, atualizados em resposta a um sinal de clock (na maioria das implementações síncronas):
  - *SR (Set-Reset)*: $S=1$ força saída para 1; $R=1$ força para 0; $S{=}R{=}1$ é combinação proibida (estado indefinido).
  - *D (Data/Delay)*: a saída simplesmente copia a entrada $D$ no próximo pulso de clock -- o flip-flop mais usado em registradores.
  - *JK*: generaliza o SR sem a combinação proibida -- $J{=}K{=}1$ faz a saída *alternar* (toggle), resolvendo a ambiguidade do SR.
  - *T (Toggle)*: alterna a saída a cada pulso de clock quando $T=1$; mantém quando $T=0$ -- caso particular do JK com $J=K=T$.
]

#definition(name: "Tabela de excitação", id: "def-tabela-excitacao")[
  Tabela que, dado o estado atual $Q$ e o estado *desejado* seguinte $Q^+$, indica quais entradas do flip-flop devem ser aplicadas para produzir essa transição -- o "inverso" da tabela-verdade normal do flip-flop, essencial para projetar circuitos sequenciais (07).
]

== Exemplo resolvido

#example(name: "Tabela de excitação do flip-flop SR", id: "ex-excitacao-sr")[
  #table(
    columns: 4,
    [*$Q$*], [*$Q^+$*], [*$S$*], [*$R$*],
    [0], [0], [0], [X],
    [0], [1], [1], [0],
    [1], [0], [0], [1],
    [1], [1], [X], [0],
  )
  (X = don't care.) Para manter $Q=0 arrow.r Q^+=0$: qualquer combinação que não force $Q$ a 1 serve, então $S=0$ (não pode forçar 1) e $R$ é irrelevante (X) -- e assim por diante para as demais linhas. Essa tabela é montada comparando, para cada transição desejada, quais valores de $S,R$ a produzem segundo a definição do SR.

  #figure(
    image("figures/d-flip-flop.svg", width: 40%),
    caption: [Flip-flop tipo D disparado por borda: a saída copia a entrada $D$ na transição do clock. Fonte: Wikimedia Commons, CC BY-SA/GFDL (Nolanjshettle).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "Combinacional vs. sequencial é a pegadinha mais recorrente da disciplina")[
  Um circuito com portas lógicas *sem nenhum caminho de realimentação* (feedback) e sem flip-flops é sempre combinacional, não importa quão complexo -- a presença de memória (estado), não a complexidade, é o critério que define um circuito como sequencial.
]

#remark(name: "JK resolve a combinação proibida do SR -- não é apenas \"outro nome\"")[
  $J{=}K{=}1$ no flip-flop JK produz comportamento *definido* (toggle), diferente de $S{=}R{=}1$ no SR, que é *indefinido/proibido*. Tratar JK como um simples sinônimo de SR, ignorando essa diferença, é um erro recorrente de prova.
]

== Questões estilo POSCOMP

*Questão 1.* A diferença fundamental entre um circuito combinacional e um circuito sequencial é que o sequencial:
- a) Usa mais portas lógicas.
- b) Tem saída dependente também de um estado interno armazenado, não apenas das entradas atuais.
- c) Não pode ser implementado com portas AND/OR/NOT.
- d) É sempre mais rápido.
- e) Não usa clock em nenhuma hipótese.

*Questão 2.* No flip-flop SR, a combinação de entradas $S{=}1, R{=}1$ é:
- a) Uma combinação normal, produzindo toggle.
- b) Proibida/indefinida.
- c) Equivalente a $S{=}R{=}0$.
- d) Usada para resetar o sistema inteiro.
- e) A única forma de setar a saída.

*Questão 3.* O flip-flop tipo D é caracterizado por:
- a) Alternar a saída a cada pulso de clock.
- b) Copiar o valor da entrada D para a saída no próximo pulso de clock.
- c) Ter uma combinação de entradas proibida.
- d) Não poder ser usado em registradores.
- e) Ser equivalente ao flip-flop JK em todos os aspectos.

== Gabarito comentado

1. *(b)* -- presença de estado interno é o critério definidor de circuito sequencial.
2. *(b)* -- $S{=}R{=}1$ é a combinação proibida clássica do flip-flop SR.
3. *(b)* -- definição direta do flip-flop D.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 5--6 (Circuitos sequenciais e flip-flops).
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 7--8.
