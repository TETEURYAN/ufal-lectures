#import "@preview/mousse-notes:1.1.0": *

= Teoria dos Domínios: Ordens Parciais Completas, Continuidade, Ponto Fixo, Domínios, Espaço das Funções
#text(size: 9pt, style: "italic")[Edital POSCOMP: 6.9]

== Introdução

Fechando a disciplina: teoria dos domínios estende ordens parciais (06) para fundamentar rigorosamente a *semântica* de definições recursivas -- como a de 01 -- e de programas que podem não terminar. É a base matemática da semântica denotacional de linguagens de programação; se já existir conteúdo de Semântica Formal em Linguagens de Programação (12.3), esta seção fornece a fundamentação matemática por trás dele -- ainda sem material escrito neste repositório no momento desta seção.

== Definições formais

#definition(name: "Ordem parcial completa (CPO)", id: "def-ordem-parcial-completa")[
  Um conjunto parcialmente ordenado $(D, <=)$ (06) é uma *ordem parcial completa* (CPO) se: (i) possui um elemento mínimo $bot$ ("bottom", representando "indefinido" ou "computação que não termina"); (ii) todo subconjunto *dirigido* $S subset.eq D$ (onde todo par de elementos de $S$ tem uma cota superior em $S$) possui supremo $or.big S$ em $D$. Domínios usados em semântica de linguagens de programação são tipicamente CPOs.
]

#definition(name: "Função contínua (entre CPOs)", id: "def-funcao-continua-cpo")[
  Uma função $f: D -> D'$ entre CPOs é *contínua* se preserva supremos de conjuntos dirigidos: $f(or.big S) = or.big f(S)$ para todo subconjunto dirigido $S subset.eq D$ (junto com monotonicidade: $x<=y arrow.r.double f(x)<=f(y)$). Intuitivamente, o comportamento de $f$ sobre um limite (supremo de uma sequência crescente de aproximações) é determinado pelo comportamento de $f$ sobre as aproximações individuais -- essencial para justificar que definições recursivas *convergem* para um significado bem definido.
]

#definition(name: "Ponto fixo", id: "def-ponto-fixo")[
  Um *ponto fixo* de $f: D -> D$ é um elemento $x in D$ tal que $f(x) = x$. O *Teorema do Ponto Fixo de Kleene* garante que, para $f$ contínua sobre uma CPO com $bot$, o *menor ponto fixo* existe e é dado por:
  $ "lfp"(f) = or.big_(n=0)^infinity f^n (bot) = or.big \{bot, f(bot), f(f(bot)), dots\} $
  Essa construção é exatamente como se atribui significado formal a uma definição recursiva: começando de "totalmente indefinido" ($bot$), aplica-se $f$ repetidamente, aproximando-se do significado final.
]

== Exemplo resolvido

#example(name: "Ponto fixo para o significado de uma função recursiva", id: "ex-ponto-fixo-funcao-recursiva")[
  Considere o domínio $D$ das funções parciais de $NN$ em $NN$ (incluindo a função "totalmente indefinida" $bot$, que não retorna resultado para nenhuma entrada), ordenado por extensão de definição ($f <= g$ se $g$ concorda com $f$ em tudo que $f$ já define, podendo definir mais). A definição recursiva do fatorial (01) corresponde a um funcional $F: D -> D$:
  $ F(f)(n) = cases(1 & "se" n=0, n times f(n-1) & "se" n>0) $
  O menor ponto fixo de $F$ é exatamente a função fatorial usual: $F(bot)$ já define corretamente $f(0)=1$ (não depende de nenhuma chamada recursiva); $F(F(bot))$ define corretamente $f(0)$ e $f(1)$; e assim por diante -- cada aplicação de $F$ "aprova" mais uma entrada, e o supremo dessa sequência crescente de aproximações é a função fatorial total, bem definida para todo $n$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Bottom (⊥) representa \"indefinido\", não \"zero\" ou \"vazio\"")[
  Em teoria dos domínios, $bot$ modela uma computação que *não termina* ou está *totalmente indefinida* -- não deve ser confundido com o número zero, o conjunto vazio, ou qualquer valor "normal" do domínio. É um elemento extra, abaixo de todos os demais na ordem, especificamente para modelar não-terminação.
]

#remark(name: "Continuidade aqui não é a continuidade do Cálculo")[
  "Continuidade" em teoria dos domínios (preservar supremos de conjuntos dirigidos) é uma noção *discreta/ordinal*, definida via a ordem $<=$ do domínio -- não envolve limites de sequências de números reais nem épsilon-delta do Cálculo Diferencial. É um erro comum tentar aplicar intuições de continuidade analítica a este contexto.
]

== Questões estilo POSCOMP

*Questão 1.* Em uma ordem parcial completa (CPO), o elemento $bot$ representa:
- a) O maior elemento do domínio.
- b) Um valor numérico igual a zero.
- c) Uma computação indefinida ou que não termina.
- d) O conjunto vazio, obrigatoriamente.
- e) O supremo de todo o domínio.

*Questão 2.* Uma função $f$ entre CPOs é dita contínua quando:
- a) É contínua no sentido do Cálculo Diferencial (limites, épsilon-delta).
- b) Preserva supremos de subconjuntos dirigidos: $f(or.big S) = or.big f(S)$.
- c) É constante em todo o domínio.
- d) Nunca está definida para $bot$.
- e) É sempre bijetora.

*Questão 3.* Segundo o Teorema do Ponto Fixo de Kleene, o menor ponto fixo de uma função contínua $f$ sobre uma CPO com $bot$ é dado por:
- a) $f(top)$, onde $top$ é o maior elemento do domínio.
- b) $or.big_(n=0)^infinity f^n (bot)$, o supremo das aplicações sucessivas de $f$ a partir de $bot$.
- c) Um valor arbitrário escolhido pelo projetista da linguagem.
- d) $f(0)$ apenas, sem iteração.
- e) Não existe garantia de que um ponto fixo exista.

== Gabarito comentado

1. *(c)* -- definição direta de $bot$: representa indefinição/não-terminação, não um valor numérico específico.
2. *(b)* -- definição direta de continuidade em teoria dos domínios, preservação de supremos de dirigidos.
3. *(b)* -- é exatamente o enunciado do Teorema do Ponto Fixo de Kleene apresentado nesta seção.

== Referências

- SCOTT, D.; STRACHEY, C. *Toward a Mathematical Semantics for Computer Languages* (1971) -- artigo fundador da semântica denotacional e teoria dos domínios.
- WINSKEL, G. *The Formal Semantics of Programming Languages*. Cap. 5 (Teoria dos domínios).
- Linguagens de Programação (12.3, Semântica Formal) -- aplicação em semântica denotacional, ainda sem material escrito neste repositório no momento desta seção.
