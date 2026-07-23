#import "@preview/mousse-notes:1.1.0": *

= 18.7 --- Mineração de Dados

== Introdução

Mineração de dados é o processo de descobrir padrões úteis e não triviais em grandes volumes de dados. Dentro do processo mais amplo de KDD (Knowledge Discovery in Databases), é a etapa de aplicação de algoritmos. Na POSCOMP, o subtópico mais cobrado é regras de associação (suporte e confiança), geralmente com um pequeno cálculo sobre uma tabela de transações.

== Definições formais

#definition(name: "Processo KDD", id: "def-kdd")[
  Sequência de etapas para extrair conhecimento de dados brutos: seleção, pré-processamento (limpeza), transformação, *mineração de dados* (aplicação dos algoritmos) e interpretação/avaliação dos padrões encontrados.
]

#definition(name: "Regra de associação", id: "def-regra-associacao")[
  Implicação da forma $X arrow.r Y$, onde $X$ e $Y$ são conjuntos disjuntos de itens, indicando que transações contendo $X$ tendem a conter também $Y$.
  - *Suporte* de $X arrow.r Y$: proporção de transações que contêm $X union Y$ em relação ao total de transações.
  - *Confiança* de $X arrow.r Y$: proporção de transações que contêm $Y$ dentre as que já contêm $X$ (isto é, suporte de $X union Y$ dividido pelo suporte de $X$).
]

#definition(name: "Classificação vs. Clusterização", id: "def-classificacao-clusterizacao")[
  *Classificação* é aprendizado *supervisionado*: atribui um rótulo pré-definido a um novo registro, com base em um modelo treinado sobre exemplos rotulados. *Clusterização (agrupamento)* é aprendizado *não supervisionado*: agrupa registros por similaridade, sem rótulos pré-existentes.
]

== Exemplo resolvido

#example(name: "Cálculo de suporte e confiança", id: "ex-suporte-confianca")[
  Considere 5 transações de um mercado:

  #table(
    columns: 2,
    [*Transação*], [*Itens*],
    [T1], [pão, leite, manteiga],
    [T2], [pão, manteiga],
    [T3], [leite, café],
    [T4], [pão, leite, manteiga, café],
    [T5], [pão, leite],
  )

  Para a regra `pão -> manteiga`:
  - Transações com `{pão, manteiga}`: T1, T2, T4 -- 3 de 5. *Suporte* = 3/5 = 60%.
  - Transações com `pão`: T1, T2, T4, T5 -- 4 de 5. *Confiança* = (3/5) / (4/5) = 3/4 = 75%.

  Ou seja: em 60% das compras aparecem pão e manteiga juntos; e, entre quem compra pão, 75% também compra manteiga.
]

== Atenção -- pegadinhas comuns

#remark(name: "Suporte alto não implica confiança alta, e vice-versa")[
  Suporte mede a frequência *geral* da combinação; confiança mede a frequência *condicional* dado o antecedente. Uma regra pode ter confiança de 100% (sempre que aparece $X$, aparece $Y$) mas suporte baixíssimo, se $X$ for raro.
]

#remark(name: "Correlação não implica causalidade")[
  Uma regra de associação com suporte e confiança altos indica *correlação* estatística nos dados históricos, não uma relação de causa e efeito -- é um erro comum de interpretação em provas e na prática.
]

#remark(name: "Classificação exige dados rotulados")[
  Se o enunciado menciona "prever a categoria de um novo cliente com base em exemplos já rotulados", é classificação (supervisionado). Se menciona "agrupar clientes por perfil de compra sem rótulos prévios", é clusterização (não supervisionado).
]

== Questões estilo POSCOMP

*Questão 1.* Considerando as transações do exemplo desta seção, o suporte da regra `leite -> pão` é:
- a) 3/5.
- b) 3/4.
- c) 4/5.
- d) 1/5.
- e) 2/5.

*Questão 2.* A etapa do processo KDD em que algoritmos são de fato aplicados para descobrir padrões é:
- a) Seleção.
- b) Pré-processamento.
- c) Mineração de dados.
- d) Transformação.
- e) Interpretação.

*Questão 3.* Uma tarefa de aprendizado que agrupa clientes por similaridade de comportamento, sem que existam rótulos de categoria pré-definidos, é um exemplo de:
- a) Classificação.
- b) Regressão supervisionada.
- c) Clusterização.
- d) Regra de associação.
- e) Árvore de decisão supervisionada.

== Gabarito comentado

1. *(a)* -- transações com `{leite, pão}`: T1, T4, T5 -- 3 de 5, suporte = 3/5 (o mesmo conjunto de itens de `pão -> manteiga` não se aplica aqui; note que suporte de $X arrow.r Y$ é simétrico em relação ao conjunto de itens, embora confiança não seja).
2. *(c)* -- por definição, mineração de dados é a etapa de aplicação dos algoritmos dentro do processo KDD mais amplo.
3. *(c)* -- agrupamento sem rótulos pré-existentes é a definição direta de clusterização (não supervisionado).

== Referências

- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*. Cap. 28 (Mineração de dados).
- HAN, J.; KAMBER, M.; PEI, J. *Data Mining: Concepts and Techniques*. Cap. 6 (Regras de associação).
