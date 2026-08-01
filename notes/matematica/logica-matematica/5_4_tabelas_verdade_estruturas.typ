#import "@preview/mousse-notes:1.1.0": *

= 5.4 --- Tabelas Verdade e Estruturas de Primeira Ordem

== Introdução

Enquanto 5.2/5.3 tratam de sintaxe, esta subseção introduz a *semântica*: como atribuir significado (valor-verdade) a uma fórmula. Para lógica proposicional, isso é feito por tabelas-verdade; para lógica de primeira ordem, por estruturas (domínio + interpretação). É o item mais operacional da disciplina -- construir e ler tabelas-verdade corretamente é habilidade certa em prova.

== Definições formais

#definition(name: "Tabela-verdade dos conectivos básicos", id: "def-tabela-verdade-conectivos")[
  #table(
    columns: 6,
    [*$p$*], [*$q$*], [*$not p$*], [*$p and q$*], [*$p or q$*], [*$p -> q$*],
    [V], [V], [F], [V], [V], [V],
    [V], [F], [F], [F], [V], [F],
    [F], [V], [V], [F], [V], [V],
    [F], [F], [V], [F], [F], [V],
  )
  A condicional $p -> q$ só é falsa quando $p$ é verdadeiro e $q$ é falso -- é o caso mais frequentemente errado por quem constrói tabelas-verdade pela primeira vez.
]

#definition(name: "Tautologia, contradição, contingência e satisfazibilidade", id: "def-tautologia-contradicao")[
  - *Tautologia*: fórmula verdadeira em *todas* as linhas de sua tabela-verdade (verdadeira sob qualquer atribuição).
  - *Contradição (insatisfazível)*: falsa em *todas* as linhas.
  - *Contingência*: verdadeira em algumas linhas e falsa em outras.
  - *Satisfazível*: verdadeira em *pelo menos uma* linha (tautologias e contingências são satisfazíveis; contradições não).
]

#definition(name: "Estrutura de primeira ordem", id: "def-estrutura-primeira-ordem")[
  Uma estrutura $cal(M)$ para uma linguagem de primeira ordem consiste em um *domínio* não vazio $D$ (o universo de discurso) e uma *interpretação*: cada constante é mapeada para um elemento de $D$; cada símbolo de função $n$-ária, para uma função $D^n -> D$; cada símbolo de predicado $n$-ário, para uma relação sobre $D^n$. Uma sentença $phi$ é *verdadeira em $cal(M)$* (notação $cal(M) models phi$) se sua interpretação, seguindo essa estrutura, resulta em verdadeiro.
]

== Exemplo resolvido

#example(name: "Tabela-verdade de uma fórmula composta", id: "ex-tabela-verdade-composta")[
  Construindo a tabela-verdade de $(p -> q) and (not q or p)$:

  #table(
    columns: 6,
    [*$p$*], [*$q$*], [*$p -> q$*], [*$not q$*], [*$not q or p$*], [*$(p->q) and (not q or p)$*],
    [V], [V], [V], [F], [V], [V],
    [V], [F], [F], [V], [V], [F],
    [F], [V], [V], [F], [F], [F],
    [F], [F], [V], [V], [V], [V],
  )

  A fórmula é *contingência*: verdadeira em duas linhas (VV e FF) e falsa em outras duas -- não é tautologia nem contradição.
]

#example(name: "Estrutura de primeira ordem para os naturais", id: "ex-estrutura-naturais")[
  Para a linguagem com símbolo de predicado binário $<$ e constante $0$, considere a estrutura $cal(M)$ com domínio $D = NN$, interpretando $<$ como a ordem usual e $0$ como o número zero. A sentença $forall x, (0 < x or x = 0)$ é verdadeira em $cal(M)$ ($cal(M) models phi$), pois todo natural é maior que zero ou igual a zero. Se trocássemos o domínio para $D = ZZ$ (mesma interpretação de $<$), a mesma sentença seria *falsa* (ex.: $x=-1$ viola ambas as disjunções) -- ilustrando que verdade depende da estrutura, não só da fórmula.
]

== Atenção -- pegadinhas comuns

#remark(name: "Condicional falsa só em um único caso")[
  O erro mais comum ao montar tabelas-verdade é esquecer que $p -> q$ é *verdadeira* quando $p$ é falso, independentemente de $q$ ("do falso segue-se qualquer coisa") -- só a linha $p$=V, $q$=F torna a condicional falsa.
]

#remark(name: "Satisfazível não é o mesmo que tautologia")[
  Uma fórmula satisfazível só precisa ser verdadeira em *pelo menos uma* linha -- uma contingência é satisfazível, mas não é tautologia. Confundir "satisfazível" com "sempre verdadeira" é pegadinha recorrente.
]

== Questões estilo POSCOMP

*Questão 1.* A fórmula $p or not p$ é classificada como:
- a) Contradição.
- b) Contingência.
- c) Tautologia.
- d) Insatisfazível.
- e) Indecidível.

*Questão 2.* Considerando a tabela-verdade de $p -> q$, o único caso em que essa fórmula é falsa ocorre quando:
- a) $p$ é falso e $q$ é falso.
- b) $p$ é verdadeiro e $q$ é verdadeiro.
- c) $p$ é verdadeiro e $q$ é falso.
- d) $p$ é falso e $q$ é verdadeiro.
- e) Nunca é falsa.

*Questão 3.* Sobre a fórmula $p and not p$, é correto afirmar que:
- a) É uma tautologia.
- b) É uma contradição, portanto insatisfazível.
- c) É uma contingência.
- d) É satisfazível, mas não é tautologia.
- e) Seu valor depende do domínio de interpretação.

*Questão 4.* Na estrutura $cal(M)$ com domínio $D=NN$ e $<$ interpretado como a ordem usual, a sentença $exists x, forall y, x <= y$ é:
- a) Falsa, pois não há menor natural.
- b) Verdadeira, testemunhada por $x=0$.
- c) Indefinida, pois $<=$ não foi declarado na linguagem.
- d) Verdadeira apenas se o domínio for os inteiros.
- e) Uma fórmula, não uma sentença.

== Gabarito comentado

1. *(c)* -- $p or not p$ (princípio do terceiro excluído) é verdadeira em toda linha, logo tautologia.
2. *(c)* -- conforme a tabela-verdade de $->$ desta seção.
3. *(b)* -- $p$ e $not p$ nunca são ambos verdadeiros, logo a conjunção é falsa em toda linha: contradição.
4. *(b)* -- $0$ é o menor elemento de $NN$ com a ordem usual, testemunhando a sentença como verdadeira.

== Referências

- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 1 (Tabelas-verdade) e Cap. 2 (Estruturas).
- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 2 (Estruturas e satisfação).
