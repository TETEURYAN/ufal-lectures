#import "@preview/mousse-notes:1.1.0": *

= 7.1 --- Eventos

== Introdução

Todo estudo de probabilidade parte de um experimento e do conjunto de seus resultados possíveis. Um *evento* é qualquer subconjunto desse conjunto de resultados, e as operações de conjuntos (união, interseção, complementar) entre eventos são a base de praticamente toda questão de probabilidade da POSCOMP -- inclusive quando o enunciado não menciona "conjunto" explicitamente.

== Definições formais

#definition(name: "Evento", id: "def-evento")[
  Dado um espaço amostral $Omega$ (o conjunto de todos os resultados possíveis de um experimento aleatório -- formalizado em 7.5), um *evento* $A$ é qualquer subconjunto de $Omega$, isto é, $A subset.eq Omega$.
  - *Evento simples (elementar)*: contém exatamente um resultado do espaço amostral.
  - *Evento composto*: contém dois ou mais resultados.
  - *Evento certo*: $A = Omega$ (ocorre sempre). *Evento impossível*: $A = emptyset$ (nunca ocorre).
]

#definition(name: "Operações entre eventos", id: "def-operacoes-eventos")[
  Sejam $A, B subset.eq Omega$:
  - *Complementar* $A^c$: ocorre quando $A$ *não* ocorre ($A^c = Omega - A$).
  - *União* $A union B$: ocorre quando $A$ ou $B$ (ou ambos) ocorre.
  - *Interseção* $A inter B$: ocorre quando $A$ *e* $B$ ocorrem simultaneamente.
  - *Diferença* $A - B$: ocorre quando $A$ ocorre e $B$ não ocorre ($A - B = A inter B^c$).
  - *Eventos mutuamente exclusivos (disjuntos)*: $A inter B = emptyset$ -- não podem ocorrer juntos no mesmo resultado do experimento.
  - *Eventos exaustivos*: $A union B = Omega$ -- cobrem todos os resultados possíveis.
]

== Propriedade relevante

#theorem(name: "Leis de De Morgan para eventos", id: "thm-de-morgan-eventos")[
  Para quaisquer eventos $A, B subset.eq Omega$:
  $ (A union B)^c = A^c inter B^c, quad quad (A inter B)^c = A^c union B^c $
]

#proof[
  Um resultado $omega$ pertence a $(A union B)^c$ se, e somente se, $omega in.not A union B$, ou seja, $omega in.not A$ *e* $omega in.not B$ -- exatamente a condição para $omega in A^c inter B^c$. O segundo caso segue de forma análoga, trocando "e" por "ou".
]

== Exemplo resolvido

#example(name: "Operações sobre eventos no lançamento de um dado", id: "ex-operacoes-dado")[
  Considere o lançamento de um dado honesto, com espaço amostral $Omega = {1,2,3,4,5,6}$. Sejam os eventos:

  $ A = "resultado par" = {2,4,6}, quad quad B = "resultado maior que 4" = {5,6} $

  - $A union B = {2,4,5,6}$ -- par *ou* maior que 4.
  - $A inter B = {6}$ -- par *e* maior que 4, simultaneamente.
  - $A^c = {1,3,5}$ -- resultado ímpar.
  - $A$ e $B$ *não* são mutuamente exclusivos, pois $A inter B = {6} eq.not emptyset$.
  - Verificando De Morgan: $(A union B)^c = {1,3}$, e $A^c inter B^c = {1,3,5} inter {1,2,3,4} = {1,3}$. Coincidem, como esperado.
]

== Atenção -- pegadinhas comuns

#remark(name: "Mutuamente exclusivos não é o mesmo que independentes")[
  Dois eventos disjuntos ($A inter B = emptyset$) são, na verdade, *fortemente dependentes*: saber que $A$ ocorreu garante que $B$ não ocorreu. Independência é um conceito distinto (definido em 7.6, via $P(A inter B) = P(A) P(B)$) e quase nunca coincide com exclusividade mútua, exceto no caso degenerado em que um dos eventos tem probabilidade zero.
]

#remark(name: "Evento impossível vs. probabilidade zero")[
  Em espaços amostrais discretos finitos, $P(A) = 0 arrow.l.r.double A = emptyset$. Já em espaços contínuos (fora do escopo discreto desta subseção), um evento pode ter probabilidade zero sem ser o conjunto vazio -- distinção que a prova às vezes explora em espaços amostrais infinitos.
]

== Questões estilo POSCOMP

*Questão 1.* Sejam $A$ e $B$ eventos de um espaço amostral $Omega$. A afirmação "$A$ e $B$ não podem ocorrer ao mesmo tempo" corresponde formalmente a:
- a) $A union B = Omega$.
- b) $A inter B = emptyset$.
- c) $A subset.eq B$.
- d) $A^c = B$.
- e) $A - B = A$.

*Questão 2.* Considerando as Leis de De Morgan, o evento $(A union B)^c$ é equivalente a:
- a) $A^c union B^c$.
- b) $A inter B$.
- c) $A^c inter B^c$.
- d) $A - B$.
- e) $B - A$.

*Questão 3.* Se $A$ e $B$ são eventos mutuamente exclusivos e $P(A) > 0$, então, ao saber que $A$ ocorreu, pode-se afirmar sobre $B$ que:
- a) $B$ necessariamente também ocorreu.
- b) $B$ necessariamente não ocorreu.
- c) Nada pode ser afirmado sobre $B$.
- d) $A$ e $B$ são independentes.
- e) $P(B) = P(A)$.

== Gabarito comentado

1. *(b)* -- eventos que não ocorrem simultaneamente têm interseção vazia, por definição de mutuamente exclusivos.
2. *(c)* -- aplicação direta da lei de De Morgan desta seção.
3. *(b)* -- se $A$ e $B$ são disjuntos e $A$ ocorreu, $B$ está necessariamente fora do resultado observado, logo não ocorreu.

== Referências

- MEYER, P. L. *Probabilidade: Aplicações à Estatística*. Cap. 2 (Espaço amostral e eventos).
- MAGALHÃES, M. N. *Probabilidade e Variáveis Aleatórias*. Cap. 1 (Introdução à probabilidade).
- BUSSAB, W. O.; MORETTIN, P. A. *Estatística Básica*. Cap. 4 (Probabilidade).
