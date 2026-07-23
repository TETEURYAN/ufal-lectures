#import "@preview/mousse-notes:1.1.0": *

= 18.4 --- Concorrência, Recuperação após Falha, Gerenciamento de Transações

== Introdução

Transações são a unidade de trabalho do SGBD, e a execução concorrente de várias transações exige protocolos que garantam consistência. Este é um dos tópicos mais explorados em provas discursivas da POSCOMP: propriedades ACID, escalonamentos serializáveis, protocolos de bloqueio (2PL) e recuperação via log.

== Definições formais

#definition(name: "Transação e ACID", id: "def-transacao-acid")[
  Uma *transação* é uma sequência de operações executada como uma unidade lógica indivisível, que deve satisfazer as propriedades *ACID*:
  - *Atomicidade*: a transação executa por completo ou não executa nenhum efeito (tudo ou nada).
  - *Consistência*: leva o banco de um estado consistente a outro estado consistente.
  - *Isolamento*: o efeito de transações concorrentes é equivalente a alguma execução serial delas.
  - *Durabilidade*: efeitos de uma transação confirmada (commit) persistem mesmo após falhas.
]

#definition(name: "Escalonamento (Schedule)", id: "def-escalonamento")[
  Sequência de operações (leitura/escrita) de um conjunto de transações concorrentes, preservando a ordem interna de cada transação. Um escalonamento é *serial* se as transações executam uma após a outra sem intercalação, e *serializável* se seu efeito é equivalente a algum escalonamento serial.
]

#definition(name: "Protocolo de bloqueio em duas fases (2PL)", id: "def-2pl")[
  Protocolo em que cada transação tem uma *fase de crescimento* (só adquire bloqueios) seguida de uma *fase de encolhimento* (só libera bloqueios), sem intercalar as duas.
  - *2PL estrito*: todos os bloqueios de escrita são liberados somente após o commit/abort -- evita leitura suja (dirty read) por outras transações.
  - *2PL rígido/conservador*: todos os bloqueios (leitura e escrita) são adquiridos antes do início da execução -- evita deadlock, ao custo de menor concorrência.
]

#definition(name: "Log de escrita antecipada (WAL) e Checkpoint", id: "def-wal-checkpoint")[
  *WAL (Write-Ahead Logging)*: todo registro de log referente a uma alteração deve ser gravado em disco *antes* da própria alteração ser gravada nos dados, permitindo desfazer (`UNDO`) ou refazer (`REDO`) operações após uma falha. Um *checkpoint* é um ponto periódico em que o SGBD grava o estado das transações ativas, limitando o quanto do log precisa ser reprocessado na recuperação.
]

== Propriedade relevante

#theorem(name: "Serializabilidade por grafo de precedência", id: "thm-grafo-precedencia")[
  Um escalonamento é *serializável por conflito* se, e somente se, seu grafo de precedência (um nó por transação, uma aresta $T_i arrow.r T_j$ para cada par de operações conflitantes onde a operação de $T_i$ precede a de $T_j$) é *acíclico*.
]

#proof[
  Se o grafo é acíclico, uma ordenação topológica dos nós fornece uma ordem serial equivalente que respeita todos os conflitos observados. Se há um ciclo, não existe ordenação linear das transações que respeite simultaneamente todas as restrições de precedência impostas pelos conflitos -- logo, nenhum escalonamento serial pode ser equivalente.
]

== Exemplo resolvido

#example(name: "Teste de serializabilidade", id: "ex-serializabilidade")[
  Considere as transações $T_1$: `R(A) W(A) R(B) W(B)` e $T_2$: `R(B) W(B) R(A) W(A)`, escalonadas como:

  ```
  T1: R(A)       W(A)              R(B)  W(B)
  T2:       R(B)       W(B)  R(A)              W(A)
  ```

  Conflitos: $T_1$ escreve $A$ antes de $T_2$ ler/escrever $A$ $arrow.r T_1 arrow.r T_2$. $T_2$ escreve $B$ antes de $T_1$ ler/escrever $B$ $arrow.r T_2 arrow.r T_1$. O grafo tem um ciclo ($T_1 arrow.r T_2 arrow.r T_1$), logo o escalonamento *não* é serializável.
]

== Atenção -- pegadinhas comuns

#remark(name: "Deadlock não é starvation")[
  *Deadlock*: duas ou mais transações esperam indefinidamente uma pela outra (espera circular). *Starvation*: uma transação específica nunca consegue os recursos porque outras são sistematicamente priorizadas -- não há espera circular.
]

#remark(name: "2PL garante serializabilidade, mas não evita deadlock")[
  2PL (comum) garante que o escalonamento resultante é serializável por conflito, mas ainda pode gerar deadlock. Só o 2PL *conservador* evita deadlock (à custa de concorrência), pois trava tudo antes de começar.
]

#remark(name: "UNDO vs. REDO")[
  Na recuperação, `UNDO` desfaz efeitos de transações que não deram commit antes da falha; `REDO` reaplica efeitos de transações que deram commit mas cujas alterações ainda não tinham sido persistidas nos dados no momento da falha (graças ao WAL).
]

== Questões estilo POSCOMP

*Questão 1.* A propriedade ACID que garante que os efeitos de uma transação confirmada não sejam perdidos mesmo diante de uma queda de energia é a:
- a) Atomicidade.
- b) Consistência.
- c) Isolamento.
- d) Durabilidade.
- e) Serializabilidade.

*Questão 2.* Um escalonamento é serializável por conflito se, e somente se, seu grafo de precedência:
- a) For completo.
- b) For acíclico.
- c) Tiver pelo menos um ciclo.
- d) For bipartido.
- e) Tiver grau máximo igual a dois.

*Questão 3.* Sobre o protocolo de bloqueio em duas fases (2PL), é correto afirmar:
- a) 2PL básico garante serializabilidade e também está livre de deadlock.
- b) 2PL conservador adquire todos os bloqueios necessários antes do início da transação, evitando deadlock.
- c) 2PL estrito libera bloqueios de escrita imediatamente após o uso, antes do commit.
- d) 2PL não tem relação com a propriedade de isolamento.
- e) Fase de crescimento e de encolhimento podem se alternar livremente.

*Questão 4.* No mecanismo de write-ahead logging (WAL), a exigência fundamental é que:
- a) Os dados sejam gravados em disco antes do respectivo registro de log.
- b) O registro de log referente a uma alteração seja gravado antes da alteração correspondente ser persistida nos dados.
- c) Checkpoints sejam feitos a cada transação individual.
- d) O log seja mantido apenas em memória volátil.
- e) Nenhuma das anteriores.

== Gabarito comentado

1. *(d)* -- durabilidade é, por definição, a persistência dos efeitos de transações confirmadas.
2. *(b)* -- é exatamente o enunciado do teorema de serializabilidade por grafo de precedência.
3. *(b)* -- 2PL conservador trava tudo antecipadamente, eliminando a possibilidade de deadlock; (a) é falsa pois 2PL básico não evita deadlock; (c) descreve o oposto de "estrito".
4. *(b)* -- essa é a definição central de WAL: log antes do dado.

== Referências

- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*. Caps. 20--22 (Transações, concorrência e recuperação).
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*. Caps. 14--16 (Transações, controle de concorrência, recuperação).
