#import "@preview/mousse-notes:1.1.0": *

= Cadeias e Processamento de Cadeias

== Introdução

Cadeias de caracteres (*strings*) são sequências ordenadas de símbolos de um alfabeto finito, e seu
processamento (busca, comparação, compressão) é uma das aplicações mais diretas de estruturas de
dados lineares. O edital enfatiza especificamente algoritmos de *compressão de texto* — Huffman e
LZW — que também sintetizam ideias de árvores (9.9) e tabelas hash (9.10) vistas adiante.

== Definições formais

#definition(id: "def-cadeia")[
  Uma *cadeia* (string) $s$ sobre um alfabeto $Sigma$ é uma sequência finita $s = s_1 s_2 ... s_n$,
  $s_i in Sigma$. $|s| = n$ é o *comprimento* da cadeia. A cadeia vazia $epsilon$ tem $|epsilon| = 0$.
]

#definition(id: "def-operacoes-cadeia")[
  Operações básicas sobre cadeias incluem: *concatenação* ($s dot t$), extração de *subcadeia*
  (`s[i..j]`), *comparação lexicográfica*, e *busca de padrão* (encontrar ocorrências de um padrão
  $p$ dentro de um texto $t$, $|p| <= |t|$) — o problema clássico de *casamento de padrões* (string
  matching), resolvido por algoritmos como o ingênuo ($O(n m)$) ou Knuth-Morris-Pratt ($O(n+m)$).
]

#definition(id: "def-entropia")[
  A *entropia de Shannon* de uma fonte com símbolos $x_1, ..., x_k$ e probabilidades
  $p_1, ..., p_k$ é
  $ H(X) = -sum_(i=1)^k p_i log_2 p_i "bits/símbolo," $
  e representa o número médio *mínimo* de bits necessários para representar cada símbolo de uma
  fonte sem perdas, sob codificação ótima.
]

#remark[
  A entropia dá um *limite inferior teórico* de compressão: nenhum algoritmo de compressão sem
  perdas pode, em média, usar menos que $H(X)$ bits por símbolo para uma fonte com aquela
  distribuição de probabilidades. Algoritmos práticos (Huffman, LZW) são avaliados por quão perto
  chegam desse limite — essa é a "aproximação de entropia" citada no edital.
]

== Compressão de Huffman

#definition(id: "def-huffman")[
  A *codificação de Huffman* constrói um código de tamanho variável, *livre de prefixo* (nenhum
  código é prefixo de outro, permitindo decodificação sem ambiguidade), atribuindo códigos mais
  curtos aos símbolos mais frequentes. O algoritmo constrói uma *árvore binária* de baixo para cima:
  + Crie uma folha para cada símbolo, com peso igual à sua frequência.
  + Repita até restar um único nó: remova os dois nós de menor peso e crie um novo nó pai com peso
    igual à soma dos dois, tornando-os filhos esquerdo e direito.
  + O código de cada símbolo é o caminho da raiz até a folha (0 = esquerda, 1 = direita).
]

#theorem(name: "Otimalidade de Huffman", id: "thm-huffman-otimo")[
  Entre todos os códigos livres de prefixo para um dado alfabeto e distribuição de frequências, a
  codificação de Huffman minimiza o comprimento médio esperado do código, $sum_i p_i dot "comprimento"(s_i)$.
]

#example(id: "ex-huffman")[
  Codifique o alfabeto $\{A: 45, B: 13, C: 12, D: 16, E: 9, F: 5\}$ (frequências em número de
  ocorrências) com Huffman.

  #figure(
    image("../figures/huffman-example.svg", width: 75%),
    caption: [Árvore de Huffman resultante — nós internos acumulam a soma dos pesos dos filhos.
      Fonte: Wikimedia Commons (CC BY-SA 3.0).],
  )

  O símbolo mais frequente ($A$, peso 45) recebe o código mais curto (1 bit: `0`); os menos
  frequentes ($E$, $F$) recebem códigos mais longos (4 bits). O comprimento médio resultante fica
  próximo da entropia da distribuição, e sempre menor ou igual ao de um código de tamanho fixo
  (que exigiria $ceil(log_2 6) = 3$ bits por símbolo para 6 símbolos).
]

== Compressão LZW (Lempel-Ziv-Welch)

#definition(id: "def-lzw")[
  *LZW* é um algoritmo de compressão por *dicionário adaptativo*: constrói, durante a própria
  compressão, uma tabela de substrings já vistas, substituindo ocorrências repetidas por um índice
  curto para a entrada correspondente na tabela — ao contrário de Huffman, não precisa conhecer as
  frequências dos símbolos antecipadamente (é um algoritmo *adaptativo*, de uma passada).
]

#example(id: "ex-lzw-esboco")[
  Esboço do algoritmo de compressão LZW:

  ```
  dicionário ← {todos os símbolos do alfabeto, cada um com seu próprio código}
  w ← ""
  para cada símbolo c na entrada faça
      se w+c está no dicionário então
          w ← w + c
      senão
          emitir código(w)
          adicionar w+c ao dicionário
          w ← c
      fim-se
  fim-para
  emitir código(w)
  ```

  Padrões repetidos no texto (ex.: `"ABABAB..."`) rapidamente entram no dicionário como entradas de
  múltiplos caracteres, permitindo que grandes trechos repetidos sejam emitidos com um único
  código — é a base de formatos como GIF e do utilitário `compress` do Unix.
]

== Armadilhas comuns

#remark[
  - *Huffman precisa das frequências antecipadamente* (é *estático* / *offline*); *LZW não precisa*
    (é *adaptativo* / *online*) — essa distinção é frequentemente cobrada diretamente.
  - *Huffman não é único*: quando há empates de peso, diferentes escolhas de desempate geram
    árvores diferentes, mas todas com o mesmo comprimento médio ótimo — "a" árvore de Huffman não é
    universalmente única, apenas o comprimento médio esperado é.
  - *Compressão sem perdas $eq.not$ compressão com perdas*: Huffman e LZW são algoritmos de
    compressão *sem perdas* (o texto original é recuperado exatamente); técnicas como JPEG são
    *com perdas*. A entropia de Shannon só limita a compressão sem perdas.
  - *Confundir bits por símbolo com bits totais*: a entropia $H(X)$ é uma média *por símbolo*; o
    tamanho comprimido total é aproximadamente $n dot H(X)$ para uma fonte de $n$ símbolos
    i.i.d., não $H(X)$ isoladamente.
]

== Questões

#example(id: "q-cadeias-1")[
  *(Múltipla escolha)* Sobre Huffman e LZW, é correto afirmar que:

  (a) Ambos exigem conhecer as frequências dos símbolos antes de iniciar a compressão.
  (b) Huffman é adaptativo; LZW exige uma tabela de frequências pré-computada.
  (c) Huffman constrói uma árvore binária com base em frequências; LZW constrói um dicionário
      adaptativo durante a compressão.
  (d) LZW produz sempre códigos de tamanho fixo.
  (e) Huffman é um algoritmo de compressão com perdas.
]

#example(id: "q-cadeias-2")[
  *(Dissertativa curta)* Explique por que a entropia de Shannon $H(X)$ representa um limite
  inferior para a compressão sem perdas, e o que significa um algoritmo "se aproximar" desse
  limite.
]

#solution[
  *Q1*: (c).

  *Q2*: $H(X)$ é o número médio mínimo de bits necessário, sob *qualquer* esquema de codificação
  sem perdas, para representar um símbolo daquela fonte — é uma consequência do Teorema da
  Codificação de Fonte de Shannon. Um algoritmo "se aproxima" da entropia quando o comprimento
  médio do código que ele produz fica próximo de $H(X)$; Huffman, por exemplo, garante um
  comprimento médio no intervalo $[H(X), H(X)+1)$ bits/símbolo.
]

== Referências

- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 16.3 (códigos de Huffman).
- Sayood, K. *Introduction to Data Compression* (Huffman, LZW, entropia).
- Ziviani, N. *Projeto de Algoritmos*, cap. sobre casamento de padrões.
