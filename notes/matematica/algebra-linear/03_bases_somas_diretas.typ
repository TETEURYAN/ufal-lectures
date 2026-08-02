#import "@preview/mousse-notes:1.1.0": *

= Bases
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.4]

== Introdução

Uma base é o menor conjunto de vetores capaz de "gerar" todo o espaço -- um sistema de coordenadas mínimo e sem redundância. A dimensão (número de vetores em qualquer base) é um dos invariantes mais usados para caracterizar um espaço vetorial.

== Definições formais

#definition(name: "Independência linear, geração e base", id: "def-base-dimensao")[
  - Um conjunto $\{v_1,dots,v_n\}$ é *linearmente independente* se $a_1 v_1 + dots + a_n v_n = 0$ só admite a solução trivial $a_1=dots=a_n=0$.
  - $\{v_1,dots,v_n\}$ *gera* $V$ se todo $v in V$ pode ser escrito como combinação linear $v = a_1 v_1 + dots + a_n v_n$.
  - Uma *base* de $V$ é um conjunto linearmente independente que gera $V$. A *dimensão* de $V$, $dim(V)$, é o número de vetores em qualquer base de $V$ (todas as bases de um mesmo espaço têm a mesma cardinalidade).
]

= Somas Diretas
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.5]

== Introdução

Soma direta formaliza a ideia de "decompor" um espaço em pedaços independentes, sem sobreposição -- generalizando, por exemplo, como $RR^3$ se decompõe em um plano e uma reta transversal a ele.

== Definições formais

#definition(name: "Soma direta de subespaços", id: "def-soma-direta")[
  Dados subespaços $U, W subset.eq V$, $V$ é a *soma direta* de $U$ e $W$, denotada $V = U plus.circle W$, se:
  + $V = U + W$ (todo vetor de $V$ se escreve como $u+w$, $u in U$, $w in W$).
  + $U inter W = \{0\}$ (interseção trivial).
  Quando isso vale, a decomposição $v=u+w$ de cada vetor é *única*, e $dim(V) = dim(U)+dim(W)$.
]

== Exemplo resolvido

#example(name: "Verificando uma base e uma soma direta", id: "ex-base-soma-direta")[
  Em $RR^3$: $\{(1,0,0),(0,1,0),(0,0,1)\}$ é a base canônica, com $dim(RR^3)=3$.

  Considere $U = \{(x,y,0) : x,y in RR\}$ (plano $x y$) e $W = \{(0,0,z) : z in RR\}$ (eixo $z$). $U+W = RR^3$ (todo $(x,y,z)$ se escreve como $(x,y,0)+(0,0,z)$), e $U inter W = \{(0,0,0)\}$ (só a origem satisfaz ambas as formas simultaneamente). Logo $RR^3 = U plus.circle W$, e $dim(RR^3)=dim(U)+dim(W)=2+1=3$ ✓.
]

== Atenção -- pegadinhas comuns

#remark(name: "V = U + W não é o mesmo que soma direta -- falta a interseção trivial")[
  $U+W=V$ sozinho garante apenas que todo vetor *pode* ser escrito como $u+w$ -- não que essa escrita é *única*. Se $U inter W eq.not \{0\}$, um mesmo vetor pode ter múltiplas decomposições em $U+W$, e não se trata de soma direta.
]

#remark(name: "Base não é única, mas a dimensão sim")[
  Um espaço vetorial (não trivial) tem infinitas bases possíveis -- mas todas têm o mesmo número de vetores, a dimensão. Confundir "a base" (como se fosse única) com "uma base" é um deslize comum de vocabulário que pode indicar confusão conceitual mais profunda em prova.
]

== Questões estilo POSCOMP

*Questão 1.* Um conjunto de vetores é uma base de um espaço vetorial $V$ quando é:
- a) Apenas gerador de $V$.
- b) Apenas linearmente independente.
- c) Linearmente independente e gerador de $V$ simultaneamente.
- d) Um conjunto com exatamente 3 vetores.
- e) Formado apenas por vetores unitários.

*Questão 2.* Se $dim(U)=2$ e $dim(W)=3$, e $V = U plus.circle W$, então $dim(V)$ é:
- a) $1$.
- b) $5$.
- c) $6$.
- d) $2$.
- e) $3$.

*Questão 3.* Para que $V = U plus.circle W$, é necessário que:
- a) $U inter W = V$.
- b) $U + W = V$ e $U inter W = \{0\}$.
- c) $U$ e $W$ tenham a mesma dimensão.
- d) $U subset.eq W$.
- e) Apenas $U + W = V$, sem restrição sobre a interseção.

== Gabarito comentado

1. *(c)* -- definição direta de base: independência linear e geração simultâneas.
2. *(b)* -- $dim(V) = dim(U)+dim(W) = 2+3=5$ em uma soma direta.
3. *(b)* -- definição direta de soma direta desta seção: soma igual a $V$ e interseção trivial.

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 3 (Base e dimensão).
- BOLDRINI, J. L. et al. *Álgebra Linear*. Cap. 5 (Base, dimensão e soma direta).
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 4.
