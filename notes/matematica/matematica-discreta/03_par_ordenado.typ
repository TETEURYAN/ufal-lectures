#import "@preview/mousse-notes:1.1.0": *

= Par Ordenado
#text(size: 9pt, style: "italic")[Edital POSCOMP: 6.3]

== Introdução

Um par ordenado $(a,b)$ parece trivial -- mas definir "ordem" usando apenas conjuntos (sem introduzir um novo conceito primitivo) é um exercício clássico de fundamentação axiomática, e a base para tudo que depende de ordem: produto cartesiano, relações (06) e funções (04).

== Definições formais

#definition(name: "Par ordenado (definição de Kuratowski)", id: "def-par-ordenado-kuratowski")[
  O par ordenado $(a,b)$ é definido, usando apenas a noção de conjunto, como:
  $ (a,b) := {{a}, {a,b}} $
  Diferente do conjunto $\{a,b\}$ (não ordenado, onde $\{a,b\} = \{b,a\}$), essa construção captura a *ordem* dos elementos dentro da estrutura de conjuntos.
]

#definition(name: "Produto cartesiano", id: "def-produto-cartesiano")[
  Para conjuntos $A, B$: $A times B = {(a,b) : a in A " e " b in B}$ -- o conjunto de todos os pares ordenados com primeira coordenada em $A$ e segunda em $B$. Se $abs(A) = m$ e $abs(B) = n$ (conjuntos finitos), então $abs(A times B) = m n$.
]

== Propriedade relevante

#theorem(name: "Igualdade de pares ordenados", id: "thm-igualdade-pares-ordenados")[
  $(a,b) = (c,d)$ se, e somente se, $a=c$ e $b=d$ -- a propriedade fundamental que justifica chamar $(a,b)$ de "ordenado": a definição de Kuratowski distingue corretamente a ordem dos elementos.
]

#proof[
  Esboço ($arrow.l$, trivial: se $a=c$ e $b=d$, os conjuntos $\{\{a\},\{a,b\}\}$ e $\{\{c\},\{c,d\}\}$ são idênticos). Para ($arrow.r$): suponha $\{\{a\},\{a,b\}\} = \{\{c\},\{c,d\}\}$. Se $a=b$, o lado esquerdo é $\{\{a\}\}$ (conjunto unitário), forçando $c=d=a$. Caso contrário ($a eq.not b$), o lado esquerdo tem dois elementos distintos ($\{a\}$ e $\{a,b\}$); comparando tamanhos e elementos com o lado direito, conclui-se que $\{a\}=\{c\}$ (logo $a=c$) e, substituindo, $\{a,b\}=\{a,d\}$ força $b=d$.
]

== Exemplo resolvido

#example(name: "Produto cartesiano de dois conjuntos pequenos", id: "ex-produto-cartesiano")[
  Sejam $A = \{1,2\}$ e $B = \{x,y,z\}$. Então:
  $ A times B = \{(1,x),(1,y),(1,z),(2,x),(2,y),(2,z)\} $
  com $abs(A times B) = 2 times 3 = 6$, confirmando a fórmula da cardinalidade. Note que $(1,x) eq.not (x,1)$ (nem faria sentido, já que $x in.not A$) -- a ordem das coordenadas é essencial, diferente de um conjunto $\{1,x\}$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Par ordenado não é o mesmo que conjunto de 2 elementos")[
  $(a,b) eq.not \{a,b\}$ em geral: o conjunto $\{a,b\}$ não distingue qual elemento "vem primeiro" ($\{a,b\}=\{b,a\}$), enquanto $(a,b) eq.not (b,a)$ sempre que $a eq.not b$ -- confundir os dois invalida qualquer raciocínio subsequente sobre relações e funções.
]

#remark(name: "Produto cartesiano não é comutativo")[
  Em geral, $A times B eq.not B times A$ (a menos que $A=B$) -- os pares têm coordenadas em posições diferentes, então mesmo que os elementos envolvidos sejam os mesmos, os pares resultantes são estruturalmente distintos.
]

== Questões estilo POSCOMP

*Questão 1.* Segundo a definição de Kuratowski, o par ordenado $(a,b)$ é definido como o conjunto:
- a) $\{a,b\}$.
- b) $\{\{a\},\{a,b\}\}$.
- c) $\{\{a,b\},\{b,a\}\}$.
- d) $\{a\} union \{b\}$.
- e) $\{(a,b)\}$.

*Questão 2.* Se $abs(A)=4$ e $abs(B)=5$, então $abs(A times B)$ é:
- a) $9$.
- b) $20$.
- c) $1$.
- d) $4$.
- e) $5$.

*Questão 3.* Sobre o produto cartesiano, é correto afirmar que, em geral:
- a) $A times B = B times A$ sempre.
- b) $A times B eq.not B times A$, a menos que $A=B$.
- c) $A times B$ é sempre vazio.
- d) $A times B$ não pode ser definido para conjuntos finitos.
- e) $A times B = A inter B$.

== Gabarito comentado

1. *(b)* -- definição direta de Kuratowski apresentada nesta seção.
2. *(b)* -- $abs(A times B) = abs(A) times abs(B) = 4 times 5 = 20$.
3. *(b)* -- produto cartesiano não é comutativo em geral, conforme a observação desta seção.

== Referências

- ROSEN, K. H. *Matemática Discreta e suas Aplicações*. Cap. 2 (Pares ordenados e produto cartesiano).
- KURATOWSKI, K. *Sur la notion de l'ordre dans la Théorie des Ensembles* (1921) -- artigo original da definição.
- HALMOS, P. *Naive Set Theory* (1960).
