#import "@preview/mousse-notes:1.1.0": *

= 22.16 --- Árvores de Decisão, Redes Neurais e Algoritmos Genéticos

== Introdução

Três das técnicas mais influentes de aprendizado indutivo (22.15) e otimização em IA: árvores de decisão (interpretáveis, baseadas em regras), redes neurais (inspiradas no cérebro, base do deep learning), e algoritmos genéticos (inspirados na evolução, para busca/otimização). Cada uma aparece com frequência em questões objetivas da POSCOMP.

== Árvores de Decisão

#definition(name: "Árvore de decisão", id: "def-arvore-decisao")[
  Estrutura em árvore em que cada nó interno testa um atributo do exemplo, cada ramo corresponde a um valor (ou faixa de valores) desse atributo, e cada folha atribui uma classificação. Algoritmos clássicos de construção (ex.: *ID3*) escolhem, em cada nó, o atributo que mais reduz a *entropia* (incerteza) do conjunto de exemplos restante -- construindo a árvore de forma gulosa, do topo para as folhas.
]

#figure(
  image("figures/decision-tree.svg", width: 45%),
  caption: [Árvore de decisão binária simples: cada nó interno faz uma pergunta, cada folha é uma classificação. Fonte: Wikimedia Commons, domínio público (Eviatar Bach).],
)

== Redes Neurais

#definition(name: "Rede Neural Artificial", id: "def-rede-neural")[
  Modelo computacional inspirado em neurônios biológicos: unidades (*neurônios artificiais*) organizadas em *camadas* (entrada, uma ou mais camadas ocultas, saída), conectadas por pesos ajustáveis. Cada neurônio calcula uma soma ponderada de suas entradas e aplica uma *função de ativação* (não linear, ex.: sigmoide, ReLU) para produzir sua saída. O treinamento (ex.: via *retropropagação*, backpropagation) ajusta os pesos para minimizar o erro entre a saída da rede e o valor esperado.
]

#figure(
  image("figures/neural-network.svg", width: 45%),
  caption: [Rede neural com uma camada oculta: neurônios de entrada (esquerda), camada oculta (meio) e saída (direita), conectados por pesos ajustáveis. Fonte: Wikimedia Commons, CC BY-SA 3.0 (Cburnett).],
)

== Algoritmos Genéticos

#definition(name: "Algoritmo Genético", id: "def-algoritmo-genetico")[
  Método de busca/otimização inspirado na evolução biológica, operando sobre uma *população* de soluções candidatas (cromossomos), avaliadas por uma *função de aptidão* (fitness). A cada geração: *seleção* (favorece indivíduos mais aptos para reprodução), *cruzamento/crossover* (combina partes de dois "pais" para gerar descendentes) e *mutação* (altera aleatoriamente partes de um descendente, mantendo diversidade) produzem a próxima geração, repetindo até convergência ou critério de parada.
]

== Exemplo resolvido

#example(name: "Uma geração de algoritmo genético", id: "ex-geracao-algoritmo-genetico")[
  População de 4 cromossomos binários (representando soluções candidatas), com aptidão = número de bits 1:

  #table(
    columns: 3,
    [*Cromossomo*], [*Aptidão*], [*Selecionado para reprodução?*],
    [`1101`], [3], [Sim (alta aptidão)],
    [`1001`], [2], [Sim],
    [`0100`], [1], [Não (baixa aptidão)],
    [`0000`], [0], [Não],
  )

  Cruzamento entre `1101` e `1001` (ponto de corte após o 2º bit): cada pai é dividido em `11|01` e `10|01`; trocando as caudas após o corte, os descendentes são `11`+`01`(do outro pai)$=$`1101` e `10`+`01`(do outro pai)$=$`1001` -- nesse par específico o resultado coincide com os pais, mas em geral o crossover produz combinações novas. Em seguida, uma pequena chance de mutação altera aleatoriamente um bit de um descendente (ex.: `1100 -> 1110`). A população evolui, geração a geração, em direção a cromossomos de aptidão mais alta.
]

== Atenção -- pegadinhas comuns

#remark(name: "Overfitting é risco comum a árvores de decisão e redes neurais")[
  Uma árvore de decisão muito profunda (ou uma rede neural muito grande, treinada por muitas épocas sem regularização) pode se ajustar excessivamente aos exemplos de treinamento, perdendo capacidade de generalizar (22.15) -- por isso técnicas de *poda* (pruning) em árvores e *regularização* (ou parada antecipada) em redes neurais são usadas na prática.
]

#remark(name: "Algoritmo genético não garante o ótimo global, mas explora o espaço de forma paralela")[
  Como hill climbing e simulated annealing (22.5), algoritmos genéticos são heurísticas de busca sem garantia de otimalidade -- mas, ao manter uma *população* inteira de soluções em paralelo (em vez de um único estado), exploram o espaço de busca de forma mais ampla, reduzindo (sem eliminar) o risco de ficar preso em um ótimo local.
]

== Questões estilo POSCOMP

*Questão 1.* O algoritmo clássico de construção de árvores de decisão que escolhe, em cada nó, o atributo que mais reduz a entropia do conjunto de exemplos é conhecido como:
- a) A\*.
- b) ID3.
- c) Backpropagation.
- d) Simulated Annealing.
- e) Naive Bayes.

*Questão 2.* Em uma rede neural artificial, a função responsável por introduzir não-linearidade na saída de um neurônio é chamada de:
- a) Função de aptidão.
- b) Função de ativação.
- c) Função heurística.
- d) Função de pertinência.
- e) Função objetivo de busca.

*Questão 3.* Em um algoritmo genético, o operador que combina partes de dois indivíduos "pais" para gerar um descendente é o:
- a) Seleção.
- b) Mutação.
- c) Cruzamento (crossover).
- d) Poda.
- e) Retropropagação.

*Questão 4.* Uma árvore de decisão excessivamente profunda, ajustada perfeitamente aos exemplos de treinamento mas com desempenho ruim em dados novos, está sofrendo de:
- a) Underfitting.
- b) Overfitting.
- c) Viés indutivo insuficiente.
- d) Falha de convergência do algoritmo genético.
- e) Erro de retropropagação.

== Gabarito comentado

1. *(b)* -- ID3 é o algoritmo clássico baseado em redução de entropia para construção de árvores de decisão.
2. *(b)* -- função de ativação introduz não-linearidade, essencial para redes neurais aprenderem padrões complexos.
3. *(c)* -- cruzamento/crossover é definido exatamente como a combinação de material genético de dois pais.
4. *(b)* -- ajuste excessivo aos dados de treino, com perda de generalização, é a definição de overfitting.

== Referências

- QUINLAN, J. R. *Induction of Decision Trees* (1986) -- artigo original do ID3.
- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 18--21 (Árvores de decisão, redes neurais, algoritmos genéticos).
- HOLLAND, J. *Adaptation in Natural and Artificial Systems* (1975) -- referência original dos algoritmos genéticos.
