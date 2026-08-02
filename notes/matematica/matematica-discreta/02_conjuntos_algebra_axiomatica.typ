#import "@preview/mousse-notes:1.1.0": *

= Conjuntos e Álgebra de Conjuntos como uma Teoria Axiomática
#text(size: 9pt, style: "italic")[Edital POSCOMP: 6.2]

== Introdução

Tratar conjuntos *axiomaticamente* (não apenas intuitivamente, "coleção de objetos") evita paradoxos (como o paradoxo de Russell) e fundamenta rigorosamente todas as estruturas discretas que seguem nesta disciplina -- de pares ordenados (03) a relações (06) e estruturas algébricas (07).

== Definições formais

#definition(name: "Conjunto e pertinência (visão axiomática)", id: "def-conjunto-axiomatico")[
  Formalmente (teoria dos conjuntos de Zermelo-Fraenkel, ZFC), "conjunto" e "pertinência" ($in$) são noções primitivas, governadas por axiomas (ex.: extensionalidade -- dois conjuntos são iguais se têm exatamente os mesmos elementos) que evitam construções autorreferentes problemáticas. Para os propósitos desta disciplina, adota-se a visão *ingênua* (naive) usual, mas com o cuidado de sempre justificar igualdades e operações formalmente, não apenas por diagramas.
]

#definition(name: "Operações básicas sobre conjuntos", id: "def-operacoes-conjuntos")[
  Para conjuntos $A, B$ em um universo $U$:
  - *União*: $A union B = {x : x in A " ou " x in B}$.
  - *Interseção*: $A inter B = {x : x in A " e " x in B}$.
  - *Diferença*: $A - B = {x : x in A " e " x in.not B}$.
  - *Complemento*: $A^c = U - A = {x in U : x in.not A}$.
]

#figure(
  image("figures/venn-intersection.svg", width: 40%),
  caption: [Diagrama de Venn da interseção $A inter B$: útil para intuição, mas não substitui a prova formal por dupla inclusão. Fonte: Wikimedia Commons, domínio público.],
)

== Propriedade relevante

#theorem(name: "Leis de De Morgan para conjuntos", id: "thm-de-morgan-conjuntos")[
  Para quaisquer conjuntos $A, B subset.eq U$:
  $ (A union B)^c = A^c inter B^c, quad quad (A inter B)^c = A^c union B^c $
]

#proof[
  Prova por *dupla inclusão* de $(A union B)^c = A^c inter B^c$: (⊆) seja $x in (A union B)^c$; então $x in.not (A union B)$, isto é, $x in.not A$ e $x in.not B$; logo $x in A^c$ e $x in B^c$, ou seja, $x in A^c inter B^c$. (⊇) seja $x in A^c inter B^c$; então $x in.not A$ e $x in.not B$, logo $x in.not (A union B)$, isto é, $x in (A union B)^c$. Como cada lado está contido no outro, os conjuntos são iguais. A segunda identidade segue por argumento simétrico.
]

== Exemplo resolvido

#example(name: "Prova de igualdade de conjuntos por dupla inclusão", id: "ex-prova-dupla-inclusao")[
  Provar que $A - B = A inter B^c$.

  (⊆) Seja $x in A - B$. Por definição, $x in A$ e $x in.not B$. Como $x in.not B$, temos $x in B^c$. Logo $x in A$ e $x in B^c$, isto é, $x in A inter B^c$.

  (⊇) Seja $x in A inter B^c$. Então $x in A$ e $x in B^c$, isto é, $x in.not B$. Logo $x in A$ e $x in.not B$, que é exatamente a definição de $x in A - B$.

  Como cada conjunto está contido no outro, $A - B = A inter B^c$. ∎
]

== Atenção -- pegadinhas comuns

#remark(name: "Dupla inclusão é o método padrão para provar igualdade de conjuntos")[
  Desenhar um diagrama de Venn pode *sugerir* que dois conjuntos são iguais, mas não constitui prova formal -- o método rigoroso e esperado em prova é sempre mostrar $A subset.eq B$ e $B subset.eq A$ separadamente (dupla inclusão), como no exemplo desta seção.
]

#remark(name: "Complemento depende do universo U escolhido")[
  $A^c$ só tem significado bem definido em relação a um universo $U$ fixado -- o mesmo conjunto $A$ pode ter complementos diferentes conforme o universo considerado. Omitir ou trocar o universo no meio de uma prova é um erro sutil e recorrente.
]

== Questões estilo POSCOMP

*Questão 1.* Segundo as Leis de De Morgan, $(A inter B)^c$ é igual a:
- a) $A^c inter B^c$.
- b) $A union B$.
- c) $A^c union B^c$.
- d) $A - B$.
- e) $B - A$.

*Questão 2.* O método padrão e rigoroso para provar que dois conjuntos $A$ e $B$ são iguais é:
- a) Desenhar um diagrama de Venn e verificar visualmente.
- b) Mostrar que $A subset.eq B$ e $B subset.eq A$ (dupla inclusão).
- c) Mostrar apenas que $A subset.eq B$.
- d) Contar o número de elementos de cada conjunto.
- e) Assumir que são iguais se tiverem nomes parecidos.

*Questão 3.* O complemento de um conjunto $A$:
- a) É definido independentemente de qualquer universo.
- b) É sempre o conjunto vazio.
- c) Depende do universo $U$ considerado.
- d) É sempre igual a $A$.
- e) Não pode ser calculado para conjuntos infinitos.

== Gabarito comentado

1. *(c)* -- segunda lei de De Morgan, conforme o teorema desta seção.
2. *(b)* -- dupla inclusão é o método formal padrão, conforme a observação desta seção.
3. *(c)* -- complemento é relativo a um universo $U$ fixado, conforme a definição desta seção.

== Referências

- ROSEN, K. H. *Matemática Discreta e suas Aplicações*. Cap. 2 (Conjuntos).
- HALMOS, P. *Naive Set Theory* (1960) -- referência clássica sobre teoria dos conjuntos.
- SCHEINERMAN, E. R. *Matemática Discreta: Uma Introdução*. Cap. 1.
