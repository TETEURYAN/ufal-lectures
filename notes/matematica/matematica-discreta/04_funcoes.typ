#import "@preview/mousse-notes:1.1.0": *

= Funções
#text(size: 9pt, style: "italic")[Edital POSCOMP: 6.4]

== Introdução

Função é provavelmente o conceito matemático mais usado em ciência da computação -- mas sua definição formal, em termos de pares ordenados (03) e relações (06), é frequentemente esquecida em favor da noção informal de "máquina que transforma entrada em saída". Esta subseção fecha essa lacuna.

== Definições formais

#definition(name: "Função", id: "def-funcao")[
  Uma função $f: A -> B$ é uma relação $f subset.eq A times B$ (03) satisfazendo:
  + *Totalidade*: para todo $a in A$, existe pelo menos um $b in B$ tal que $(a,b) in f$.
  + *Unicidade*: se $(a,b_1) in f$ e $(a,b_2) in f$, então $b_1 = b_2$.
  Em outras palavras, cada elemento de $A$ (o *domínio*) está associado a *exatamente um* elemento de $B$ (o *contradomínio*). O conjunto ${f(a) : a in A} subset.eq B$ é a *imagem* de $f$.
]

#definition(name: "Classificação de funções", id: "def-classificacao-funcoes")[
  - *Injetora (um-a-um)*: $a_1 eq.not a_2 arrow.r.double f(a_1) eq.not f(a_2)$ -- elementos distintos do domínio têm imagens distintas.
  - *Sobrejetora*: para todo $b in B$, existe $a in A$ tal que $f(a) = b$ -- a imagem coincide com todo o contradomínio.
  - *Bijetora*: injetora *e* sobrejetora simultaneamente -- estabelece uma correspondência um-a-um entre $A$ e $B$ (base da definição de cardinalidades iguais entre conjuntos, inclusive infinitos).
]

== Exemplo resolvido

#example(name: "Classificando três funções", id: "ex-classificando-funcoes")[
  - $f: ZZ -> ZZ$, $f(x) = 2x$: *injetora* (valores distintos de $x$ geram valores distintos de $2x$), mas *não sobrejetora* (nenhum $x$ inteiro satisfaz $2x=3$, por exemplo) -- logo não é bijetora.
  - $g: RR -> RR$, $g(x) = x^2$: *não injetora* ($g(-2)=g(2)=4$), *não sobrejetora* (nenhum $x$ real satisfaz $x^2=-1$) -- nem injetora, nem sobrejetora.
  - $h: RR -> RR$, $h(x) = x^3$: *injetora* (função estritamente crescente) e *sobrejetora* (todo real tem raiz cúbica real) -- portanto *bijetora*.
]

== Atenção -- pegadinhas comuns

#remark(name: "Toda função é uma relação, mas nem toda relação é uma função")[
  Uma relação $R subset.eq A times B$ qualquer não precisa satisfazer totalidade nem unicidade -- pode deixar elementos de $A$ sem correspondente, ou associar um mesmo $a$ a múltiplos $b$'s. Função é uma relação *especial*, restrita por essas duas condições extras. A distinção completa entre relação geral e suas propriedades (reflexiva, simétrica, etc.) é tratada em 06.
]

#remark(name: "Sobrejetividade depende do contradomínio declarado, não só da \"fórmula\"")[
  A mesma fórmula $f(x)=x^2$ é sobrejetora se declarada como $f: RR -> [0,infinity)$ (contradomínio restrito à imagem real), mas não sobrejetora se declarada como $f: RR -> RR$. Classificar uma função exige sempre considerar o contradomínio *declarado*, não apenas o comportamento da fórmula.
]

== Questões estilo POSCOMP

*Questão 1.* Uma função $f: A -> B$ é dita sobrejetora quando:
- a) $a_1 eq.not a_2 arrow.r.double f(a_1) eq.not f(a_2)$.
- b) Para todo $b in B$, existe $a in A$ tal que $f(a)=b$.
- c) $f$ não está definida para todo elemento de $A$.
- d) $abs(A) = abs(B)$ necessariamente.
- e) $f$ é também uma relação de equivalência.

*Questão 2.* A função $f: NN -> NN$, $f(x) = x+1$, é:
- a) Bijetora.
- b) Injetora, mas não sobrejetora (pois $0$ não é imagem de nenhum natural).
- c) Sobrejetora, mas não injetora.
- d) Nem injetora, nem sobrejetora.
- e) Não é uma função.

*Questão 3.* Sobre a relação entre funções e relações, é correto afirmar que:
- a) Toda relação é uma função.
- b) Toda função é uma relação que satisfaz totalidade e unicidade.
- c) Funções e relações são conceitos completamente independentes.
- d) Apenas relações simétricas podem ser funções.
- e) Uma função nunca pode ser vista como um conjunto de pares ordenados.

== Gabarito comentado

1. *(b)* -- definição direta de sobrejetividade.
2. *(b)* -- $f(x)=x+1$ é injetora (crescente estrita), mas $0 in NN$ não é imagem de nenhum $x in NN$ (já que $x+1>=1$), logo não sobrejetora.
3. *(b)* -- definição direta desta seção: função é relação satisfazendo totalidade e unicidade.

== Referências

- ROSEN, K. H. *Matemática Discreta e suas Aplicações*. Cap. 2 (Funções).
- SCHEINERMAN, E. R. *Matemática Discreta: Uma Introdução*. Cap. 5.
- HALMOS, P. *Naive Set Theory* (1960).
