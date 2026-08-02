#import "@preview/mousse-notes:1.1.0": *

= 22.11 --- Formalismos para a Representação de Conhecimento Incerto

== Introdução

Muito conhecimento do mundo real é incerto: sintomas não garantem diagnósticos, sensores têm ruído, regras têm exceções (22.10). Esta subseção apresenta formalismos para representar e propagar essa incerteza -- base necessária para entender a Regra de Bayes (22.12) e a lógica fuzzy (22.13).

== Definições formais

#definition(name: "Fatores de certeza", id: "def-fatores-certeza")[
  Abordagem heurística (popularizada pelo sistema especialista MYCIN, 22.17) que atribui a cada regra e fato um *fator de certeza* (CF) em um intervalo (ex.: $[-1,1]$), combinando esses fatores por fórmulas ad-hoc ao encadear regras -- simples de implementar, mas sem a fundamentação probabilística rigorosa da abordagem bayesiana.
]

#definition(name: "Rede Bayesiana", id: "def-rede-bayesiana")[
  Grafo *acíclico dirigido* (DAG) cujos nós são variáveis aleatórias e cujas arestas representam dependência probabilística direta entre elas. Cada nó tem uma *tabela de probabilidade condicional* (CPT) que especifica $P("nó" | "pais do nó")$. A ausência de uma aresta entre dois nós codifica uma suposição de independência (condicional) -- permitindo representar distribuições conjuntas complexas de forma compacta, evitando enumerar exponencialmente todas as combinações.
]

== Exemplo resolvido

#example(name: "Estrutura de uma rede Bayesiana simples", id: "ex-estrutura-rede-bayesiana")[
  #figure(
    image("figures/bayesian-network.svg", width: 55%),
    caption: [Estrutura de uma rede Bayesiana: nós são variáveis aleatórias, arestas indicam dependência probabilística direta, e cada nó tem uma tabela de probabilidade condicional dada seus pais no grafo. Fonte: Wikimedia Commons, domínio público.],
  )
  Uma rede diagnosticando "gripe" poderia ter nós `Gripe` (causa), com arestas para `Febre` e `Tosse` (efeitos observáveis) -- codificando que febre e tosse são condicionalmente independentes *dado* que se sabe se há gripe ou não, mesmo sendo correlacionadas na população geral (ambas causadas pela gripe).
]

= 22.12 --- A Regra de Bayes

== Introdução

A Regra de Bayes é o mecanismo formal para *atualizar* uma crença (probabilidade) à luz de nova evidência -- o núcleo matemático por trás de redes Bayesianas, classificadores probabilísticos (ex.: filtros de spam) e diagnóstico automatizado.

== Definições formais

#definition(name: "Regra de Bayes", id: "def-regra-bayes")[
  Para hipótese $H$ e evidência $E$, com $P(E) > 0$:
  $ P(H|E) = (P(E|H) dot P(H))/P(E) $
  onde $P(H)$ é a *probabilidade a priori* (antes de observar a evidência), $P(E|H)$ é a *verossimilhança* (probabilidade de observar a evidência, dado que a hipótese é verdadeira), e $P(H|E)$ é a *probabilidade a posteriori* (crença atualizada, após observar a evidência).
]

== Exemplo resolvido

#example(name: "Classificador bayesiano simples para spam", id: "ex-classificador-bayesiano-spam")[
  Um filtro de spam sabe que 40% dos e-mails recebidos são spam ($P("spam")=0.4$). A palavra "promoção" aparece em 70% dos spams ($P("promoção"|"spam")=0.7$) e em apenas 5% dos e-mails legítimos ($P("promoção"|not "spam")=0.05$). Um e-mail com a palavra "promoção" chega -- qual a probabilidade de ser spam?

  Probabilidade total de conter "promoção": $P("promoção") = (0.7)(0.4) + (0.05)(0.6) = 0.28 + 0.03 = 0.31$.

  $ P("spam" | "promoção") = (0.7 times 0.4)/0.31 = 0.28/0.31 approx 0.903 $

  Ou seja, ao observar a palavra "promoção", a crença de que o e-mail é spam sobe de 40% (a priori) para aproximadamente 90% (a posteriori) -- exatamente o mecanismo usado (de forma mais elaborada, combinando várias palavras sob suposição de independência) em classificadores *Naive Bayes* reais.
]

== Atenção -- pegadinhas comuns

#remark(name: "Não confundir P(H|E) com P(E|H) -- mesma pegadinha de Probabilidade e Estatística")[
  $P("spam"|"promoção")$ (o que queremos) é diferente de $P("promoção"|"spam")$ (o dado que já temos) -- a Regra de Bayes existe precisamente para inverter uma na outra. Essa confusão ("falácia da probabilidade condicional invertida") é a pegadinha mais recorrente envolvendo Bayes em qualquer disciplina que o cubra.
]

#remark(name: "Naive Bayes assume independência condicional entre evidências")[
  Classificadores Naive Bayes (usados em PLN, 22.18, e aprendizado de máquina, 22.14) aplicam a Regra de Bayes assumindo (ingenuamente, daí o nome) que múltiplas evidências são condicionalmente independentes dado a hipótese -- uma simplificação que raramente é 100% verdadeira, mas que funciona surpreendentemente bem na prática.
]

== Questões estilo POSCOMP

*Questão 1.* Em uma rede Bayesiana, a ausência de uma aresta direta entre dois nós indica:
- a) Que as duas variáveis são idênticas.
- b) Uma suposição de independência (condicional) entre elas.
- c) Um erro de modelagem.
- d) Que uma das variáveis é sempre falsa.
- e) Que a rede é necessariamente cíclica.

*Questão 2.* Na Regra de Bayes $P(H|E) = P(E|H)P(H)\/P(E)$, o termo $P(H)$ é chamado de:
- a) Verossimilhança.
- b) Probabilidade a posteriori.
- c) Probabilidade a priori.
- d) Probabilidade total.
- e) Fator de certeza.

*Questão 3.* Considerando o exemplo do filtro de spam desta seção, a probabilidade a posteriori de um e-mail com a palavra "promoção" ser spam é:
- a) Menor que a probabilidade a priori de 40%.
- b) Igual à probabilidade a priori de 40%.
- c) Maior que a probabilidade a priori, subindo para aproximadamente 90%.
- d) Exatamente 70%, igual à verossimilhança.
- e) Impossível de calcular sem mais informações.

== Gabarito comentado

1. *(b)* -- ausência de aresta em rede Bayesiana codifica independência (condicional) entre as variáveis.
2. *(c)* -- $P(H)$, a crença antes de observar a evidência, é a probabilidade a priori.
3. *(c)* -- conforme calculado no exemplo desta seção, a probabilidade sobe de 40% para ~90.3% após observar a evidência.

== Referências

- PEARL, J. *Probabilistic Reasoning in Intelligent Systems* (1988) -- referência clássica de redes Bayesianas.
- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 13--14 (Incerteza e raciocínio probabilístico).
- Stanford CS221 (stanford-cs221.github.io) -- módulo de modelos gráficos (factor graphs, Bayesian networks).
- Probabilidade e Estatística (7.6, Probabilidades em Espaços Amostrais Discretos) -- base formal da Regra de Bayes usada nesta seção.
