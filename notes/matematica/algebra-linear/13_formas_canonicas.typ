#import "@preview/mousse-notes:1.1.0": *

= Formas Canônicas
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.20]

== Introdução

Fechando a disciplina: nem toda matriz é diagonalizável (06) -- quando autovalores repetidos têm autoespaços "pequenos demais", a melhor forma simplificada possível é a *forma de Jordan*, tratada aqui em nível introdutório.

== Definições formais

#definition(name: "Forma canônica de Jordan", id: "def-forma-jordan")[
  Toda matriz quadrada $A$ (sobre $CC$, ou sobre $RR$ quando todos os autovalores são reais) é *semelhante* a uma matriz em *forma de Jordan*: uma matriz de blocos diagonais, onde cada *bloco de Jordan* $J_k (lambda)$ tem o autovalor $lambda$ repetido na diagonal principal, $1$'s na superdiagonal (imediatamente acima da diagonal) e $0$ em todo o resto. Quando todos os blocos têm tamanho $1$, a forma de Jordan *é* a matriz diagonal usual -- diagonalização é o caso particular em que cada autovalor tem multiplicidade geométrica igual à algébrica.
]

== Exemplo resolvido

#example(name: "Uma matriz não diagonalizável e sua forma de Jordan", id: "ex-forma-jordan-nao-diagonalizavel")[
  Seja $A = mat(2,1;0,2)$. Polinômio característico: $(2-lambda)^2=0 arrow.r.double lambda=2$ (multiplicidade algébrica 2).

  Autovetores: $(A-2I)v=0 arrow.r.double mat(0,1;0,0)v=0 arrow.r.double v_2=0$, $v_1$ livre -- autoespaço de dimensão *1* (multiplicidade geométrica 1), *menor* que a multiplicidade algébrica (2). Logo $A$ *não é diagonalizável* (06): não há dois autovetores independentes para formar uma base de autovetores.

  A própria matriz $A$ já está em *forma de Jordan*: um único bloco de Jordan $J_2(2) = mat(2,1;0,2)$ -- diagonal com o autovalor repetido, e um $1$ na superdiagonal registrando a "deficiência" de autovetores.
]

== Atenção -- pegadinhas comuns

#remark(name: "Multiplicidade geométrica menor que a algébrica é o sinal de não-diagonalizabilidade")[
  Sempre que a multiplicidade geométrica de algum autovalor (dimensão do autoespaço) é *estritamente menor* que sua multiplicidade algébrica (multiplicidade como raiz do polinômio característico), a matriz não é diagonalizável -- e a forma de Jordan correspondente terá blocos de tamanho maior que 1 para esse autovalor, com uns na superdiagonal.
]

#remark(name: "Forma de Jordan generaliza diagonalização, não a substitui")[
  Toda matriz diagonalizável já está, trivialmente, em forma de Jordan (todos os blocos de tamanho 1, sem nenhum 1 na superdiagonal) -- a forma de Jordan é a resposta geral para "qual é a forma mais simples possível de qualquer matriz quadrada", da qual a diagonalização é apenas o caso mais favorável.
]

== Questões estilo POSCOMP

*Questão 1.* Uma matriz não é diagonalizável quando, para algum autovalor:
- a) A multiplicidade geométrica é igual à algébrica.
- b) A multiplicidade geométrica é estritamente menor que a algébrica.
- c) O autovalor é zero.
- d) A matriz é simétrica.
- e) A matriz é ortogonal.

*Questão 2.* Um bloco de Jordan $J_k(lambda)$ tem, por definição:
- a) O autovalor $lambda$ na diagonal e $1$'s na superdiagonal.
- b) Todos os elementos iguais a $lambda$.
- c) Apenas zeros fora da diagonal principal.
- d) Determinante sempre igual a zero.
- e) Tamanho fixo igual a $2$.

*Questão 3.* Toda matriz diagonalizável, em relação à forma de Jordan, tem:
- a) Blocos de Jordan de tamanho sempre maior que 1.
- b) Todos os blocos de Jordan de tamanho 1 (a própria matriz diagonal).
- c) Nenhuma forma de Jordan associada.
- d) Apenas autovalores complexos.
- e) Determinante nulo obrigatoriamente.

== Gabarito comentado

1. *(b)* -- é exatamente o critério de não-diagonalizabilidade discutido nesta seção.
2. *(a)* -- definição direta de bloco de Jordan.
3. *(b)* -- diagonalização é o caso particular da forma de Jordan com todos os blocos de tamanho 1, conforme a observação desta seção.

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 6 (Forma de Jordan, introdução).
- HOFFMAN, K.; KUNZE, R. *Linear Algebra*. Cap. 6--7 (Formas canônicas).
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 5 (Complemento sobre forma de Jordan).
