#import "@preview/mousse-notes:1.1.0": *

= Dispositivos Lógicos Programáveis (PLD)
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.14]

== Introdução

Fechando a disciplina: em vez de fabricar um circuito integrado dedicado para cada projeto (caro, lento de produzir), dispositivos lógicos programáveis permitem implementar circuitos digitais customizados em hardware genérico, reconfigurável antes (ou mesmo depois) da fabricação final.

== Definições formais

#definition(name: "PLA e PAL", id: "def-pla-pal")[
  - *PLA (Programmable Logic Array)*: array programável tanto na matriz *AND* quanto na matriz *OR* -- máxima flexibilidade para implementar qualquer função em forma de soma de produtos (03), mas mais lento e caro de fabricar devido à dupla programabilidade.
  - *PAL (Programmable Array Logic)*: matriz *AND* programável, mas matriz *OR* fixa -- menos flexível que PLA, porém mais simples, rápido e barato, sendo historicamente mais popular para a maioria das aplicações práticas.
]

#definition(name: "FPGA (Field-Programmable Gate Array)", id: "def-fpga")[
  Dispositivo reconfigurável de granularidade muito mais fina que PLA/PAL: um array de *blocos lógicos configuráveis* (tipicamente pequenas tabelas de consulta, LUTs, capazes de implementar qualquer função de poucas entradas) interconectados por uma malha de roteamento também programável. Permite implementar circuitos combinacionais e sequenciais arbitrariamente complexos (incluindo processadores inteiros), reconfiguráveis quantas vezes forem necessárias -- muito mais flexível que PLA/PAL, ao custo de maior área e consumo por função implementada, comparado a um circuito dedicado (ASIC) equivalente.
]

== Comparação entre dispositivos programáveis

#table(
  columns: 4,
  [*Dispositivo*], [*Matriz AND*], [*Matriz OR*], [*Flexibilidade/Granularidade*],
  [PLA], [Programável], [Programável], [Alta flexibilidade em nível de soma de produtos; baixa granularidade],
  [PAL], [Programável], [Fixa], [Flexibilidade intermediária; simples e rápido],
  [FPGA], [N/A (blocos lógicos configuráveis, não matriz AND/OR)], [N/A], [Granularidade fina; pode implementar qualquer circuito digital, incluindo sequenciais complexos],
)

== Exemplo resolvido

#example(name: "Escolhendo entre PAL e FPGA", id: "ex-escolha-pal-fpga")[
  Um projeto precisa implementar um decodificador combinacional simples e fixo (nunca mudará após o projeto inicial), com restrição de custo por unidade em produção de grande volume -- um *PAL* (ou, em maior volume ainda, um ASIC dedicado) é mais adequado: simples, barato em escala, sem necessidade da flexibilidade extra de um FPGA. Já um projeto de prototipagem de um processador customizado, que será ajustado repetidamente durante o desenvolvimento, se beneficia enormemente de um *FPGA*: reconfigurável a cada iteração, sem custo de nova fabricação física a cada mudança de projeto.
]

== Atenção -- pegadinhas comuns

#remark(name: "FPGA não é \"apenas um PLA maior\" -- é uma arquitetura qualitativamente diferente")[
  PLA/PAL são estruturados diretamente como uma matriz AND-OR, adequada para funções combinacionais em forma de soma de produtos. FPGAs usam blocos lógicos configuráveis (LUTs) e roteamento programável, uma arquitetura muito mais geral, capaz de implementar eficientemente circuitos sequenciais complexos e não apenas expressões booleanas simples -- uma diferença de granularidade e arquitetura, não apenas de "tamanho".
]

#remark(name: "Programável não significa reconfigurável indefinidamente, em todos os casos")[
  Alguns PLDs mais antigos são programados *uma única vez* (fusíveis queimados fisicamente, irreversível); outros (a maioria dos PALs/PLAs modernos e todos os FPGAs SRAM-based) são reprogramáveis indefinidamente -- a POSCOMP pode cobrar essa distinção entre programação única e reconfiguração repetida.
]

== Questões estilo POSCOMP

*Questão 1.* A diferença central entre PLA e PAL é que, no PAL:
- a) Ambas as matrizes (AND e OR) são programáveis.
- b) A matriz AND é programável, mas a matriz OR é fixa.
- c) Nenhuma matriz é programável.
- d) Não existe matriz AND.
- e) É idêntico a um FPGA em arquitetura.

*Questão 2.* FPGAs são estruturados com base em:
- a) Uma única matriz AND-OR programável, como PLA.
- b) Blocos lógicos configuráveis (LUTs) interconectados por roteamento programável.
- c) Exclusivamente memórias ROM.
- d) Transistores bipolares TTL fixos.
- e) Uma matriz OR programável e AND fixa, como PAL.

*Questão 3.* Um projeto que exige reconfiguração frequente durante prototipagem, incluindo lógica sequencial complexa, é mais bem atendido por:
- a) PAL.
- b) PLA.
- c) FPGA.
- d) Um circuito TTL fixo.
- e) Uma ROM.

== Gabarito comentado

1. *(b)* -- matriz AND programável com matriz OR fixa é a definição de PAL, em contraste com o PLA (ambas programáveis).
2. *(b)* -- blocos lógicos configuráveis e roteamento programável definem a arquitetura de um FPGA.
3. *(c)* -- flexibilidade para reconfiguração repetida e suporte a lógica sequencial complexa é a vantagem central do FPGA, conforme o exemplo desta seção.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 11 (Dispositivos lógicos programáveis).
- WAKERLY, J. F. *Digital Design: Principles and Practices*. Cap. sobre PLDs e FPGAs.
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 13.
