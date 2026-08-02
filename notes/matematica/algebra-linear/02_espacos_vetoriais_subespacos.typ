#import "@preview/mousse-notes:1.1.0": *

= Espaços Vetoriais
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.2]

== Introdução

Espaço vetorial generaliza a noção de "vetor" muito além de setas no plano/espaço -- matrizes, polinômios e funções também formam espaços vetoriais, desde que satisfaçam os mesmos 8 axiomas. É a estrutura central sobre a qual toda a disciplina se constrói.

== Definições formais

#definition(name: "Espaço vetorial", id: "def-espaco-vetorial")[
  Um espaço vetorial sobre um corpo $FF$ (tipicamente $RR$) é um conjunto $V$ com operações de adição ($+: V times V -> V$) e multiplicação por escalar ($dot: FF times V -> V$) satisfazendo, para todos $u,v,w in V$ e $a,b in FF$:
  + $u+v = v+u$ (comutatividade).
  + $(u+v)+w = u+(v+w)$ (associatividade da soma).
  + Existe $0 in V$ tal que $v+0=v$ para todo $v$ (elemento neutro).
  + Para todo $v$, existe $-v$ tal que $v+(-v)=0$ (inverso aditivo).
  + $a(b v) = (a b) v$ (associatividade da multiplicação escalar).
  + $1 dot v = v$ (identidade escalar).
  + $a(u+v) = a u + a v$ (distributividade sobre soma de vetores).
  + $(a+b)v = a v + b v$ (distributividade sobre soma de escalares).
]

= Subespaços
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.3]

== Introdução

Nem todo subconjunto de um espaço vetorial herda a estrutura de espaço vetorial -- subespaço é o subconjunto que herda, e o critério para verificar isso é muito mais simples do que checar os 8 axiomas do zero.

== Definições formais

#definition(name: "Subespaço vetorial e critério de subespaço", id: "def-subespaco-criterio")[
  Um subconjunto $W subset.eq V$ é um *subespaço* de $V$ se, com as operações herdadas de $V$, $W$ também é um espaço vetorial. Na prática, basta verificar três condições (o *critério de subespaço*), mais simples que checar os 8 axiomas:
  + $0 in W$ (contém o vetor nulo).
  + Fechado sob soma: $u,v in W arrow.r.double u+v in W$.
  + Fechado sob multiplicação escalar: $v in W, a in FF arrow.r.double a v in W$.
  As demais propriedades (associatividade, comutatividade etc.) são automaticamente herdadas de $V$.
]

== Exemplo resolvido

#example(name: "Verificando se um subconjunto é subespaço", id: "ex-verificar-subespaco")[
  Em $RR^3$, considere $W_1 = \{(x,y,z) : x+y+z=0\}$ (plano pela origem) e $W_2 = \{(x,y,z) : x+y+z=1\}$ (plano paralelo, não pela origem).

  - $W_1$: contém $(0,0,0)$ ✓ (soma dá 0). Fechado sob soma: se $u,v in W_1$, $(u_1{+}v_1)+(u_2{+}v_2)+(u_3{+}v_3) = (u_1{+}u_2{+}u_3)+(v_1{+}v_2{+}v_3)=0+0=0$ ✓. Fechado sob escalar: análogo. *É subespaço*.
  - $W_2$: $(0,0,0)$ satisfaz $0+0+0=1$? Não -- *não contém o vetor nulo*, logo *não é subespaço* (basta essa falha para descartar, sem checar as outras duas condições).
]

== Atenção -- pegadinhas comuns

#remark(name: "Checagem rápida: se o vetor nulo não pertence, já não é subespaço")[
  Testar $0 in W$ primeiro é a forma mais rápida de descartar um candidato a subespaço -- qualquer conjunto definido por uma equação *não homogênea* (com termo constante não nulo, como $W_2$ do exemplo) automaticamente falha nesse primeiro teste.
]

#remark(name: "Fechamento sob soma E sob escalar são condições independentes")[
  Um conjunto pode ser fechado sob soma mas não sob multiplicação escalar (ou vice-versa) -- é preciso verificar *ambas* as condições, não basta uma delas. Um exemplo clássico de armadilha: o primeiro quadrante de $RR^2$ ($x>=0, y>=0$) é fechado sob soma, mas não sob multiplicação por escalar negativo.
]

== Questões estilo POSCOMP

*Questão 1.* Qual dos seguintes axiomas NÃO é um dos 8 axiomas de espaço vetorial?
- a) Comutatividade da soma.
- b) Existência de elemento neutro aditivo.
- c) Comutatividade da multiplicação por escalar entre dois vetores.
- d) Distributividade da multiplicação escalar sobre a soma de vetores.
- e) Existência de inverso aditivo.

*Questão 2.* O conjunto $W = \{(x,y) in RR^2 : y = 2x\}$ é subespaço de $RR^2$ porque:
- a) Não contém a origem.
- b) Contém a origem, é fechado sob soma e sob multiplicação escalar.
- c) Tem exatamente dois elementos.
- d) Não é fechado sob soma.
- e) É definido por uma equação não homogênea.

*Questão 3.* O conjunto $W = \{(x,y) in RR^2 : x y >= 0\}$ (produto das coordenadas não negativo):
- a) É subespaço, pois contém a origem.
- b) Não é subespaço, pois não é fechado sob soma -- por exemplo, $(1,0)$ e $(0,-1)$ estão em $W$, mas $(1,0)+(0,-1)=(1,-1) in.not W$ (produto $-1 < 0$).
- c) É subespaço, pois é fechado sob multiplicação escalar.
- d) Não é subespaço porque não contém a origem.
- e) É subespaço trivial.

== Gabarito comentado

1. *(c)* -- multiplicação por escalar não é "comutativa entre dois vetores" (nem faz sentido essa formulação); não é um dos 8 axiomas.
2. *(b)* -- reta pela origem satisfaz o critério de subespaço completo.
3. *(b)* -- $(1,0), (0,-1) in W$ (produtos $0$ e $0$, ambos $>=0$), mas a soma $(1,-1)$ tem produto $-1 < 0$, fora de $W$: não fechado sob soma, logo não é subespaço.

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 3 (Espaços vetoriais).
- BOLDRINI, J. L. et al. *Álgebra Linear*. Cap. 3--4 (Espaços vetoriais e subespaços).
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 4.
