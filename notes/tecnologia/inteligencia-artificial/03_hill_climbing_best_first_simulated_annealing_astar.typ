#import "@preview/mousse-notes:1.1.0": *

= 22.5 --- Hill Climbing, Best First, Simulated Annealing e Algoritmo A\*

== Introdução

Com busca cega e o conceito de heurística já estabelecidos (22.3, 22.4), esta subseção detalha os algoritmos concretos que usam heurística para guiar a busca -- o bloco de questões objetivas mais denso da disciplina, especialmente sobre o algoritmo A\*.

== Definições formais

#definition(name: "Hill Climbing (subida de encosta)", id: "def-hill-climbing")[
  Busca local *gulosa*: a cada passo, move-se para o vizinho de melhor valor (maior ou menor, conforme o objetivo), sem manter histórico nem retroceder. Para quando nenhum vizinho é melhor que o estado atual -- que pode ser um *máximo local* (não necessariamente o ótimo global), um *platô* (região plana) ou uma *crista* (ridge, exige movimentos diagonais que o operador local não enxerga).
]

#definition(name: "Busca Best-First (gulosa)", id: "def-best-first")[
  Mantém uma fronteira ordenada por uma função de avaliação e sempre expande o nó de melhor valor. A *busca gulosa best-first* usa $f(n) = h(n)$ exclusivamente (ignora o custo já percorrido) -- rápida, mas não garante otimalidade nem completude em geral.
]

#definition(name: "Simulated Annealing (recozimento simulado)", id: "def-simulated-annealing")[
  Busca local probabilística inspirada no recozimento de metais: aceita um movimento para um vizinho *pior* com probabilidade $e^(-Delta E \/ T)$, onde $Delta E$ é a piora e $T$ é uma "temperatura" que diminui gradualmente ao longo da execução (*resfriamento*). No início ($T$ alto), aceita quase qualquer movimento (explora amplamente); ao final ($T -> 0$), comporta-se como hill climbing puro -- essa capacidade de aceitar piora ocasionalmente é o que permite escapar de máximos locais.
]

#definition(name: "Algoritmo A\\*", id: "def-a-estrela")[
  Busca informada que expande sempre o nó de menor $f(n) = g(n) + h(n)$, onde $g(n)$ é o custo real já percorrido até $n$, e $h(n)$ é a estimativa heurística do custo restante até o objetivo. Combina o rigor da busca de custo uniforme (via $g$) com a orientação da busca heurística (via $h$).
]

== Propriedade relevante

#theorem(name: "Otimalidade de A\\* com heurística admissível", id: "thm-otimalidade-a-estrela")[
  Se a heurística $h(n)$ é *admissível* (nunca superestima o custo real restante, isto é, $h(n) <= h^*(n)$ para todo $n$), a busca A\* em árvore é *ótima*: a primeira solução encontrada tem custo mínimo. Para busca em grafo (com nós repetidos), é necessária também *consistência* (monotonicidade: $h(n) <= "custo"(n,n') + h(n')$ para todo sucessor $n'$).
]

#proof[
  Esboço: suponha que A\* retorna uma solução $S$ com $f(S) = g(S)$ (pois $h(S)=0$ em um nó objetivo) maior que o custo ótimo $C^*$. Como existiria um nó $n$ na fronteira, no caminho para a solução ótima, com $f(n) = g(n) + h(n) <= C^*$ (por admissibilidade, $h(n)$ nunca superestima), esse $n$ teria sido expandido *antes* de $S$ (menor $f$), contradizendo a suposição de que $S$ foi escolhido primeiro. Logo, A\* nunca retorna uma solução com custo maior que $C^*$.
]

== Comparação entre algoritmos

#table(
  columns: 5,
  [*Algoritmo*], [*Completo?*], [*Ótimo?*], [*Complexidade de tempo*], [*Complexidade de espaço*],
  [Hill Climbing], [Não (para em máximo local)], [Não], [Variável, tipicamente baixa], [$O(1)$ (só estado atual)],
  [Best-First guloso], [Não, em geral], [Não, em geral], [$O(b^m)$, pior caso], [$O(b^m)$],
  [Simulated Annealing], [Sim, com resfriamento suficientemente lento (teórico)], [Sim, no limite teórico], [Depende do cronograma de resfriamento], [$O(1)$ (só estado atual)],
  [A\*], [Sim (com $b$ finito e custos $>0$)], [Sim, se $h$ admissível], [Exponencial, pior caso], [Exponencial, pior caso (mantém fronteira)],
)

#figure(
  image("figures/astar-pathfinding.svg", width: 55%),
  caption: [Busca A\* em uma grade, usando a distância de Manhattan como heurística $h(n)$: o caminho encontrado (destacado) equilibra custo percorrido $g(n)$ e distância estimada ao destino. Fonte: Wikimedia Commons, CC BY-SA.],
)

== Exemplo resolvido

#example(name: "A\\* passo a passo", id: "ex-a-estrela-passo-a-passo")[
  Grafo com nós $S$ (início), $A$, $B$, $G$ (objetivo). Custos de aresta: $S{-}A{=}1$, $S{-}B{=}4$, $A{-}B{=}2$, $A{-}G{=}5$, $B{-}G{=}1$. Heurística (estimativa até $G$): $h(S){=}6$, $h(A){=}4$, $h(B){=}2$, $h(G){=}0$.

  #table(
    columns: 4,
    [*Passo*], [*Nó expandido*], [*Atualizações*], [*Fronteira após o passo*],
    [1], [$S$ ($f{=}0{+}6{=}6$)], [$g(A){=}1, f(A){=}5$; $g(B){=}4, f(B){=}6$], [$A(5), B(6)$],
    [2], [$A$ ($f{=}5$)], [via $A$: $g(B){=}1{+}2{=}3 < 4$, atualiza $f(B){=}3{+}2{=}5$; $g(G){=}1{+}5{=}6, f(G){=}6$], [$B(5), G(6)$],
    [3], [$B$ ($f{=}5$)], [via $B$: $g(G){=}3{+}1{=}4 < 6$, atualiza $f(G){=}4{+}0{=}4$], [$G(4)$],
    [4], [$G$ ($f{=}4$)], [nó objetivo alcançado com o menor $f$ da fronteira], [--],
  )

  Caminho ótimo: $S -> A -> B -> G$, custo total $1+2+1=4$. Note o passo 2: A\* *atualiza* o custo de $B$ ao descobrir um caminho mais barato via $A$ (em vez do caminho direto $S{-}B$) -- esse recálculo é essencial para a otimalidade do algoritmo.
]

== Atenção -- pegadinhas comuns

#remark(name: "Hill climbing e simulated annealing não mantêm fronteira -- A\\* mantém")[
  Hill climbing e simulated annealing usam memória $O(1)$ (apenas o estado atual), por isso escalam bem, mas sacrificam completude/otimalidade. A\* mantém toda a fronteira explorada, pagando em memória o que ganha em garantias.
]

#remark(name: "Admissibilidade é sobre nunca superestimar -- não é sobre precisão")[
  Uma heurística admissível pode ser muito imprecisa (ex.: $h(n)=0$ para todo $n$ é sempre admissível, reduzindo A\* a busca de custo uniforme) -- o que importa para a garantia de otimalidade é *nunca* superestimar, não o quão próxima a estimativa está do valor real.
]

== Questões estilo POSCOMP

*Questão 1.* O algoritmo A\* expande, a cada passo, o nó de menor valor de:
- a) $g(n)$ apenas.
- b) $h(n)$ apenas.
- c) $f(n) = g(n) + h(n)$.
- d) Profundidade na árvore.
- e) Número de sucessores.

*Questão 2.* Para que A\* garanta encontrar a solução ótima (busca em árvore), a heurística $h(n)$ deve ser:
- a) Sempre igual a zero.
- b) Admissível (nunca superestimar o custo real restante).
- c) Sempre igual ao custo real exato.
- d) Decrescente ao longo da busca.
- e) Independente do problema.

*Questão 3.* A principal limitação do Hill Climbing é:
- a) Uso excessivo de memória.
- b) Complexidade de tempo sempre exponencial.
- c) Pode ficar preso em máximos locais, platôs ou cristas, sem garantia de encontrar o ótimo global.
- d) Nunca termina.
- e) Exige uma heurística admissível, como o A\*.

*Questão 4.* No Simulated Annealing, a probabilidade de aceitar um movimento para um estado pior:
- a) É sempre zero, como no Hill Climbing.
- b) É sempre um, independentemente da temperatura.
- c) Diminui à medida que a temperatura $T$ diminui ao longo da execução.
- d) Não depende da diferença de qualidade entre os estados.
- e) É calculada apenas no último passo da busca.

== Gabarito comentado

1. *(c)* -- definição central do algoritmo A\*.
2. *(b)* -- admissibilidade é a condição suficiente para otimalidade em busca em árvore, conforme o teorema desta seção.
3. *(c)* -- ausência de backtracking e de memória de estados visitados torna o Hill Climbing vulnerável a ótimos locais.
4. *(c)* -- a probabilidade $e^(-Delta E\/T)$ diminui conforme $T$ diminui, aproximando o comportamento de Hill Climbing puro ao final.

== Referências

- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 3--4 (Busca informada e busca local).
- HART, P.; NILSSON, N.; RAPHAEL, B. *A Formal Basis for the Heuristic Determination of Minimum Cost Paths* (1968) -- artigo original do A\*.
- KIRKPATRICK, S.; GELATT, C.; VECCHI, M. *Optimization by Simulated Annealing* (1983).
