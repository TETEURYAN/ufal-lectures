#import "@preview/mousse-notes:1.1.0": *

= Modelo de Von Neumann, ISA e Microarquitetura
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.1]

== Introdução

Toda a disciplina de Arquitetura e Organização de Computadores parte de um único modelo conceitual: a máquina de Von Neumann, que descreve como CPU, memória e E/S se articulam para executar um programa armazenado. Sobre essa base, é essencial distinguir três níveis de abstração -- ISA, microarquitetura e implementação física -- que a POSCOMP cobra insistentemente, muitas vezes confundindo-os de propósito nas alternativas.

== Definições formais

#definition(name: "Arquitetura de Von Neumann", id: "def-von-neumann")[
  Modelo de organização de computador em que um único espaço de memória armazena tanto *instruções* quanto *dados*, acessado por um único barramento compartilhado. A CPU executa repetidamente o *ciclo de instrução*: busca (fetch) a próxima instrução na memória (endereçada pelo *contador de programa*, PC), decodifica-a, executa-a e, se necessário, acessa memória para ler/escrever dados, antes de avançar o PC para a próxima instrução.
]

#definition(name: "Gargalo de Von Neumann", id: "def-gargalo-von-neumann")[
  Como instruções e dados compartilham o mesmo barramento até a memória, a CPU não pode buscar uma nova instrução e acessar um dado simultaneamente -- esse compartilhamento limita a taxa de transferência entre CPU e memória, tornando-a com frequência o fator limitante de desempenho, independentemente de quão rápida seja a CPU.
]

#definition(name: "Arquitetura de Harvard", id: "def-arquitetura-harvard")[
  Modelo alternativo que mantém memórias *fisicamente separadas* para instruções e para dados, cada uma com seu próprio barramento -- permite buscar uma instrução e acessar um dado no mesmo ciclo, aliviando o gargalo de Von Neumann. É comum em microcontroladores e nos primeiros níveis de cache de processadores modernos (cache de instrução separada da cache de dados), mesmo quando a memória principal, mais abaixo na hierarquia, segue o modelo Von Neumann unificado.
]

#definition(name: "ISA, microarquitetura e implementação", id: "def-isa-microarquitetura-implementacao")[
  Três níveis de abstração, do mais alto (visível ao programador) ao mais baixo (físico):
  - *ISA (Instruction Set Architecture)*: a interface entre software e hardware -- o conjunto de instruções, modos de endereçamento, registradores visíveis e formatos de dados que um programa em linguagem de montagem (03) pode usar. Define *o que* o processador faz.
  - *Microarquitetura*: a organização interna que implementa uma dada ISA -- como o pipeline é estruturado, quantas unidades funcionais existem, como a previsão de desvio funciona. Define *como* a ISA é realizada internamente.
  - *Implementação (física)*: a realização concreta em silício de uma microarquitetura -- litografia, frequência de clock alcançável, layout físico dos transistores.
  Uma mesma ISA pode ter múltiplas microarquiteturas ao longo do tempo (e de fabricantes distintos), e uma mesma microarquitetura pode ter múltiplas implementações físicas (processos de fabricação diferentes).
]

== Exemplo resolvido

#example(name: "Mesma ISA, microarquiteturas diferentes", id: "ex-isa-microarquitetura-x86")[
  A ISA x86-64 é compartilhada por processadores de fabricantes concorrentes -- Intel (microarquiteturas como Skylake, Alder Lake) e AMD (Zen, Zen 4) -- e por gerações sucessivas de cada um. Um programa compilado para x86-64 roda, sem recompilação, em qualquer um desses processadores, pois todos implementam a mesma interface de instruções.

  Internamente, porém, a *microarquitetura* de cada um difere radicalmente: número e organização dos estágios de pipeline (10), tamanho e política das caches (07), presença de execução fora de ordem, número de unidades de execução paralelas (12). Duas gerações de processadores com a mesma ISA podem ter desempenho muito diferente para o mesmo programa, precisamente porque a ISA não determina a microarquitetura -- apenas a restringe a produzir os mesmos resultados observáveis.

  #figure(
    image("figures/von-neumann-architecture.svg", width: 55%),
    caption: [Organização básica de Von Neumann: unidade de controle e ULA (juntas, a CPU), memória e dispositivos de entrada/saída, interligados por um barramento comum. Fonte: Wikimedia Commons, CC BY-SA 3.0 (Chris-martin, Aeroid).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "ISA não é a mesma coisa que microarquitetura")[
  A pegadinha mais recorrente deste subtópico: um enunciado descreve uma característica *interna* de implementação (ex.: número de estágios de pipeline, tamanho de uma cache) e pergunta se isso faz parte "da arquitetura" -- a resposta depende de qual dos três níveis a questão realmente quer dizer. Estritamente, esses detalhes internos são *microarquitetura* ou *implementação*, não a ISA (que só especifica o comportamento visível ao software).
]

#remark(name: "Arquitetura de Harvard não eliminou o modelo de Von Neumann")[
  Processadores modernos de propósito geral continuam sendo, em sua memória principal, máquinas de Von Neumann (um único espaço de endereçamento para código e dados) -- a separação estilo Harvard aparece tipicamente apenas nos níveis mais próximos da CPU (caches L1 de instrução e de dados separadas, 07), uma solução híbrida às vezes chamada de "Harvard modificada", não uma substituição completa do modelo Von Neumann.
]

== Questões estilo POSCOMP

*Questão 1.* O gargalo de Von Neumann decorre diretamente de qual característica do modelo?
- a) O uso de um único barramento compartilhado entre instruções e dados armazenados na mesma memória.
- b) A ausência de registradores na CPU.
- c) O uso exclusivo de memórias voláteis.
- d) A existência de múltiplos núcleos de processamento.
- e) A separação física entre memória de instrução e de dados.

*Questão 2.* Duas CPUs de fabricantes diferentes implementam a mesma ISA, mas uma possui pipeline de 14 estágios e a outra, de 20 estágios. Essa diferença está localizada em qual nível de abstração?
- a) ISA.
- b) Microarquitetura.
- c) Linguagem de montagem.
- d) Sistema operacional.
- e) Modo de endereçamento.

*Questão 3.* A arquitetura de Harvard se diferencia da arquitetura de Von Neumann clássica principalmente por:
- a) Não possuir unidade de controle.
- b) Utilizar memórias e barramentos separados para instruções e dados.
- c) Não permitir operações de entrada e saída.
- d) Ser aplicável apenas a supercomputadores.
- e) Eliminar completamente a necessidade de um contador de programa.

== Gabarito comentado

1. *(a)* -- o compartilhamento do mesmo barramento entre busca de instrução e acesso a dados é exatamente a causa do gargalo, conforme a definição desta seção.
2. *(b)* -- a ISA é preservada (mesmo conjunto de instruções), mas a organização interna (número de estágios) é uma decisão de microarquitetura.
3. *(b)* -- definição direta de arquitetura de Harvard: memórias e barramentos fisicamente separados para instrução e dado.

== Referências

- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. 1--2 (Introdução e organização de computadores).
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. 1 (Abstrações e tecnologia).
- TANENBAUM, A. S. *Organização Estruturada de Computadores*. Cap. 1.
