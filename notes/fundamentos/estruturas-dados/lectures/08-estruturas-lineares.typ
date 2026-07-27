#import "@preview/mousse-notes:1.1.0": *

= Estruturas de Dados Lineares e suas Generalizações

== Introdução

Estruturas lineares organizam elementos em uma sequência, com no máximo um predecessor e um sucessor
por elemento. São a base sobre a qual quase todas as estruturas mais complexas (árvores, grafos,
hashes com encadeamento) se apoiam, e o subconjunto — listas ordenadas, listas encadeadas, pilhas e
filas — mais cobrado em questões objetivas de estruturas de dados.

== Listas ordenadas

#definition(id: "def-lista-ordenada")[
  Uma *lista ordenada* é uma sequência de elementos $a_1, a_2, ..., a_n$ tal que
  $a_1 <= a_2 <= ... <= a_n$ segundo alguma relação de ordem total. Pode ser implementada sobre um
  array (mantendo os elementos contíguos e ordenados) ou sobre uma lista encadeada (mantendo a ordem
  via os ponteiros de encadeamento).
]

#figure(
  table(
    columns: 3,
    stroke: 0.5pt,
    align: left,
    [*Operação*], [*Array ordenado*], [*Lista encadeada ordenada*],
    [Busca], [$O(log n)$ (busca binária)], [$O(n)$ (sem acesso aleatório)],
    [Inserção], [$O(n)$ (deslocar elementos)], [$O(n)$ (percorrer até a posição) $+ O(1)$],
    [Remoção], [$O(n)$ (deslocar elementos)], [$O(n)$ (percorrer) $+ O(1)$],
  ),
  caption: [Trade-off central: array ordenado permite busca binária $O(log n)$ mas inserção/remoção
    $O(n)$; lista encadeada ordenada tem inserção/remoção $O(1)$ *uma vez encontrada a posição*, mas
    a busca da posição já é $O(n)$ por não ter acesso aleatório.],
)

== Listas encadeadas

#definition(id: "def-lista-encadeada")[
  Uma *lista encadeada* (linked list) representa uma sequência como uma cadeia de *nós*, cada um
  contendo um valor e um (ou mais) *ponteiro(s)* para o(s) nó(s) vizinho(s):
  - *Simplesmente encadeada*: cada nó aponta apenas para o próximo; percorrível em uma direção.
  - *Duplamente encadeada*: cada nó aponta para o próximo *e* para o anterior; percorrível nos dois
    sentidos, ao custo de um ponteiro extra por nó.
  - *Circular*: o último nó aponta de volta para o primeiro, em vez de para `nulo`.
]

#figure(
  image("../figures/linked-list.svg", width: 90%),
  caption: [Lista simplesmente encadeada — cada nó guarda um valor e um ponteiro para o próximo.
    Fonte: Wikimedia Commons (domínio público).],
)

#remark[
  Diferente de um array, uma lista encadeada não tem *acesso aleatório* $O(1)$: para chegar ao
  $k$-ésimo elemento é preciso percorrer os $k-1$ anteriores, custando $O(k)$. Em compensação,
  inserir ou remover um nó *já localizado* (dado um ponteiro para ele, ou para seu antecessor) custa
  $O(1)$, sem deslocar elementos — o oposto do array.
]

== Pilhas (stacks)

#definition(id: "def-pilha")[
  Uma *pilha* é um TAD linear com disciplina de acesso *LIFO* (Last In, First Out — o último
  elemento inserido é o primeiro removido), com duas operações principais:
  - `empilhar` (`push`): insere um elemento no topo. $O(1)$.
  - `desempilhar` (`pop`): remove e retorna o elemento do topo. $O(1)$.
  - (auxiliar) `topo`/`peek`: consulta o elemento do topo sem removê-lo.
]

#figure(
  image("../figures/stack-lifo.svg", width: 45%),
  caption: [Pilha (LIFO): inserção e remoção ocorrem sempre pelo topo. Fonte: Wikimedia
    Commons (CC BY 3.0).],
)

#example(id: "ex-pilha-parenteses")[
  Verificar se uma cadeia de parênteses/colchetes/chaves está balanceada é a aplicação clássica de
  pilha:

  ```
  função balanceado(s)
      pilha ← vazia
      para cada caractere c em s faça
          se c é abertura então
              empilhar(pilha, c)
          senão se c é fechamento então
              se pilha vazia então retorne falso
              se topo(pilha) não corresponde a c então retorne falso
              desempilhar(pilha)
          fim-se
      fim-para
      retorne pilha vazia
  fim-função
  ```

  Para `"([{}])"`: cada abertura é empilhada, e cada fechamento deve corresponder ao topo — a pilha
  volta a ficar vazia exatamente quando a cadeia está corretamente balanceada. Custo: $O(n)$ tempo,
  $O(n)$ espaço no pior caso.
]

== Filas (queues)

#definition(id: "def-fila")[
  Uma *fila* é um TAD linear com disciplina de acesso *FIFO* (First In, First Out — o primeiro
  elemento inserido é o primeiro removido), com duas operações principais:
  - `enfileirar` (`enqueue`): insere um elemento no final (*fim* / *rear*). $O(1)$ amortizado.
  - `desenfileirar` (`dequeue`): remove e retorna o elemento do início (*início* / *front*). $O(1)$
    amortizado.
]

#figure(
  image("../figures/queue.svg", width: 70%),
  caption: [Fila (FIFO): inserção pelo final, remoção pelo início. Fonte: Wikimedia Commons
    (CC BY-SA 3.0).],
)

#remark[
  Implementar uma fila eficientemente sobre um *array* exige um *buffer circular* (índices de
  início/fim que "dão a volta" no array) — usar um array simples com remoção pelo início ingênua
  custaria $O(n)$ por deslocar todos os elementos restantes. Uma *lista duplamente encadeada* com
  ponteiros para início e fim resolve isso naturalmente em $O(1)$ por operação, sem esse cuidado.

  Uma *fila de prioridade* (usada com Heaps, tópico 9.9) generaliza a fila: em vez de FIFO estrito,
  remove sempre o elemento de maior (ou menor) prioridade.
]

== Armadilhas comuns

#remark[
  - *Pilha vs. recursão*: toda recursão pode ser reescrita de forma iterativa usando uma pilha
    explícita — questões costumam pedir para "simular" uma chamada recursiva com uma pilha manual.
  - *Fila com array sem buffer circular*: implementação ingênua de `dequeue` deslocando todo o array
    é $O(n)$, não $O(1)$ — uma pegadinha comum em questões que pedem a complexidade "correta" da
    operação.
  - *Confundir pilha (LIFO) com fila (FIFO)*: parece óbvio, mas é comum a prova descrever o
    comportamento (ex.: "uma pilha de pratos") e pedir para identificar a estrutura — ou o
    inverso, descrever uma operação e perguntar se ela é compatível com pilha, fila, ou ambas.
  - *Deque (double-ended queue)*: generaliza pilha e fila, permitindo inserção/remoção em ambas as
    pontas — não deve ser confundida com uma fila comum de acesso único.
]

== Questões

#example(id: "q-lineares-1")[
  *(Múltipla escolha)* Qual estrutura de dados é mais adequada para implementar o histórico de
  "desfazer" (undo) de um editor de texto, em que a última ação realizada deve ser a primeira a ser
  desfeita?

  (a) Fila #h(1em) (b) Pilha #h(1em) (c) Lista ordenada por array #h(1em) (d) Fila de prioridade
  #h(1em) (e) Qualquer uma, são equivalentes
]

#example(id: "q-lineares-2")[
  *(Múltipla escolha)* Em uma lista simplesmente encadeada com $n$ elementos e um ponteiro apenas
  para o início, qual é a complexidade de acessar o *último* elemento?

  (a) $O(1)$ #h(1em) (b) $O(log n)$ #h(1em) (c) $O(n)$ #h(1em) (d) $O(n log n)$ #h(1em)
  (e) $O(n^2)$
]

#example(id: "q-lineares-3")[
  *(Dissertativa curta)* Explique por que um array ordenado permite busca binária em $O(log n)$
  mas uma lista encadeada ordenada não, mesmo estando ambas ordenadas.
]

#solution[
  *Q1*: (b) — comportamento LIFO é exatamente o de undo/redo.

  *Q2*: (c) — sem ponteiro para o fim (nem acesso aleatório), é preciso percorrer todos os $n$ nós.

  *Q3*: Busca binária depende de *acesso aleatório* $O(1)$ a qualquer posição (para calcular o
  elemento do meio de um intervalo diretamente) — algo que um array oferece por indexação direta em
  memória contígua. Uma lista encadeada só permite acesso *sequencial*: mesmo sabendo que o elemento
  do "meio" está na posição $n/2$, chegar até ele custa $O(n/2) = O(n)$, eliminando a vantagem da
  busca binária.
]

== Referências

- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 10 (pilhas, filas, listas encadeadas).
- Sedgewick, R.; Wayne, K. *Algorithms*, cap. 1.3.
- Tenenbaum, A. M. et al. *Estruturas de Dados usando C*, cap. 3–4.
