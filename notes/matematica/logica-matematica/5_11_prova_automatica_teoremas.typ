#import "@preview/mousse-notes:1.1.0": *

= 5.11 --- Prova Automática de Teoremas

== Introdução

Se a validade em lógica de primeira ordem é apenas semidecidível (5.10), ainda assim é possível construir algoritmos práticos que buscam provas automaticamente -- é o campo da prova automática de teoremas, com o *princípio da resolução* como sua técnica mais influente, base também da Programação em Lógica (Prolog).

== Definições formais

#definition(name: "Forma clausal (FNC)", id: "def-forma-clausal")[
  Uma *cláusula* é uma disjunção de literais (uma proposição ou sua negação). Toda fórmula proposicional pode ser convertida para uma conjunção de cláusulas -- a *Forma Normal Conjuntiva (FNC)* -- por transformações sintáticas equivalentes. A prova automática por resolução trabalha exclusivamente sobre conjuntos de cláusulas nessa forma.
]

#definition(name: "Princípio da Resolução", id: "def-principio-resolucao")[
  Dadas duas cláusulas que contêm um literal complementar ($alpha or C$ e $not alpha or D$, onde $C, D$ são disjunções do restante dos literais), a regra de resolução deriva a *cláusula resolvente* $C or D$, eliminando o par complementar $alpha$/$not alpha$. Uma *refutação por resolução* mostra que um conjunto de cláusulas é insatisfazível derivando repetidamente resolventes até obter a *cláusula vazia* ($bot$, uma contradição).
]

#definition(name: "Unificação (para primeira ordem)", id: "def-unificacao")[
  Em lógica de primeira ordem, dois literais só podem ser resolvidos se, após uma *substituição* apropriada de variáveis por termos, se tornarem sintaticamente idênticos (a menos do sinal de negação). *Unificação* é o processo algorítmico de encontrar essa substituição (o *unificador mais geral*, quando existe) -- é o mecanismo que generaliza a resolução proposicional para primeira ordem, e é também o mecanismo central por trás da resolução de consultas em Prolog (programação em lógica).
]

== Exemplo resolvido

#example(name: "Refutação por resolução proposicional", id: "ex-refutacao-resolucao")[
  Mostre que ${p or q, not q or r, not p, not r}$ é insatisfazível:

  #table(
    columns: 3,
    [*Passo*], [*Cláusula resolvente*], [*Resolvendo*],
    [1], [$p or q$], [(premissa)],
    [2], [$not q or r$], [(premissa)],
    [3], [$not p$], [(premissa)],
    [4], [$not r$], [(premissa)],
    [5], [$q$], [resolução de (1) e (3), eliminando $p$/$not p$],
    [6], [$r$], [resolução de (5) e (2), eliminando $q$/$not q$],
    [7], [$bot$ (cláusula vazia)], [resolução de (6) e (4), eliminando $r$/$not r$],
  )

  Como a cláusula vazia $bot$ foi derivada, o conjunto original de cláusulas é *insatisfazível* -- não existe atribuição de valores-verdade que torne as quatro premissas simultaneamente verdadeiras.
]

== Atenção -- pegadinhas comuns

#remark(name: "Resolução prova insatisfazibilidade, não valida diretamente")[
  A resolução é tipicamente usada como um procedimento de *refutação*: para provar que $Gamma tack.r phi$, nega-se $phi$, junta-se ${not phi}$ a $Gamma$ e mostra-se, por resolução, que esse conjunto é insatisfazível (deriva $bot$) -- e não que se deriva $phi$ diretamente "para frente".
]

#remark(name: "Unificação e Prolog")[
  A ligação entre unificação/resolução e Programação em Lógica (tratada com mais profundidade em Inteligência Artificial) é direta: um interpretador Prolog resolve uma consulta tentando unificá-la com a cabeça de cláusulas do programa, aplicando resolução SLD repetidamente -- a mesma ideia central desta seção, aplicada como mecanismo de execução de um paradigma de programação.
]

== Questões estilo POSCOMP

*Questão 1.* A regra de resolução, aplicada às cláusulas $p or q$ e $not p or r$, produz a cláusula resolvente:
- a) $p or r$.
- b) $q or r$.
- c) $not q or not r$.
- d) $p and r$.
- e) $bot$.

*Questão 2.* A obtenção da cláusula vazia ($bot$) ao final de uma sequência de resoluções indica que:
- a) O conjunto original de cláusulas é satisfazível.
- b) O conjunto original de cláusulas é insatisfazível.
- c) A fórmula original é uma tautologia diretamente, sem necessidade de refutação.
- d) O processo de resolução falhou.
- e) É necessário aplicar unificação adicionalmente, mesmo em lógica proposicional.

*Questão 3.* A unificação é necessária especificamente na resolução em lógica de primeira ordem porque:
- a) Cláusulas proposicionais nunca podem ser resolvidas.
- b) É preciso encontrar substituições de variáveis por termos que tornem dois literais sintaticamente idênticos (a menos da negação) antes de resolver.
- c) Substitui completamente a necessidade da regra de resolução.
- d) Só se aplica a fórmulas sem quantificadores.
- e) É equivalente ao princípio da compacidade.

== Gabarito comentado

1. *(b)* -- eliminando o par complementar $p$/$not p$, resta $q or r$.
2. *(b)* -- a cláusula vazia representa uma contradição direta, confirmando insatisfazibilidade do conjunto original, como no exemplo desta seção.
3. *(b)* -- é a definição direta de unificação e seu papel na resolução de primeira ordem.

== Referências

- ROBINSON, J. A. *A Machine-Oriented Logic Based on the Resolution Principle* (1965) -- artigo original do princípio da resolução.
- RUSSELL, S.; NORVIG, P. *Inteligência Artificial*. Cap. sobre lógica de primeira ordem e inferência (resolução e unificação, conectando com Programação em Lógica).
- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 2 (Resolução).
