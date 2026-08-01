#import "@preview/mousse-notes:1.1.0": *

= 25.3 --- Comunicação entre Processos

== Introdução

Toda coordenação distribuída (25.1) e todo protocolo de commit (25.2) dependem, na base, de um modelo de comunicação entre processos. A POSCOMP cobra reconhecer qual paradigma -- RPC, mensagens síncronas/assíncronas, ou publish/subscribe -- se encaixa em um cenário descrito, e as implicações de cada escolha para acoplamento e tolerância a falhas.

== Definições formais

#definition(name: "Chamada de Procedimento Remoto (RPC)", id: "def-rpc")[
  Mecanismo que permite a um processo cliente invocar um procedimento executado em um processo servidor remoto *como se fosse uma chamada local*. Um *stub* cliente empacota (`marshalling`) os parâmetros em uma mensagem, envia pela rede; o servidor recebe, desempacota (`unmarshalling`) via seu próprio stub, executa o procedimento e devolve o resultado pelo caminho inverso. O objetivo é *transparência*: esconder do programador os detalhes de rede.
]

#definition(name: "Comunicação síncrona vs. assíncrona", id: "def-comunicacao-sincrona-assincrona")[
  - *Síncrona (bloqueante)*: o processo que envia (ou que faz uma chamada RPC) *bloqueia* até receber a resposta/confirmação. Modelo natural para RPC clássico.
  - *Assíncrona (não bloqueante)*: o remetente envia e continua sua execução imediatamente, sem esperar; a resposta (se houver) é tratada depois, tipicamente por callback ou por consulta posterior a uma fila/buffer.
]

#definition(name: "Publish/Subscribe (pub/sub)", id: "def-publish-subscribe")[
  Paradigma *desacoplado*: produtores (*publishers*) publicam eventos/mensagens associados a um tópico, sem conhecer os consumidores; consumidores (*subscribers*) se inscrevem em tópicos de interesse e recebem as mensagens publicadas, sem conhecer os produtores. O desacoplamento é triplo: *no espaço* (não se conhecem diretamente), *no tempo* (não precisam estar ativos simultaneamente) e *na sincronização* (publicar não bloqueia esperando um consumidor).
]

== Comparação e cenários de uso típicos

#table(
  columns: 3,
  [*Paradigma*], [*Acoplamento*], [*Cenário típico*],
  [RPC (síncrono)], [Forte -- cliente conhece o servidor e espera resposta], [Chamada cliente-servidor tradicional (ex.: consultar saldo de uma conta em um serviço bancário)],
  [Mensagens assíncronas], [Médio -- remetente conhece o destinatário, mas não espera], [Filas de tarefas (ex.: processar upload de vídeo em segundo plano)],
  [Publish/Subscribe], [Fraco -- produtores e consumidores desacoplados], [Sistemas orientados a eventos (ex.: sensores IoT publicando leituras; múltiplos serviços reagindo a um mesmo evento)],
)

== Exemplo resolvido

#example(name: "RPC síncrono: cliente bloqueado durante a chamada", id: "ex-rpc-sincrono")[
  #figure(
    box(width: 300pt, height: 90pt)[
      #place(dx: 20pt, dy: 10pt, text(size: 9pt, weight: "bold")[Cliente])
      #place(dx: 0pt, dy: 20pt, line(start: (20pt, 0pt), end: (280pt, 0pt), stroke: 1pt))
      #place(dx: 20pt, dy: 60pt, text(size: 9pt, weight: "bold")[Servidor])
      #place(dx: 0pt, dy: 70pt, line(start: (20pt, 0pt), end: (280pt, 0pt), stroke: 1pt))

      #place(dx: 80pt, dy: 17pt, rect(width: 100pt, height: 6pt, fill: gray.lighten(40%), stroke: none))
      #place(dx: 76pt, dy: 0pt, text(size: 8pt)[chamada (bloqueado)])

      #place(dx: 0pt, dy: 0pt, line(start: (80pt, 20pt), end: (110pt, 70pt), stroke: (paint: gray, dash: "dashed")))
      #place(dx: 0pt, dy: 0pt, line(start: (110pt, 70pt), end: (180pt, 20pt), stroke: (paint: gray, dash: "dashed")))
      #place(dx: 100pt, dy: 55pt, text(size: 8pt)[executa])
    ],
    caption: [RPC síncrono: o cliente fica bloqueado (faixa cinza) do momento da chamada até o retorno da resposta do servidor.],
  )

  Se a mesma chamada fosse feita de forma *assíncrona*, o cliente continuaria executando imediatamente após o envio, tratando a resposta do servidor (quando chegasse) por meio de um callback ou de uma consulta posterior -- sem a faixa de bloqueio da figura.
]

== Atenção -- pegadinhas comuns

#remark(name: "\"Exatamente uma vez\" é praticamente inatingível com falhas de rede")[
  Sob falhas de rede/processo, RPC pode ter semânticas *no máximo uma vez* (a chamada pode não ser executada, mas nunca duas vezes) ou *pelo menos uma vez* (garante execução, mas pode duplicar, exigindo idempotência do procedimento remoto). A semântica *exatamente uma vez* é o ideal intuitivo, mas geralmente inatingível em sistemas distribuídos reais na presença de falhas -- pegadinha clássica de prova.
]

#remark(name: "Comunicação síncrona acopla disponibilidade")[
  Em comunicação síncrona, se o destinatário está indisponível (caiu, está sobrecarregado), o remetente fica bloqueado ou falha. A comunicação assíncrona (ou pub/sub com fila intermediária) desacopla essa dependência, tornando o sistema mais resiliente a indisponibilidades temporárias -- ao custo de maior complexidade para raciocinar sobre ordem e consistência.
]

== Questões estilo POSCOMP

*Questão 1.* No diagrama do exemplo desta seção, a faixa cinza sobre a linha do tempo do Cliente representa:
- a) O tempo em que o servidor está ocioso.
- b) O período em que o cliente está bloqueado aguardando a resposta do servidor.
- c) Uma falha de comunicação.
- d) O tempo de processamento do servidor apenas.
- e) O uso de comunicação assíncrona.

*Questão 2.* Um sistema de sensores IoT publica leituras de temperatura sem saber quais serviços as consumirão, e novos serviços podem se inscrever a qualquer momento sem alterar os sensores. Esse cenário é mais bem descrito pelo paradigma:
- a) RPC síncrono.
- b) Publish/Subscribe.
- c) Chamada de procedimento local.
- d) Exclusão mútua distribuída.
- e) Commit em duas fases.

*Questão 3.* Sobre semânticas de execução de RPC sob falhas, é correto afirmar que:
- a) "Exatamente uma vez" é sempre garantida por qualquer implementação de RPC.
- b) "Pelo menos uma vez" pode causar execuções duplicadas, exigindo que o procedimento remoto seja idempotente.
- c) "No máximo uma vez" garante que o procedimento sempre será executado.
- d) Semânticas de falha só importam em comunicação síncrona.
- e) RPC nunca pode falhar, por definição.

== Gabarito comentado

1. *(b)* -- a faixa cinza no diagrama marca o intervalo de bloqueio do cliente até a resposta.
2. *(b)* -- desacoplamento total entre produtores e consumidores é a marca registrada do publish/subscribe.
3. *(b)* -- "pelo menos uma vez" pode reexecutar a chamada após timeout, arriscando duplicação se o procedimento não for idempotente.

== Referências

- TANENBAUM, A. S.; VAN STEEN, M. *Distributed Systems: Principles and Paradigms*. Cap. 4 (Comunicação: RPC, mensagens, publish/subscribe).
- COULOURIS, G. et al. *Sistemas Distribuídos: Conceitos e Projeto*. Cap. 5 (Comunicação entre processos) e Cap. 6 (Invocação remota).
