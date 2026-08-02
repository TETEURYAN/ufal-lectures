#import "@preview/mousse-notes:1.1.0": *

= O Teorema Espectral
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.19]

== Introdução

O Teorema Espectral é o ápice de todo o percurso da disciplina: combina diagonalização (06), ortogonalidade (07) e operadores simétricos (11) em um único resultado extremamente forte -- garantindo, para matrizes simétricas, o melhor cenário possível de diagonalização.

== Definições formais

#definition(name: "Teorema Espectral (caso real, simétrico)", id: "def-teorema-espectral")[
  Toda matriz simétrica real $A$ ($A = A^T$) é *ortogonalmente diagonalizável*: existe uma matriz ortogonal $Q$ ($Q^T Q = I$) e uma matriz diagonal $D$ (com entradas reais) tais que $A = Q D Q^T$. Além disso: todos os autovalores de $A$ são *reais*, e autovetores associados a autovalores *distintos* são automaticamente *ortogonais* entre si.
]

== Exemplo resolvido

#example(name: "Diagonalização ortogonal de uma matriz simétrica", id: "ex-diagonalizacao-ortogonal-espectral")[
  Seja $A = mat(2,1;1,2)$ (simétrica). Polinômio característico: $(2-lambda)^2 - 1 = 0 arrow.r.double lambda = 3 " ou " lambda=1$.

  *Autovetor para $lambda{=}3$*: $(A-3I)v=0 arrow.r.double mat(-1,1;1,-1)v=0 arrow.r.double v_1=v_2$. Autovetor normalizado: $(1,1)\/sqrt(2)$.

  *Autovetor para $lambda{=}1$*: $(A-I)v=0 arrow.r.double mat(1,1;1,1)v=0 arrow.r.double v_1=-v_2$. Autovetor normalizado: $(1,-1)\/sqrt(2)$.

  Note que os dois autovetores já são *automaticamente ortogonais* ($1(1)+1(-1)=0$) -- exatamente a garantia do Teorema Espectral para autovalores distintos de uma matriz simétrica, sem precisar de Gram-Schmidt (07) adicional.

  $ Q = 1/sqrt(2) mat(1,1;1,-1), quad quad D = mat(3,0;0,1) $

  Como $Q$ é ortogonal, $Q^(-1)=Q^T$, e $A = Q D Q^T$ (sem precisar calcular uma inversa geral, como seria necessário para diagonalização não ortogonal em 06).
]

== Atenção -- pegadinhas comuns

#remark(name: "Simetria é suficiente para garantir ortogonalidade dos autovetores -- não é preciso verificar à parte")[
  Para matrizes simétricas, autovetores associados a autovalores *distintos* são ortogonais *automaticamente* -- uma consequência direta da simetria, não algo que precise ser checado separadamente ou obtido via Gram-Schmidt (a menos que haja autovalores repetidos, caso em que Gram-Schmidt pode ainda ser necessário *dentro* do autoespaço repetido).
]

#remark(name: "Nem toda matriz diagonalizável é ortogonalmente diagonalizável")[
  Diagonalização comum (06) só exige autovetores linearmente independentes. Diagonalização *ortogonal* (via $Q$ ortogonal) é uma exigência mais forte, garantida pelo Teorema Espectral *apenas* para matrizes simétricas (no caso real) -- uma matriz diagonalizável qualquer, não simétrica, pode não admitir diagonalização ortogonal.
]

== Questões estilo POSCOMP

*Questão 1.* O Teorema Espectral garante que toda matriz simétrica real é:
- a) Não diagonalizável.
- b) Diagonalizável apenas por matrizes não ortogonais.
- c) Ortogonalmente diagonalizável, com autovalores reais.
- d) Sempre igual à matriz identidade.
- e) Nunca invertível.

*Questão 2.* Para uma matriz simétrica com autovalores distintos, os autovetores associados são, garantidamente:
- a) Paralelos entre si.
- b) Ortogonais entre si.
- c) Iguais entre si.
- d) Nulos.
- e) Complexos.

*Questão 3.* A diferença entre diagonalização comum ($A=P D P^(-1)$) e diagonalização ortogonal ($A=Q D Q^T$) é que a segunda:
- a) Não exige autovetores.
- b) Exige que a matriz de mudança de base seja ortogonal, garantida pelo Teorema Espectral para matrizes simétricas.
- c) Só se aplica a matrizes não quadradas.
- d) É sempre impossível.
- e) Não envolve autovalores.

== Gabarito comentado

1. *(c)* -- enunciado direto do Teorema Espectral apresentado nesta seção.
2. *(b)* -- consequência direta da simetria, conforme o exemplo e a observação desta seção.
3. *(b)* -- exigência adicional de ortogonalidade de $Q$, garantida especificamente para matrizes simétricas pelo Teorema Espectral.

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 6 (Teorema Espectral).
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 7.
- AXLER, S. *Linear Algebra Done Right*. Cap. 7.
