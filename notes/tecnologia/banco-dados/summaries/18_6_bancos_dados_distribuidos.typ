#import "@preview/mousse-notes:1.1.0": *

= 18.6 --- Bancos de Dados Distribuídos

== Introdução

Um banco de dados distribuído espalha os dados por vários nós, buscando disponibilidade e desempenho, ao custo de maior complexidade em consultas e transações. A POSCOMP costuma cobrar fragmentação, transparência e o Teorema CAP -- este último quase sempre em questões conceituais sobre trade-offs.

== Definições formais

#definition(name: "Banco de Dados Distribuído", id: "def-bd-distribuido")[
  Coleção de múltiplos bancos de dados logicamente inter-relacionados, distribuídos em uma rede de computadores, gerenciados de forma a parecer, para o usuário, um único banco de dados.
]

#definition(name: "Fragmentação", id: "def-fragmentacao")[
  - *Horizontal*: divide uma relação em subconjuntos de *tuplas* (ex.: clientes da região Norte em um fragmento, região Sul em outro).
  - *Vertical*: divide uma relação em subconjuntos de *atributos*, mantendo a chave primária em cada fragmento para permitir reconstrução via junção.
  - *Mista (híbrida)*: combinação de fragmentação horizontal e vertical.
]

#definition(name: "Transparência de distribuição", id: "def-transparencia")[
  Propriedade de um SGBD distribuído de esconder do usuário os detalhes da distribuição física dos dados:
  - *Transparência de fragmentação*: usuário não precisa saber como os dados foram fragmentados.
  - *Transparência de localização*: usuário não precisa saber em qual nó cada fragmento está.
  - *Transparência de replicação*: usuário não precisa saber quantas cópias existem, nem gerenciá-las.
]

#definition(name: "Commit em duas fases (2PC)", id: "def-2pc")[
  Protocolo para garantir atomicidade de uma transação distribuída sobre múltiplos nós: na *fase de votação*, o coordenador pergunta a cada participante se pode confirmar (`prepare`); só se *todos* votarem "sim", a *fase de decisão* manda todos aplicarem o commit -- caso qualquer um vote "não", todos abortam.
]

== Propriedade relevante

#theorem(name: "Teorema CAP", id: "thm-cap")[
  Em um sistema distribuído, é impossível garantir simultaneamente as três propriedades: *Consistência* (todos os nós veem os mesmos dados ao mesmo tempo), *Disponibilidade* (toda requisição recebe resposta, mesmo que não seja a mais recente) e *Tolerância a Partição* (o sistema continua operando mesmo com falha de comunicação entre nós). Na presença de uma partição de rede, o sistema deve escolher entre consistência e disponibilidade.
]

#proof[
  Se a rede particiona (comunicação entre dois grupos de nós falha) e ambos os grupos continuam respondendo a escritas, os dados divergem -- perdendo consistência. Para manter consistência durante a partição, ao menos um grupo precisa recusar operações -- perdendo disponibilidade. Como partições são inevitáveis em sistemas reais, o trade-off relevante na prática é entre C e A.
]

== Exemplo resolvido

#example(name: "Fragmentação horizontal e junção reduzida por semi-join", id: "ex-fragmentacao-semijoin")[
  A relação `Cliente(cliente_id, nome, regiao, saldo)` é fragmentada horizontalmente por `regiao`: `Cliente_Norte` no nó A, `Cliente_Sul` no nó B. Uma consulta que junta `Cliente` com `Pedido` (armazenada centralmente no nó B) filtrando `regiao = 'Sul'` só precisa acessar `Cliente_Sul` (nó B) -- a fragmentação horizontal, combinada com transparência de fragmentação, evita transferir dados irrelevantes do nó A pela rede.
]

== Atenção -- pegadinhas comuns

#remark(name: "CAP não é \"escolha exatamente 2 de 3\" o tempo todo")[
  Um erro comum é achar que o sistema escolhe permanentemente 2 das 3 propriedades. Na verdade, tolerância a partição é praticamente obrigatória em sistemas distribuídos reais (redes falham); o trade-off relevante acontece *durante* uma partição, entre consistência e disponibilidade.
]

#remark(name: "Fragmentação vertical sempre preserva a chave")[
  Para que uma fragmentação vertical seja reconstruível por junção, todo fragmento deve conter a chave primária da relação original -- caso contrário, não é possível recompor as tuplas originais sem ambiguidade.
]

== Questões estilo POSCOMP

*Questão 1.* A divisão de uma relação em subconjuntos de tuplas, distribuídos por diferentes nós, é chamada de:
- a) Fragmentação vertical.
- b) Fragmentação horizontal.
- c) Replicação total.
- d) Transparência de localização.
- e) Normalização distribuída.

*Questão 2.* Segundo o Teorema CAP, na ocorrência de uma partição de rede, um sistema distribuído deve necessariamente abrir mão de:
- a) Tolerância a partição.
- b) Ou consistência, ou disponibilidade.
- c) Simultaneamente consistência e disponibilidade.
- d) Nenhuma das três propriedades -- é sempre possível manter as três.
- e) Apenas do isolamento transacional.

*Questão 3.* No protocolo de commit em duas fases (2PC), se um único participante votar "não" na fase de preparação:
- a) Apenas esse participante aborta; os demais confirmam normalmente.
- b) O coordenador ignora o voto e força o commit.
- c) Todos os participantes devem abortar a transação.
- d) A fase de decisão é pulada.
- e) O protocolo reinicia automaticamente sem intervenção.

== Gabarito comentado

1. *(b)* -- fragmentação horizontal particiona por tuplas (linhas); vertical particiona por atributos (colunas).
2. *(b)* -- durante uma partição, o sistema escolhe entre C e A; manter as três simultaneamente é impossível segundo o teorema.
3. *(c)* -- 2PC exige unanimidade na fase de votação; um único voto negativo força abort global, preservando atomicidade.

== Referências

- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*. Cap. 25 (Bancos de dados distribuídos).
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*. Cap. 19--20 (Bancos de dados distribuídos e paralelos).
- BREWER, E. *Towards Robust Distributed Systems* (conjectura original do Teorema CAP).
