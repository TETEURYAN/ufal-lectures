#import "@preview/mousse-notes:1.1.0": *

= 25.2 --- Compartilhamento de Informação: Controle de Concorrência, Transações Distribuídas

== Introdução

Quando dados são replicados ou particionados entre vários nós, controlar o acesso concorrente exige protocolos que funcionam sem memória compartilhada -- o mesmo problema de fundo tratado em Banco de Dados (controle de concorrência local, escalonamentos e 2PL), mas agora estendido a *múltiplos sites* que precisam concordar sobre o destino de uma transação inteira, mesmo diante de falhas parciais de rede ou de nó.

== Definições formais

#definition(name: "Controle de concorrência pessimista vs. otimista", id: "def-concorrencia-pessimista-otimista")[
  - *Pessimista*: bloqueia recursos *antes* de acessá-los (ex.: variantes distribuídas de 2PL), impedindo conflitos por construção, ao custo de esperas e maior risco de deadlock distribuído.
  - *Otimista*: permite que as transações executem livremente, assumindo que conflitos são raros, e *valida* no momento do commit (comparando o conjunto de leituras/escritas com transações concorrentes); se houver conflito, aborta e reinicia a transação. Bom desempenho quando a taxa de conflito é baixa; caro quando é alta (muitos reinícios).
]

#definition(name: "Transação distribuída", id: "def-transacao-distribuida")[
  Transação cujas operações são executadas em *múltiplos* nós (cada um com seu próprio gerenciador de recursos/dados). Para preservar atomicidade (uma das propriedades ACID), é preciso um protocolo de *commit atômico distribuído*: ou todos os nós envolvidos confirmam a transação, ou todos a desfazem -- nunca um subconjunto.
]

#definition(name: "Protocolo de Commit em Duas Fases (2PC)", id: "def-2pc-sd")[
  Um processo *coordenador* orquestra $n$ processos *participantes*:
  + *Fase de votação (prepare)*: o coordenador envia `PREPARE` a todos os participantes; cada um grava seu estado em log estável e responde `VOTE-COMMIT` (se pode confirmar) ou `VOTE-ABORT` (caso contrário).
  + *Fase de decisão (commit/abort)*: se *todos* votaram `VOTE-COMMIT`, o coordenador grava a decisão e envia `GLOBAL-COMMIT` a todos; se *qualquer* participante votou `VOTE-ABORT` (ou não respondeu a tempo), envia `GLOBAL-ABORT` a todos.
  Cada participante confirma/desfaz localmente e envia um `ACK` ao coordenador.
]

== Propriedade relevante

#theorem(name: "2PC pode bloquear diante de falha do coordenador", id: "thm-2pc-bloqueio")[
  Se o coordenador falha *após* todos os participantes votarem `VOTE-COMMIT` mas *antes* de enviar a decisão final, os participantes ficam bloqueados: já gastaram seu voto (não podem abortar unilateralmente, pois o coordenador pode ter decidido `GLOBAL-COMMIT`), mas também não sabem se devem confirmar. Só a recuperação do coordenador (ou um protocolo mais complexo, como o *Commit em Três Fases*, fora do escopo detalhado aqui) resolve esse bloqueio.
]

#proof[
  Após votar `VOTE-COMMIT`, um participante está em estado *incerto*: não pode decidir abortar por conta própria, pois o coordenador pode já ter decidido `GLOBAL-COMMIT` com base nos votos recebidos (e outros participantes já podem ter confirmado); tampouco pode confirmar por conta própria, pois o coordenador pode decidir abortar se outro participante tiver votado `VOTE-ABORT`. Sem informação adicional (ex.: consultar outro participante ou aguardar o coordenador se recuperar), a única opção segura é esperar -- daí o bloqueio.
]

== Exemplo resolvido

#example(name: "2PC com um participante votando abort", id: "ex-2pc-abort")[
  Uma transferência bancária envolve o *Coordenador* (agência A) e dois participantes (*Banco B*, *Banco C*).

  #table(
    columns: 4,
    [*Passo*], [*Coordenador*], [*Banco B*], [*Banco C*],
    [1], [envia `PREPARE`], [recebe `PREPARE`], [recebe `PREPARE`],
    [2], [aguarda votos], [saldo insuficiente $arrow.r$ `VOTE-ABORT`], [saldo OK $arrow.r$ `VOTE-COMMIT`],
    [3], [recebe 1 `VOTE-ABORT` $arrow.r$ decide `GLOBAL-ABORT`], [--], [--],
    [4], [envia `GLOBAL-ABORT`], [desfaz operação local], [desfaz operação local (mesmo tendo votado commit!)],
  )

  Note que basta *um único* `VOTE-ABORT` para que a transação inteira seja desfeita em *todos* os participantes -- inclusive no Banco C, que estava pronto para confirmar. Isso ilustra a propriedade de atomicidade: tudo ou nada, mesmo distribuído.
]

#figure(
  image("figures/two-phase-commit-success.png", width: 75%),
  caption: [Diagrama de sequência do 2PC no caminho de sucesso (todos votam commit). Fonte: Wikimedia Commons, domínio público/CC0 (Jayaprabhakar).],
)

== Atenção -- pegadinhas comuns

#remark(name: "Otimista não elimina conflitos, apenas adia a checagem")[
  Controle de concorrência otimista não impede fisicamente o conflito -- ele *permite* que ocorra e só o detecta na validação de commit. Sob alta contenção, isso pode gerar muito mais reinícios de transação do que um esquema pessimista equivalente.
]

#remark(name: "2PC garante atomicidade, mas não é livre de bloqueio")[
  Um erro comum é achar que 2PC resolve completamente o problema de falhas em transações distribuídas. Ele garante *atomicidade* (tudo confirma ou tudo desfaz), mas, como mostra o teorema desta seção, pode *bloquear* participantes indefinidamente se o coordenador falhar no momento errado -- disponibilidade não é garantida.
]

== Questões estilo POSCOMP

*Questão 1.* No protocolo 2PC, se um participante vota `VOTE-ABORT` na fase de preparação, a decisão final do coordenador deve ser:
- a) `GLOBAL-COMMIT`, pois a maioria pode ter votado commit.
- b) `GLOBAL-ABORT`, aplicado a todos os participantes.
- c) Deixar cada participante decidir individualmente.
- d) Repetir a fase de votação indefinidamente.
- e) Ignorar o voto do participante que abortou.

*Questão 2.* Considerando o exemplo desta seção (transferência com 2 participantes), se o Banco C tivesse recebido `GLOBAL-ABORT` mas já tivesse aplicado a alteração permanentemente antes de receber a mensagem, isso violaria a propriedade ACID de:
- a) Consistência.
- b) Isolamento.
- c) Atomicidade.
- d) Durabilidade.
- e) Serializabilidade.

*Questão 3.* O bloqueio de participantes em 2PC após todos votarem commit, mas antes da decisão do coordenador, ocorre porque:
- a) Os participantes perderam seus dados locais.
- b) Os participantes não sabem se o coordenador decidiu commit ou abort, e não podem decidir isso sozinhos com segurança.
- c) O protocolo exige reinício completo da transação.
- d) A rede está necessariamente particionada.
- e) Os participantes votaram de forma inconsistente.

*Questão 4.* Controle de concorrência otimista é mais adequado que o pessimista quando:
- a) A taxa de conflito entre transações é alta.
- b) A taxa de conflito entre transações é baixa.
- c) O sistema não pode tolerar nenhum reinício de transação.
- d) Não há necessidade de validação no commit.
- e) Todas as transações são de longa duração e conflitantes.

== Gabarito comentado

1. *(b)* -- basta um `VOTE-ABORT` para que o coordenador decida `GLOBAL-ABORT` para todos, garantindo atomicidade.
2. *(c)* -- aplicar uma alteração que depois precisa ser desfeita, mas já foi tornada permanente, quebra a atomicidade (tudo ou nada) da transação distribuída.
3. *(b)* -- exatamente o argumento do teorema/prova desta seção sobre o estado "incerto" dos participantes.
4. *(b)* -- otimista compensa em cenários de baixa contenção, evitando o custo de bloqueio constante do pessimista.

== Referências

- TANENBAUM, A. S.; VAN STEEN, M. *Distributed Systems: Principles and Paradigms*. Cap. 8 (Transações e controle de concorrência distribuídos).
- COULOURIS, G. et al. *Sistemas Distribuídos: Conceitos e Projeto*. Cap. 16--17 (Transações distribuídas e commit atômico).
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*. Cap. 19--20 (contexto local de controle de concorrência e transações, base para a extensão distribuída aqui).
