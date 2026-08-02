#import "@preview/mousse-notes:1.1.0": *

= Movimentos Rígidos
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.13]

== Introdução

Movimentos rígidos (isometrias) são as transformações que preservam distâncias -- rotações, translações e reflexões. São a base matemática de gráficos por computador, robótica e visão computacional, sempre que um objeto precisa ser movido sem deformar sua forma.

== Definições formais

#definition(name: "Movimento rígido (isometria)", id: "def-movimento-rigido")[
  Uma transformação $T: RR^n -> RR^n$ é um *movimento rígido* (ou isometria) se preserva distâncias: $norm(T(x)-T(y)) = norm(x-y)$ para todos $x,y$. Todo movimento rígido pode ser escrito como a composição de uma transformação linear *ortogonal* (rotação, ou rotação seguida de reflexão) com uma *translação*.
]

#definition(name: "Matriz ortogonal", id: "def-matriz-ortogonal-movimento")[
  Uma matriz quadrada $Q$ é *ortogonal* se $Q^T Q = I$ (equivalentemente, $Q^(-1)=Q^T$) -- suas colunas formam uma base ortonormal. Transformações lineares representadas por matrizes ortogonais preservam comprimentos e ângulos; se $det(Q)=1$, é uma *rotação pura*; se $det(Q)=-1$, envolve *reflexão*.
]

== Exemplo resolvido

#example(name: "Verificando que uma rotação preserva distância", id: "ex-rotacao-preserva-distancia")[
  A matriz de rotação de $90°$ no plano é $R = mat(0,-1;1,0)$. Verificando ortogonalidade: $R^T R = mat(0,1;-1,0) mat(0,-1;1,0) = mat(1,0;0,1) = I$ ✓, e $det(R) = 0(0)-(-1)(1) = 1$ (rotação pura, sem reflexão).

  Tomando $x=(1,0)$, $y=(0,1)$: $norm(x-y) = norm((1,-1)) = sqrt(2)$. Aplicando $R$: $R x = (0,1)$, $R y=(-1,0)$, $norm(R x - R y) = norm((1,1)) = sqrt(2)$ -- distância preservada, como esperado de um movimento rígido.
]

== Atenção -- pegadinhas comuns

#remark(name: "Nem toda transformação linear preserva distância -- só as ortogonais")[
  Uma transformação linear qualquer (ex.: escala, $T(x,y)=(2x,2y)$) altera distâncias -- só transformações representadas por matrizes *ortogonais* preservam norma e, portanto, distância. Confundir "transformação linear" com "movimento rígido" (um caso particular) é um erro comum.
]

#remark(name: "Determinante -1 indica reflexão, não apenas rotação em sentido contrário")[
  $det(Q)=-1$ não significa "rotação no sentido horário em vez de anti-horário" -- indica que a transformação inverte a orientação do espaço (reflexão), uma mudança qualitativa distinta de apenas rotacionar em outra direção.
]

== Questões estilo POSCOMP

*Questão 1.* Uma matriz $Q$ representa uma rotação pura (sem reflexão) quando:
- a) $Q^T Q = I$ e $det(Q) = 1$.
- b) $det(Q) = 0$.
- c) $Q$ é simétrica.
- d) $Q^T Q = 0$.
- e) $Q$ tem todos os elementos positivos.

*Questão 2.* Um movimento rígido em $RR^n$ pode sempre ser decomposto como:
- a) Apenas uma translação.
- b) Apenas uma matriz diagonal.
- c) Uma transformação ortogonal seguida de uma translação.
- d) Uma projeção ortogonal.
- e) Uma matriz de posto zero.

*Questão 3.* A transformação $T(x,y) = (3x, 3y)$ (escala uniforme por 3):
- a) É um movimento rígido, pois é linear.
- b) Não é um movimento rígido, pois não preserva distâncias.
- c) É uma rotação de $90°$.
- d) É representada por uma matriz ortogonal.
- e) Preserva a norma de qualquer vetor.

== Gabarito comentado

1. *(a)* -- ortogonalidade ($Q^T Q=I$) e determinante $1$ definem rotação pura, conforme o exemplo desta seção.
2. *(c)* -- é exatamente a decomposição de um movimento rígido apresentada nesta seção.
3. *(b)* -- escala por um fator diferente de $1$ altera distâncias (multiplica por $3$), logo não é isometria.

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 4, 8 (Matrizes ortogonais e transformações).
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 6--7.
- BOLDRINI, J. L. et al. *Álgebra Linear*. Cap. 10.
