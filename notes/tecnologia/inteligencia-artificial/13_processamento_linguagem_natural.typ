#import "@preview/mousse-notes:1.1.0": *

= 22.18 --- Processamento de Linguagem Natural

== Introdução

Processamento de Linguagem Natural (PLN) aplica técnicas de IA para que máquinas processem linguagem humana -- naturalmente ambígua e irregular, ao contrário das linguagens formais de programação (Linguagens Formais, Autômatos e Computabilidade, 13). A POSCOMP cobra principalmente os níveis de análise e os tipos de ambiguidade.

== Definições formais

#definition(name: "Níveis de análise em PLN", id: "def-niveis-analise-pln")[
  - *Análise léxica*: identifica palavras (tokens) e suas categorias gramaticais (substantivo, verbo...).
  - *Análise sintática (parsing)*: determina a estrutura gramatical da sentença (ex.: árvore sintática), usando uma gramática (relacionada às gramáticas formais de 13).
  - *Análise semântica*: extrai o significado literal da sentença, a partir de sua estrutura sintática.
  - *Análise pragmática*: interpreta o significado *em contexto* -- intenção do falante, referências que dependem do diálogo/situação, o que a sentença literalmente diz vs. o que ela realmente comunica.
]

#definition(name: "Ambiguidade em linguagem natural", id: "def-ambiguidade-pln")[
  - *Lexical*: uma palavra tem múltiplos significados possíveis (ex.: "manga" -- fruta ou parte de roupa).
  - *Sintática (estrutural)*: uma sentença admite mais de uma árvore de análise gramatical válida.
  - *Semântica*: mesmo com uma única estrutura sintática, o significado pode ser ambíguo (ex.: escopo de quantificadores).
  - *Pragmática*: o significado pretendido depende de contexto não presente na sentença isolada (ex.: ironia, referência a algo já dito).
]

== Exemplo resolvido

#example(name: "Ambiguidade sintática clássica", id: "ex-ambiguidade-sintatica")[
  A sentença "Vi o homem com o telescópio" é sintaticamente ambígua: "com o telescópio" pode modificar "vi" (eu usei um telescópio para ver o homem) ou "o homem" (o homem que eu vi estava carregando um telescópio) -- duas árvores sintáticas diferentes, ambas gramaticalmente válidas, para a mesma sequência de palavras. Resolver qual interpretação é a pretendida frequentemente exige informação *pragmática* (contexto), não apenas sintática.
]

== Atenção -- pegadinhas comuns

#remark(name: "PLN moderno combina análise linguística com aprendizado estatístico")[
  Embora os quatro níveis de análise (léxico, sintático, semântico, pragmático) sejam a base conceitual clássica, sistemas modernos de PLN frequentemente usam classificadores estatísticos (ex.: Naive Bayes, 22.11/22.12, ou redes neurais, 22.16) treinados sobre grandes volumes de texto, em vez de regras gramaticais escritas manualmente -- os dois enfoques (baseado em regras e baseado em dados) não são mutuamente exclusivos.
]

#remark(name: "Análise sintaticamente correta não implica significado correto extraído")[
  Uma sentença pode ser sintaticamente bem formada e ainda gerar erro ou ambiguidade nos níveis semântico ou pragmático -- os quatro níveis são sequenciais em dependência (sintaxe depende de léxico, semântica depende de sintaxe), mas cada um pode falhar independentemente, e a prova gosta de testar em qual nível especificamente um erro/ambiguidade ocorre.
]

== Questões estilo POSCOMP

*Questão 1.* A frase "Vi o homem com o telescópio", que admite duas árvores de análise gramatical distintas, ilustra um caso de ambiguidade:
- a) Lexical.
- b) Sintática.
- c) Pragmática apenas.
- d) Fonética.
- e) Não há ambiguidade nessa frase.

*Questão 2.* O nível de análise em PLN responsável por identificar palavras e suas categorias gramaticais é o:
- a) Nível pragmático.
- b) Nível semântico.
- c) Nível léxico.
- d) Nível sintático.
- e) Nível fonológico.

*Questão 3.* Interpretar a intenção de um falante, considerando o contexto do diálogo além do significado literal das palavras, é tarefa do nível de análise:
- a) Léxico.
- b) Sintático.
- c) Semântico.
- d) Pragmático.
- e) Nenhum dos níveis trata disso.

== Gabarito comentado

1. *(b)* -- duas estruturas gramaticais distintas para a mesma sentença caracterizam ambiguidade sintática.
2. *(c)* -- identificação de palavras e categorias gramaticais é a definição de análise léxica.
3. *(d)* -- interpretação dependente de contexto e intenção é, por definição, análise pragmática.

== Referências

- JURAFSKY, D.; MARTIN, J. *Speech and Language Processing*. Cap. 1--2 (Níveis de análise linguística).
- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 23--24 (Processamento de linguagem natural).
- Linguagens Formais, Autômatos e Computabilidade (13) -- fundamentos de gramáticas formais relacionados à análise sintática.
