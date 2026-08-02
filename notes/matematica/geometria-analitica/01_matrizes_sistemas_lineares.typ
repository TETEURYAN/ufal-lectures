#import "@preview/mousse-notes:1.1.0": *

= Matrizes
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.1]

== Introdução

Matrizes são a ferramenta computacional central de toda a Geometria Analítica: representam sistemas de equações, transformações de coordenadas e, adiante, os coeficientes de retas e planos. O método de eliminação de Gauss em si (resolução de sistemas) é tratado com exemplo completo em Álgebra Linear, subtópico 1.1 -- aqui o foco é a álgebra matricial (soma, produto, determinante) como ferramenta.

== Definições formais

#definition(name: "Matriz e operações básicas", id: "def-matriz-operacoes")[
  Uma matriz $A$ de ordem $m times n$ é uma tabela retangular de números com $m$ linhas e $n$ colunas. Operações básicas:
  - *Soma*: $(A+B)_(i j) = A_(i j) + B_(i j)$, definida apenas entre matrizes de mesma ordem.
  - *Produto por escalar*: $(k A)_(i j) = k A_(i j)$.
  - *Produto matricial*: $(A B)_(i j) = sum_k A_(i k) B_(k j)$, definido apenas quando o número de colunas de $A$ é igual ao número de linhas de $B$.
]

#definition(name: "Determinante: regra de Sarrus e Laplace", id: "def-determinante-sarrus-laplace")[
  - *Regra de Sarrus* (só para matrizes $3 times 3$): repetindo as duas primeiras colunas à direita, soma-se o produto das três diagonais "descendentes" e subtrai-se o produto das três diagonais "ascendentes".
  - *Expansão de Laplace* (cofatores, qualquer ordem $n$, essencial para $n >= 4$): $det(A) = sum_(j=1)^n (-1)^(i+j) A_(i j) M_(i j)$, expandindo por uma linha (ou coluna) $i$ fixa, onde $M_(i j)$ é o menor complementar (determinante da submatriz obtida removendo a linha $i$ e a coluna $j$).
]

#definition(name: "Matriz simétrica", id: "def-matriz-simetrica-ga")[
  Uma matriz quadrada $A$ é *simétrica* se $A = A^T$, isto é, $A_(i j) = A_(j i)$ para todos $i,j$ -- a matriz é uma "reflexão" de si mesma através da diagonal principal.
]

== Exemplo resolvido

#example(name: "Soma, produto e determinante de matrizes", id: "ex-soma-produto-determinante")[
  Sejam $A = mat(1,2;3,4)$ e $B = mat(5,6;7,8)$.

  *Soma*: $A+B = mat(6,8;10,12)$.

  *Produto*: $A B = mat(1(5)+2(7), 1(6)+2(8); 3(5)+4(7), 3(6)+4(8)) = mat(19,22;43,50)$.

  *Determinante por Sarrus* de $C = mat(1,2,3;0,1,4;5,6,0)$: repetindo as colunas 1--2, as diagonais descendentes dão $1(1)(0)+2(4)(5)+3(0)(6) = 0+40+0=40$; as ascendentes dão $3(1)(5)+1(4)(6)+2(0)(0)=15+24+0=39$. $det(C) = 40-39=1$.

  *Matriz simétrica*: $D = mat(2,3;3,5)$ satisfaz $D^T=D$ -- é simétrica.
]

= Sistemas de Equações Lineares
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.2]

== Introdução

Em Geometria Analítica, um sistema de equações lineares tem interpretação geométrica direta: cada equação representa uma reta (no plano) ou um plano (no espaço), e resolver o sistema significa encontrar a interseção comum entre elas.

== Definições formais

#definition(name: "Sistema linear como interseção geométrica", id: "def-sistema-interseccao-geometrica")[
  Um sistema $A x = b$ com 2 equações e 2 incógnitas representa a interseção de duas *retas* no plano; com 3 equações e 3 incógnitas, a interseção de três *planos* no espaço (07). A classificação do sistema (Possível Determinado, Possível Indeterminado, Impossível -- ver Álgebra Linear, 1.1, para o método de resolução por eliminação de Gauss) corresponde geometricamente a: retas/planos que se cruzam em um único ponto; retas/planos coincidentes ou que se cruzam em uma reta comum (infinitos pontos); ou retas/planos paralelos distintos (nenhuma interseção comum).
]

== Exemplo resolvido

#example(name: "Interpretação geométrica de um sistema 2×2", id: "ex-interpretacao-geometrica-sistema")[
  O sistema $x+y=3$, $2x-y=0$ representa duas retas no plano. Resolvendo (substituição ou Gauss): da segunda equação, $y=2x$; substituindo na primeira, $x+2x=3 arrow.r.double x=1$, $y=2$. As retas se cruzam em um único ponto $(1,2)$ -- sistema Possível Determinado. Já o sistema $x+y=3$, $x+y=5$ representa duas retas *paralelas distintas* (mesmo coeficiente angular, interceptos diferentes) -- sem solução, sistema Impossível.
]

== Atenção -- pegadinhas comuns

#remark(name: "Regra de Sarrus só vale para matrizes 3×3")[
  Aplicar a regra de Sarrus (diagonais) a matrizes $4 times 4$ ou maiores produz um resultado *incorreto* -- para ordem $n >= 4$, é obrigatório usar expansão de Laplace (ou eliminação de Gauss adaptada para calcular determinante via produto dos pivôs).
]

#remark(name: "Produto matricial não é comutativo, mesmo quando ambos os produtos existem")[
  Em geral, $A B eq.not B A$, mesmo quando as dimensões permitem calcular ambos os produtos -- ordem importa em multiplicação de matrizes, diferente da multiplicação de números reais.
]

== Questões estilo POSCOMP

*Questão 1.* O determinante de $mat(2,0,1;1,3,0;0,2,4)$, calculado pela regra de Sarrus, é:
- a) $26$.
- b) $22$.
- c) $18$.
- d) $24$.
- e) $16$.

*Questão 2.* Uma matriz $A$ é simétrica quando:
- a) $det(A) = 0$.
- b) $A = A^T$.
- c) $A$ é a matriz identidade.
- d) $A$ tem apenas zeros fora da diagonal.
- e) $A^2 = A$.

*Questão 3.* Um sistema de duas equações lineares com duas incógnitas, cujas retas associadas são paralelas e distintas, é:
- a) Possível determinado.
- b) Possível indeterminado.
- c) Impossível.
- d) Homogêneo.
- e) Indefinido, sem classificação possível.

== Gabarito comentado

1. *(a)* -- expandindo pela primeira linha: $2(3 dot 4 - 0 dot 2) - 0(1 dot 4 - 0 dot 0) + 1(1 dot 2 - 3 dot 0) = 2(12) - 0 + 1(2) = 24+2=26$.
2. *(b)* -- definição direta de matriz simétrica.
3. *(c)* -- retas paralelas distintas nunca se cruzam: sistema sem solução, impossível.

== Referências

- LEDESMA, D. S. *Apostila de Geometria Analítica*. UNICAMP. Cap. 2--6 (Matrizes, determinantes, sistemas lineares).
- WINTERLE, P. *Vetores e Geometria Analítica*. Cap. 1 (Matrizes e sistemas).
- Álgebra Linear (1.1, Sistemas de Equações Lineares) -- método de eliminação de Gauss detalhado.
