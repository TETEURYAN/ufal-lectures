#import "@preview/mousse-notes:1.1.0": *

= Mecanismos de Interrupção e de Exceção
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.4]

== Introdução

Interrupções e exceções são o mecanismo pelo qual a CPU desvia do fluxo sequencial normal de execução (Von Neumann, 01) para reagir a eventos -- um dispositivo de E/S pronto, um erro aritmético, uma chamada de sistema. A POSCOMP explora insistentemente a distinção entre interrupção (evento externo, assíncrono) e exceção (evento interno, síncrono à instrução), além do próprio ciclo de atendimento.

== Definições formais

#definition(name: "Interrupção", id: "def-interrupcao")[
  Sinal *assíncrono*, gerado por um dispositivo externo à CPU (ex.: controlador de disco avisando que uma leitura terminou, teclado avisando uma tecla pressionada), que solicita atenção imediata do processador, interrompendo o fluxo de execução corrente entre duas instruções.
]

#definition(name: "Exceção", id: "def-excecao")[
  Evento *síncrono*, gerado internamente pela própria CPU como consequência direta da execução de uma instrução específica (ex.: divisão por zero, overflow aritmético, acesso a instrução inválida, falta de página -- page fault). Ao contrário da interrupção, ocorre em um ponto determinístico e previsível do programa, sempre que aquela instrução com aquelas entradas é executada.
]

#definition(name: "Trap (interrupção de software)", id: "def-trap")[
  Caso particular de exceção, gerada *deliberadamente* pelo próprio programa por meio de uma instrução específica (ex.: `SYSCALL`, `INT`), tipicamente para solicitar um serviço do sistema operacional -- a ponte clássica entre modo usuário e modo núcleo (Sistemas Operacionais).
]

#definition(name: "Vetor de interrupções e rotina de tratamento", id: "def-vetor-interrupcoes")[
  O *vetor de interrupções* é uma tabela, mantida em posição fixa de memória, que associa cada tipo de interrupção/exceção ao endereço inicial de sua *rotina de tratamento* (Interrupt Service Routine, ISR). Ao ocorrer um evento, a CPU consulta o vetor pelo código do evento e desvia a execução para o endereço correspondente.
]

#definition(name: "Interrupções mascaráveis e não mascaráveis", id: "def-interrupcao-mascaravel")[
  - *Mascarável*: pode ser temporariamente ignorada pela CPU, se o software desabilitar aquela linha de interrupção (útil para proteger seções críticas de código contra interrupção).
  - *Não mascarável (NMI)*: não pode ser desabilitada por software -- reservada a eventos críticos que exigem atenção imediata (ex.: falha de energia iminente, erro grave de hardware).
]

== Propriedade relevante

#theorem(name: "Ciclo de atendimento de interrupção/exceção", id: "thm-ciclo-atendimento")[
  Ao detectar uma interrupção ou exceção (verificada ao final de cada ciclo de instrução), a CPU executa, em ordem:
  + Completa (ou descarta, no caso de exceções fatais) a instrução corrente.
  + Salva o *contexto* mínimo necessário para retomar a execução -- ao menos o contador de programa (PC) e os registradores de status/flags -- tipicamente na pilha do sistema.
  + Consulta o vetor de interrupções e desvia o PC para o endereço da rotina de tratamento correspondente.
  + Executa a rotina de tratamento, que trata o evento e, se aplicável, salva/restaura registradores adicionais que for usar.
  + Ao final da rotina, uma instrução de retorno (ex.: `IRET`, `RETI`) restaura o contexto salvo, retomando a execução do programa interrompido no ponto exato em que parou (ou no seguinte, conforme o tipo de evento).
]

== Exemplo resolvido

#example(name: "Rastreando uma interrupção de E/S", id: "ex-rastreio-interrupcao")[
  Um programa executa uma sequência de instruções aritméticas quando, entre duas instruções, o controlador de disco sinaliza (via linha de interrupção) que uma operação de leitura solicitada anteriormente foi concluída.

  + A CPU termina a instrução em andamento normalmente (interrupções de E/S não abortam a instrução corrente, ao contrário de certas exceções fatais).
  + O PC atual (apontando para a *próxima* instrução do programa interrompido) e os flags são salvos na pilha.
  + A CPU consulta o vetor de interrupções na entrada correspondente ao controlador de disco, obtendo o endereço da ISR de tratamento de disco.
  + A ISR copia os dados lidos para o buffer apropriado, sinaliza ao sistema operacional que a operação terminou, e executa a instrução de retorno.
  + O contexto salvo é restaurado, e a CPU retoma exatamente a instrução seguinte à que estava em andamento antes da interrupção -- o programa original não percebe que foi interrompido, exceto pelo tempo decorrido.
]

== Atenção -- pegadinhas comuns

#remark(name: "Interrupção é assíncrona; exceção é síncrona -- a distinção mais cobrada desta seção")[
  Uma interrupção pode ocorrer a qualquer momento, independente de qual instrução está sendo executada (depende do dispositivo externo). Uma exceção está sempre associada a uma instrução específica e, dada a mesma entrada, ocorre de forma reprodutível sempre que aquela instrução é executada -- por exemplo, dividir por zero sempre gera a mesma exceção no mesmo ponto do código.
]

#remark(name: "Trap é uma exceção deliberada, não um erro")[
  Diferente de uma exceção de erro (divisão por zero, instrução inválida), uma trap é disparada *intencionalmente* pelo programa para solicitar um serviço -- tipicamente uma chamada de sistema. Tratar toda exceção como sinônimo de "erro de programa" é um erro conceitual comum.
]

#remark(name: "Interrupção não mascarável não significa \"a mais frequente\", mas \"a mais crítica\"")[
  NMI é reservada a eventos raros, porém graves o bastante para que ignorá-los (mesmo temporariamente) seja inaceitável -- não deve ser confundida com "a interrupção de maior prioridade entre as mascaráveis", que ainda pode ser desabilitada em conjunto com as demais em uma seção crítica.
]

== Questões estilo POSCOMP

*Questão 1.* A principal diferença entre uma interrupção e uma exceção é que a interrupção é:
- a) Sempre gerada pela própria instrução em execução.
- b) Um evento assíncrono, gerado por um dispositivo externo à CPU, independente da instrução em execução.
- c) Sempre não mascarável.
- d) Um mecanismo exclusivo de sistemas com múltiplos núcleos.
- e) Incapaz de interromper o fluxo de execução.

*Questão 2.* Ao atender uma interrupção, antes de desviar para a rotina de tratamento, a CPU deve necessariamente:
- a) Reiniciar o sistema operacional.
- b) Salvar o contexto mínimo (ao menos PC e flags) para permitir retomar a execução posteriormente.
- c) Apagar o conteúdo de todos os registradores.
- d) Desligar todos os dispositivos de entrada e saída.
- e) Recompilar o programa em execução.

*Questão 3.* Uma instrução de divisão por zero, ao ser executada, sempre gera o mesmo evento no mesmo ponto do programa. Esse evento é classificado como:
- a) Interrupção mascarável.
- b) Interrupção não mascarável.
- c) Exceção.
- d) Sinal de E/S.
- e) Diretiva de montagem.

== Gabarito comentado

1. *(b)* -- é exatamente a definição de interrupção: evento assíncrono, externo, independente da instrução corrente.
2. *(b)* -- salvar contexto (PC e flags, no mínimo) é etapa obrigatória do ciclo de atendimento, para permitir retomar a execução do programa interrompido.
3. *(c)* -- por ser síncrona à instrução e reprodutível, é uma exceção, não uma interrupção.

== Referências

- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre interrupções.
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. sobre exceções.
- TANENBAUM, A. S. *Organização Estruturada de Computadores*. Cap. sobre entrada/saída e interrupções.
