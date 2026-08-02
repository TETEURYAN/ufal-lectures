#import "@preview/mousse-notes:1.1.0": *

= Iteração, Indução e Recursão
#text(size: 9pt, style: "italic")[Edital POSCOMP: 6.1]

== Introdução

Indução e recursão são conceitos gêmeos, mas distintos: indução é uma técnica de *prova* sobre os naturais; recursão é uma técnica de *definição* (de funções, estruturas ou algoritmos). Ambas exploram a mesma ideia estrutural -- reduzir o caso geral a um caso menor mais um caso base -- e são a base formal de toda prova de correção de algoritmo recursivo.

== Definições formais

#definition(name: "Princípio da Indução Matemática (fraca)", id: "def-inducao-fraca")[
  Para provar que uma propriedade $P(n)$ vale para todo $n >= n_0$ (tipicamente $n_0 = 0$ ou $1$), basta provar:
  + *Caso base*: $P(n_0)$ é verdadeira.
  + *Passo indutivo*: para todo $k >= n_0$, se $P(k)$ é verdadeira (*hipótese de indução*), então $P(k+1)$ também é verdadeira.
  Conclui-se, pelo princípio, que $P(n)$ vale para todo $n >= n_0$.
]

#definition(name: "Indução forte (ou completa)", id: "def-inducao-forte")[
  Variante em que o passo indutivo assume a hipótese para *todos* os valores anteriores, não apenas o imediatamente anterior: se $P(n_0), P(n_0+1), dots, P(k)$ são todas verdadeiras, então $P(k+1)$ também é -- útil quando reduzir $k+1$ ao caso $k$ isoladamente não é suficiente (ex.: provas sobre fatoração em primos, onde a redução pode "pular" para um valor bem menor que $k$).
]

#definition(name: "Definição recursiva", id: "def-definicao-recursiva")[
  Define um objeto (função, sequência, estrutura) em termos de si mesmo, aplicado a uma instância *menor*, mais um ou mais *casos base* que não dependem da própria definição -- estruturalmente análoga à indução, mas usada para *construir* objetos, não para *provar* propriedades sobre eles. A implementação prática de funções recursivas (recursão direta/indireta, pilha de chamadas, estouro de pilha) é tratada em Algoritmos e Estruturas de Dados, subtópico 9.4; aqui o foco é a definição matemática formal.
]

== Exemplo resolvido

#example(name: "Prova por indução: soma dos primeiros n naturais", id: "ex-prova-inducao-soma")[
  Provar que $sum_(i=1)^n i = (n(n+1))/2$ para todo $n >= 1$.

  *Caso base* ($n=1$): $sum_(i=1)^1 i = 1$, e $(1 dot 2)/2 = 1$. ✓

  *Passo indutivo*: suponha (hipótese de indução) que $sum_(i=1)^k i = (k(k+1))/2$ vale para algum $k >= 1$. Mostrar para $k+1$:
  $ sum_(i=1)^(k+1) i = sum_(i=1)^k i + (k+1) = (k(k+1))/2 + (k+1) = ((k+1)(k+2))/2 $
  que é exatamente a fórmula para $n=k+1$. Como base e passo estão provados, pelo princípio da indução a fórmula vale para todo $n >= 1$.
]

#example(name: "Definição recursiva do fatorial", id: "ex-definicao-recursiva-fatorial")[
  $ n! = cases(1 & "se" n = 0 "(caso base)", n times (n-1)! & "se" n > 0 "(passo recursivo)") $
  Cada aplicação reduz o problema ($n!$) a uma instância estritamente menor ($(n-1)!$), garantindo terminação no caso base $0! = 1$ -- a mesma estrutura de base + redução vista na indução, agora usada para *definir* uma função, não para provar uma propriedade sobre ela.
]

== Atenção -- pegadinhas comuns

#remark(name: "Indução prova; recursão define -- não são a mesma coisa")[
  Um erro comum é tratar "prova por indução" e "definição recursiva" como sinônimos só porque compartilham a estrutura base+redução. Indução é uma *técnica de demonstração* de uma propriedade já enunciada sobre todos os naturais; recursão é uma *técnica de construção* de um objeto (a definição em si). É possível definir algo recursivamente e depois precisar de indução para provar uma propriedade sobre essa definição -- os dois frequentemente aparecem juntos, mas com papéis diferentes.
]

#remark(name: "Indução forte não é \"mais poderosa\" que a fraca -- são equivalentes em força lógica")[
  Apesar do nome, indução forte e fraca provam exatamente a mesma classe de propriedades sobre os naturais (são logicamente equivalentes) -- a diferença é de *conveniência*: certas provas ficam mais naturais assumindo toda a história até $k$, em vez de apenas $P(k)$.
]

== Questões estilo POSCOMP

*Questão 1.* No princípio da indução matemática fraca, o passo indutivo consiste em provar que:
- a) $P(n_0)$ é verdadeira.
- b) $P(k) arrow.r.double P(k+1)$, para todo $k >= n_0$.
- c) $P(n)$ é falsa para algum $n$.
- d) $P(k-1) arrow.r.double P(k)$, apenas para $k = n_0$.
- e) A propriedade vale apenas para $n = n_0$.

*Questão 2.* A definição recursiva do fatorial ($0! = 1$; $n! = n times (n-1)!$ para $n>0$) tem como caso base:
- a) $n! = n times (n-1)!$.
- b) $0! = 1$.
- c) Não possui caso base.
- d) $1! = 1!$.
- e) $n = infinity$.

*Questão 3.* A indução forte se diferencia da indução fraca porque, no passo indutivo:
- a) Assume-se apenas $P(k)$ para provar $P(k+1)$.
- b) Assume-se $P(n_0), dots, P(k)$ (toda a história anterior) para provar $P(k+1)$.
- c) Não há necessidade de caso base.
- d) Prova-se apenas para números pares.
- e) É estritamente mais poderosa em força lógica que a fraca.

== Gabarito comentado

1. *(b)* -- definição direta do passo indutivo na indução fraca.
2. *(b)* -- $0!=1$ é o único caso não definido em termos de si mesmo, logo o caso base.
3. *(b)* -- é a definição direta de indução forte, usando toda a história até $k$, e não apenas $P(k)$.

== Referências

- ROSEN, K. H. *Matemática Discreta e suas Aplicações*. Cap. 5 (Indução e recursão).
- SCHEINERMAN, E. R. *Matemática Discreta: Uma Introdução*. Cap. 3--4.
- Algoritmos e Estruturas de Dados (9.4, Recursividade) -- implementação prática de funções recursivas.
