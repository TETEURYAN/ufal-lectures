#import "@preview/mousse-notes:1.1.0": *

= 5.2 --- Linguagem Proposicional e de Primeira Ordem

== Introdução

Antes de discutir verdade ou dedução, é preciso fixar precisamente *o que conta como uma fórmula* -- puramente pela forma (sintaxe), sem ainda atribuir significado. Esta subseção define formalmente as linguagens proposicional e de primeira ordem por meio de definições recursivas, um estilo de definição central em lógica e ciência da computação.

== Definições formais

#definition(name: "Linguagem proposicional: fórmulas bem formadas (fbf)", id: "def-fbf-proposicional")[
  O alfabeto consiste em símbolos proposicionais ($p, q, r, dots$), conectivos ($not, and, or, ->, <->$) e parênteses. O conjunto das *fórmulas bem formadas* é definido recursivamente:
  + Todo símbolo proposicional é uma fbf (caso base).
  + Se $alpha$ é fbf, então $(not alpha)$ é fbf.
  + Se $alpha$ e $beta$ são fbf, então $(alpha and beta)$, $(alpha or beta)$, $(alpha -> beta)$ e $(alpha <-> beta)$ são fbf.
  + Nada mais é fbf (cláusula de fechamento).
]

#definition(name: "Linguagem de primeira ordem: termos e fórmulas", id: "def-linguagem-primeira-ordem")[
  O alfabeto inclui: variáveis ($x,y,z,dots$), constantes, símbolos de função, símbolos de predicado, conectivos, quantificadores ($forall, exists$) e parênteses.
  - *Termos* (recursivo): toda variável e toda constante é termo; se $f$ é símbolo de função $n$-ária e $t_1,dots,t_n$ são termos, então $f(t_1,dots,t_n)$ é termo.
  - *Fórmulas* (recursivo): se $P$ é símbolo de predicado $n$-ário e $t_1,dots,t_n$ são termos, então $P(t_1,dots,t_n)$ é fórmula atômica; fórmulas se combinam pelos mesmos conectivos da lógica proposicional; se $alpha$ é fórmula e $x$ é variável, então $forall x, alpha$ e $exists x, alpha$ são fórmulas.
]

#definition(name: "Variável livre, ligada, e sentença", id: "def-variavel-livre-ligada")[
  Uma ocorrência de variável $x$ está *ligada* se está no escopo de um quantificador $forall x$ ou $exists x$; caso contrário, está *livre*. Uma fórmula sem nenhuma variável livre é uma *sentença* (fórmula fechada) -- só sentenças têm valor-verdade definido independente de uma atribuição externa às variáveis.
]

== Exemplo resolvido

#example(name: "Construindo uma fórmula e identificando variáveis livres/ligadas", id: "ex-formula-livre-ligada")[
  Considere a fórmula $alpha$: $forall x, (P(x) -> exists y, Q(x,y))$.

  - $P(x)$ e $Q(x,y)$ são fórmulas atômicas (aplicações de símbolos de predicado a termos).
  - $exists y, Q(x,y)$ é fórmula (quantificação existencial sobre $Q(x,y)$) -- aqui, $y$ está ligada, mas $x$ ainda está *livre* dentro dessa subfórmula.
  - $(P(x) -> exists y, Q(x,y))$ combina as duas por $->$.
  - $forall x, (P(x) -> exists y, Q(x,y))$ liga também o $x$ restante -- toda ocorrência de variável em $alpha$ está ligada, logo $alpha$ é uma *sentença*.

  Se removêssemos o $forall x$ externo, a fórmula $(P(x) -> exists y, Q(x,y))$ teria $x$ livre, e não seria uma sentença.
]

== Atenção -- pegadinhas comuns

#remark(name: "Definição recursiva de fbf não é a mesma coisa que a semântica da fórmula")[
  As definições desta seção são puramente *sintáticas*: dizem apenas quais sequências de símbolos são gramaticalmente válidas, sem atribuir verdade ou falsidade a elas. Atribuir significado exige uma *estrutura* (interpretação), tratada em 5.4.
]

#remark(name: "Só sentenças (fórmulas fechadas) têm valor-verdade absoluto")[
  Uma fórmula com variável livre, como $P(x)$ sozinha, não é verdadeira nem falsa até que $x$ receba um valor específico (ou seja quantificada) -- confundir fórmula aberta com sentença é um erro comum ao formalizar enunciados.
]

== Questões estilo POSCOMP

*Questão 1.* Segundo a definição recursiva de fbf da lógica proposicional, qual das seguintes NÃO é uma fbf bem formada (assumindo $p, q$ símbolos proposicionais)?
- a) $(p and q)$.
- b) $(not p)$.
- c) $p q and$.
- d) $((p -> q) or (not q))$.
- e) $p$.

*Questão 2.* Na fórmula $exists x, (P(x) and Q(x,y))$, a variável $y$ está:
- a) Ligada pelo quantificador existencial.
- b) Livre.
- c) Ligada por um quantificador universal implícito.
- d) Indefinida sintaticamente.
- e) Necessariamente igual a $x$.

*Questão 3.* Uma fórmula sem nenhuma variável livre é chamada de:
- a) Fórmula atômica.
- b) Termo.
- c) Sentença (fórmula fechada).
- d) Tautologia.
- e) Predicado unário.

== Gabarito comentado

1. *(c)* -- "$p q and$" não segue nenhuma das regras recursivas de formação (conectivo binário exige a forma $(alpha "conectivo" beta)$, com parênteses e ordem corretos).
2. *(b)* -- o quantificador $exists x$ só liga ocorrências de $x$; $y$ permanece livre nessa fórmula.
3. *(c)* -- definição direta de sentença (fórmula fechada) desta seção.

== Referências

- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 2 (Linguagem de primeira ordem).
- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 2 (Sintaxe da lógica de primeira ordem).
