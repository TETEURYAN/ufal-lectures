#import "@preview/mousse-notes:1.1.0": *

= Princípios e Técnicas de Projeto. Conceitos de Controle e de Tempo
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.12]

== Introdução

Fecha o bloco de projeto (05, 07, 11) com dois conceitos transversais: a separação clássica entre *controle* e *datapath*, e as restrições de *tempo* que todo circuito síncrono real precisa respeitar para funcionar corretamente.

== Definições formais

#definition(name: "Unidade de controle vs. datapath (caminho de dados)", id: "def-controle-datapath")[
  Separação arquitetural clássica: o *datapath* contém os componentes que efetivamente processam dados (ULA, registradores, multiplexadores) -- majoritariamente circuitos combinacionais e de armazenamento (05, 10). A *unidade de controle* é tipicamente uma FSM (08) que gera os sinais de controle (habilitações, seleções de MUX, códigos de operação) que orquestram o datapath ciclo a ciclo, sem processar os dados em si.
]

#definition(name: "Tempo de setup, tempo de hold e atraso de propagação", id: "def-tempo-setup-hold")[
  - *Tempo de propagação ($t_p$)*: tempo máximo para a saída de um circuito (combinacional ou flip-flop) se estabilizar após uma mudança na entrada.
  - *Tempo de setup ($t_(s u)$)*: intervalo mínimo em que a entrada de dado de um flip-flop deve permanecer *estável antes* da borda de clock relevante.
  - *Tempo de hold ($t_h$)*: intervalo mínimo em que a entrada de dado deve permanecer *estável depois* da borda de clock.
  Violar qualquer uma dessas restrições pode levar o flip-flop a um estado *metaestável* (nem 0 nem 1 de forma confiável), comprometendo a correção do circuito.
]

== Exemplo resolvido

#example(name: "Frequência máxima de clock a partir dos tempos de propagação", id: "ex-frequencia-maxima-clock")[
  Um circuito síncrono tem: tempo de propagação do flip-flop $t_(p f f)=2"ns"$, atraso máximo da lógica combinacional entre flip-flops $t_(l o g i c)=5"ns"$, e tempo de setup $t_(s u)=1"ns"$. O período mínimo de clock deve acomodar todo esse caminho:
  $ T_(min) = t_(p f f) + t_(l o g i c) + t_(s u) = 2+5+1 = 8"ns" $
  A frequência máxima de operação é $f_(max) = 1\/T_(min) = 1\/(8"ns") = 125"MHz"$. Operar acima dessa frequência arrisca violar o tempo de setup do flip-flop de destino, comprometendo a confiabilidade do circuito.
]

== Atenção -- pegadinhas comuns

#remark(name: "Controle não processa dados; datapath não decide o que fazer")[
  Confundir os papéis é erro comum: o datapath *executa* operações (somar, comparar, mover dados entre registradores), mas não decide *quando* ou *qual* operação executar -- essa decisão vem inteiramente da unidade de controle, tipicamente implementada como FSM (08), que apenas emite sinais habilitando/desabilitando partes do datapath a cada ciclo.
]

#remark(name: "Violação de tempo não é um erro lógico da função booleana -- é um problema físico de temporização")[
  Assim como hazards (09), violações de setup/hold não significam que a lógica booleana projetada está incorreta -- são restrições *físicas* sobre quando os sinais podem mudar em relação ao clock, que devem ser respeitadas independentemente de a função implementada estar certa.
]

== Questões estilo POSCOMP

*Questão 1.* Em uma arquitetura digital dividida em controle e datapath, a unidade de controle é responsável por:
- a) Executar diretamente operações aritméticas sobre os dados.
- b) Gerar os sinais que orquestram quando e quais operações o datapath executa.
- c) Armazenar permanentemente todos os dados do sistema.
- d) Substituir a necessidade de registradores.
- e) Processar dados em paralelo com o datapath, de forma independente.

*Questão 2.* O tempo de setup de um flip-flop refere-se a:
- a) O tempo que a saída leva para se estabilizar após uma mudança na entrada.
- b) O intervalo mínimo em que a entrada de dado deve estar estável antes da borda de clock relevante.
- c) O intervalo mínimo em que a entrada deve estar estável depois da borda de clock.
- d) O tempo total de vida útil do flip-flop.
- e) Um conceito exclusivo de circuitos combinacionais.

*Questão 3.* Considerando o exemplo desta seção, se o atraso da lógica combinacional aumentasse para $8"ns"$ (mantendo os demais valores), a frequência máxima de operação:
- a) Aumentaria.
- b) Permaneceria a mesma.
- c) Diminuiria, pois o período mínimo de clock aumentaria.
- d) Seria impossível de calcular.
- e) Se tornaria infinita.

== Gabarito comentado

1. *(b)* -- geração de sinais de controle que orquestram o datapath é a função central da unidade de controle.
2. *(b)* -- definição direta de tempo de setup.
3. *(c)* -- aumentar o atraso da lógica combinacional aumenta $T_(min)$, reduzindo $f_(max) = 1\/T_(min)$.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 9--10 (Controle, datapath e temporização).
- HARRIS, D.; HARRIS, S. *Digital Design and Computer Architecture*. Cap. 3 (Análise de temporização).
