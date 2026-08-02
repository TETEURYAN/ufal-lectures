#import "@preview/mousse-notes:1.1.0": *

= 22.3 --- Resolução de Problemas como Busca

== Introdução

Muitos problemas de IA (jogos, planejamento, navegação) podem ser formalizados como *busca* em um espaço de estados: partir de uma situação inicial e encontrar uma sequência de ações que leve a um objetivo. Essa formalização é o alicerce de todo o bloco de busca (22.3 a 22.7), o mais cobrado em questões objetivas da disciplina.

== Definições formais

#definition(name: "Problema de busca", id: "def-problema-busca")[
  Um problema de busca é definido por cinco componentes:
  - *Estado inicial*: a situação de partida.
  - *Ações*: o conjunto de ações disponíveis em cada estado.
  - *Modelo de transição*: função que, dado um estado e uma ação, retorna o estado resultante.
  - *Teste de objetivo*: verifica se um estado é uma solução.
  - *Custo de caminho*: função que atribui um custo numérico a uma sequência de ações, usada para comparar soluções.
  O conjunto de todos os estados alcançáveis, junto com as transições entre eles, forma o *espaço de estados* -- tipicamente representado e percorrido como um grafo ou árvore de busca.
]

== Exemplo resolvido

#example(name: "Formalizando o problema do 8-puzzle", id: "ex-formalizacao-8-puzzle")[
  No quebra-cabeça de 8 peças (grade 3×3 com 8 peças numeradas e um espaço vazio):
  - *Estado*: a disposição das 8 peças e do espaço vazio na grade.
  - *Estado inicial*: a configuração embaralhada dada.
  - *Ações*: mover o espaço vazio para cima, baixo, esquerda ou direita (quando aplicável na borda).
  - *Modelo de transição*: troca a posição do espaço vazio com a peça na direção escolhida.
  - *Teste de objetivo*: a configuração está na ordem numérica correta.
  - *Custo de caminho*: número de movimentos realizados (cada movimento custa 1).
]

= 22.4 --- Estratégias de Busca, Busca Cega e Busca Heurística

== Introdução

Formalizado o problema, resta *como* percorrer o espaço de estados eficientemente. Estratégias *cegas (não informadas)* não usam nenhuma informação sobre a distância ao objetivo; estratégias *heurísticas (informadas)* usam uma estimativa para guiar a busca -- a diferença entre "explorar no escuro" e "explorar com um mapa aproximado".

== Definições formais

#definition(name: "Busca cega: largura, profundidade e custo uniforme", id: "def-busca-cega")[
  - *Busca em largura (BFS)*: expande todos os nós de uma profundidade antes de avançar à próxima -- usa uma fila FIFO.
  - *Busca em profundidade (DFS)*: expande o nó mais profundo disponível antes de retroceder -- usa uma pilha (ou recursão).
  - *Busca de custo uniforme (UCS)*: expande sempre o nó de menor custo acumulado $g(n)$ até o momento -- generaliza BFS para custos de aresta não uniformes.
]

#definition(name: "Busca heurística (informada)", id: "def-busca-heuristica")[
  Usa uma *função heurística* $h(n)$, que estima o custo do nó $n$ até o objetivo mais próximo, para priorizar quais nós expandir primeiro -- em vez de expandir cegamente por ordem estrutural. As estratégias concretas (hill climbing, best-first, A\*) são tratadas em 22.5.
]

== Comparação: busca cega

#table(
  columns: 5,
  [*Estratégia*], [*Completa?*], [*Ótima?*], [*Complexidade de tempo*], [*Complexidade de espaço*],
  [Largura (BFS)], [Sim (se fator de ramificação finito)], [Sim, se custo uniforme por aresta], [$O(b^d)$], [$O(b^d)$],
  [Profundidade (DFS)], [Não (pode entrar em ramos infinitos)], [Não], [$O(b^m)$], [$O(b m)$],
  [Custo uniforme (UCS)], [Sim (custos positivos)], [Sim, sempre], [$O(b^(1+floor(C^*\/epsilon)))$], [Igual ao tempo],
)
Onde $b$ é o fator de ramificação, $d$ a profundidade da solução mais rasa, $m$ a profundidade máxima da árvore, e $C^*$ o custo da solução ótima.

== Exemplo resolvido

#example(name: "BFS vs. DFS na mesma árvore", id: "ex-bfs-dfs-arvore")[
  Considere uma árvore de busca com raiz $A$, filhos $B, C$ de $A$, e filhos $D, E$ de $B$, com objetivo $E$.

  - *BFS* visita: $A, B, C, D, E$ -- explora todo o nível 1 ($B, C$) antes do nível 2 ($D, E$), encontrando $E$ no 5º nó visitado.
  - *DFS* visita: $A, B, D$ (retrocede, $D$ não é objetivo e não tem filhos), $E$ -- encontra $E$ no 4º nó, descendo o mais fundo possível por um ramo antes de tentar outro.

  Nesse exemplo pequeno, DFS "ganhou" por sorte da ordem dos ramos -- mas DFS não garante encontrar a solução mais rasa (não é ótima), enquanto BFS sempre encontra primeiro a solução de menor profundidade.
]

== Atenção -- pegadinhas comuns

#remark(name: "BFS só é ótima se o custo por passo for uniforme")[
  Busca em largura garante a solução com *menos passos*, não necessariamente a de *menor custo* -- se as arestas tiverem custos diferentes, BFS pode retornar uma solução subótima em custo. Para isso, use busca de custo uniforme (UCS), que sempre expande por menor $g(n)$ acumulado.
]

#remark(name: "DFS economiza espaço, mas paga o preço em completude/otimalidade")[
  A vantagem de DFS é a complexidade de espaço linear ($O(b m)$, contra o exponencial de BFS), mas isso vem ao custo de não ser completa em espaços infinitos (pode ficar presa em um ramo infinito) nem ótima -- um trade-off clássico cobrado em prova.
]

== Questões estilo POSCOMP

*Questão 1.* A estratégia de busca que garante encontrar a solução de menor custo, mesmo quando os custos das arestas não são uniformes, é:
- a) Busca em profundidade.
- b) Busca em largura.
- c) Busca de custo uniforme.
- d) Hill climbing.
- e) Busca bidirecional sem custo.

*Questão 2.* A principal desvantagem da busca em profundidade (DFS), em relação à busca em largura (BFS), é:
- a) Maior consumo de memória.
- b) Não é completa em espaços de busca infinitos e não garante otimalidade.
- c) Não pode ser implementada recursivamente.
- d) Sempre encontra a solução ótima, mas gasta mais tempo.
- e) Não pode ser usada em nenhum problema de busca.

*Questão 3.* Uma função heurística $h(n)$, no contexto de busca informada, serve para:
- a) Garantir que a busca nunca expanda um nó incorreto.
- b) Estimar o custo restante de $n$ até o objetivo, orientando a ordem de expansão dos nós.
- c) Substituir completamente o teste de objetivo.
- d) Calcular o custo exato até o objetivo, sempre com precisão perfeita.
- e) Eliminar a necessidade de definir ações no problema.

*Questão 4.* A complexidade de espaço da busca em largura (BFS), em termos do fator de ramificação $b$ e profundidade da solução $d$, é:
- a) $O(b m)$, linear.
- b) $O(b^d)$, exponencial.
- c) $O(log b)$.
- d) $O(1)$, constante.
- e) $O(d)$, linear em $d$ apenas.

== Gabarito comentado

1. *(c)* -- UCS expande por menor custo acumulado $g(n)$, garantindo otimalidade mesmo com custos de aresta variáveis.
2. *(b)* -- DFS pode ficar presa em ramos infinitos (incompleta) e não garante a solução de menor profundidade/custo (não ótima).
3. *(b)* -- definição direta de função heurística.
4. *(b)* -- BFS mantém em memória toda a fronteira, que cresce exponencialmente com a profundidade, conforme a tabela desta seção.

== Referências

- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 3 (Resolução de problemas por busca).
- LUGER, G. *Inteligência Artificial*. Cap. 3--4 (Busca cega e heurística).
- Stanford CS221 (stanford-cs221.github.io) -- módulo de busca e route planning.
