#import "@preview/mousse-notes:1.1.0": *

= Paralelismo de Baixa Granularidade
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.10]

== Introdução

Paralelismo pode ser explorado em diferentes escalas ("granularidades"): de instruções individuais dentro de um único fluxo de execução até processos inteiros rodando em máquinas distintas (13, 14). Esta subseção trata da escala mais fina -- o paralelismo em nível de instrução (ILP) --, base conceitual para os processadores superescalares e VLIW tratados em 12.

== Definições formais

#definition(name: "Granularidade de paralelismo", id: "def-granularidade-paralelismo")[
  Medida do *tamanho* da unidade de trabalho que é executada em paralelo:
  - *Granularidade fina (baixa)*: unidades pequenas, como instruções individuais dentro de um mesmo programa -- paralelismo em nível de instrução (ILP). Explorado dentro de uma única CPU.
  - *Granularidade média*: unidades intermediárias, como laços ou procedimentos.
  - *Granularidade grossa (alta)*: unidades grandes, como processos ou programas inteiros, tipicamente distribuídos entre múltiplos núcleos, processadores (13) ou máquinas (14).
  Quanto mais fina a granularidade, maior o potencial de paralelismo explorável, mas também maior a sobrecarga (overhead) de coordenação por unidade de trabalho.
]

#definition(name: "Paralelismo em nível de instrução (ILP)", id: "def-ilp")[
  Quantidade de instruções de um mesmo programa que podem, em princípio, ser executadas simultaneamente (ou fora de ordem) sem violar as dependências de dados e controle entre elas. É a base teórica explorada tanto pelo pipeline simples (10, sobreposição de estágios) quanto pelas técnicas mais agressivas de 12 (múltiplas instruções por ciclo).
]

#definition(name: "Dependências que limitam o ILP", id: "def-dependencias-ilp")[
  O ILP disponível em um trecho de código é limitado pelas dependências entre instruções (já vistas como hazards de dados em 10, agora no contexto mais amplo de quanto paralelismo é *teoricamente* extraível):
  - *Dependência verdadeira (RAW)*: uma instrução usa um resultado calculado por outra -- dependência real, intransponível sem reordenar a lógica do programa.
  - *Antidependência (WAR)* e *dependência de saída (WAW)*: conflitos de *nomes* (o mesmo registrador/posição de memória reutilizado), não de fluxo real de dados -- eliminável por renomeação de registradores, técnica de hardware/compilador que atribui nomes distintos a reutilizações do mesmo registrador arquitetural.
]

#definition(name: "VLIW (Very Long Instruction Word)", id: "def-vliw")[
  Arquitetura em que o *compilador*, não o hardware, identifica em tempo de compilação quais operações são independentes e as agrupa em uma única instrução "muito longa", contendo vários campos de operação executados em paralelo por unidades funcionais distintas. Contrasta com o processador superescalar (12), que descobre paralelismo *em tempo de execução*, via hardware dedicado -- VLIW transfere esse trabalho para o compilador, simplificando o hardware.
]

== Exemplo resolvido

#example(name: "Desenrolamento de laço (loop unrolling) para aumentar o ILP", id: "ex-loop-unrolling")[
  Laço original, somando uma constante a cada elemento de um vetor, uma iteração por vez:
  ```
  para i de 0 até n-1 faça
      V[i] <- V[i] + 10
  fim-para
  ```
  Cada iteração inclui, além da soma útil, overhead de controle (incremento do índice, teste de condição de parada, desvio de volta ao início) -- instruções que não contribuem diretamente para o resultado, mas se repetem a cada elemento.

  *Desenrolado* por um fator 4 (processando 4 elementos por iteração):
  ```
  para i de 0 até n-1, passo 4 faça
      V[i]   <- V[i]   + 10
      V[i+1] <- V[i+1] + 10
      V[i+2] <- V[i+2] + 10
      V[i+3] <- V[i+3] + 10
  fim-para
  ```
  O overhead de controle (teste e desvio) agora ocorre uma vez a cada 4 elementos, não a cada elemento -- e, crucialmente, as quatro somas dentro de uma iteração são *mutuamente independentes* (nenhuma depende do resultado da outra), expondo ILP que o compilador (ou o hardware superescalar de 12) pode explorar executando-as em paralelo.
]

== Atenção -- pegadinhas comuns

#remark(name: "Baixa granularidade não significa \"pouco paralelismo\" -- significa \"unidades pequenas\"")[
  É um erro comum interpretar "granularidade baixa" como sinônimo de "paralelismo limitado". Ao contrário: granularidade fina (instruções individuais) é justamente onde há *mais* oportunidades de paralelismo a explorar dentro de um único programa, embora cada oportunidade individual seja pequena -- volume alto de unidades pequenas, não volume baixo.
]

#remark(name: "WAR e WAW não são dependências de dados reais")[
  Diferente da dependência RAW (o único caso em que um valor genuinamente precisa ser calculado antes de ser usado), WAR e WAW surgem apenas porque duas instruções não relacionadas reutilizam o *mesmo nome* de registrador -- um problema de alocação de nomes, resolvido por renomeação, não uma restrição fundamental sobre a ordem de execução.
]

#remark(name: "VLIW depende fortemente da qualidade do compilador")[
  Como o hardware VLIW não reordena instruções em tempo de execução (ao contrário do superescalar, 12), todo o ônus de encontrar e agrupar operações independentes recai sobre o compilador *em tempo de compilação* -- se o compilador não conseguir extrair ILP suficiente do código-fonte, unidades funcionais do processador VLIW ficam ociosas, sem possibilidade de correção posterior pelo hardware.
]

== Questões estilo POSCOMP

*Questão 1.* A granularidade fina (baixa) de paralelismo se refere a:
- a) Paralelismo entre processos inteiros, distribuídos em máquinas diferentes.
- b) Paralelismo entre instruções individuais de um mesmo programa.
- c) Ausência total de paralelismo.
- d) Paralelismo exclusivo entre discos de um arranjo RAID.
- e) Paralelismo apenas em operações de entrada e saída.

*Questão 2.* As dependências do tipo WAR (write-after-read) e WAW (write-after-write) são consideradas, em relação ao ILP:
- a) Dependências de dados reais, intransponíveis sob qualquer circunstância.
- b) Conflitos de nomeação de registrador, eliminável por renomeação, não uma restrição real de fluxo de dados.
- c) Exclusivas de arquiteturas CISC.
- d) Impossíveis de ocorrer em processadores modernos.
- e) Equivalentes a hazards estruturais de pipeline.

*Questão 3.* A principal diferença entre VLIW e um processador superescalar é que, no VLIW:
- a) O hardware reordena instruções dinamicamente em tempo de execução.
- b) O compilador identifica e agrupa operações independentes em tempo de compilação, sem reordenação pelo hardware em tempo de execução.
- c) Não existe qualquer forma de paralelismo em nível de instrução.
- d) Apenas uma instrução pode ser executada por ciclo, como em processadores escalares simples.
- e) A granularidade do paralelismo é sempre grossa, não fina.

== Gabarito comentado

1. *(b)* -- definição direta de granularidade fina, associada ao paralelismo em nível de instrução (ILP).
2. *(b)* -- WAR e WAW são conflitos de nome, não dependências reais de fluxo de dados, conforme definido nesta seção.
3. *(b)* -- é exatamente a distinção central entre VLIW (paralelismo definido estaticamente pelo compilador) e superescalar (paralelismo descoberto dinamicamente pelo hardware, tratado em 12).

== Referências

- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Cap. 3 (Paralelismo em nível de instrução).
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. 4.
- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre paralelismo em nível de instrução.
