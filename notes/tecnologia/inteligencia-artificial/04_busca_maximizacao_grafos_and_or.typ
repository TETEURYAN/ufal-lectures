#import "@preview/mousse-notes:1.1.0": *

= 22.6 --- Busca como Maximização de Função

== Introdução

Os algoritmos de busca local de 22.5 (hill climbing, simulated annealing) podem ser vistos de uma perspectiva unificadora: buscar não é apenas "encontrar um caminho", mas *maximizar* (ou minimizar) uma função objetivo sobre o espaço de estados -- uma ponte conceitual entre busca em IA e otimização matemática.

== Definições formais

#definition(name: "Busca como maximização de função objetivo", id: "def-busca-maximizacao")[
  Reformula um problema de busca como: dado um espaço de estados e uma *função objetivo* $f: "Estados" -> RR$ que mede a qualidade de cada estado, encontrar $s^*$ que maximize (ou minimize) $f$. O espaço de estados, sob essa ótica, é visualizado como uma *paisagem* (landscape): altitude = valor de $f$, e a busca local "caminha" por essa paisagem tentando subir (ou descer) até um pico (ou vale).
]

== Exemplo resolvido

#example(name: "Paisagem de uma função objetivo com múltiplos picos", id: "ex-paisagem-funcao-objetivo")[
  Considere maximizar $f(x) = -(x-3)^2 + 10$ para $x$ em um domínio discreto pequeno, com um segundo pico local em $f(x) = -(x-8)^2 + 6$ sobreposto (paisagem com dois máximos locais). Um hill climbing iniciado próximo de $x=8$ converge ao pico local ($f=6$), não ao pico global em $x=3$ ($f=10$) -- ilustrando por que a escolha do estado inicial (ou reinícios aleatórios) importa tanto quanto o algoritmo em si.
]

== Atenção -- pegadinhas comuns

#remark(name: "Maximizar e minimizar são o mesmo problema, com sinal trocado")[
  Minimizar $f$ é equivalente a maximizar $-f$ -- a formalização como maximização não perde generalidade; problemas tipicamente descritos como "minimizar custo" (ex.: busca de caminho mínimo) se encaixam na mesma moldura teórica.
]

= 22.7 --- Grafos And/Or

== Introdução

Nem todo problema se resolve com um único caminho no espaço de estados: alguns problemas exigem *decompor* um problema em subproblemas, alguns dos quais precisam ser todos resolvidos (AND), outros dos quais basta resolver um (OR). Grafos AND/OR formalizam essa estrutura, generalizando os grafos de espaço de estados comuns (que são, nessa terminologia, grafos "só-OR").

== Definições formais

#definition(name: "Grafo AND/OR", id: "def-grafo-and-or")[
  Um grafo AND/OR representa a decomposição de um problema em subproblemas:
  - *Nó OR*: representa alternativas -- resolver o nó exige resolver *apenas um* de seus sucessores (como em um grafo de espaço de estados comum).
  - *Nó AND*: representa uma decomposição -- resolver o nó exige resolver *todos* os seus sucessores (subproblemas independentes que, juntos, resolvem o problema original).
  Uma *solução* é uma subárvore do grafo AND/OR (não apenas um caminho) que resolve o problema original, respeitando essas regras em cada nó.
]

== Exemplo resolvido

#example(name: "Decompondo um problema em grafo AND/OR", id: "ex-decomposicao-and-or")[
  Resolver "montar um relatório" pode ser decomposto (nó AND) em três subproblemas que devem ser *todos* concluídos: "coletar dados" *e* "gerar gráficos" *e* "escrever texto". Já "coletar dados" pode ter duas alternativas (nó OR): "consultar banco de dados" *ou* "aplicar questionário" -- basta uma delas ser bem-sucedida. O grafo AND/OR completo mistura os dois tipos de nó, e uma solução válida precisa satisfazer cada nó AND integralmente, escolhendo apenas um ramo em cada nó OR.
]

== Atenção -- pegadinhas comuns

#remark(name: "Grafo de espaço de estados comum é um caso particular (só-OR) de grafo AND/OR")[
  Os algoritmos de busca de 22.3--22.5 (BFS, DFS, A\*) operam sobre grafos onde todo nó é efetivamente um nó OR (escolher um único caminho). Grafos AND/OR generalizam isso para problemas com decomposição em subproblemas independentes, exigindo algoritmos adaptados (ex.: AO\*, uma extensão de A\* para grafos AND/OR) -- os fundamentos básicos de grafo (nós, arestas, caminhos), tratados em Teoria dos Grafos (17), continuam válidos, mas a semântica de "solução" muda.
]

#remark(name: "Custo de um nó AND soma os custos dos filhos; custo de um nó OR é o mínimo entre eles")[
  Ao calcular o custo estimado de resolver um nó AND, somam-se os custos de resolver *todos* os filhos (todos são necessários); para um nó OR, toma-se o *mínimo* entre os custos dos filhos (só o melhor caminho é necessário) -- confundir essas duas regras de agregação é o erro mais comum ao avaliar um grafo AND/OR.
]

== Questões estilo POSCOMP

*Questão 1.* Em um grafo AND/OR, resolver um nó AND com três filhos exige:
- a) Resolver apenas um dos três filhos.
- b) Resolver todos os três filhos.
- c) Resolver exatamente dois dos três filhos.
- d) Não resolver nenhum filho.
- e) Escolher aleatoriamente um filho para ignorar.

*Questão 2.* Um grafo de espaço de estados tradicional (como os usados em BFS, DFS e A\*) corresponde, na terminologia de grafos AND/OR, a um grafo:
- a) Composto exclusivamente por nós AND.
- b) Composto exclusivamente por nós OR.
- c) Sem nenhum nó, apenas arestas.
- d) Necessariamente cíclico.
- e) Sem solução possível.

*Questão 3.* Reformular um problema de busca como maximização de uma função objetivo $f$ é útil porque:
- a) Elimina completamente a necessidade de uma heurística.
- b) Unifica a visão de busca local (hill climbing, simulated annealing) como otimização de $f$ sobre o espaço de estados.
- c) Só se aplica a problemas com um único estado possível.
- d) Torna toda busca automaticamente completa e ótima.
- e) É equivalente a um grafo AND/OR.

== Gabarito comentado

1. *(b)* -- definição direta de nó AND: todos os filhos devem ser resolvidos.
2. *(b)* -- grafos de espaço de estados tradicionais só têm decisões do tipo "escolha um caminho", equivalente a nós OR.
3. *(b)* -- é exatamente a reformulação apresentada nesta seção, ligando busca local à otimização de função objetivo.

== Referências

- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 4 (Busca local) e Cap. 4/11 (Grafos AND/OR e planejamento).
- NILSSON, N. *Principles of Artificial Intelligence*. Cap. sobre grafos AND/OR e o algoritmo AO\*.
- LUGER, G. *Inteligência Artificial*. Cap. 4.
