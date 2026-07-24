#import "@preview/mousse-notes:1.1.0": *
= 24.2 -- Protocolos e Serviços de Comunicação

== Introdução

Antes de entrar em topologias e arquitetura (24.3) ou na especificação
formal de um protocolo (24.4), é preciso fixar a distinção entre *protocolo*
e *serviço* -- dois termos usados de forma quase intercambiável na
linguagem comum, mas que o modelo em camadas trata como conceitos
distintos e relacionados. A comparação TCP x UDP que fecha este subtópico é
um dos tópicos mais cobrados de toda a disciplina na POSCOMP.

== Protocolo x serviço

#definition(id: "def-servico")[
  Um *serviço* é o conjunto de operações que uma camada oferece à camada
  imediatamente superior, definido por sua *interface* (quais primitivas
  existem e o que cada uma faz) -- é um contrato sobre *o que* a camada faz,
  sem dizer *como*.
]

#definition(id: "def-protocolo")[
  Um *protocolo* é o conjunto de regras (formato de mensagens, ordem de
  troca, ações em cada evento) que as entidades de uma mesma camada, em
  máquinas diferentes, usam entre si para *implementar* o serviço oferecido à
  camada superior.
]

#remark[
  Regra de bolso cobrada em prova: *serviço é vertical* (entre camadas
  adjacentes, na mesma máquina), *protocolo é horizontal* (entre entidades
  pares, em máquinas diferentes). Uma camada pode trocar o protocolo interno
  sem alterar o serviço oferecido acima, desde que a interface se mantenha --
  esse é o princípio central por trás da própria ideia de arquitetura em
  camadas (24.3).
]

== Primitivas de serviço

#definition(id: "def-primitivas-servico")[
  A interação entre uma camada e o usuário do serviço (camada acima) é
  descrita por quatro primitivas clássicas:
]

#figure(
  tablef(
    columns: 2,
    [*Primitiva*], [*Significado*],
    table.hline(),
    [REQUEST (requisição)], [O usuário pede à camada que inicie alguma ação],
    [INDICATION (indicação)], [A camada informa ao usuário que algo ocorreu],
    [RESPONSE (resposta)], [O usuário responde a uma indicação recebida],
    [CONFIRM (confirmação)], [A camada confirma ao usuário original o resultado de sua requisição],
  ),
  caption: [Primitivas de serviço entre camadas adjacentes.],
)

#remark[
  Em um serviço *confirmado* aparecem as quatro primitivas (ex.: estabelecer
  uma conexão); em um serviço *não confirmado*, apenas REQUEST e INDICATION
  (ex.: enviar um datagrama sem esperar confirmação) -- distinção diretamente
  ligada a serviços orientados a conexão x sem conexão, a seguir.
]

== Serviços orientados a conexão e sem conexão

#definition(id: "def-servico-conexao")[
  - *Orientado a conexão*: exige estabelecimento prévio de uma sessão lógica
    (handshake), entrega dados na ordem enviada e é encerrado explicitamente
    ao final -- análogo a uma ligação telefônica;
  - *Sem conexão*: cada unidade de dado é enviada de forma independente, sem
    setup prévio nem garantia de ordem -- análogo ao envio de cartas pelo
    correio.
]

#remark[
  "Orientado a conexão" *não* é sinônimo de "confiável": é perfeitamente
  possível um serviço sem conexão confiável (raro) e um orientado a conexão
  não confiável (também raro) -- mas na prática os pares mais cobrados em
  prova são justamente TCP (conexão + confiável) e UDP (sem conexão + não
  confiável), a seguir.
]

== TCP x UDP

#definition(id: "def-tcp-udp")[
  *TCP* (Transmission Control Protocol) e *UDP* (User Datagram Protocol) são
  os dois protocolos de transporte da pilha TCP/IP, ambos executados sobre
  IP (camada de rede), mas com garantias radicalmente diferentes.
]

#figure(
  tablef(
    columns: 3,
    [*Característica*], [*TCP*], [*UDP*],
    table.hline(),
    [Orientação], [Orientado a conexão (handshake de 3 vias)], [Sem conexão],
    [Confiabilidade], [Confiável: confirmação (ACK), retransmissão, checksum], [Não confiável: apenas checksum, sem retransmissão],
    [Ordem], [Garante entrega na ordem enviada], [Não garante ordem],
    [Controle de fluxo], [Sim (janela deslizante)], [Não],
    [Controle de congestionamento], [Sim (ex.: slow start, AIMD)], [Não],
    [Overhead/latência], [Maior (setup, ACKs, cabeçalho maior)], [Menor (envio imediato, cabeçalho de 8 bytes)],
    [Uso típico], [HTTP, e-mail (SMTP), transferência de arquivos (FTP)], [DNS, streaming em tempo real, VoIP, jogos online],
  ),
  caption: [Comparação entre TCP e UDP.],
)

#remark[
  Pegadinha recorrente: TCP e UDP estão *ambos* na camada de transporte, não
  em camadas diferentes -- a diferença é de garantias oferecidas, não de
  posição na pilha. Outro erro comum é achar que UDP "não serve para nada
  importante": aplicações de tempo real preferem UDP justamente porque
  retransmitir um pacote atrasado é pior do que simplesmente perdê-lo (ex.:
  um pacote de voz atrasado chega inútil de qualquer forma).
]

== Questões estilo POSCOMP

#example(id: "q-242-servico-protocolo")[
  (Múltipla escolha) A respeito da distinção entre serviço e protocolo em
  uma arquitetura de rede em camadas, é correto afirmar que:
  + Serviço e protocolo são sinônimos, ambos descrevendo a comunicação entre entidades pares.
  + O serviço define a interface oferecida à camada superior; o protocolo define como esse serviço é implementado entre entidades pares.
  + O protocolo é definido apenas dentro de uma única máquina, nunca envolvendo comunicação em rede.
  + Alterar o protocolo de uma camada necessariamente altera o serviço percebido pela camada superior.
]

#solution[
  Resposta: alternativa *(2)*. (1) e (3) invertem os conceitos; (4) contraria
  o próprio objetivo do encapsulamento em camadas -- a interface de serviço
  pode permanecer estável mesmo com troca do protocolo subjacente.
]

#example(id: "q-242-tcp-udp")[
  (Múltipla escolha) Uma aplicação de videochamada em tempo real, sensível a
  atrasos e tolerante a alguma perda ocasional de pacotes, deve utilizar
  preferencialmente qual protocolo de transporte, e por quê?
  + TCP, pois garante que todos os quadros de vídeo cheguem, mesmo que atrasados.
  + UDP, pois evita o atraso de retransmissões e controle de congestionamento, aceitável dado que pacotes atrasados são inúteis para tempo real.
  + TCP, pois seu handshake inicial reduz a latência percebida pelo usuário.
  + UDP, pois garante a entrega ordenada dos pacotes de áudio e vídeo.
]

#solution[
  Resposta: alternativa *(2)*. TCP prioriza confiabilidade e ordem à custa de
  latência (retransmissão, ACKs, controle de congestionamento) -- inadequado
  quando um dado atrasado já perdeu utilidade; UDP não garante ordem nem
  entrega, então (4) está incorreta mesmo apontando o protocolo certo.
]

#example(id: "q-242-primitivas")[
  (Múltipla escolha) Em um serviço *não confirmado*, quais primitivas de
  serviço estão presentes?
  + REQUEST e CONFIRM, apenas.
  + REQUEST, INDICATION, RESPONSE e CONFIRM.
  + Apenas REQUEST e INDICATION.
  + Apenas INDICATION e RESPONSE.
]

#solution[
  Resposta: alternativa *(3)*. Um serviço não confirmado dispensa a
  confirmação explícita ao emissor original: o usuário pede (REQUEST) e o
  par remoto é avisado (INDICATION), sem RESPONSE/CONFIRM de volta.
]

== Referências

- TANENBAUM, A. S.; WETHERALL, D. *Redes de Computadores*. Cap. 1 (serviços
  x protocolos) e Cap. 6 (camada de transporte, TCP/UDP).
- KUROSE, J. F.; ROSS, K. W. *Redes de Computadores e a Internet*. Cap. 3.
- cienciadacomputacao.wiki.br -- Tópico 24.2.
