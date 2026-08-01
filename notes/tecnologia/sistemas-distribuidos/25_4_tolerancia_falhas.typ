#import "@preview/mousse-notes:1.1.0": *

= 25.4 --- Tolerância a Falhas

== Introdução

Falhas parciais -- onde alguns processos ou enlaces falham enquanto o resto do sistema continua operando -- são a marca registrada (e o principal desafio) de sistemas distribuídos. A POSCOMP cobra a classificação dos modelos de falha, o problema do consenso (incluindo o cenário bizantino) e a diferença entre estratégias de replicação para tolerá-las.

== Definições formais

#definition(name: "Modelos de falha", id: "def-modelos-falha")[
  - *Falha por parada (crash/fail-stop)*: o processo simplesmente para de responder e nunca mais se recupera; até parar, comporta-se corretamente.
  - *Falha por omissão*: o processo (ou canal) falha em enviar ou receber uma mensagem específica, mas continua funcionando normalmente fora isso.
  - *Falha temporal*: o processo responde corretamente, mas fora do intervalo de tempo esperado (relevante em sistemas de tempo real).
  - *Falha bizantina (arbitrária)*: o processo pode se comportar de *qualquer forma*, incluindo enviar informações falsas ou contraditórias a diferentes destinatários -- o modelo mais geral e mais difícil de tolerar, podendo modelar desde bugs graves até comportamento malicioso.
]

#definition(name: "Problema do consenso distribuído", id: "def-consenso-distribuido")[
  Um algoritmo de consenso deve levar $n$ processos, cada um propondo um valor inicial, a decidir por um único valor comum, satisfazendo:
  - *Acordo*: todos os processos corretos decidem o mesmo valor.
  - *Validade*: o valor decidido foi proposto por algum processo (não pode ser inventado).
  - *Terminação*: todo processo correto decide em tempo finito.
  O resultado de impossibilidade de *FLP* (Fischer, Lynch, Paterson, 1985) mostra que, em um sistema *assíncrono* (sem limites de tempo garantidos para mensagens), não existe algoritmo determinístico que garanta consenso mesmo com apenas *uma* falha por parada -- um resultado teórico clássico de prova.
]

#definition(name: "Replicação ativa vs. passiva", id: "def-replicacao-ativa-passiva")[
  - *Ativa (state machine replication)*: todas as réplicas processam *todas* as requisições, de forma determinística e na mesma ordem, mantendo-se em sincronia constante -- recuperação instantânea se uma réplica falha, ao custo de processar tudo $k$ vezes ($k$ réplicas).
  - *Passiva (primary-backup)*: apenas a réplica *primária* processa requisições e periodicamente propaga seu estado atualizado às réplicas backup; se a primária falha, uma backup assume -- menor custo de processamento normal, mas com uma janela de indisponibilidade durante a troca de primária (failover).
]

== Propriedade relevante

#theorem(name: "Problema dos Generais Bizantinos", id: "thm-generais-bizantinos")[
  Para que $n$ generais alcancem consenso por troca de mensagens orais (não assinadas) na presença de até $f$ traidores (que podem mentir ou enviar mensagens contraditórias), é necessário que $n >= 3f + 1$. Com $n <= 3f$, não existe algoritmo que garanta simultaneamente acordo e validade entre os generais leais.
]

#proof[
  Esboço intuitivo para $f=1$: com $n=3$ (1 traidor, 2 leais), o traidor pode dizer "atacar" a um general leal e "recuar" ao outro. Cada general leal recebe uma ordem direta e uma segunda opinião (do outro leal, retransmitindo o que recebeu) -- mas como não sabe *quem* é o traidor, não consegue distinguir "o traidor mentiu para mim" de "o outro general leal está retransmitindo errado (ou é ele o traidor)". Os dois leais podem acabar decidindo ações diferentes. Com $n=4$ (ainda $f=1$), a maioria (3 leais contra 1 traidor) permite que cada general leal identifique, por votação majoritária das mensagens recebidas, qual valor é consistente com a maioria -- generalizando, é necessário $n >= 3f+1$ para que os leais superem em número qualquer combinação de mentiras que os $f$ traidores possam coordenar.
]

== Exemplo resolvido

#example(name: "Por que n=3, f=1 falha", id: "ex-generais-bizantinos-falha")[
  #table(
    columns: 3,
    [*General*], [*Ordem recebida diretamente do comandante*], [*Ordem retransmitida pelo outro general leal*],
    [Leal A], [Comandante (traidor) diz "Atacar"], [Leal B retransmite "Recuar" (o que B recebeu do comandante)],
    [Leal B], [Comandante (traidor) diz "Recuar"], [Leal A retransmite "Atacar" (o que A recebeu do comandante)],
  )

  Tanto A quanto B recebem uma ordem e uma retransmissão *conflitantes*, sem meio de saber qual é a mensagem original do traidor -- podem terminar decidindo ações diferentes (um ataca, outro recua), violando o requisito de *acordo*. Esse é exatamente o cenário em que $n=3 < 3f+1=4$ (com $f=1$), confirmando o teorema.
]

== Atenção -- pegadinhas comuns

#remark(name: "Disponibilidade vs. consistência (Teorema CAP, introdução)")[
  Em um sistema distribuído sujeito a partições de rede, não é possível garantir simultaneamente *Consistência* (todos os nós veem os mesmos dados) e *Disponibilidade* (toda requisição recebe resposta) -- é preciso escolher entre elas durante a partição (Teorema CAP, tratado com mais profundidade em Banco de Dados Distribuídos). Réplicas ativas tendem a favorecer consistência forte; esquemas com replicação assíncrona costumam favorecer disponibilidade, aceitando consistência eventual.
]

#remark(name: "Redundância ativa exige determinismo; passiva não")[
  Replicação ativa só funciona corretamente se o processamento for *determinístico* (mesma entrada, mesma ordem $arrow.r$ mesmo estado em todas as réplicas) -- operações não determinísticas (ex.: horário do sistema, números aleatórios) quebram essa premissa, a menos que sejam tratadas à parte. Replicação passiva não tem essa exigência, pois apenas a primária processa e propaga o *resultado*, não a operação em si.
]

#remark(name: "Falha bizantina generaliza, não substitui, os outros modelos")[
  Um algoritmo tolerante a falhas bizantinas automaticamente tolera falhas por parada, omissão e temporais (casos particulares de comportamento arbitrário) -- mas o inverso não vale, e o custo (em número de réplicas e mensagens) de tolerar falhas bizantinas é sempre maior.
]

== Questões estilo POSCOMP

*Questão 1.* No exemplo dos Generais Bizantinos desta seção, com $n=3$ e $f=1$ traidor, o problema não pode ser resolvido de forma confiável porque:
- a) Os generais leais não conseguem se comunicar entre si.
- b) O número de generais leais não é suficiente para superar em número as mensagens conflitantes do traidor.
- c) O traidor sempre revela sua identidade.
- d) O protocolo exige um coordenador central inexistente no cenário.
- e) $n=3$ é sempre suficiente para qualquer valor de $f$.

*Questão 2.* Um processo que, devido a uma falha, envia informações diferentes e contraditórias para destinatários diferentes está exibindo uma falha do tipo:
- a) Crash (parada).
- b) Omissão.
- c) Temporal.
- d) Bizantina.
- e) Nenhuma das anteriores; esse comportamento é impossível de modelar.

*Questão 3.* A principal diferença entre replicação ativa e passiva é que:
- a) Na replicação ativa, apenas a réplica primária processa requisições.
- b) Na replicação passiva, todas as réplicas processam todas as requisições simultaneamente.
- c) Na replicação ativa, todas as réplicas processam todas as requisições de forma determinística; na passiva, só a primária processa e propaga o estado às backups.
- d) Replicação passiva exige processamento determinístico; a ativa não.
- e) Não há diferença de custo de processamento entre as duas estratégias.

*Questão 4.* O resultado de impossibilidade de FLP mostra que:
- a) Consenso é impossível em qualquer sistema distribuído, síncrono ou assíncrono.
- b) Em um sistema assíncrono, não existe algoritmo determinístico que garanta consenso mesmo com apenas uma falha por parada.
- c) FLP se aplica apenas a sistemas com falhas bizantinas.
- d) Consenso síncrono é sempre impossível.
- e) O teorema CAP e o resultado de FLP são equivalentes.

== Gabarito comentado

1. *(b)* -- com $n=3f=3$ (não $>= 3f+1=4$), os leais não superam em número as possíveis mentiras do traidor, como detalhado na prova do teorema.
2. *(d)* -- comportamento arbitrário/contraditório caracteriza exatamente uma falha bizantina.
3. *(c)* -- definição direta da diferença entre replicação ativa (todas processam) e passiva (só a primária processa, propaga às backups).
4. *(b)* -- é o enunciado central do resultado de impossibilidade de FLP para sistemas assíncronos.

== Referências

- TANENBAUM, A. S.; VAN STEEN, M. *Distributed Systems: Principles and Paradigms*. Cap. 8 (Tolerância a falhas: modelos, consenso, replicação).
- LAMPORT, L.; SHOSTAK, R.; PEASE, M. *The Byzantine Generals Problem* (1982) -- artigo original do teorema desta seção.
- COULOURIS, G. et al. *Sistemas Distribuídos: Conceitos e Projeto*. Cap. 15 (Tolerância a falhas e replicação).
