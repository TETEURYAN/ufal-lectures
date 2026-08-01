#import "@preview/mousse-notes:1.1.0": *

= 7.6 --- Probabilidades em Espaços Amostrais Discretos

== Introdução

A regra de Laplace (7.5) só se aplica a espaços equiprováveis. A axiomatização de Kolmogorov generaliza probabilidade para qualquer espaço amostral discreto, e a partir dela derivam-se probabilidade condicional, independência e o Teorema de Bayes -- provavelmente o item isolado mais cobrado de toda a disciplina na POSCOMP.

== Definições formais

#definition(name: "Axiomas de Kolmogorov", id: "def-axiomas-kolmogorov")[
  Uma *probabilidade* é uma função $P$ que associa a cada evento $A subset.eq Omega$ um número real, satisfazendo:
  + *Não-negatividade*: $P(A) >= 0$ para todo evento $A$.
  + *Normalização*: $P(Omega) = 1$.
  + *Aditividade contável*: para eventos mutuamente exclusivos $A_1, A_2, dots$ (dois a dois disjuntos), $P(union.big_i A_i) = sum_i P(A_i)$.
]

#definition(name: "Probabilidade condicional", id: "def-probabilidade-condicional")[
  Dado um evento $B$ com $P(B) > 0$, a probabilidade condicional de $A$ dado $B$ é:
  $ P(A|B) = P(A inter B)/P(B) $
  Interpretação: a probabilidade de $A$, *restrita* ao universo em que $B$ já é sabido ter ocorrido. Rearranjando, obtém-se a *regra do produto*: $P(A inter B) = P(B) dot P(A|B)$.
]

#definition(name: "Independência de eventos", id: "def-independencia-eventos")[
  Dois eventos $A$ e $B$ são *independentes* se $P(A inter B) = P(A) dot P(B)$ -- equivalentemente (quando $P(B)>0$), $P(A|B) = P(A)$: saber que $B$ ocorreu não altera a probabilidade de $A$.
]

== Propriedade relevante

#theorem(name: "Teorema da Probabilidade Total e Teorema de Bayes", id: "thm-bayes")[
  Seja $A_1, dots, A_n$ uma *partição* de $Omega$ (eventos disjuntos dois a dois, com $union.big_i A_i = Omega$ e $P(A_i) > 0$ para todo $i$), e seja $B$ um evento qualquer.

  *Probabilidade total*: $ P(B) = sum_(i=1)^n P(B|A_i) dot P(A_i) $

  *Teorema de Bayes*: $ P(A_k|B) = (P(B|A_k) dot P(A_k))/(sum_(i=1)^n P(B|A_i) dot P(A_i)) = (P(B|A_k) P(A_k))/P(B) $
]

#proof[
  Como $A_1,dots,A_n$ particionam $Omega$, o evento $B$ se decompõe como união disjunta $B = union.big_i (B inter A_i)$; pela aditividade (axioma 3), $P(B) = sum_i P(B inter A_i) = sum_i P(B|A_i)P(A_i)$ (regra do produto), provando a probabilidade total. O Teorema de Bayes segue diretamente da definição de probabilidade condicional aplicada duas vezes: $P(A_k|B) = P(A_k inter B)/P(B) = (P(B|A_k)P(A_k))/P(B)$, substituindo $P(B)$ pela fórmula da probabilidade total.
]

== Exemplo resolvido

#example(name: "Teorema de Bayes: teste diagnóstico", id: "ex-bayes-teste-diagnostico")[
  Uma doença atinge 1% de uma população ($P(D) = 0.01$). Um teste diagnóstico tem sensibilidade de 95% (detecta corretamente 95% dos doentes, $P(+|D) = 0.95$) e taxa de falso positivo de 5% ($P(+|D^c) = 0.05$). Uma pessoa testou positivo. Qual a probabilidade de ela realmente ter a doença, $P(D|+)$?

  *Passo 1 -- probabilidade total de teste positivo:*
  $ P(+) = P(+|D)P(D) + P(+|D^c)P(D^c) = (0.95)(0.01) + (0.05)(0.99) = 0.0095 + 0.0495 = 0.059 $

  *Passo 2 -- Bayes:*
  $ P(D|+) = (P(+|D) P(D))/P(+) = 0.0095/0.059 approx 0.161 $

  Ou seja, mesmo com um teste de 95% de sensibilidade, apenas cerca de *16,1%* das pessoas que testam positivo de fato têm a doença -- porque a doença é rara, a maioria dos positivos vem de falsos positivos entre a grande população saudável. Este é o exemplo clássico usado para ilustrar por que a *prevalência* (probabilidade a priori) é essencial na interpretação de um resultado de teste.
]

== Atenção -- pegadinhas comuns

#remark(name: "P(A|B) não é o mesmo que P(B|A)")[
  Confundir $P("teste positivo" | "doente")$ (sensibilidade) com $P("doente" | "teste positivo")$ (o que o Teorema de Bayes calcula) é o erro mais comum -- e é exatamente a "falácia da probabilidade condicional invertida" ilustrada no exemplo desta seção.
]

#remark(name: "Independência é uma condição, não uma suposição automática")[
  $A$ e $B$ só são independentes se $P(A inter B) = P(A)P(B)$ *verificado* -- nunca presuma independência apenas porque os eventos parecem "não relacionados" no enunciado; a prova costuma dar valores que quebram essa igualdade de propósito.
]

#remark(name: "Eventos independentes vs. mutuamente exclusivos (revisão de 7.1)")[
  Se $A$ e $B$ são mutuamente exclusivos e ambos têm probabilidade positiva, eles *não podem* ser independentes: $P(A inter B) = 0 eq.not P(A)P(B) > 0$. É um par de conceitos frequentemente cobrado em conjunto na mesma questão.
]

== Questões estilo POSCOMP

*Questão 1.* Qual das alternativas NÃO é um dos axiomas de Kolmogorov?
- a) $P(Omega) = 1$.
- b) $P(A) >= 0$ para todo evento $A$.
- c) Para eventos disjuntos, a probabilidade da união é a soma das probabilidades.
- d) $P(A|B) = P(A)$ para quaisquer eventos $A$, $B$.
- e) $P(emptyset) = 0$ (consequência dos axiomas).

*Questão 2.* Em uma população, 40% das pessoas praticam exercícios ($E$) e 25% têm alimentação saudável ($S$); 15% fazem as duas coisas. A probabilidade de uma pessoa ter alimentação saudável, dado que pratica exercícios, é:
- a) $0.15$.
- b) $0.25$.
- c) $0.375$.
- d) $0.60$.
- e) $0.10$.

*Questão 3.* Considerando o exemplo de teste diagnóstico desta seção, a razão pela qual $P(D|+)$ é muito menor que a sensibilidade do teste (95%) é:
- a) O teste tem especificidade muito baixa.
- b) A prevalência da doença na população é baixa, então a maioria dos positivos são falsos positivos.
- c) O Teorema de Bayes superestima sistematicamente a probabilidade condicional.
- d) $P(+|D)$ e $P(D|+)$ são sempre iguais por definição.
- e) O tamanho da amostra é pequeno demais.

*Questão 4.* Dois eventos $A$ e $B$, com $P(A) = 0.3$ e $P(B) = 0.4$, são independentes. O valor de $P(A inter B)$ é:
- a) $0.7$.
- b) $0.12$.
- c) $0.1$.
- d) $0$.
- e) $0.34$.

== Gabarito comentado

1. *(d)* -- essa igualdade só vale quando $A$ e $B$ são independentes; não é um axioma geral.
2. *(c)* -- $P(S|E) = P(S inter E)/P(E) = 0.15/0.40 = 0.375$.
3. *(b)* -- exatamente o fenômeno explicado no exemplo: com prevalência baixa, mesmo um teste sensível gera mais falsos positivos em números absolutos do que verdadeiros positivos.
4. *(b)* -- por independência, $P(A inter B) = P(A) dot P(B) = 0.3 times 0.4 = 0.12$.

== Referências

- MEYER, P. L. *Probabilidade: Aplicações à Estatística*. Cap. 3 (Axiomas e probabilidade condicional).
- MAGALHÃES, M. N. *Probabilidade e Variáveis Aleatórias*. Cap. 2 (Probabilidade condicional e independência).
- ROSS, S. *Probabilidade: Um Curso Moderno com Aplicações*. Cap. 3 (Teorema de Bayes).
