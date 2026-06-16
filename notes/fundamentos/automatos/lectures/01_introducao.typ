#import "@preview/mousse-notes:1.1.0": *

= Introdução

== O que são Linguagens Formais?

Imagine que você quer ensinar um robô a entender comandos. Você precisa definir _exatamente_ quais sequências de palavras ele pode aceitar — sem ambiguidade. Esse é, em essência, o problema que as *linguagens formais* resolvem.

Uma linguagem formal é um conjunto de cadeias (sequências de símbolos) construídas a partir de um alfabeto definido, seguindo regras precisas. Ao contrário das linguagens naturais (como o português), as linguagens formais não admitem ambiguidade: cada sentença ou pertence à linguagem, ou não pertence.

#definition[
  Uma *linguagem formal* é um conjunto de palavras (cadeias de símbolos) definido sobre um alfabeto finito, especificado por meio de regras matemáticas precisas.
]

== Motivação Histórica

A teoria das linguagens formais tem raízes na matemática e na lógica do século XX. Os principais marcos históricos são:

- *Anos 1930 — Alan Turing e Alonzo Church*: investigaram o que pode ou não ser computado, formalizando os limites da computação.
- *Anos 1950 — Noam Chomsky*: linguista que criou a _Hierarquia de Chomsky_, classificando linguagens em quatro tipos (regulares, livres de contexto, sensíveis ao contexto e recursivamente enumeráveis).
- *Anos 1950–60 — Kleene, Rabin e Scott*: desenvolveram os autômatos finitos e as expressões regulares como ferramentas matemáticas para descrever linguagens regulares.
- *Anos 1960–70 — Knuth e outros*: aplicaram a teoria às linguagens de programação e compiladores.

Essa teoria, aparentemente abstrata, tornou-se a base de praticamente toda a computação moderna.

== Aplicações Práticas

#definition[
  *Por que estudar linguagens formais?*

  Porque elas fundamentam ferramentas que você usa todo dia como programador.
]

As principais áreas de aplicação são:

/ *Compiladores e interpretadores*: Toda linguagem de programação (Python, Java, C) é uma linguagem formal. O compilador usa autômatos e gramáticas para analisar o código-fonte.

/ *Editores de texto e buscas*: Ferramentas como `grep`, `sed`, e as funções de busca em editores usam _expressões regulares_ — um dos tópicos centrais desta disciplina.

/ *Processamento de linguagem natural (PLN)*: Chatbots, tradutores automáticos e assistentes de voz utilizam gramáticas formais para analisar frases.

/ *Verificação de protocolos*: Sistemas de comunicação e segurança são modelados por autômatos para verificar seu comportamento.

/ *Bioinformática*: A análise de sequências de DNA é modelada como um problema de linguagens formais.
