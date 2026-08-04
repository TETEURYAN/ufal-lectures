#import "@preview/mousse-notes:1.1.0": *

= Pipeline
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.9]

== Introdução

Pipeline é a técnica que mais se beneficia da uniformidade das instruções RISC (09): sobrepor a execução de várias instruções em estágios distintos, como uma linha de montagem, para aumentar a vazão (throughput) sem acelerar cada instrução individualmente. É também a origem dos hazards -- situações em que a sobreposição quebra a ilusão de execução sequencial -- tema mais cobrado desta subseção.

== Definições formais

#definition(name: "Pipeline de instruções", id: "def-pipeline-instrucoes")[
  Técnica que divide a execução de uma instrução em $k$ *estágios* independentes, cada um implementado por hardware dedicado, permitindo que até $k$ instruções estejam em processamento simultâneo, uma em cada estágio. O pipeline clássico de 5 estágios (didático, associado a arquiteturas RISC) é: *IF* (busca da instrução), *ID* (decodificação e leitura de registradores), *EX* (execução na ULA), *MEM* (acesso à memória de dados) e *WB* (escrita do resultado no registrador destino).
]

#definition(name: "Hazards (riscos) de pipeline", id: "def-hazards-pipeline")[
  Situações que impedem a próxima instrução de avançar no pipeline no ciclo esperado:
  - *Hazard estrutural*: duas instruções, em estágios diferentes, precisam do *mesmo* recurso de hardware simultaneamente (ex.: uma única porta de acesso à memória usada por IF e MEM ao mesmo tempo).
  - *Hazard de dados*: uma instrução depende de um resultado que uma instrução anterior, ainda em processamento no pipeline, não terminou de calcular -- inclui as dependências RAW (read-after-write, a mais comum e problemática), WAR (write-after-read) e WAW (write-after-write).
  - *Hazard de controle*: uma instrução de desvio (05) só tem seu destino conhecido em um estágio posterior do pipeline, deixando incerto quais instruções buscar nos ciclos imediatamente seguintes.
]

#definition(name: "Técnicas de mitigação de hazards", id: "def-mitigacao-hazards")[
  - *Forwarding (bypassing)*: encaminha o resultado de uma instrução diretamente do estágio onde foi calculado (tipicamente EX) para o estágio de entrada de uma instrução dependente, sem esperar a escrita formal no banco de registradores (WB) -- mitiga hazards de dados sem parar o pipeline.
  - *Stall (bolha)*: insere um ciclo (ou mais) de espera, atrasando a instrução dependente até que o dado esteja disponível -- usado quando forwarding sozinho não resolve a dependência (ex.: instrução `LOAD` seguida imediatamente de uso do valor carregado).
  - *Previsão de desvio (branch prediction)*: a CPU "aposta" no resultado de um desvio (tomado ou não) antes de ele ser resolvido, buscando especulativamente as instruções da direção prevista -- se a previsão errar, o pipeline é esvaziado (flush) e recomeça a partir do destino correto, com penalidade de alguns ciclos.
]

== Propriedade relevante

#theorem(name: "Número de ciclos e speedup ideal de um pipeline", id: "thm-ciclos-speedup-pipeline")[
  Para um pipeline de $k$ estágios executando $n$ instruções, o número total de ciclos necessário é:
  $ "ciclos"_"pipeline" = k + (n - 1) $
  contra $n times k$ ciclos em execução puramente sequencial (sem sobreposição). O speedup ideal, quando $n$ é muito maior que $k$, tende a $k$ (o número de estágios) -- o limite teórico de aceleração de um pipeline sem hazards.
]

== Exemplo resolvido

#example(name: "Ciclos totais e speedup para 4 instruções em pipeline de 5 estágios", id: "ex-ciclos-speedup-pipeline")[
  #figure(
    table(
      columns: 9,
      stroke: 0.5pt,
      align: center,
      [*Instrução*], [1], [2], [3], [4], [5], [6], [7], [8],
      [$I_1$], [IF], [ID], [EX], [MEM], [WB], [], [], [],
      [$I_2$], [], [IF], [ID], [EX], [MEM], [WB], [], [],
      [$I_3$], [], [], [IF], [ID], [EX], [MEM], [WB], [],
      [$I_4$], [], [], [], [IF], [ID], [EX], [MEM], [WB],
    ),
    caption: [Diagrama espaço-tempo de um pipeline de 5 estágios processando 4 instruções -- cada linha é uma instrução, cada coluna um ciclo de clock.],
  )

  Ciclos totais: $k + (n-1) = 5 + (4-1) = 8$ ciclos, contra $n times k = 4 times 5 = 20$ ciclos em execução sequencial pura.

  $ "Speedup" = 20 / 8 = 2.5 $

  Note que o pipeline nunca fica ocioso a partir do ciclo 5: a cada ciclo subsequente, uma nova instrução termina (WB) -- essa é a vazão em regime permanente que justifica o ganho.
]

== Atenção -- pegadinhas comuns

#remark(name: "Pipeline não reduz a latência de uma única instrução -- aumenta a vazão")[
  Uma instrução isolada continua levando $k$ ciclos para completar todos os estágios (a mesma latência de antes, ou até maior, por causa do overhead dos registradores de pipeline entre estágios) -- o que melhora é a *taxa de conclusão* de instruções em regime permanente (uma por ciclo, idealmente), não o tempo individual de cada uma.
]

#remark(name: "Forwarding nem sempre elimina a necessidade de stall")[
  O caso clássico é uma instrução `LOAD` imediatamente seguida por uma instrução que usa o valor carregado: o dado só fica disponível ao final do estágio MEM do `LOAD`, tarde demais para ser encaminhado ao estágio EX da instrução seguinte sem ao menos uma bolha -- esse é o "load-use hazard", que forwarding sozinho não resolve completamente.
]

#remark(name: "Hazard de controle é mais custoso quanto mais cedo o desvio é resolvido tardiamente")[
  Quanto mais estágios o pipeline tiver antes de resolver definitivamente um desvio, maior o número de instruções buscadas especulativamente que podem precisar ser descartadas em caso de previsão errada -- por isso pipelines muito profundos (superpipeline, 12) investem pesadamente em previsores de desvio sofisticados.
]

== Questões estilo POSCOMP

*Questão 1.* Um pipeline de 4 estágios processa 6 instruções. O número total de ciclos necessário, sem hazards, é:
- a) $4$.
- b) $6$.
- c) $9$.
- d) $10$.
- e) $24$.

*Questão 2.* Um hazard de dados do tipo RAW (read-after-write) ocorre quando:
- a) Uma instrução tenta ler um registrador antes que uma instrução anterior, ainda em processamento, termine de escrever nele.
- b) Duas instruções competem pela mesma unidade de memória no mesmo ciclo.
- c) Um desvio condicional altera o fluxo de controle do programa.
- d) Uma instrução é buscada duas vezes pelo mesmo estágio IF.
- e) O pipeline está completamente vazio.

*Questão 3.* A técnica de forwarding (bypassing) tem como objetivo:
- a) Aumentar o número de estágios do pipeline.
- b) Encaminhar um resultado diretamente do estágio onde foi calculado para uma instrução dependente, sem esperar a escrita formal no banco de registradores.
- c) Prever o resultado de desvios condicionais.
- d) Eliminar completamente a necessidade de hazards de controle.
- e) Substituir o estágio de busca de instrução (IF).

== Gabarito comentado

1. *(c)* -- $k + (n-1) = 4 + (6-1) = 9$ ciclos.
2. *(a)* -- definição direta de hazard RAW: leitura de um dado que ainda não foi escrito por uma instrução anterior.
3. *(b)* -- definição direta de forwarding/bypassing apresentada nesta seção.

== Referências

- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. 4 (O processador: pipelining).
- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Cap. 3.
- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre pipelining de instruções.
