#import "@preview/mousse-notes:1.1.0": *

= Transformações Lineares e Matrizes
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.7]

== Introdução

Transformações lineares são as funções "compatíveis" com a estrutura de espaço vetorial -- e toda transformação linear entre espaços de dimensão finita pode ser representada por uma matriz, uma vez fixadas as bases. Essa correspondência é o que torna álgebra linear computacionalmente tratável.

== Definições formais

#definition(name: "Transformação linear", id: "def-transformacao-linear")[
  Uma função $T: V -> W$ entre espaços vetoriais é *linear* se, para todos $u,v in V$ e escalar $a$:
  + $T(u+v) = T(u) + T(v)$ (preserva soma).
  + $T(a v) = a T(v)$ (preserva multiplicação escalar).
  Consequência imediata: $T(0) = 0$ para toda transformação linear.
]

#definition(name: "Matriz de uma transformação linear", id: "def-matriz-transformacao")[
  Fixadas bases $cal(B)$ de $V$ e $cal(C)$ de $W$, toda transformação linear $T: V -> W$ é representada por uma matriz $[T]_(cal(B))^(cal(C))$: a $j$-ésima coluna dessa matriz é o vetor de coordenadas (na base $cal(C)$) da imagem $T(v_j)$ do $j$-ésimo vetor da base $cal(B)$. Uma vez obtida a matriz, calcular $T(v)$ se reduz a multiplicação matriz-vetor.
]

#definition(name: "Núcleo e imagem", id: "def-nucleo-imagem")[
  - *Núcleo (kernel)*: $ker(T) = \{v in V : T(v) = 0\}$ -- subespaço de $V$.
  - *Imagem*: $"im"(T) = \{T(v) : v in V\} subset.eq W$ -- subespaço de $W$.
  *Teorema do Núcleo e da Imagem*: $dim(V) = dim(ker(T)) + dim("im"(T))$.
]

== Exemplo resolvido

#example(name: "Matriz de uma transformação e verificação de linearidade", id: "ex-matriz-transformacao-linearidade")[
  Seja $T: RR^2 -> RR^2$, $T(x,y) = (2x - y, x + y)$. Verificando linearidade: $T((x_1,y_1)+(x_2,y_2)) = T(x_1{+}x_2, y_1{+}y_2) = (2(x_1{+}x_2)-(y_1{+}y_2), (x_1{+}x_2)+(y_1{+}y_2))$, que se expande exatamente para $T(x_1,y_1)+T(x_2,y_2)$ -- e $T(a(x,y)) = a T(x,y)$ segue de forma análoga. *É linear*.

  Matriz em relação à base canônica: $T(1,0)=(2,1)$ (primeira coluna) e $T(0,1)=(-1,1)$ (segunda coluna):
  $ [T] = mat(2, -1; 1, 1) $
  Verificação: $[T] vec(x,y) = mat(2,-1;1,1) vec(x,y) = vec(2x-y, x+y)$, coincidindo com a definição original de $T$.

  #figure(
    image("figures/shear-transformation.svg", width: 45%),
    caption: [Transformação de cisalhamento (shear): um exemplo clássico de transformação linear que preserva área mas distorce ângulos -- usada frequentemente para ilustrar autovalores/autovetores (06), já que a direção horizontal permanece invariante. Fonte: Wikimedia Commons, CC BY-SA (Lyudmil Antonov).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "T(0)=0 é necessário, mas não suficiente, para linearidade")[
  Toda transformação linear satisfaz $T(0)=0$, mas o inverso não vale: existem transformações não lineares que também satisfazem $T(0)=0$ (ex.: $T(x)=x^2$ em $RR$, com $T(0)=0$, não é linear). Verificar $T(0)=0$ é um teste rápido de *descarte* (se falhar, definitivamente não é linear), não uma prova de linearidade.
]

#remark(name: "A matriz de T depende das bases escolhidas")[
  A mesma transformação $T$ tem representações matriciais diferentes conforme as bases $cal(B)$ e $cal(C)$ escolhidas -- "a matriz de $T$", sem especificar as bases, é uma expressão incompleta. Mudar de base transforma a matriz por conjugação/multiplicação por matrizes de mudança de base.
]

== Questões estilo POSCOMP

*Questão 1.* Uma função $T: V -> W$ é linear se, e somente se, satisfaz:
- a) Apenas $T(0)=0$.
- b) $T(u+v)=T(u)+T(v)$ e $T(a v) = a T(v)$, para todos $u,v$ e escalar $a$.
- c) $T$ ser bijetora.
- d) $T$ ser definida apenas em $RR^2$.
- e) $T(u dot v) = T(u) dot T(v)$.

*Questão 2.* Pelo Teorema do Núcleo e da Imagem, se $T: RR^5 -> RR^3$ tem $dim(ker(T))=2$, então $dim("im"(T))$ é:
- a) $5$.
- b) $3$.
- c) $2$.
- d) $8$.
- e) $1$.

*Questão 3.* A transformação $T(x,y) = (x+1, y)$ (translação):
- a) É linear, pois preserva a forma geral de uma função.
- b) Não é linear, pois $T(0,0) = (1,0) eq.not (0,0)$.
- c) É linear apenas se restrita ao primeiro quadrante.
- d) É linear, pois é uma função contínua.
- e) Não pode ser representada por nenhuma matriz, mesmo em coordenadas homogêneas.

== Gabarito comentado

1. *(b)* -- definição direta de transformação linear.
2. *(b)* -- $dim(V) = dim(ker(T))+dim("im"(T)) arrow.r.double 5 = 2 + dim("im"(T)) arrow.r.double dim("im"(T))=3$.
3. *(b)* -- translação não fixa a origem ($T(0,0) eq.not 0$), violando a condição necessária, logo não é linear (embora seja representável em coordenadas homogêneas, técnica usada em Computação Gráfica, fora do escopo desta verificação direta).

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 3, 7 (Transformações lineares).
- BOLDRINI, J. L. et al. *Álgebra Linear*. Cap. 6--7.
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 1, 4.
