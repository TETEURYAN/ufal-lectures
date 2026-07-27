#import "@preview/mousse-notes:1.1.0": *

= Árvores e suas Generalizações

== Introdução

Árvores generalizam as estruturas lineares do tópico anterior para uma organização hierárquica,
permitindo busca, inserção e remoção em tempo logarítmico quando bem balanceadas. É provavelmente o
tema de estruturas de dados mais cobrado em provas de fundamentos, pela quantidade de variantes
(binária, de busca, balanceada, heap) e propriedades que cada uma exige.

== Árvores binárias

#definition(id: "def-arvore-binaria")[
  Uma *árvore* é um grafo acíclico conexo com um nó distinguido, a *raiz*. Uma *árvore binária* é
  uma árvore em que cada nó tem no máximo dois filhos, distinguidos como *filho esquerdo* e *filho
  direito*. A *altura* de um nó é o comprimento do caminho mais longo até uma folha; a altura da
  árvore é a altura da raiz. Um nó sem filhos é uma *folha*.
]

#definition(id: "def-arvore-tipos")[
  Classificações estruturais comuns de árvores binárias:
  - *Cheia (full)*: todo nó tem 0 ou 2 filhos (nunca exatamente 1).
  - *Completa (complete)*: todos os níveis estão totalmente preenchidos, exceto possivelmente o
    último, que é preenchido da esquerda para a direita.
  - *Perfeita (perfect)*: todos os níveis, incluindo o último, estão totalmente preenchidos —
    uma árvore perfeita de altura $h$ tem exatamente $2^(h+1) - 1$ nós.
  - *Balanceada*: para todo nó, a diferença de altura entre as subárvores esquerda e direita é
    limitada por uma constante (ex.: no máximo 1, no caso da AVL).
]

#theorem(name: "Altura mínima e máxima", id: "thm-altura-arvore")[
  Uma árvore binária com $n$ nós tem altura $h$ satisfazendo
  $ floor(log_2 n) <= h <= n - 1. $
  O limite inferior é atingido por árvores perfeitas/completas; o limite superior, por uma árvore
  degenerada em formato de lista encadeada (cada nó com um único filho).
]

== Árvores de busca binária (BST)

#definition(id: "def-bst")[
  Uma *Árvore de Busca Binária* (BST) é uma árvore binária em que, para todo nó $x$ com chave
  $k(x)$: toda chave na subárvore esquerda de $x$ é $< k(x)$, e toda chave na subárvore direita é
  $> k(x)$ (*propriedade de BST*). Essa propriedade permite busca, inserção e remoção guiadas por
  comparação, descartando uma subárvore inteira a cada passo.
]

#figure(
  image("../figures/bst-search.svg", width: 55%),
  caption: [Busca em uma árvore de busca binária: a cada nó, compara-se a chave procurada e desce-se
    para a esquerda ou direita. Fonte: Wikimedia Commons (domínio público).],
)

#remark[
  Todas as operações fundamentais de uma BST — `buscar`, `inserir`, `remover`, `mínimo`, `máximo`,
  `sucessor`, `predecessor` — custam $O(h)$, onde $h$ é a altura da árvore. Pelo
  @thm-altura-arvore, isso é $O(log n)$ no melhor caso (árvore balanceada), mas degrada para $O(n)$
  no pior caso (árvore degenerada, equivalente a uma lista encadeada) — por exemplo, ao inserir
  chaves já ordenadas em sequência numa BST sem rebalanceamento.
]

== Árvores balanceadas (AVL)

#definition(id: "def-avl")[
  Uma *árvore AVL* (Adelson-Velsky e Landis) é uma BST auto-balanceada em que, para cada nó, o
  *fator de balanceamento* — a diferença entre a altura da subárvore direita e da esquerda — é
  sempre $-1, 0$ ou $1$. Após cada inserção/remoção que viola essa invariante, *rotações* restauram
  o balanceamento.
]

#definition(id: "def-rotacoes-avl")[
  As quatro rotações de rebalanceamento de uma AVL:
  - *Rotação simples à direita*: corrige desbalanceamento esquerda-esquerda (LL).
  - *Rotação simples à esquerda*: corrige desbalanceamento direita-direita (RR).
  - *Rotação dupla esquerda-direita*: corrige desbalanceamento esquerda-direita (LR) — uma rotação
    à esquerda na subárvore esquerda, seguida de rotação à direita na raiz.
  - *Rotação dupla direita-esquerda*: corrige desbalanceamento direita-esquerda (RL), simétrica.
]

#figure(
  image("../figures/avl-rebalancing.svg", width: 55%),
  caption: [Rebalanceamento AVL: rotações restauram a propriedade de fator de balanceamento
    $in \{-1,0,1\}$ após uma inserção. Fonte: Wikimedia Commons (CC BY-SA 3.0).],
)

#theorem(id: "thm-avl-altura")[
  Uma árvore AVL com $n$ nós tem altura $h = O(log n)$ — mais precisamente, $h < 1.44 log_2(n+2)$.
  Consequentemente, busca, inserção e remoção em AVL são sempre $O(log n)$, mesmo no pior caso.
]

#remark[
  A garantia de $O(log n)$ *no pior caso* é exatamente o que diferencia AVL (e outras árvores
  balanceadas, como árvores rubro-negras e árvores-B, tópico 9.9 avançado) de uma BST comum:
  BST simples é $O(log n)$ apenas *em média*, sobre entradas aleatórias.
]

== Heaps

#definition(id: "def-heap")[
  Um *heap binário* é uma árvore binária *completa* que satisfaz a *propriedade de heap*:
  - *Max-heap*: a chave de cada nó é $>=$ a chave de seus filhos (a raiz é sempre o máximo).
  - *Min-heap*: a chave de cada nó é $<=$ a chave de seus filhos (a raiz é sempre o mínimo).

  Por ser completa, um heap é tipicamente implementado sobre um *array*, sem ponteiros: o filho
  esquerdo do nó no índice $i$ está em $2i+1$, o direito em $2i+2$, e o pai em $floor((i-1)/2)$
  (indexação a partir de 0).
]

#figure(
  image("../figures/max-heap.svg", width: 55%),
  caption: [Max-heap: a raiz é sempre o maior elemento; a propriedade vale recursivamente para
    cada subárvore. Fonte: Wikimedia Commons (CC BY-SA 3.0).],
)

#definition(id: "def-heap-operacoes")[
  Operações de heap, todas $O(log n)$ (exceto `construir`, que é $O(n)$):
  - `inserir`: adiciona a folha no fim do array e "sobe" (`sift-up`) trocando com o pai enquanto
    viola a propriedade de heap.
  - `extrair-máximo` (ou mínimo): remove a raiz, move o último elemento para a raiz, e "desce"
    (`sift-down` / `heapify`) trocando com o maior filho enquanto viola a propriedade.
  - `construir-heap`: transforma um array arbitrário em heap aplicando `heapify` de baixo para
    cima, em $O(n)$ (não $O(n log n)$, por uma análise mais fina da soma das alturas dos nós).
]

#remark[
  *Heap não é uma árvore ordenada* como a BST: a propriedade de heap garante apenas que um nó é
  $>=$ (ou $<=$) seus filhos *diretos*, não que a árvore inteira esteja em ordem — elementos em
  subárvores distintas não têm relação de ordem garantida entre si. Por isso um heap *não* permite
  busca binária eficiente de um elemento arbitrário (é $O(n)$), diferente de uma BST.
]

== Exemplo resolvido

#example(id: "ex-arvore-insercao-bst")[
  Insira as chaves $50, 30, 70, 20, 40$ nessa ordem em uma BST vazia, e depois em um max-heap
  (array), comparando os resultados:

  *BST*: cada chave desce comparando com a raiz e os nós seguintes:
  ```
          50
        /    \
      30      70
     /  \
   20    40
  ```
  Estrutura *hierárquica por valor*: tudo à esquerda de um nó é menor, tudo à direita é maior.

  *Max-heap* (array, com `sift-up` a cada inserção): $[50]$, $[50,30]$, $[70,30,50]$
  (70 sobe trocando com 50), $[70,30,50,20]$, $[70,40,50,20,30]$ (40 sobe trocando com 30).
  Estrutura *só garante o máximo no topo* — a ordem entre os demais elementos não é total.
]

== Armadilhas comuns

#remark[
  - *"Balanceada" $eq.not$ "completa"*: uma árvore pode ser completa (níveis preenchidos da
    esquerda para a direita) sem satisfazer a propriedade de BST, e uma AVL balanceada não precisa
    ser completa nem perfeita — são propriedades ortogonais.
  - *BST no pior caso é $O(n)$*, não $O(log n)$ — só é $O(log n)$ garantido se for uma árvore
    balanceada (AVL, rubro-negra) ou se as inserções forem em ordem aleatória (caso médio).
  - *Heap não serve para busca*: encontrar um elemento arbitrário em um heap é $O(n)$, pois a
    propriedade de heap só restringe a relação pai-filho, não a ordem lateral entre subárvores —
    erro comum é assumir que "estruturado como árvore" implica busca $O(log n)$.
  - *`construir-heap` é $O(n)$, não $O(n log n)$*: aplicar `heapify` de baixo para cima explora o
    fato de que a maioria dos nós está perto das folhas (poucos níveis para "descer") — inserir os
    $n$ elementos um a um (`inserir` $O(log n)$ cada) daria $O(n log n)$, uma alternativa
    corretamente mais lenta.
]

== Questões

#example(id: "q-arvores-1")[
  *(Múltipla escolha)* Em uma árvore AVL com $n$ nós, a complexidade de pior caso para busca é:

  (a) $O(1)$ #h(1em) (b) $O(log n)$ #h(1em) (c) $O(n)$ #h(1em) (d) $O(n log n)$ #h(1em)
  (e) Depende da ordem de inserção
]

#example(id: "q-arvores-2")[
  *(Múltipla escolha)* Um max-heap contém os elementos $\{10, 8, 9, 3, 4\}$ organizados
  corretamente segundo a propriedade de heap. É correto afirmar que:

  (a) O elemento na raiz é necessariamente 10.
  (b) O array representa a sequência ordenada dos elementos.
  (c) $8$ é necessariamente maior que $9$.
  (d) A árvore é necessariamente uma BST válida.
  (e) A busca de um elemento arbitrário é $O(log n)$.
]

#example(id: "q-arvores-3")[
  *(Dissertativa curta)* Explique por que uma BST comum pode degenerar para complexidade $O(n)$ e
  como uma árvore AVL evita esse problema.
]

#solution[
  *Q1*: (b) — garantia do pior caso do @thm-avl-altura.

  *Q2*: (a) — a propriedade de max-heap garante que a raiz é sempre o maior elemento,
  independente da posição dos demais.

  *Q3*: Se as chaves forem inseridas em ordem (já ordenadas) em uma BST comum, cada nova chave
  sempre se torna filho único do último nó inserido, formando uma cadeia — equivalente a uma lista
  encadeada de altura $n-1$, tornando busca/inserção $O(n)$. Uma AVL evita isso aplicando rotações
  (@def-rotacoes-avl) após cada inserção/remoção que viole o fator de balanceamento, garantindo
  altura $O(log n)$ (@thm-avl-altura) independentemente da ordem de inserção.
]

== Referências

- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 12 (BST), cap. 13 (rubro-negra), cap. 6
  (heaps).
- Sedgewick, R.; Wayne, K. *Algorithms*, cap. 3.2–3.3, 2.4 (heaps).
- Ziviani, N. *Projeto de Algoritmos*, cap. 6–7.
