#import "@preview/mousse-notes:1.1.0": *

= Algoritmos para Pesquisa e Ordenação

== Introdução

Busca e ordenação são os algoritmos mais estudados da ciência da computação — praticamente todo
outro algoritmo eficiente depende de dados já ordenados (para busca binária) ou de uma rotina de
ordenação como subrotina. Este tópico também cobre União-Busca (Union-Find), a estrutura de dados
clássica para o problema de conectividade dinâmica.

== Algoritmos de busca

#definition(id: "def-busca-linear")[
  *Busca linear*: percorre a sequência do início ao fim comparando cada elemento à chave procurada.
  Não exige dados ordenados. Complexidade $O(n)$ no pior caso, $O(1)$ no melhor caso.
]

#definition(id: "def-busca-binaria")[
  *Busca binária*: exige a sequência *ordenada*. Compara a chave com o elemento do meio do
  intervalo atual; descarta a metade que não pode conter a chave; repete no intervalo restante.
  Complexidade $O(log n)$, pois cada comparação elimina metade do espaço de busca.
  ```
  função busca_binaria(v, chave)
      baixo ← 0, alto ← |v| - 1
      enquanto baixo ≤ alto faça
          meio ← (baixo + alto) / 2
          se v[meio] = chave então retorne meio
          senão se v[meio] < chave então baixo ← meio + 1
          senão alto ← meio - 1
      fim-enquanto
      retorne não-encontrado
  fim-função
  ```
]

#definition(id: "def-buscas-variantes")[
  Variantes que exploram diferentes suposições sobre a distribuição dos dados:
  - *Jump search*: em um array ordenado de tamanho $n$, pula em blocos de tamanho $sqrt(n)$ até
    ultrapassar a chave, depois faz busca linear dentro do bloco. Complexidade $O(sqrt(n))$ — entre
    a busca linear e a binária, útil quando "voltar" é caro (ex.: mídia sequencial).
  - *Interpolation search*: em vez de sempre testar o meio, estima a posição provável da chave por
    interpolação linear entre os extremos (assumindo distribuição aproximadamente uniforme dos
    valores). Complexidade média $O(log log n)$, mas $O(n)$ no pior caso (dados não-uniformes).
  - *Exponential search*: encontra um intervalo $[2^(i-1), 2^i]$ que contém a chave dobrando $i$ a
    cada passo, depois aplica busca binária dentro desse intervalo. Complexidade $O(log n)$, mas
    especialmente útil quando o tamanho $n$ não é conhecido de antemão (ex.: streams, listas
    infinitas).
]

== Algoritmos de ordenação

#definition(id: "def-ordenacao-conceitos")[
  Um algoritmo de ordenação é *estável* quando preserva a ordem relativa de elementos com chaves
  iguais, e é *in-place* quando usa apenas $O(1)$ (ou $O(log n)$) memória auxiliar além da entrada.
]

#figure(
  table(
    columns: 6,
    stroke: 0.5pt,
    align: (left, center, center, center, center, center),
    [*Algoritmo*], [*Melhor*], [*Médio*], [*Pior*], [*Estável?*], [*In-place?*],
    [Insertion Sort], [$O(n)$], [$O(n^2)$], [$O(n^2)$], [Sim], [Sim],
    [Selection Sort], [$O(n^2)$], [$O(n^2)$], [$O(n^2)$], [Não], [Sim],
    [Bubble Sort], [$O(n)$], [$O(n^2)$], [$O(n^2)$], [Sim], [Sim],
    [Shell Sort], [$O(n log n)$], [$O(n^(4/3))$#footnote[depende da sequência de gaps]], [$O(n^2)$], [Não], [Sim],
    [Merge Sort], [$O(n log n)$], [$O(n log n)$], [$O(n log n)$], [Sim], [Não ($O(n)$ extra)],
    [Quick Sort], [$O(n log n)$], [$O(n log n)$], [$O(n^2)$], [Não], [Sim (in-place na prática)],
    [Heap Sort], [$O(n log n)$], [$O(n log n)$], [$O(n log n)$], [Não], [Sim],
  ),
  caption: [Complexidade e propriedades dos algoritmos de ordenação clássicos.],
)

#definition(id: "def-insertion-selection-bubble")[
  Os três algoritmos $O(n^2)$ mais simples, todos por comparação:
  - *Insertion Sort*: constrói a sequência ordenada incrementalmente, inserindo cada novo elemento
    na posição correta entre os já ordenados (como organizar cartas na mão). Eficiente para
    entradas quase ordenadas ($O(n)$ nesse caso).
  - *Selection Sort*: a cada passo, encontra o menor elemento restante e o coloca na posição
    correta por troca. Sempre $Theta(n^2)$ comparações, independentemente da entrada — mas faz no
    máximo $O(n)$ trocas, útil quando o custo de escrita é alto.
  - *Bubble Sort*: percorre repetidamente a sequência trocando pares adjacentes fora de ordem, "borbulhando"
    o maior elemento até o fim a cada passagem.
]

#definition(id: "def-shell-sort")[
  *Shell Sort* generaliza o Insertion Sort ordenando subsequências de elementos espaçados por um
  *gap* (intervalo), reduzindo o gap progressivamente até 1 (insertion sort convencional). Move
  elementos distantes rapidamente logo no início, reduzindo o número de trocas de longa distância
  que tornam o Insertion Sort puro $O(n^2)$.
]

#definition(id: "def-merge-quick-heap")[
  Os três algoritmos $O(n log n)$ mais estudados:
  - *Merge Sort*: divide o array ao meio recursivamente até subarrays de tamanho 1, depois
    *combina* (merge) pares ordenados em sequências maiores ordenadas. Recorrência
    $T(n) = 2T(n/2) + O(n)$, resolvida pelo Teorema Mestre (9.4) como $O(n log n)$ garantido.
  - *Quick Sort*: escolhe um *pivô*, particiona o array em elementos menores/maiores que o pivô, e
    recorre em cada partição. Rápido na prática (boas constantes, in-place), mas com pivô mal
    escolhido (ex.: sempre o primeiro elemento, em entrada já ordenada) degrada para $O(n^2)$.
  - *Heap Sort*: constrói um max-heap (9.9) em $O(n)$, depois extrai repetidamente o máximo,
    colocando-o no fim do array, $n$ vezes em $O(log n)$ cada — $O(n log n)$ garantido, in-place,
    mas não estável e com constantes piores que Merge/Quick Sort na prática.
]

#figure(
  image("../figures/merge-sort.svg", width: 75%),
  caption: [Merge Sort: divide recursivamente até subarrays triviais, depois combina pares
    ordenados. Fonte: Wikimedia Commons (domínio público).],
)

== Exemplo resolvido: partição do Quick Sort

#example(id: "ex-quicksort-particao")[
  Particione $[8, 3, 7, 4, 9, 2, 5]$ com o esquema de Lomuto, usando o último elemento (5) como
  pivô:

  ```
  função particiona(v, baixo, alto)
      pivô ← v[alto]
      i ← baixo - 1
      para j de baixo até alto - 1 faça
          se v[j] ≤ pivô então
              i ← i + 1
              trocar(v[i], v[j])
      trocar(v[i+1], v[alto])
      retorne i + 1
  fim-função
  ```

  Percorrendo com pivô $= 5$: $8$ (fica), $3$ ($<= 5$, troca para posição 0), $7$ (fica), $4$
  ($<=5$, troca para posição 1), $9$ (fica), $2$ ($<=5$, troca para posição 2). Ao final, o pivô é
  colocado logo após o último elemento $<=5$, resultando em
  $[3, 4, 2, 5, 9, 7, 8]$ — o pivô (5) já está em sua posição final, com tudo menor à esquerda e
  maior à direita.
]

== Algoritmos de União e Busca (Union-Find)

#definition(id: "def-union-find")[
  A estrutura *União-Busca (Union-Find / Disjoint Set Union)* mantém uma partição de $n$ elementos
  em conjuntos disjuntos, suportando duas operações:
  - `busca(x)` (find): retorna o representante (raiz) do conjunto que contém $x$.
  - `união(x, y)` (union): funde os conjuntos que contêm $x$ e $y$.
  Cada conjunto é representado como uma árvore, onde cada nó aponta para seu pai, e a raiz aponta
  para si mesma.
]

#definition(id: "def-problema-conectividade")[
  O *problema da conectividade dinâmica* pergunta, para um grafo cujas arestas chegam uma a uma:
  "$x$ e $y$ estão no mesmo componente conexo?" — respondida diretamente por
  `busca(x) = busca(y)`, tornando União-Busca a estrutura natural para o algoritmo de Kruskal (MST)
  e para detecção de ciclos incremental.
]

#definition(id: "def-uniao-lenta-rapida")[
  - *União lenta (quick-find)*: mantém um array `id[]` tal que `id[x]` é o identificador do
    componente de $x$; `busca` é $O(1)$ (consulta direta), mas `união` é $O(n)$ (precisa atualizar
    todos os elementos do componente).
  - *União rápida (quick-union)*: `união` só reatribui o pai da raiz de um conjunto à raiz do
    outro, $O("altura da árvore")$; mas `busca` também custa $O("altura")$, que pode degenerar para
    $O(n)$ sem cuidado adicional.
  - *União por peso/rank (weighted union)*: ao unir, sempre pendura a árvore *menor* sob a raiz da
    *maior* — garante altura $O(log n)$, logo `busca`/`união` ficam $O(log n)$.
]

#definition(id: "def-compressao-caminho")[
  *Compressão de caminho por redução pela metade (path halving)*: durante uma `busca(x)`, em vez de
  apenas seguir os ponteiros de pai até a raiz, cada nó visitado no caminho é reapontado para seu
  *avô* (pulando um nível), achatando a árvore progressivamente a cada busca subsequente.
]

#theorem(name: "União por peso + compressão de caminho", id: "thm-union-find-complexidade")[
  Combinando união por peso (ou rank) com compressão de caminho, uma sequência de $m$ operações
  sobre $n$ elementos custa $O(m dot alpha(n))$ no total, onde $alpha$ é a função inversa de
  Ackermann — cresce tão lentamente que $alpha(n) <= 4$ para qualquer $n$ praticamente
  representável, tornando cada operação efetivamente $O(1)$ amortizado.
]

== Armadilhas comuns

#remark[
  - *Busca binária exige dados ordenados*: aplicá-la sobre um array não ordenado (ou desatualizado
    após inserções) é um erro comum e sutil, já que o algoritmo não detecta a violação — apenas
    produz resultados incorretos silenciosamente.
  - *Quick Sort não é estável*, e seu pior caso $O(n^2)$ ocorre tipicamente com dados já ordenados
    (ou quase) combinados com escolha ingênua de pivô (primeiro/último elemento) — mitigado por
    escolha aleatória de pivô ou mediana-de-três.
  - *Selection Sort sempre faz $Theta(n^2)$ comparações*, mesmo em entrada já ordenada — diferente
    de Insertion e Bubble Sort, que são $O(n)$ no melhor caso (entrada já ordenada).
  - *Quick-find tem `busca` $O(1)$ mas `união` $O(n)$*: um erro comum é assumir que uma estrutura
    "rápida para buscar" é sempre preferível — depende de qual operação domina a carga de trabalho.
]

== Questões

#example(id: "q-ordenacao-1")[
  *(Múltipla escolha)* Qual dos algoritmos de ordenação a seguir tem complexidade de pior caso
  garantida $O(n log n)$ *e* é estável?

  (a) Quick Sort #h(1em) (b) Heap Sort #h(1em) (c) Merge Sort #h(1em) (d) Selection Sort
  #h(1em) (e) Shell Sort
]

#example(id: "q-ordenacao-2")[
  *(Múltipla escolha)* Sobre União-Busca com união por peso e compressão de caminho, a
  complexidade amortizada de uma sequência de $m$ operações é:

  (a) $O(m log n)$ #h(1em) (b) $O(m n)$ #h(1em) (c) $O(m dot alpha(n))$ #h(1em)
  (d) $O(m log log n)$ #h(1em) (e) $O(m)$ estritamente constante por operação
]

#example(id: "q-ordenacao-3")[
  *(Dissertativa curta)* Compare Interpolation Search e Busca Binária quanto à complexidade média
  e ao pior caso, indicando em que cenário cada uma é preferível.
]

#solution[
  *Q1*: (c) — Merge Sort é o único da lista que é simultaneamente estável e $O(n log n)$
  garantido no pior caso.

  *Q2*: (c) — ver @thm-union-find-complexidade.

  *Q3*: Interpolation Search tem complexidade média $O(log log n)$, melhor que a busca binária
  ($O(log n)$), *quando* os dados são aproximadamente uniformemente distribuídos, pois estima a
  posição da chave por interpolação em vez de sempre dividir ao meio. Porém, seu pior caso é
  $O(n)$ para distribuições adversas (ex.: dados concentrados/exponenciais), enquanto a busca
  binária garante $O(log n)$ *sempre*, independente da distribuição — preferível quando não há
  garantias sobre a uniformidade dos dados.
]

== Referências

- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 2, 6–8 (ordenação), cap. 21
  (Union-Find).
- Sedgewick, R.; Wayne, K. *Algorithms*, cap. 1.5 (Union-Find), 2.1–2.4 (ordenação).
- Knuth, D. E. *The Art of Computer Programming, Vol. 3: Sorting and Searching*.
