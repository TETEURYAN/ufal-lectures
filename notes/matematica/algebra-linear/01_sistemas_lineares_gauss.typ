#import "@preview/mousse-notes:1.1.0": *

= Sistemas de Equações Lineares: Método de Eliminação de Gauss
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.1]

== Introdução

Resolver sistemas lineares é o problema computacional mais básico (e mais cobrado) de Álgebra Linear -- todo o resto da disciplina (espaços vetoriais, transformações, autovalores) generaliza ou se apoia nessa operação fundamental.

== Definições formais

#definition(name: "Sistema linear e forma matricial", id: "def-sistema-linear")[
  Um sistema de $m$ equações lineares em $n$ incógnitas pode ser escrito na forma matricial $A x = b$, onde $A$ é a matriz $m times n$ dos coeficientes, $x$ é o vetor coluna de incógnitas, e $b$ é o vetor coluna dos termos independentes.
]

#definition(name: "Eliminação de Gauss", id: "def-eliminacao-gauss")[
  Método sistemático para resolver $A x = b$: aplica-se a matriz aumentada $[A | b]$ uma sequência de *operações elementares de linha* (trocar duas linhas; multiplicar uma linha por escalar não nulo; somar a uma linha um múltiplo de outra) até atingir a *forma escalonada* (cada linha começa com mais zeros à esquerda que a anterior), de onde a solução é obtida por *substituição regressiva*.
]

#definition(name: "Classificação de sistemas lineares", id: "def-classificacao-sistemas")[
  Comparando o posto (rank) de $A$ com o posto da matriz aumentada $[A|b]$ e o número de incógnitas $n$:
  - *Sistema Possível Determinado (SPD)*: posto$(A)$ = posto$([A|b])$ = $n$ -- solução única.
  - *Sistema Possível Indeterminado (SPI)*: posto$(A)$ = posto$([A|b])$ $<$ $n$ -- infinitas soluções (com $n - "posto"$ variáveis livres).
  - *Sistema Impossível (SI)*: posto$(A)$ $<$ posto$([A|b])$ -- nenhuma solução (uma linha da forma $0=c$, $c eq.not 0$, aparece no escalonamento).
]

== Exemplo resolvido

#example(name: "Resolução completa por eliminação de Gauss", id: "ex-eliminacao-gauss-completa")[
  Resolver o sistema:
  $ mat(delim: "[", 1, 1, 1, 6; 2, 1, -1, 1; 1, -1, 2, 5) $

  *Passo 1* ($R_2 arrow.l R_2 - 2R_1$; $R_3 arrow.l R_3 - R_1$):
  $ mat(delim: "[", 1, 1, 1, 6; 0, -1, -3, -11; 0, -2, 1, -1) $

  *Passo 2* ($R_3 arrow.l R_3 - 2R_2$):
  $ mat(delim: "[", 1, 1, 1, 6; 0, -1, -3, -11; 0, 0, 7, 21) $

  Forma escalonada atingida. *Substituição regressiva*: da 3ª linha, $7z=21 arrow.r.double z=3$. Da 2ª linha, $-y-3(3)=-11 arrow.r.double y=2$. Da 1ª linha, $x+2+3=6 arrow.r.double x=1$.

  Posto$(A)=$ posto$([A|b])=3=n$: sistema *Possível Determinado*, solução única $(x,y,z)=(1,2,3)$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Uma linha \"0 = c\" (c ≠ 0) sempre indica sistema impossível")[
  Se, durante o escalonamento, surgir uma linha da forma $0 x_1 + dots + 0 x_n = c$ com $c eq.not 0$, o sistema é imediatamente impossível -- não é necessário continuar o escalonamento para concluir isso.
]

#remark(name: "SPI tem infinitas soluções, não \"várias soluções específicas\"")[
  Quando posto$(A) < n$, as variáveis correspondentes às colunas sem pivô são *livres* (podem assumir qualquer valor), e as demais são expressas em função delas -- o conjunto solução é infinito (uma reta, plano, ou subespaço de dimensão maior), não um punhado finito de soluções alternativas.
]

== Questões estilo POSCOMP

*Questão 1.* Ao escalonar a matriz aumentada de um sistema, obtém-se uma linha $[0 space 0 space 0 | 5]$. O sistema é:
- a) Possível determinado.
- b) Possível indeterminado.
- c) Impossível.
- d) Homogêneo.
- e) Impossível de classificar sem mais informação.

*Questão 2.* Um sistema com 3 equações e 4 incógnitas, cuja matriz de coeficientes tem posto 3 (igual ao posto da matriz aumentada), é:
- a) Impossível.
- b) Possível determinado.
- c) Possível indeterminado, com 1 variável livre.
- d) Possível indeterminado, com 3 variáveis livres.
- e) Não pode ser resolvido por eliminação de Gauss.

*Questão 3.* No sistema resolvido no exemplo desta seção, o valor de $z$ é obtido primeiro porque:
- a) É a primeira incógnita do sistema original.
- b) A substituição regressiva começa pela última linha da forma escalonada, que isola $z$.
- c) $z$ é sempre a incógnita de maior valor numérico.
- d) A ordem é arbitrária e não segue nenhuma lógica.
- e) $z$ aparece em todas as equações originais.

== Gabarito comentado

1. *(c)* -- linha $0=5$ (constante não nula) é uma contradição, tornando o sistema impossível.
2. *(c)* -- posto$(A)=3 < n=4$: possível indeterminado, com $4-3=1$ variável livre.
3. *(b)* -- substituição regressiva percorre a forma escalonada de baixo para cima, começando pela equação mais simples (última linha).

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 1--2 (Sistemas lineares e eliminação de Gauss).
- BOLDRINI, J. L. et al. *Álgebra Linear*. Cap. 1.
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 1.
