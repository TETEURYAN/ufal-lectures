#import "@preview/mousse-notes:1.1.0": *

= Transformações em Espaços com Produto Interno
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.15]

== Introdução

Quando o espaço vetorial de 05 tem, além disso, um produto interno (07), a representação matricial de uma transformação linear ganha uma simplificação importante -- e abre caminho para os operadores especiais (adjunta, simétrico, ortogonal, normal) tratados em 11.

== Definições formais

#definition(name: "Matriz de um operador em base ortonormal", id: "def-matriz-operador-ortonormal")[
  Se $cal(B) = \{e_1,dots,e_n\}$ é uma base *ortonormal* de um espaço com produto interno $V$, a entrada $(i,j)$ da matriz de um operador linear $T: V -> V$ em relação a $cal(B)$ é simplesmente $angle.l T(e_j), e_i angle.r$ -- sem precisar resolver um sistema linear para expressar $T(e_j)$ em coordenadas, como seria necessário em uma base qualquer (05). Essa simplificação é a razão prática mais imediata para preferir trabalhar em bases ortonormais.
]

== Exemplo resolvido

#example(name: "Matriz de um operador via produtos internos", id: "ex-matriz-operador-produtos-internos")[
  Seja $T: RR^2 -> RR^2$, $T(x,y) = (x+2y, 3x-y)$, e $cal(B) = \{e_1,e_2\}$ a base canônica (ortonormal em relação ao produto escalar usual). A entrada $(1,1)$ da matriz é $angle.l T(e_1),e_1 angle.r$: $T(e_1)=T(1,0)=(1,3)$, e $angle.l (1,3),(1,0) angle.r = 1$. Analogamente, calculando as demais entradas ($angle.l T(e_1),e_2 angle.r=3$, $angle.l T(e_2),e_1 angle.r=2$, $angle.l T(e_2),e_2 angle.r=-1$), obtém-se diretamente:
  $ [T] = mat(1,2;3,-1) $
  coincidindo com o método direto (colunas = imagens dos vetores da base) de 05 -- a vantagem do método via produto interno aparece em bases ortonormais *não canônicas*, onde o método direto exigiria resolver um sistema para cada coluna.
]

== Atenção -- pegadinhas comuns

#remark(name: "A simplificação exige base ortonormal -- não vale para uma base qualquer")[
  A fórmula $[T]_(i j) = angle.l T(e_j),e_i angle.r$ só é válida quando $\{e_i\}$ é uma base *ortonormal*. Em uma base apenas ortogonal (não normalizada) ou não ortogonal, a fórmula precisa de ajustes (dividir pela norma ao quadrado de cada vetor, ou resolver o sistema completo) -- aplicá-la ingenuamente a uma base não ortonormal produz uma matriz incorreta.
]

== Questões estilo POSCOMP

*Questão 1.* Em uma base ortonormal $\{e_1,dots,e_n\}$, a entrada $(i,j)$ da matriz de um operador $T$ é dada por:
- a) $T(e_i) + T(e_j)$.
- b) $angle.l T(e_j), e_i angle.r$.
- c) $angle.l e_i, e_j angle.r$.
- d) $det(T)$.
- e) A norma de $e_j$.

*Questão 2.* A simplificação de calcular a matriz de um operador via produtos internos, como nesta seção, é válida:
- a) Para qualquer base, ortonormal ou não.
- b) Apenas quando a base é ortonormal.
- c) Apenas em $RR^2$.
- d) Apenas para operadores diagonalizáveis.
- e) Apenas quando o operador é a identidade.

== Gabarito comentado

1. *(b)* -- definição direta apresentada nesta seção.
2. *(b)* -- a fórmula depende crucialmente de ortonormalidade da base, conforme a observação desta seção.

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 4, 7.
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 6--7.
- AXLER, S. *Linear Algebra Done Right*. Cap. 6 (Espaços com produto interno).
