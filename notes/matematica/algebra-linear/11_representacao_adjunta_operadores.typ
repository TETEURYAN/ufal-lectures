#import "@preview/mousse-notes:1.1.0": *

= O Teorema da Representação para Funções Lineares
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.16]

== Introdução

Esta subseção reúne três conceitos estreitamente ligados: como um funcional linear (uma "função que produz um número") sempre corresponde a um produto interno com um vetor fixo; como isso permite definir a *adjunta* de uma transformação; e como certos operadores especiais (simétrico, ortogonal/unitário, normal) se caracterizam em termos da adjunta.

== Definições formais

#definition(name: "Teorema da Representação (Riesz, dimensão finita)", id: "def-teorema-representacao")[
  Seja $V$ um espaço vetorial de dimensão finita com produto interno, e $f: V -> RR$ um *funcional linear* (transformação linear com valores escalares). Então existe um único vetor $u in V$ tal que $f(v) = angle.l v,u angle.r$ para todo $v in V$ -- todo funcional linear é, essencialmente, "produto interno contra um vetor fixo".
]

= Adjunta de uma Transformação Linear
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.17]

== Definições formais

#definition(name: "Transformação adjunta", id: "def-transformacao-adjunta")[
  Dado um operador linear $T: V -> V$ em um espaço com produto interno, a *adjunta* $T^*$ é o único operador satisfazendo $angle.l T(u),v angle.r = angle.l u, T^*(v) angle.r$ para todos $u,v in V$ (existência garantida pelo Teorema da Representação). Em coordenadas, com base ortonormal, a matriz de $T^*$ é a *transposta conjugada* da matriz de $T$ -- no caso real (sem números complexos), simplesmente a *transposta*: $[T^*] = [T]^T$.
]

= Operadores Simétricos, Unitários, Ortogonais e Normais
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.18]

== Definições formais

#definition(name: "Operadores especiais via adjunta", id: "def-operadores-especiais")[
  - *Simétrico (autoadjunto)*: $T = T^*$, isto é, $A = A^T$ (matriz simétrica).
  - *Ortogonal* (espaços reais) *ou unitário* (espaços complexos): $T^* = T^(-1)$, isto é, $A^T A = I$ -- preserva produto interno (e, portanto, norma e ângulo).
  - *Normal*: $T T^* = T^* T$ (comuta com sua própria adjunta) -- generaliza simétrico e ortogonal/unitário simultaneamente (ambos são casos particulares de operador normal).
]

== Exemplo resolvido

#example(name: "Verificando se uma matriz é simétrica e calculando sua adjunta", id: "ex-verificar-simetrica-adjunta")[
  Seja $A = mat(2,1;1,3)$. Como $A^T = mat(2,1;1,3) = A$, a matriz é *simétrica*, logo $T=T^*$ (o operador é autoadjunto) -- a adjunta de $T$ é o próprio $T$, sem necessidade de calcular nada além de transpor (e constatar que a transposta coincide com a original).

  Já para $B = mat(0,-1;1,0)$ (rotação de $90°$, vista em 08): $B^T = mat(0,1;-1,0) eq.not B$ (não simétrica), mas $B^T B = mat(0,1;-1,0)mat(0,-1;1,0) = mat(1,0;0,1) = I$ -- *ortogonal*, apesar de não ser simétrica. Isso ilustra que simetria e ortogonalidade são propriedades independentes (uma matriz pode ter uma, ambas, ou nenhuma).
]

== Atenção -- pegadinhas comuns

#remark(name: "Simétrico, ortogonal e normal são categorias relacionadas, mas distintas")[
  Toda matriz simétrica é normal ($A A^T = A^T A$, pois $A=A^T$); toda matriz ortogonal também é normal ($A A^T = I = A^T A$) -- mas nem toda matriz normal é simétrica ou ortogonal (existem exemplos que só satisfazem a condição mais geral de comutar com a própria adjunta). A hierarquia é: simétrico ⊂ normal, e ortogonal ⊂ normal, mas simétrico e ortogonal são categorias que se sobrepõem apenas em casos particulares.
]

#remark(name: "Adjunta no caso real é apenas a transposta -- não confunda com inversa")[
  Para espaços vetoriais reais (sem números complexos), a adjunta $T^*$ corresponde exatamente à matriz transposta $A^T$ -- *não* à inversa $A^(-1)$, exceto no caso especial de matrizes ortogonais, onde $A^T = A^(-1)$ coincidem por definição.
]

== Questões estilo POSCOMP

*Questão 1.* Segundo o Teorema da Representação, todo funcional linear $f: V -> RR$ pode ser escrito como:
- a) $f(v) = det(v)$.
- b) $f(v) = angle.l v,u angle.r$, para um único vetor $u$ fixo.
- c) $f(v) = v^2$.
- d) $f(v) = 0$ para todo $v$.
- e) $f(v)$ não pode ser representado por produto interno em geral.

*Questão 2.* No caso real, a matriz da adjunta de um operador $T$, em relação a uma base ortonormal, é:
- a) A inversa de $[T]$.
- b) A transposta de $[T]$.
- c) Igual a $[T]$, sempre.
- d) A matriz nula.
- e) O determinante de $[T]$.

*Questão 3.* Um operador $T$ é dito normal quando:
- a) $T = T^*$ apenas.
- b) $T^* = T^(-1)$ apenas.
- c) $T T^* = T^* T$ (comuta com sua adjunta).
- d) $T$ é a identidade.
- e) $det(T) = 0$.

== Gabarito comentado

1. *(b)* -- enunciado direto do Teorema da Representação de Riesz.
2. *(b)* -- no caso real, adjunta corresponde à transposta, conforme esta seção.
3. *(c)* -- definição direta de operador normal: comuta com a própria adjunta.

== Referências

- AXLER, S. *Linear Algebra Done Right*. Cap. 7 (Operadores em espaços com produto interno).
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 6--7.
- HOFFMAN, K.; KUNZE, R. *Linear Algebra*. Cap. 9 (Operadores adjuntos).
