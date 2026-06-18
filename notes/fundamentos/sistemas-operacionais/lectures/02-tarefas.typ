#import "@preview/mousse-notes:1.1.0": *

= Conceitos de Tarefas

== Introdução

Imagine que você está diante de um computador moderno e decide abrir simultaneamente um navegador web, um editor de texto e um reprodutor de música. Para o usuário, parece que essas três aplicações rodam ao mesmo tempo, de forma harmoniosa e independente. Mas como o sistema operacional consegue fazer isso, especialmente em um processador que, na maioria das vezes, só é capaz de executar um único fluxo de instruções por vez?

A resposta está em um dos conceitos mais centrais da área de sistemas operacionais: o conceito de *tarefa*. Entender o que é uma tarefa, como ela nasce, evolui e termina, e como o sistema operacional a controla é fundamental para compreender o funcionamento de qualquer sistema computacional moderno.

Este capítulo apresenta o conceito de tarefa de forma progressiva. Começamos pela definição e pelas distinções fundamentais em relação a conceitos correlatos, como programa, processo e thread. Em seguida, exploramos o ciclo de vida das tarefas, o contexto de execução, a troca de contexto e os diferentes tipos de tarefas. Por fim, discutimos concorrência, paralelismo e a importância do gerenciamento de tarefas para a construção de sistemas eficientes e responsivos.

== O que é uma Tarefa

No vocabulário dos sistemas operacionais, o termo *tarefa* (_task_) refere-se a uma unidade de trabalho gerenciada pelo sistema operacional. Ela representa a execução ativa de um programa ou de parte dele, sendo dotada de recursos próprios e de um estado que evolui ao longo do tempo.

#definition[
  Uma *tarefa* é definida como a execução de um fluxo sequencial de instruções construído para atender a uma finalidade específica. Do ponto de vista do sistema operacional, uma tarefa é uma entidade ativa que compete por recursos de hardware e software para completar seu objetivo.
]

É importante ressaltar que o termo "tarefa" é usado de forma abrangente neste texto para englobar tanto *processos* quanto *threads*, que são as duas principais formas concretas de implementação de tarefas em sistemas modernos. A distinção entre esses termos será aprofundada mais adiante neste capítulo.

A importância das tarefas reside no fato de que são elas que permitem ao sistema operacional organizar, priorizar e distribuir o uso dos recursos de hardware entre diferentes demandas de execução. Sem o conceito de tarefa, seria impossível suportar a execução simultânea de múltiplos programas, característica que consideramos trivial nos computadores atuais.

== Programa versus Tarefa

Uma das confusões mais comuns entre iniciantes é tratar os termos "programa" e "tarefa" (ou "processo") como sinônimos. Embora estejam relacionados, eles se referem a realidades fundamentalmente distintas.

Um *programa* é uma entidade *estática*: trata-se de um conjunto de instruções e dados armazenados em um arquivo no sistema de armazenamento persistente (disco rígido, SSD, etc.). O programa existe independentemente de estar sendo executado ou não. Ele é apenas uma descrição do que deve ser feito.

Uma *tarefa*, por sua vez, é uma entidade *dinâmica*: é o programa em execução. Ela possui estado, consome recursos e evolui ao longo do tempo. Uma mesma tarefa pode ser interrompida, retomada, bloqueada e finalizada. Sua existência é temporária e começa no momento em que o programa é carregado na memória e encerrada quando a execução termina.

Uma analogia frequentemente utilizada para ilustrar essa distinção é a da receita de bolo @book:

#example[
  Considere uma receita de bolo escrita em um livro guardado na estante. O *programa* é a receita em si: um texto estático que descreve ingredientes, quantidades e procedimentos. Ele pode existir sem nunca ser executado.

  A *tarefa* é o ato de cozinhar seguindo aquela receita. A cozinheira (o processador) lê os passos, separa os ingredientes (dados de entrada), mistura, assa e produz o bolo (saída). Durante a execução, ela pode ser interrompida por um telefonema (interrupção), retomar de onde parou e, eventualmente, concluir o trabalho.

  Uma mesma receita pode ser executada simultaneamente por duas cozinheiras em cozinhas diferentes, produzindo dois bolos distintos — assim como o mesmo programa pode originar múltiplas tarefas rodando ao mesmo tempo no computador.
]

A tabela a seguir resume as principais diferenças entre programa e tarefa:

#figure(
  table(
    columns: (auto, auto, auto),
    align: left,
    stroke: 0.5pt,
    table.header(
      [*Aspecto*], [*Programa*], [*Tarefa*],
    ),
    [Natureza], [Estática], [Dinâmica],
    [Armazenamento], [Disco (arquivo executável)], [Memória RAM (durante execução)],
    [Existência], [Permanente (enquanto o arquivo existir)], [Temporária (enquanto executar)],
    [Estado], [Não possui estado de execução], [Possui estado que evolui],
    [Recursos], [Não consome recursos ativos], [Consome CPU, memória, I/O],
    [Multiplicidade], [Um arquivo pode originar várias tarefas], [Cada tarefa é uma instância única],
  ),
  caption: [Diferenças entre programa e tarefa],
)

Essa distinção é fundamental para compreender por que é possível abrir o mesmo aplicativo duas vezes no computador e obter duas janelas independentes: cada abertura cria uma nova tarefa a partir do mesmo programa.

== Características Fundamentais de uma Tarefa

Uma tarefa possui um conjunto de características que a definem e a diferenciam de outras tarefas no sistema. Compreender essas características é essencial para entender como o sistema operacional as gerencia.

=== Identidade

Cada tarefa possui um identificador único, denominado *PID* (_Process Identifier_) nos sistemas baseados em Unix/Linux. Esse identificador permite ao sistema operacional referenciar, monitorar e controlar cada tarefa de forma inequívoca. O PID é atribuído no momento da criação da tarefa e liberado após seu encerramento.

=== Estado de Execução

Em qualquer instante, uma tarefa se encontra em um determinado estado que reflete sua situação atual em relação ao uso do processador e dos demais recursos. Os estados possíveis e as transições entre eles são discutidos em detalhes na seção sobre o ciclo de vida.

=== Contexto de Execução

O contexto de execução é o conjunto completo de informações que descreve o estado atual de uma tarefa. Ele inclui o conteúdo dos registradores do processador, o ponteiro para a próxima instrução a ser executada (_program counter_), o estado da pilha de execução (_stack_), os identificadores dos recursos alocados (arquivos abertos, conexões de rede, segmentos de memória) e outras informações de controle mantidas pelo sistema operacional. O contexto é o que permite que uma tarefa seja interrompida e retomada sem perda de informação.

=== Espaço de Endereçamento

Cada tarefa possui seu próprio espaço de endereçamento virtual, ou seja, um conjunto de endereços de memória que ela pode acessar. Esse espaço é dividido em regiões com funções específicas: código (as instruções do programa), dados estáticos e globais, heap (memória alocada dinamicamente) e pilha (dados temporários, parâmetros de funções e endereços de retorno).

=== Recursos Associados

Durante sua execução, uma tarefa acumula recursos alocados pelo sistema operacional: descritores de arquivos abertos, conexões de rede, semáforos, segmentos de memória compartilhada, entre outros. Esses recursos são gerenciados pelo sistema operacional e liberados ao término da tarefa.

=== Proprietário e Permissões

Em sistemas multiusuário, cada tarefa está associada a um usuário (ou a uma conta de sistema), e essa associação determina as permissões de acesso a arquivos, dispositivos e outros recursos do sistema. Isso garante isolamento e segurança entre tarefas de diferentes usuários.

=== Prioridade

O sistema operacional atribui a cada tarefa uma prioridade que influencia o escalonamento, ou seja, a decisão de qual tarefa terá acesso ao processador quando houver competição. Prioridades podem ser fixas ou dinâmicas, e sua gestão é um dos principais desafios dos algoritmos de escalonamento.

== Estados de uma Tarefa

O comportamento de uma tarefa ao longo do tempo é descrito por um modelo de estados. Cada estado representa uma condição distinta em que a tarefa pode se encontrar, e as transições entre estados são disparadas por eventos específicos. O modelo mais comum, adotado pela maioria dos sistemas operacionais modernos, define cinco estados principais.

```
  +-------+    admissão     +-------+    escalonar    +-----------+
  | Nova  | -------------> | Pronta | ------------> | Executando |
  +-------+                +-------+                +-----------+
                               ^                         |
                               |      preempção          |
                               +-------------------------+
                               |                         |
                               |   evento concluído      |  aguardar evento
                               |                         v
                               |                    +-----------+
                               +------------------- | Bloqueada |
                                                    +-----------+
                                                         |
  +-----------+                                          |  (não há transição
  | Finalizada| <------- término ---------------+        |   direta de
  +-----------+          (de qualquer estado)   |        |   Bloqueada para
                                                +--------+   Finalizada)
```

// #note[
//   O diagrama acima representa o modelo de cinco estados mais utilizado na literatura. Alguns sistemas operacionais adicionam estados adicionais, como "suspenso" (_suspended_) ou "zumbi" (_zombie_), para tratar situações específicas. Esses estados serão discutidos oportunamente.
// ]

=== Estado Novo (_New_)

O estado *Novo* corresponde ao momento em que uma tarefa está sendo criada, mas ainda não está apta a concorrer pelo processador. Nessa fase, o sistema operacional reserva as estruturas de dados necessárias para representar a tarefa (como a entrada na tabela de processos), aloca o espaço de endereçamento inicial e carrega o código do programa na memória.

A criação de uma tarefa pode ocorrer de diversas formas: pela chamada de sistema `fork()` (que cria uma cópia da tarefa atual) em sistemas Unix, pela chamada `CreateProcess()` no Windows, ou pela inicialização automática pelo próprio sistema operacional durante o boot.

Durante o estado Novo, a tarefa não está elegível para execução. A transição para o estado Pronto ocorre quando a inicialização é concluída e o sistema operacional a admite na fila de tarefas prontas.

=== Estado Pronto (_Ready_)

No estado *Pronto*, a tarefa está completamente inicializada, tem todos os recursos necessários (exceto o processador) e aguarda sua vez de executar. Ela está na *fila de prontos* (_ready queue_), uma estrutura de dados mantida pelo escalonador do sistema operacional.

Uma tarefa pode entrar no estado Pronto a partir de dois caminhos distintos:

- A partir do estado Novo, quando sua inicialização é concluída.
- A partir do estado Executando, quando o sistema operacional a preempta (interrompe sua execução para dar vez a outra tarefa).
- A partir do estado Bloqueado, quando o evento que a tarefa aguardava ocorre e ela está pronta para prosseguir.

O tempo que uma tarefa passa no estado Pronto sem executar é denominado *tempo de espera* (_waiting time_) e é uma das métricas utilizadas para avaliar a qualidade dos algoritmos de escalonamento.

=== Estado Executando (_Running_)

No estado *Executando*, a tarefa está efetivamente utilizando o processador para executar suas instruções. Em um sistema com um único núcleo de processamento, apenas uma tarefa pode estar no estado Executando em cada instante. Em sistemas multiprocessadores ou com múltiplos núcleos, pode haver tantas tarefas executando simultaneamente quantos forem os núcleos disponíveis.

A tarefa permanece no estado Executando até que uma das seguintes situações ocorra:

- Ela solicita acesso a um recurso indisponível (leitura de arquivo, espera por entrada do usuário, etc.), transitando para o estado Bloqueado.
- Ela é preemptada pelo sistema operacional (por exemplo, porque seu tempo de CPU esgotou), transitando para o estado Pronto.
- Ela conclui sua execução, transitando para o estado Finalizado.

=== Estado Bloqueado (_Blocked_ / _Waiting_)

No estado *Bloqueado* (também chamado de *Espera*), a tarefa está impossibilitada de executar porque está aguardando a ocorrência de algum evento externo. Exemplos típicos incluem:

- A conclusão de uma operação de entrada e saída (leitura de um arquivo do disco, recebimento de dados pela rede).
- A disponibilização de um recurso compartilhado (como um semáforo ou mutex).
- A expiração de um temporizador (_timer_).
- Uma resposta do usuário (pressionamento de tecla, clique do mouse).

Durante o período em que está bloqueada, a tarefa não consome tempo de CPU, o que permite ao sistema operacional utilizar o processador para executar outras tarefas. Essa é uma das razões pelas quais a multiprogramação é tão eficiente: enquanto uma tarefa aguarda uma operação de I/O lenta, outras tarefas podem avançar em suas computações.

A transição do estado Bloqueado para o estado Pronto ocorre quando o evento aguardado acontece. Note que a tarefa vai para o estado *Pronto*, não diretamente para o estado Executando: ela ainda precisa aguardar o escalonador lhe conceder acesso ao processador.

  // #note[
  //   Em alguns textos, o estado Bloqueado é subdivido em dois subestados: *Bloqueado* (aguardando um evento de I/O ou sincronização) e *Suspenso* (a tarefa foi temporariamente removida da memória principal e transferida para o armazenamento secundário, num processo denominado _swapping_). Essa subdivisão é relevante em sistemas com memória física limitada.
  // ]

=== Estado Finalizado (_Terminated_ / _Exit_)

No estado *Finalizado*, a tarefa completou sua execução — seja por ter concluído normalmente, seja por ter sido encerrada de forma forçada (por exemplo, devido a um erro fatal ou por solicitação do usuário ou do sistema operacional).

Quando uma tarefa entra no estado Finalizado, o sistema operacional inicia o processo de liberação dos recursos que ela detinha: memória alocada, arquivos abertos, conexões de rede, entre outros. No entanto, em sistemas do tipo Unix, a entrada da tarefa na tabela de processos pode ser mantida temporariamente até que a tarefa pai (_parent process_) leia o código de saída do filho. Uma tarefa nessa condição — já finalizada, mas ainda com entrada na tabela — é chamada de *processo zumbi* (_zombie process_).

== Ciclo de Vida de uma Tarefa

O ciclo de vida de uma tarefa é o percurso que ela realiza pelos diferentes estados desde sua criação até seu encerramento. A figura abaixo representa esse ciclo de forma mais detalhada, incluindo as principais transições e os eventos que as provocam.

```
                         [1] Admissão
  (Nova) -----------------------------------------> (Pronta)
                                                        |
                                           [2] Escalonamento
                                                        |
                                                        v
  (Pronta) <-------------------------- [3] Preempção (Executando)
                                                        |
                              +-------------------------+
                              |                         |
                   [4] Solicit. I/O              [5] Conclusão
                   ou evento                           |
                              |                        v
                              v                    (Finalizada)
                          (Bloqueada)
                              |
                    [6] Evento concluído
                              |
                              v
                          (Pronta)
```

As principais transições são:

+ *Admissão* (Nova → Pronta): O sistema operacional conclui a inicialização da tarefa e a insere na fila de prontos.
+ *Escalonamento* (Pronta → Executando): O escalonador seleciona a tarefa como a próxima a receber o processador.
+ *Preempção* (Executando → Pronta): O sistema operacional interrompe a tarefa (por exemplo, porque seu quantum de tempo expirou) e a retorna à fila de prontos.
+ *Bloqueio* (Executando → Bloqueada): A tarefa solicita acesso a um recurso indisponível ou aguarda um evento e é suspensa.
+ *Conclusão* (Executando → Finalizada): A tarefa encerra sua execução normalmente ou é terminada de forma forçada.
+ *Desbloqueio* (Bloqueada → Pronta): O evento aguardado ocorre e a tarefa retorna à fila de prontos.

// #note[
//   Uma tarefa nunca transita diretamente do estado Bloqueado para o estado Executando. Ela sempre passa pelo estado Pronto antes de obter o processador novamente. Isso garante justiça (_fairness_) na distribuição do processador entre todas as tarefas prontas.
// ]

== Contexto de Execução

Para que o sistema operacional possa implementar as transições entre estados de forma transparente — especialmente a preempção e o posterior retorno de uma tarefa ao processador —, ele precisa ser capaz de *salvar* e *restaurar* o estado completo de uma tarefa. Esse estado é denominado *contexto de execução*.

O contexto de execução de uma tarefa é composto por:

- *Registradores de propósito geral*: valores armazenados nos registradores da CPU no momento da interrupção (acumuladores, registradores de índice, etc.).
- *Contador de programa* (_Program Counter_ — PC): endereço da próxima instrução a ser executada.
- *Ponteiro de pilha* (_Stack Pointer_ — SP): endereço do topo da pilha de execução da tarefa.
- *Registradores de status*: flags de condição (zero, negativo, overflow, carry, etc.) que refletem o resultado das últimas operações aritméticas e lógicas.
- *Informações de memória*: mapeamentos do espaço de endereçamento virtual para o físico (tabelas de páginas ou segmentos).
- *Informações de I/O*: lista de dispositivos e arquivos em uso, buffers de entrada/saída, posição atual em arquivos abertos.
- *Informações contábeis*: tempo de CPU consumido, limites de recursos, identificadores de usuário e grupo.

Todas essas informações são armazenadas pelo sistema operacional em uma estrutura de dados denominada *Bloco de Controle de Processo* (_Process Control Block_ — PCB) ou, de forma mais genérica, *descritor de tarefa*.

#definition[
  O *Bloco de Controle de Processo* (PCB) é a estrutura de dados central que o sistema operacional mantém para cada tarefa ativa. Ela contém todas as informações necessárias para descrever o estado atual da tarefa e para retomar sua execução a partir do ponto em que foi interrompida.
]

O PCB é criado quando a tarefa é admitida pelo sistema operacional e destruído quando ela finaliza. Enquanto a tarefa existe, o PCB é a sua "identidade" perante o sistema operacional.

== Troca de Contexto

A *troca de contexto* (_context switch_) é o mecanismo pelo qual o sistema operacional passa o controle do processador de uma tarefa para outra. É um procedimento fundamental para a implementação de multitarefa e ocorre dezenas ou centenas de vezes por segundo em sistemas modernos.

O processo de troca de contexto envolve as seguintes etapas:

+ *Interrupção da tarefa em execução*: Um sinal de interrupção (geralmente um temporizador de hardware) avisa o sistema operacional de que é hora de realizar uma troca de contexto.
+ *Salvamento do contexto da tarefa atual*: O sistema operacional salva o conteúdo de todos os registradores do processador e demais informações de estado no PCB da tarefa que estava executando.
+ *Seleção da próxima tarefa*: O escalonador (_scheduler_) decide qual tarefa receberá o processador a seguir, com base no algoritmo de escalonamento adotado.
+ *Restauração do contexto da nova tarefa*: O sistema operacional carrega no processador os valores dos registradores e demais informações de estado armazenadas no PCB da tarefa selecionada.
+ *Retomada da execução*: O processador começa a executar as instruções da nova tarefa a partir do ponto onde ela havia sido interrompida.

```
  Tarefa A          Sistema Operacional         Tarefa B
  --------          ------------------          --------
  Executando
      |
      | (interrupção)
      |
      +-----------> Salva contexto de A
                    Seleciona tarefa B
                    Restaura contexto de B
                                                Executando
                                                    |
                                                    | (interrupção)
                                                    |
                    Salva contexto de B <-----------+
                    Seleciona tarefa A
                    Restaura contexto de A
      |
  Executando
```

=== Custo da Troca de Contexto

A troca de contexto tem um custo: durante sua realização, nenhuma tarefa de usuário está executando, pois o processador está ocupado com as operações de salvamento e restauração de contexto. Esse tempo é considerado *overhead* do sistema operacional.

// #warning[
//   A troca de contexto é uma operação puramente de sobrecarga (_overhead_): durante sua execução, nenhum trabalho útil para as aplicações é realizado. Sistemas operacionais modernos otimizam ao máximo essa operação, mas ela nunca tem custo zero. Por isso, trocas de contexto muito frequentes podem degradar o desempenho do sistema.
// ]

O custo de uma troca de contexto depende de fatores como:

- A quantidade de registradores que precisam ser salvos e restaurados.
- A complexidade da arquitetura de memória (por exemplo, se é necessário invalidar o cache de tradução de endereços — _TLB_ — durante a troca).
- A velocidade da memória utilizada para armazenar os PCBs.

Em sistemas modernos com processadores de 64 bits, uma troca de contexto pode levar de algumas centenas de nanosegundos a alguns microssegundos, dependendo da arquitetura.

== Tipos de Tarefas

Uma classificação importante para o escalonamento e o gerenciamento de desempenho é a distinção entre tarefas *CPU-bound* e tarefas *I/O-bound*, baseada no padrão de uso dos recursos do sistema.

=== Tarefas CPU-bound

Uma tarefa é classificada como *CPU-bound* (limitada pela CPU) quando a maior parte do seu tempo de execução é dedicada a processamento intensivo no processador. Essas tarefas realizam poucas operações de entrada e saída e passam a maior parte do tempo no estado Executando.

#example[
  Exemplos típicos de tarefas CPU-bound incluem:
  - Algoritmos de criptografia e descriptografia.
  - Renderização de imagens e vídeos (processamento gráfico).
  - Simulações numéricas e modelos físicos.
  - Compilação de programas.
  - Treinamento de modelos de aprendizado de máquina.
  - Cálculos matemáticos complexos (como fatoração de números primos).
]

Para tarefas CPU-bound, o fator limitante é a velocidade e a disponibilidade do processador. O desempenho dessas tarefas melhora significativamente com o uso de múltiplos núcleos de processamento ou processadores mais rápidos.

=== Tarefas I/O-bound

Uma tarefa é classificada como *I/O-bound* (limitada por entrada/saída) quando a maior parte do seu tempo de execução é gasta aguardando operações de entrada e saída. Essas tarefas ficam frequentemente no estado Bloqueado e usam o processador por períodos curtos entre as operações de I/O.

#example[
  Exemplos típicos de tarefas I/O-bound incluem:
  - Servidores de banco de dados (que frequentemente leem e escrevem em disco).
  - Navegadores web (que aguardam respostas de servidores remotos).
  - Editores de texto (que aguardam entrada do usuário).
  - Aplicações de streaming de vídeo (que aguardam dados da rede).
  - Sistemas de backup (que leem e escrevem grandes volumes de dados).
]

Para tarefas I/O-bound, a velocidade da CPU raramente é o gargalo. O desempenho dessas tarefas é mais sensível à velocidade e à latência dos dispositivos de armazenamento e rede.

=== Implicações para o Escalonamento

A distinção entre tarefas CPU-bound e I/O-bound é relevante para o escalonamento porque:

- *Tarefas I/O-bound* costumam liberar o processador voluntariamente (ao bloquear aguardando I/O), o que favorece um alto nível de multiprogramação.
- *Tarefas CPU-bound* tendem a utilizar integralmente seus quanta de tempo, exigindo preempção para garantir que outras tarefas também recebam acesso ao processador.

Um escalonador bem projetado deve equilibrar a presença de ambos os tipos de tarefas, maximizando a utilização tanto do processador quanto dos dispositivos de I/O.

== Gerenciamento de Tarefas pelo Sistema Operacional

O gerenciamento de tarefas é uma das responsabilidades centrais do sistema operacional. Ele engloba todas as atividades relacionadas à criação, monitoramento, controle e encerramento de tarefas, além da alocação justa e eficiente dos recursos do sistema entre elas.

=== Criação de Tarefas

A criação de uma nova tarefa ocorre mediante uma *chamada de sistema* (_system call_) realizada por uma tarefa existente ou pelo próprio núcleo do sistema operacional. Nos sistemas Unix e Linux, a chamada `fork()` cria uma cópia da tarefa chamadora (denominada *processo filho*), que herda o espaço de endereçamento, os descritores de arquivo e os atributos do processo pai. Após o `fork()`, a função `exec()` pode ser usada para substituir o código do processo filho por um novo programa.

No Windows, a função `CreateProcess()` realiza a criação de um novo processo e o carregamento do código do programa em uma única operação.

=== Escalonamento de Tarefas

O *escalonador* (_scheduler_) é o componente do sistema operacional responsável por decidir qual tarefa receberá acesso ao processador em cada momento. Essa decisão é tomada com base em um *algoritmo de escalonamento*, que pode levar em conta critérios como prioridade, tempo de espera, tipo de tarefa e tempo de execução estimado. O escalonamento será estudado em detalhes no Capítulo 6.

=== Comunicação e Sincronização

O sistema operacional também é responsável por prover mecanismos que permitam às tarefas se comunicar (troca de mensagens, memória compartilhada, pipes) e se sincronizar (semáforos, mutexes, variáveis de condição), evitando condições de corrida e outros problemas de concorrência. Esses mecanismos serão tratados nos Capítulos 8 a 11.

=== Encerramento de Tarefas

Quando uma tarefa conclui sua execução, ela invoca a chamada de sistema `exit()` (ou equivalente), informando ao sistema operacional um código de saída que indica se a execução foi bem-sucedida ou se ocorreu algum erro. O sistema operacional então libera os recursos associados à tarefa e notifica o processo pai, caso este esteja aguardando.

Uma tarefa também pode ser encerrada de forma forçada pelo sistema operacional ou por outra tarefa com as permissões adequadas, por exemplo, por meio do sinal `SIGKILL` em sistemas Unix.

== Multiprogramação e Multitarefa

=== Sistemas Monotarefa

Nos primórdios da computação, os sistemas operacionais eram *monotarefa* (_single-tasking_): apenas uma tarefa podia existir no sistema em determinado momento. O programa era carregado, executado até o fim e somente então uma nova tarefa poderia ser iniciada. Esses sistemas eram simples de implementar, mas extremamente ineficientes: enquanto uma tarefa aguardava uma operação de I/O (que pode ser milhares de vezes mais lenta do que o processador), o sistema ficava completamente ocioso.

=== Multiprogramação

A *multiprogramação* (_multiprogramming_) foi a primeira grande inovação para melhorar a utilização do processador. A ideia central é manter múltiplas tarefas na memória simultaneamente, de modo que, quando uma tarefa bloqueia aguardando I/O, o processador pode ser imediatamente dedicado a outra tarefa que esteja pronta para executar.

#definition[
  *Multiprogramação* é a técnica pela qual múltiplas tarefas são mantidas na memória principal simultaneamente, permitindo que o processador seja utilizado por uma tarefa enquanto outras aguardam operações de I/O ou outros eventos.
]

A multiprogramação aumenta significativamente a *taxa de utilização da CPU* (_CPU utilization_), reduzindo o tempo em que o processador ficaria ocioso.

=== Multitarefa (Time-sharing)

A *multitarefa* (_multitasking_) ou tempo compartilhado_ (_time-sharing_) é uma evolução da multiprogramação que introduz a *preempção*: o sistema operacional interrompe periodicamente a tarefa em execução e dá a vez à próxima tarefa, mesmo que a primeira não tenha bloqueado voluntariamente. Cada tarefa recebe um intervalo de tempo chamado *quantum* ou *fatia de tempo* (_time slice).

#definition[
  *Multitarefa* (ou *tempo compartilhado*) é a técnica na qual o processador é compartilhado entre múltiplas tarefas por meio da preempção periódica, criando a ilusão de execução simultânea mesmo em sistemas com um único processador.
]

A principal vantagem da multitarefa é a *responsividade*: como nenhuma tarefa monopoliza o processador por períodos longos, os usuários percebem que suas interações com o sistema são atendidas em tempo hábil, mesmo que muitas outras tarefas estejam em execução.

#example[
  Em um sistema com quantum de 20ms e três tarefas (A, B e C), uma possível sequência de execução seria:

  ```
  Tempo:  0ms     20ms    40ms    60ms    80ms    100ms
          A        B       C       A       B       C ...
  ```

  Cada tarefa recebe o processador por 20ms por vez. Se o quantum for curto o suficiente (em relação à capacidade perceptiva humana, tipicamente abaixo de 100ms), o usuário terá a impressão de que todas as tarefas executam ao mesmo tempo.
]

== Concorrência e Paralelismo

Os termos *concorrência* e *paralelismo* são frequentemente usados como sinônimos, mas possuem significados distintos no contexto de sistemas operacionais e computação paralela.

=== Concorrência

*Concorrência* refere-se à existência de múltiplas tarefas que progridem ao longo do tempo, podendo ser executadas de forma intercalada em um único processador (multitarefa) ou simultaneamente em múltiplos processadores.

#definition[
  *Concorrência* é a propriedade de um sistema em que múltiplas tarefas estão em progresso ao mesmo tempo, independentemente de se estarem ou não executando fisicamente em paralelo. A concorrência lida com a estrutura do problema: múltiplas tarefas que precisam coexistir e interagir.
]

Um sistema é concorrente quando precisa lidar com múltiplas tarefas que se sobrepõem no tempo, mesmo que apenas uma delas execute por vez. A concorrência é essencial para sistemas responsivos e para a utilização eficiente dos recursos.

=== Paralelismo

*Paralelismo* refere-se à execução física e simultânea de múltiplas tarefas em diferentes unidades de processamento (núcleos de CPU, processadores, GPUs, etc.).

#definition[
  *Paralelismo* é a execução simultânea de múltiplas computações em hardware com múltiplas unidades de processamento. O paralelismo lida com a execução: múltiplas tarefas sendo realizadas ao mesmo tempo.
]

O paralelismo requer hardware com múltiplos processadores ou núcleos. Em um sistema com um único núcleo, é possível ter concorrência (por meio da multitarefa), mas não paralelismo verdadeiro.

=== Relação entre Concorrência e Paralelismo

```
  +--------------------------+    +--------------------------+
  |   CONCORRÊNCIA           |    |   PARALELISMO            |
  |                          |    |                          |
  |  CPU única, intercalação |    |  Múltiplas CPUs/núcleos  |
  |                          |    |                          |
  |  Tarefa A: ===   ===     |    |  Tarefa A: ===========   |
  |  Tarefa B:    ===   ===  |    |  Tarefa B: ===========   |
  |                          |    |                          |
  |  Ilusão de simultaneidade|    |  Simultaneidade real     |
  +--------------------------+    +--------------------------+
```

É possível ter:
- *Concorrência sem paralelismo*: multitarefa em um sistema com um único núcleo.
- *Paralelismo sem concorrência*: execução de uma única tarefa dividida em múltiplas subtarefas que rodam em paralelo (como operações vetoriais em GPUs).
- *Concorrência com paralelismo*: múltiplas tarefas concorrentes que executam simultaneamente em múltiplos núcleos (o caso mais comum em sistemas modernos).

// #note[
//   Uma boa analogia: *concorrência* é como um malabarista que lida com múltiplas bolas ao mesmo tempo, mas só segura uma de cada vez. *Paralelismo* é como múltiplos malabaristas, cada um com sua própria bola, trabalhando ao mesmo tempo.
// ]

== Relação entre Tarefas, Processos e Threads

Até este ponto, utilizamos o termo "tarefa" de forma genérica. É hora de precisar as duas principais formas concretas de implementação de tarefas em sistemas modernos: *processos* e *threads*.

=== Processos

Um *processo* é a forma clássica de implementação de uma tarefa. Cada processo possui seu próprio espaço de endereçamento isolado, seu próprio conjunto de recursos (descritores de arquivo, variáveis de ambiente, etc.) e seu próprio contexto de execução. O isolamento entre processos é garantido pelo sistema operacional, de modo que um erro em um processo não pode (em condições normais) corromper a memória ou o estado de outro processo.

A criação de um processo é uma operação relativamente custosa, pois exige a alocação e configuração de um espaço de endereçamento completo, a cópia (ou cópia sob demanda) dos dados do processo pai, e o registro de diversas estruturas de dados no núcleo do sistema operacional. A troca de contexto entre processos também é mais cara do que entre threads do mesmo processo, pois envolve a troca do espaço de endereçamento.

=== Threads

Uma *thread* (ou *linha de execução*) é uma unidade de execução mais leve que um processo. Múltiplas threads podem coexistir dentro de um mesmo processo, compartilhando o espaço de endereçamento, os arquivos abertos e outros recursos do processo. Cada thread possui, contudo, seu próprio contexto de execução independente: seu próprio contador de programa, pilha e registradores.

#definition[
  Uma *thread* é uma unidade de execução que existe dentro de um processo, compartilhando o espaço de endereçamento e os recursos desse processo com outras threads do mesmo processo, mas possuindo seu próprio contexto de execução independente.
]

A principal vantagem das threads sobre os processos é a eficiência: criar uma thread é muito menos custoso do que criar um processo, e a troca de contexto entre threads do mesmo processo é mais rápida, pois não exige a troca do espaço de endereçamento.

=== Comparação entre Processos e Threads

#figure(
  table(
    columns: (auto, auto, auto),
    align: left,
    stroke: 0.5pt,
    table.header(
      [*Aspecto*], [*Processo*], [*Thread*],
    ),
    [Espaço de endereçamento], [Próprio e isolado], [Compartilhado com o processo],
    [Recursos (arquivos, etc.)], [Próprios], [Compartilhados com o processo],
    [Contexto de execução], [Próprio], [Próprio (mas compartilha memória)],
    [Custo de criação], [Alto], [Baixo],
    [Troca de contexto], [Custosa (troca de espaço de endereçamento)], [Mais rápida],
    [Isolamento], [Alto (falha de um não afeta outros)], [Baixo (falha pode afetar todo o processo)],
    [Comunicação], [Requer mecanismos de IPC], [Direta via memória compartilhada],
  ),
  caption: [Comparação entre processos e threads],
)

=== A Visão Unificada

Do ponto de vista do sistema operacional, tanto processos quanto threads são formas de implementar o conceito geral de tarefa. Em sistemas Linux modernos, por exemplo, tanto processos quanto threads são representados internamente pela mesma estrutura (`task_struct`) e gerenciados pelo mesmo escalonador, diferindo principalmente no grau de compartilhamento de recursos.

```
  +---------------------------------------------+
  |                  PROCESSO                   |
  |                                             |
  |  +----------+  +----------+  +----------+  |
  |  | Thread 1 |  | Thread 2 |  | Thread 3 |  |
  |  | (main)   |  |          |  |          |  |
  |  +----------+  +----------+  +----------+  |
  |                                             |
  |  Espaço de endereçamento compartilhado      |
  |  Arquivos abertos compartilhados            |
  |  Variáveis globais compartilhadas           |
  +---------------------------------------------+
```

== Aplicações Práticas

Compreender o conceito de tarefa e o ciclo de vida permite entender por que certos comportamentos em sistemas computacionais ocorrem. Vejamos alguns exemplos práticos.

=== Responsividade de Interfaces Gráficas

Aplicações com interfaces gráficas geralmente separam a lógica de processamento em pelo menos duas threads: uma *thread de interface* (_UI thread_), responsável por responder a eventos do usuário (cliques, teclas) e atualizar a tela, e uma ou mais *threads de trabalho* (_worker threads_), que realizam computações demoradas em segundo plano.

Se todo o processamento fosse feito em uma única thread, a interface ficaria "congelada" enquanto uma operação longa (como salvar um arquivo grande) estivesse em andamento. Ao separar as responsabilidades em threads distintas, a interface permanece responsiva mesmo durante operações demoradas.

=== Servidores Web

Servidores web como o Apache e o Nginx precisam atender múltiplos clientes simultaneamente. Cada requisição HTTP pode envolver operações de I/O (leitura de arquivos, consulta a banco de dados), que tornam as tarefas I/O-bound. Para maximizar a eficiência, esses servidores criam uma tarefa (processo ou thread) para cada requisição, ou utilizam modelos assíncronos baseados em um único processo que gerencia múltiplas conexões por meio de chamadas de I/O não bloqueantes.

=== Sistemas de Tempo Real

Em sistemas de tempo real (_real-time systems_), como os encontrados em automóveis, equipamentos médicos e sistemas de controle industrial, o gerenciamento de tarefas é ainda mais crítico. As tarefas possuem *prazos* (_deadlines_) que devem ser respeitados: uma tarefa que controla os freios de um veículo não pode ser postergada indefinidamente em favor de tarefas de menor urgência. Nesses sistemas, os algoritmos de escalonamento devem garantir que as tarefas de maior prioridade sejam executadas dentro de seus prazos.

=== Navegadores Web Modernos

Os navegadores web modernos são exemplos sofisticados de gerenciamento de tarefas. Um navegador como o Chrome utiliza múltiplos processos: um processo principal (para a interface e coordenação), um processo por aba (isolando o conteúdo de cada página), processos para extensões e um processo para o renderizador. Esse design garante que uma aba com problemas (uma página com erro ou JavaScript infinito) não congele as demais abas nem o navegador como um todo.

=== Terminais e Controle de Jobs

Em sistemas Unix, o conceito de *job control* (controle de trabalhos) permite que o usuário gerencie tarefas diretamente pelo terminal. Comandos como `jobs`, `fg`, `bg` e `kill` permitem listar as tarefas em execução, trazer uma tarefa para o primeiro plano (_foreground_), enviá-la para segundo plano (_background_) ou encerrá-la. Esses comandos operam diretamente sobre o modelo de estados discutido neste capítulo.

== Importância do Gerenciamento de Tarefas

O gerenciamento eficiente de tarefas é um dos fatores que mais influenciam o desempenho, a segurança e a confiabilidade de um sistema operacional. Suas implicações práticas incluem:

- *Utilização eficiente dos recursos*: Um bom gerenciador de tarefas mantém o processador ocupado com trabalho útil o máximo do tempo possível, minimizando períodos de ociosidade.

- *Responsividade*: O sistema deve responder às solicitações dos usuários em tempo hábil, mesmo quando há muitas tarefas em execução simultânea.

- *Isolamento e segurança*: O sistema operacional deve garantir que tarefas de diferentes usuários ou aplicações não interfiram entre si, protegendo dados e recursos de acessos não autorizados.

- *Confiabilidade*: Uma tarefa com falha não deve comprometer o funcionamento das demais nem do sistema operacional em si. O isolamento proporcionado pelos processos é fundamental para essa propriedade.

- *Escalabilidade*: O sistema deve ser capaz de gerenciar um número crescente de tarefas sem degradação proporcional no desempenho.

- *Suporte à multiprogramação e multitarefa*: Ao manter múltiplas tarefas ativas, o sistema pode aproveitar os períodos de espera de uma tarefa para avançar o trabalho de outras, aumentando o throughput global do sistema.

== Resumo do Capítulo

Neste capítulo, estudamos o conceito de tarefa como unidade central de gerenciamento nos sistemas operacionais modernos. Os principais pontos abordados foram:

- Uma *tarefa* é a execução dinâmica de um programa, em contraste com o programa em si, que é uma entidade estática armazenada em disco.

- Cada tarefa possui características próprias: identidade (PID), estado de execução, contexto de execução, espaço de endereçamento, recursos associados, proprietário e prioridade.

- O ciclo de vida de uma tarefa é descrito por cinco estados: *Nova*, *Pronta*, *Executando*, *Bloqueada* e *Finalizada*, com transições bem definidas entre eles.

- O *contexto de execução* é o conjunto de informações que permite ao sistema operacional salvar e restaurar o estado de uma tarefa. Ele é armazenado no *Bloco de Controle de Processo* (PCB).

- A *troca de contexto* é o mecanismo pelo qual o processador passa de uma tarefa para outra, envolvendo o salvamento do contexto da tarefa atual e a restauração do contexto da próxima.

- Tarefas *CPU-bound* utilizam intensivamente o processador, enquanto tarefas *I/O-bound* passam a maior parte do tempo aguardando operações de entrada e saída.

- A *multiprogramação* mantém múltiplas tarefas na memória para maximizar a utilização do processador. A *multitarefa* adiciona a preempção para garantir responsividade.

- *Concorrência* é a capacidade de múltiplas tarefas progredirem ao longo do tempo (mesmo intercaladamente). *Paralelismo* é a execução física e simultânea de múltiplas tarefas em hardware com múltiplas unidades de processamento.

- As duas principais implementações concretas de tarefas são os *processos* (com espaço de endereçamento isolado) e as *threads* (que compartilham o espaço de endereçamento do processo pai).

- O gerenciamento eficiente de tarefas é fundamental para o desempenho, a segurança, a confiabilidade e a responsividade de um sistema computacional.

Nos próximos capítulos, aprofundaremos a implementação de tarefas, os algoritmos de escalonamento e os mecanismos de comunicação e sincronização entre tarefas.
