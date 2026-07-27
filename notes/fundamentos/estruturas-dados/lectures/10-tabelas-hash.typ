#import "@preview/mousse-notes:1.1.0": *

= Tabelas Hash

== Introdução

Tabelas hash oferecem, em média, acesso $O(1)$ para busca, inserção e remoção — trocando a garantia
de pior caso de uma árvore balanceada ($O(log n)$) por desempenho médio constante, ao custo de não
manter os elementos ordenados. É a estrutura de escolha para implementar dicionários/mapas e
conjuntos na maioria das linguagens modernas (`dict` em Python, `HashMap` em Java, `unordered_map`
em C++).

== Definições formais

#definition(id: "def-hash")[
  Uma *função hash* $h: U -> \{0, 1, ..., m-1\}$ mapeia um universo de chaves $U$ (potencialmente
  infinito) para um conjunto finito de $m$ índices (*buckets* / posições) de uma tabela. Uma *tabela
  hash* usa $h$ para determinar em qual posição do array armazenar (ou buscar) cada chave.
]

#definition(id: "def-colisao-fc")[
  Uma *colisão* ocorre quando $h(k_1) = h(k_2)$ para chaves distintas $k_1 eq.not k_2$. O *fator de
  carga* $alpha = n/m$ (número de elementos armazenados dividido pelo número de posições) mede o
  quão "cheia" está a tabela, e domina a análise de desempenho médio.
]

#theorem(name: "Hashing uniforme simples", id: "thm-hashing-uniforme")[
  Sob a hipótese de *hashing uniforme simples* (cada chave tem probabilidade igual de ser mapeada
  para qualquer uma das $m$ posições, independentemente das demais), o tempo esperado de uma busca
  malsucedida ou bem-sucedida em uma tabela hash com resolução de colisão por encadeamento é
  $Theta(1 + alpha)$.
]

== Resolução de colisões

#definition(id: "def-encadeamento")[
  *Encadeamento separado (separate chaining)*: cada posição da tabela guarda uma lista encadeada
  (ou outra estrutura) com todas as chaves que colidiram naquele índice. Inserção é $O(1)$
  (adiciona no início da lista); busca é $O(1 + alpha)$ em média — percorre a lista da posição.
]

#definition(id: "def-enderecamento-aberto")[
  *Endereçamento aberto (open addressing)*: todos os elementos ficam diretamente no array (sem
  listas auxiliares); uma colisão é resolvida testando uma sequência de posições alternativas até
  achar uma livre, segundo uma *sequência de sondagem* (probing):
  - *Sondagem linear*: $h(k, i) = (h(k) + i) mod m$ — testa posições consecutivas.
  - *Sondagem quadrática*: $h(k, i) = (h(k) + c_1 i + c_2 i^2) mod m$ — espaça as tentativas para
    reduzir *agrupamento primário*.
  - *Hashing duplo (double hashing)*: $h(k, i) = (h_1(k) + i dot h_2(k)) mod m$ — usa uma segunda
    função hash para o passo, minimizando agrupamento.
]

#figure(
  table(
    columns: 4,
    stroke: 0.5pt,
    align: left,
    [*Índice*], [*Chave (encadeamento)*], [*Sondagem linear*], [*Observação*],
    [0], [`"maçã"` → `"uva"`], [`"maçã"`], [colisão resolvida por lista / por deslocamento],
    [1], [(vazio)], [`"uva"`], [`"uva"` originalmente colidia em 0, foi realocada para 1],
    [2], [`"pera"`], [`"pera"`], [sem colisão],
  ),
  caption: [Comparação lado a lado: encadeamento guarda uma lista por posição; sondagem linear
    realoca a chave colidida para a próxima posição livre no próprio array.],
)

#remark[
  *Agrupamento primário (primary clustering)*: na sondagem linear, uma sequência de posições
  ocupadas consecutivas tende a crescer ainda mais rápido (qualquer chave que colida em qualquer
  ponto do grupo se junta a ele), degradando o desempenho conforme $alpha$ cresce — problema que
  sondagem quadrática e hashing duplo atenuam por espalhar melhor as tentativas.
]

== Rehashing

#definition(id: "def-rehashing")[
  Quando o fator de carga $alpha$ ultrapassa um limiar (tipicamente $0.7$–$0.75$ em endereçamento
  aberto), a tabela é *reidratada (rehash)*: aloca-se um novo array maior (em geral, o dobro do
  tamanho) e todas as chaves existentes são reinseridas com a nova função hash (que depende de $m$).
  Como isso ocorre raramente à medida que $n$ cresce geometricamente, o custo *amortizado* por
  inserção permanece $O(1)$ (mesma análise usada para *arrays dinâmicos*).
]

== Exemplo resolvido

#example(id: "ex-hash-linear-probing")[
  Insira as chaves $76, 40, 48, 5, 55$ (nessa ordem) em uma tabela hash de tamanho $m = 11$ usando
  $h(k) = k mod 11$ e sondagem linear.

  - $h(76) = 76 mod 11 = 10$ → posição 10 livre, insere.
  - $h(40) = 40 mod 11 = 7$ → posição 7 livre, insere.
  - $h(48) = 48 mod 11 = 4$ → posição 4 livre, insere.
  - $h(5) = 5 mod 11 = 5$ → posição 5 livre, insere.
  - $h(55) = 55 mod 11 = 0$ → posição 0 livre, insere (nenhuma colisão nesse conjunto de chaves).

  Se em seguida inserirmos $66$: $h(66) = 66 mod 11 = 0$, mas a posição 0 já está ocupada por
  $55$ — sondagem linear tenta a posição $1 = (0+1) mod 11$, que está livre, e insere ali.
]

== Armadilhas comuns

#remark[
  - *Pior caso de tabela hash é $O(n)$*, não $O(1)$: se todas as chaves colidirem na mesma posição
    (função hash mal escolhida, ou ataque de negação de serviço via colisões forçadas), busca
    degrada para percorrer uma lista/sequência de tamanho $n$. O $O(1)$ é sempre uma garantia
    *esperada* (média), nunca de pior caso, salvo esquemas especiais (hashing perfeito, cuckoo
    hashing).
  - *Endereçamento aberto não pode ter $alpha > 1$*: diferente de encadeamento (onde $alpha$ pode
    exceder 1, com listas cada vez maiores), endereçamento aberto exige $n <= m$ sempre, pois cada
    chave ocupa uma posição exclusiva do array.
  - *Remoção em endereçamento aberto é delicada*: simplesmente esvaziar a posição quebra cadeias de
    sondagem de chaves inseridas depois — a solução usual é marcar a posição como "removida"
    (*tombstone* / lápide), distinta de "nunca usada", para que a busca continue sondando além dela.
  - *Boa função hash $eq.not$ função hash rápida*: uma função hash "rápida" mas que concentra muitas
    chaves comuns no mesmo índice (baixa dispersão) é pior na prática que uma função um pouco mais
    cara, porém uniforme.
]

== Questões

#example(id: "q-hash-1")[
  *(Múltipla escolha)* Sob a hipótese de hashing uniforme simples e resolução por encadeamento
  separado, o tempo esperado de busca em uma tabela hash com fator de carga $alpha$ é:

  (a) $O(1)$, sempre, independente de $alpha$
  (b) $Theta(1 + alpha)$
  (c) $O(log n)$
  (d) $O(n)$, sempre
  (e) $Theta(alpha^2)$
]

#example(id: "q-hash-2")[
  *(Dissertativa curta)* Explique a diferença entre encadeamento separado e endereçamento aberto
  quanto à possibilidade de o fator de carga $alpha$ ultrapassar 1, e por que isso ocorre.
]

#solution[
  *Q1*: (b) — ver @thm-hashing-uniforme.

  *Q2*: No encadeamento separado, cada posição guarda uma lista de tamanho arbitrário, então
  $n$ pode exceder $m$ livremente ($alpha > 1$ apenas significa listas mais longas, em média). No
  endereçamento aberto, cada chave ocupa exatamente uma posição do array e não há estrutura
  auxiliar — logo é fisicamente impossível armazenar mais chaves que posições, exigindo
  $alpha <= 1$ sempre (e, na prática, rehashing bem antes disso, por volta de $alpha approx 0.7$).
]

== Referências

- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 11 (hashing).
- Sedgewick, R.; Wayne, K. *Algorithms*, cap. 3.4.
- Knuth, D. E. *The Art of Computer Programming, Vol. 3: Sorting and Searching*, cap. 6.4.
