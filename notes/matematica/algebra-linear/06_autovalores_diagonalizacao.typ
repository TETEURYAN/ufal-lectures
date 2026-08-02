#import "@preview/mousse-notes:1.1.0": *

= Autovalores e Autovetores
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.8]

== Introdução

Autovalores e autovetores identificam as direções em que uma transformação linear age apenas como uma "escala" -- sem mudar de direção, só de comprimento. É o bloco de conteúdo mais cobrado de toda a disciplina em prova, quase sempre com cálculo direto.

== Definições formais

#definition(name: "Autovalor e autovetor", id: "def-autovalor-autovetor")[
  Dado um operador linear $A: V -> V$ (representado por uma matriz quadrada), um escalar $lambda$ é *autovalor* de $A$ se existe um vetor não nulo $v$ (o *autovetor* associado) tal que $A v = lambda v$ -- isto é, $A$ age sobre $v$ apenas escalando-o por $lambda$, sem alterar sua direção.
]

#definition(name: "Polinômio característico", id: "def-polinomio-caracteristico")[
  Os autovalores de $A$ (matriz $n times n$) são exatamente as raízes do *polinômio característico* $p(lambda) = det(A - lambda I)$, uma equação polinomial de grau $n$ em $lambda$. Para cada autovalor $lambda$, os autovetores associados são as soluções não nulas de $(A - lambda I) v = 0$ (um sistema linear homogêneo, resolvido por eliminação de Gauss, 01).
]

== Exemplo resolvido

#example(name: "Calculando autovalores e autovetores de uma matriz 2×2", id: "ex-autovalores-autovetores-2x2")[
  Seja $A = mat(4, 1; 2, 3)$. Polinômio característico:
  $ p(lambda) = det mat(delim: "|", 4-lambda, 1; 2, 3-lambda) = (4-lambda)(3-lambda) - 2 = lambda^2 - 7lambda + 10 = (lambda-5)(lambda-2) $
  Autovalores: $lambda_1 = 5$, $lambda_2 = 2$.

  *Autovetor para $lambda_1=5$*: $(A-5I)v=0 arrow.r.double mat(-1,1;2,-2)v=0 arrow.r.double -v_1+v_2=0 arrow.r.double v_1=v_2$. Autovetor: $v_1 = (1,1)$.

  *Autovetor para $lambda_2=2$*: $(A-2I)v=0 arrow.r.double mat(2,1;2,1)v=0 arrow.r.double 2v_1+v_2=0 arrow.r.double v_2=-2v_1$. Autovetor: $v_2 = (1,-2)$.

  Verificação: $A v_1 = mat(4,1;2,3)vec(1,1) = vec(5,5) = 5 vec(1,1)$ ✓.
]

= Diagonalização
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.9]

== Introdução

Se uma matriz tem autovetores suficientes, ela pode ser reescrita em uma base onde age apenas como escala pura (uma matriz diagonal) -- simplificando drasticamente cálculos como potências de matrizes, sistemas dinâmicos e muito mais.

== Definições formais

#definition(name: "Matriz diagonalizável", id: "def-matriz-diagonalizavel")[
  Uma matriz $A$ ($n times n$) é *diagonalizável* se existe uma matriz invertível $P$ (cujas colunas são autovetores de $A$, linearmente independentes) e uma matriz diagonal $D$ (com os autovalores correspondentes na diagonal) tais que $A = P D P^(-1)$. Isso é possível se, e somente se, $A$ tem $n$ autovetores linearmente independentes -- em particular, sempre que $A$ tem $n$ autovalores *distintos*.
]

== Exemplo resolvido

#example(name: "Diagonalizando a matriz do exemplo anterior", id: "ex-diagonalizacao-passo-a-passo")[
  Retomando $A = mat(4,1;2,3)$, com autovalores $5, 2$ e autovetores $(1,1)$, $(1,-2)$ (dois autovalores distintos $arrow.r.double$ autovetores automaticamente independentes $arrow.r.double$ diagonalizável):

  $ P = mat(1, 1; 1, -2), quad quad D = mat(5, 0; 0, 2) $

  Calculando $P^(-1) = 1/(-3) mat(-2,-1;-1,1) = mat(2\/3, 1\/3; 1\/3, -1\/3)$ (usando a fórmula de matriz inversa $2 times 2$: $det(P) = 1(-2)-1(1)=-3$).

  Verificação de $A = P D P^(-1)$: calcular $P D = mat(1,1;1,-2)mat(5,0;0,2) = mat(5,2;5,-4)$, e então $(P D) P^(-1) = mat(5,2;5,-4) mat(2\/3,1\/3;1\/3,-1\/3)$, que resulta exatamente em $mat(4,1;2,3) = A$ (confirmando a diagonalização).
]

== Atenção -- pegadinhas comuns

#remark(name: "Autovalores distintos garantem diagonalização; autovalores repetidos, não necessariamente")[
  Se todos os $n$ autovalores de uma matriz $n times n$ são distintos, ela é *sempre* diagonalizável. Se houver autovalor repetido, a matriz *pode* não ser diagonalizável -- depende de a *multiplicidade geométrica* (dimensão do autoespaço) coincidir com a *multiplicidade algébrica* (multiplicidade da raiz no polinômio característico) para aquele autovalor.
]

#remark(name: "A ordem das colunas de P deve corresponder à ordem dos autovalores em D")[
  Se a primeira coluna de $P$ é o autovetor associado a $lambda_1$, a primeira entrada da diagonal de $D$ deve ser $lambda_1$ -- trocar a correspondência entre colunas de $P$ e entradas de $D$ é um erro recorrente que invalida $A = P D P^(-1)$.
]

== Questões estilo POSCOMP

*Questão 1.* Os autovalores de uma matriz $A$ são as raízes de:
- a) $det(A) = 0$.
- b) $det(A - lambda I) = 0$.
- c) $A v = 0$.
- d) $"traço"(A) = 0$.
- e) $A = A^T$.

*Questão 2.* Se uma matriz $3 times 3$ tem três autovalores distintos, é correto afirmar que:
- a) Ela nunca é diagonalizável.
- b) Ela é sempre diagonalizável.
- c) Ela só é diagonalizável se for simétrica.
- d) Seus autovetores são necessariamente ortogonais.
- e) Ela tem determinante zero.

*Questão 3.* Na diagonalização $A = P D P^(-1)$, as colunas de $P$ são:
- a) Autovalores de $A$.
- b) Autovetores de $A$, na mesma ordem dos autovalores correspondentes em $D$.
- c) Linhas da matriz identidade.
- d) Independentes da escolha de autovalores.
- e) Sempre vetores unitários, por definição.

== Gabarito comentado

1. *(b)* -- definição direta do polinômio característico.
2. *(b)* -- autovalores distintos garantem autovetores linearmente independentes, logo diagonalizável.
3. *(b)* -- definição direta de $P$ na diagonalização, conforme esta seção.

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 6 (Autovalores e autovetores).
- BOLDRINI, J. L. et al. *Álgebra Linear*. Cap. 8--9.
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 5.
