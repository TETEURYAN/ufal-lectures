#import "@preview/mousse-notes:1.1.0": *

= 5.9 --- Löwenheim-Skolem

== Introdução

Se corretude e completude conectam sintaxe e semântica, o Teorema de Löwenheim-Skolem revela uma limitação surpreendente da própria semântica de primeira ordem: nenhuma teoria de primeira ordem (em linguagem enumerável) consegue fixar univocamente a cardinalidade de seus modelos infinitos.

== Definições formais

#definition(name: "Teorema de Löwenheim-Skolem (descendente e ascendente)", id: "def-lowenheim-skolem")[
  Seja $T$ uma teoria de primeira ordem em uma linguagem *enumerável* (conjunto contável de símbolos):
  - *Versão descendente (Löwenheim-Skolem "para baixo")*: se $T$ tem um modelo infinito, então $T$ tem um modelo *enumerável* (contável).
  - *Versão ascendente (Löwenheim-Skolem "para cima")*: se $T$ tem um modelo infinito, então $T$ tem modelos de *toda* cardinalidade infinita maior ou igual à da linguagem.
]

== Exemplo resolvido

#example(name: "Um modelo contável para uma teoria sobre os reais", id: "ex-modelo-contavel-reais")[
  Considere a teoria de primeira ordem dos corpos ordenados (na linguagem enumerável com $+, times, <, 0, 1$), que tem os *números reais* $RR$ (não enumeráveis) como modelo natural. Pela versão descendente de Löwenheim-Skolem, essa mesma teoria também tem um modelo *enumerável* -- uma estrutura contável que satisfaz exatamente as mesmas sentenças de primeira ordem que $RR$ satisfaz, mesmo $RR$ sendo não enumerável. Esse resultado, aplicado à própria teoria dos conjuntos (que descreve conjuntos não enumeráveis), é conhecido como *Paradoxo de Skolem*: não é uma contradição lógica real, mas uma lembrança de que "enumerável" e "não enumerável" são noções relativas ao modelo, não capturáveis de forma absoluta por sentenças de primeira ordem.
]

== Atenção -- pegadinhas comuns

#remark(name: "Löwenheim-Skolem não é sobre um único modelo específico")[
  O teorema não diz que *um dado* modelo pode ser "encolhido" ou "esticado" preservando sua estrutura interna -- ele garante a *existência* de outros modelos (possivelmente muito diferentes internamente) que satisfazem exatamente as mesmas sentenças de primeira ordem.
]

#remark(name: "A limitação é específica da lógica de primeira ordem")[
  A cardinalidade de um modelo infinito não pode ser fixada por nenhum conjunto de sentenças de primeira ordem em linguagem enumerável -- essa é uma limitação expressiva real da lógica de primeira ordem (em contraste com lógica de segunda ordem, que consegue, por exemplo, caracterizar categoricamente os números naturais até isomorfismo, algo impossível em primeira ordem).
]

== Questões estilo POSCOMP

*Questão 1.* A versão descendente do Teorema de Löwenheim-Skolem garante que:
- a) Toda teoria de primeira ordem tem exatamente um modelo.
- b) Se uma teoria de primeira ordem em linguagem enumerável tem um modelo infinito, ela tem também um modelo enumerável.
- c) Toda teoria de primeira ordem é decidível.
- d) Modelos finitos sempre existem para qualquer teoria consistente.
- e) A cardinalidade do modelo é sempre igual à da linguagem.

*Questão 2.* O chamado "Paradoxo de Skolem" ilustra que:
- a) A teoria dos conjuntos é inconsistente.
- b) Uma teoria de primeira ordem que descreve conjuntos não enumeráveis pode, ainda assim, ter um modelo enumerável.
- c) Löwenheim-Skolem só se aplica a teorias finitas.
- d) Todo modelo de uma teoria de conjuntos é necessariamente não enumerável.
- e) É uma contradição lógica genuína, refutando a teoria dos conjuntos.

*Questão 3.* Uma consequência conceitual do Teorema de Löwenheim-Skolem é que:
- a) Lógica de primeira ordem consegue fixar univocamente a cardinalidade de modelos infinitos.
- b) Nenhuma teoria de primeira ordem em linguagem enumerável consegue determinar de forma única a cardinalidade de seus modelos infinitos.
- c) Todas as teorias de primeira ordem têm um único modelo, a menos de isomorfismo.
- d) O teorema só vale para lógica proposicional.
- e) Modelos infinitos nunca satisfazem a mesma teoria que modelos finitos.

== Gabarito comentado

1. *(b)* -- enunciado direto da versão descendente do teorema.
2. *(b)* -- é exatamente a definição do Paradoxo de Skolem apresentada nesta seção; não é uma contradição real.
3. *(b)* -- consequência conceitual central do teorema, conforme discutido nesta seção.

== Referências

- LÖWENHEIM, L. *Über Möglichkeiten im Relativkalkül* (1915); SKOLEM, T. (1920, 1922) -- artigos originais.
- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 2 (Löwenheim-Skolem).
- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 2.
