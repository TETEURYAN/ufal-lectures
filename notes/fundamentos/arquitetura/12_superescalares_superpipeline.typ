#import "@preview/mousse-notes:1.1.0": *

= Processadores Superescalares e Superpipeline
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.11]

== Introdução

Se o pipeline clássico (10) busca executar uma instrução por ciclo em regime permanente, superescalar e superpipeline são duas estratégias -- ortogonais entre si -- para ir além desse limite: uma alargando o pipeline (mais instruções por ciclo), outra aprofundando-o (mais estágios, ciclos mais curtos). A POSCOMP cobra principalmente a distinção conceitual entre as duas.

== Definições formais

#definition(name: "Processador superescalar", id: "def-superescalar")[
  Processador capaz de buscar, decodificar e *emitir múltiplas instruções por ciclo de clock*, replicando hardware (múltiplas unidades de busca/decodificação e múltiplas unidades funcionais, como duas ULAs) para executá-las em paralelo -- desde que não haja dependências (hazards, 10) entre elas. O grau de superescalaridade (issue width) indica quantas instruções, no máximo, podem ser emitidas por ciclo (ex.: superescalar de grau 4 emite até 4 instruções por ciclo).
]

#definition(name: "Processador superpipeline (superpipelined)", id: "def-superpipeline")[
  Processador que subdivide os estágios clássicos do pipeline (10) em *estágios ainda mais numerosos e curtos*, cada um realizando uma fração menor de trabalho -- permitindo aumentar a frequência de clock (já que o estágio mais lento, que limita o período de clock, agora faz menos trabalho). O ganho vem de ciclos mais curtos e mais numerosos, não de mais instruções por ciclo.
]

#definition(name: "Execução fora de ordem (out-of-order execution)", id: "def-execucao-fora-ordem")[
  Técnica, comum em processadores superescalares, em que instruções são executadas assim que seus operandos ficam disponíveis -- não necessariamente na ordem em que aparecem no programa -- para não bloquear instruções independentes atrás de uma instrução momentaneamente travada por dependência. Para preservar a semântica sequencial observável (e permitir exceções precisas, 05), os resultados são *retirados (commit/retire)* em ordem, mesmo que tenham sido *calculados* fora de ordem.
]

#definition(name: "IPC (Instructions Per Cycle)", id: "def-ipc")[
  Número médio de instruções concluídas por ciclo de clock -- o inverso do CPI (02), $"IPC" = 1 \/ "CPI"$. Processadores escalares simples (não superescalares) têm IPC teórico máximo igual a $1$; processadores superescalares de grau $w$ podem, em princípio, atingir $"IPC" <= w$, limitado na prática por hazards e dependências do programa.
]

== Atenção -- pegadinhas comuns

#remark(name: "Superescalar é \"largo\"; superpipeline é \"profundo\" -- não confundir as duas dimensões")[
  Superescalar aumenta o número de instruções processadas *por ciclo* (paralelismo espacial, réplicas de hardware). Superpipeline aumenta o número de *estágios* do pipeline, permitindo ciclos mais curtos (paralelismo temporal, mais sobreposição). São otimizações em eixos diferentes, e um processador pode ser simultaneamente superescalar *e* superpipeline -- não são mutuamente exclusivas nem a mesma técnica com nomes diferentes.
]

#remark(name: "Pipeline mais profundo não é sempre melhor")[
  Aumentar o número de estágios eleva a frequência de clock alcançável, mas também aumenta a penalidade de hazards de controle (10) -- um desvio mal previsto em um pipeline muito profundo descarta mais instruções especulativas em andamento. Há um ponto de retorno decrescente, e processadores reais equilibram profundidade de pipeline contra essa penalidade.
]

#remark(name: "Execução fora de ordem calcula fora de ordem, mas retira (commit) em ordem")[
  Um erro comum é achar que "fora de ordem" significa que o programa produz resultados observáveis em ordem arbitrária -- na verdade, apenas o *cálculo interno* pode ocorrer fora de ordem; os resultados são *confirmados* (tornados visíveis, escritos definitivamente) na ordem original do programa, preservando a ilusão de execução sequencial e permitindo tratar exceções de forma precisa (05).
]

== Exemplo resolvido

#example(name: "Comparando IPC teórico entre escalar e superescalar", id: "ex-ipc-comparacao")[
  Um processador escalar simples tem CPI médio de $1.2$ (por conta de hazards ocasionais). Seu IPC é:
  $ "IPC"_"escalar" = 1 \/ 1.2 approx 0.83 $

  Um processador superescalar de grau $4$, executando o mesmo programa, consegue emitir em média $2.5$ instruções por ciclo (limitado pelas dependências do próprio código, abaixo do máximo teórico de $4$):
  $ "IPC"_"superescalar" = 2.5 $

  Mesmo estando bem abaixo do grau máximo de emissão ($4$), o superescalar ainda alcança um IPC cerca de $3$ vezes maior que o escalar -- ilustrando por que o grau de superescalaridade é um limite *superior*, raramente atingido integralmente por causa de dependências reais no código (11).
]

== Questões estilo POSCOMP

*Questão 1.* Um processador superescalar de grau 3 é caracterizado por:
- a) Ter pipeline com o triplo de estágios de um pipeline convencional.
- b) Poder buscar, decodificar e emitir até 3 instruções por ciclo de clock.
- c) Executar exatamente 3 programas simultaneamente.
- d) Ter frequência de clock 3 vezes maior que um processador escalar.
- e) Utilizar exclusivamente 3 níveis de cache.

*Questão 2.* A principal diferença entre um processador superescalar e um superpipeline é:
- a) Não há diferença; são sinônimos.
- b) Superescalar aumenta instruções processadas por ciclo; superpipeline aumenta o número de estágios do pipeline, permitindo ciclos mais curtos.
- c) Superpipeline é exclusivo de arquiteturas CISC.
- d) Superescalar só existe em processadores de núcleo único.
- e) Superpipeline elimina totalmente hazards de dados.

*Questão 3.* Na execução fora de ordem, os resultados das instruções são:
- a) Calculados e confirmados (commit) sempre na ordem original do programa.
- b) Calculados possivelmente fora de ordem, mas confirmados (commit) na ordem original do programa.
- c) Calculados e confirmados em ordem totalmente arbitrária, sem relação com o programa original.
- d) Sempre descartados antes de serem usados.
- e) Impossíveis de reverter em caso de exceção.

== Gabarito comentado

1. *(b)* -- definição direta de grau de superescalaridade (issue width) desta seção.
2. *(b)* -- distinção central entre as duas técnicas: paralelismo por ciclo (superescalar) vs. profundidade de pipeline (superpipeline).
3. *(b)* -- cálculo fora de ordem, mas confirmação (commit/retire) em ordem, conforme a definição de execução fora de ordem desta seção.

== Referências

- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Cap. 3 (Exploração de ILP: superescalar e execução dinâmica).
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. 4.
- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre processadores superescalares.
