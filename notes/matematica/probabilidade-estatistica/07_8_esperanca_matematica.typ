#import "@preview/mousse-notes:1.1.0": *

= 7.8 --- Esperança Matemática

== Introdução

A esperança matemática resume uma variável aleatória em um único número: seu valor médio "de longo prazo", ponderado pelas probabilidades. É a base para a tabela de 7.7 e para a variância de 7.9, e a propriedade de linearidade é uma das ferramentas mais usadas para resolver questões de prova rapidamente, sem calcular somatórios completos.

== Definições formais

#definition(name: "Esperança matemática (valor esperado)", id: "def-esperanca")[
  Para uma v.a. discreta $X$ com função de probabilidade $p(x)$:
  $ E[X] = sum_x x dot p(x) $
  Para uma v.a. contínua $X$ com densidade $f(x)$:
  $ E[X] = integral_(-infinity)^infinity x dot f(x) dif x $
  Mais geralmente, para uma função $g$ de $X$ (ex.: $g(X)=X^2$, usada na variância de 7.9):
  $ E[g(X)] = sum_x g(x) p(x) quad "ou" quad integral_(-infinity)^infinity g(x) f(x) dif x $
]

== Propriedade relevante

#theorem(name: "Linearidade da esperança", id: "thm-linearidade-esperanca")[
  Para quaisquer variáveis aleatórias $X, Y$ e constantes $a, b in RR$:
  $ E[a X + b] = a E[X] + b, quad quad E[X + Y] = E[X] + E[Y] $
  Crucialmente, a segunda igualdade vale *sempre*, mesmo que $X$ e $Y$ não sejam independentes.
]

#proof[
  Para o caso discreto, $E[a X + b] = sum_x (a x + b) p(x) = a sum_x x p(x) + b sum_x p(x) = a E[X] + b$ (usando $sum_x p(x)=1$). Para $E[X+Y]$, escrevendo em termos da distribuição conjunta $p(x,y)$: $E[X+Y] = sum_x sum_y (x+y) p(x,y) = sum_x x sum_y p(x,y) + sum_y y sum_x p(x,y) = sum_x x p_X (x) + sum_y y p_Y (y) = E[X] + E[Y]$ -- a soma sobre a variável "livre" recupera a marginal, sem exigir independência em nenhum passo.
]

== Exemplo resolvido

#example(name: "Esperança da Binomial via indicadores", id: "ex-esperanca-binomial-indicadores")[
  Uma variável Binomial($n,p$) pode ser escrita como soma de $n$ indicadores de Bernoulli independentes: $X = I_1 + I_2 + dots + I_n$, onde $I_k = 1$ se o $k$-ésimo ensaio é sucesso, e $0$ caso contrário, com $E[I_k] = p$ para todo $k$.

  Pela linearidade da esperança (que não exige independência, mas aqui os ensaios de fato são independentes por definição da Binomial):
  $ E[X] = E[I_1 + dots + I_n] = E[I_1] + dots + E[I_n] = underbrace(p + dots + p, n "vezes") = n p $

  Essa técnica -- escrever uma variável complicada como soma de indicadores simples -- evita calcular diretamente $sum_(x=0)^n x binom(n,x) p^x (1-p)^(n-x)$, e é um atalho clássico de prova.
]

== Atenção -- pegadinhas comuns

#remark(name: "Linearidade NÃO exige independência")[
  Um erro muito comum é achar que $E[X+Y]=E[X]+E[Y]$ só vale se $X$ e $Y$ forem independentes. É falso: linearidade da esperança é incondicional. O que *de fato* exige independência é $E[X Y] = E[X] E[Y]$ (produto) e $"Var"(X+Y) = "Var"(X) + "Var"(Y)$ (ver 7.9).
]

#remark(name: "Esperança pode não existir")[
  Para algumas distribuições contínuas de cauda muito pesada, a integral que define $E[X]$ não converge (ex.: distribuição de Cauchy). Isso é incomum no escopo direto da POSCOMP, mas justifica por que a definição de esperança sempre pressupõe convergência da soma/integral.
]

== Questões estilo POSCOMP

*Questão 1.* Se $X$ e $Y$ são variáveis aleatórias quaisquer (não necessariamente independentes), com $E[X]=3$ e $E[Y]=5$, então $E[2X + 3Y - 1]$ vale:
- a) $8$.
- b) $19$.
- c) $20$.
- d) $22$.
- e) Não é possível calcular sem saber se $X$ e $Y$ são independentes.

*Questão 2.* Uma variável aleatória $X$ assume os valores $-1, 0, 1$ com probabilidades $0.2$, $0.5$ e $0.3$, respectivamente. $E[X]$ é igual a:
- a) $0$.
- b) $0.1$.
- c) $0.2$.
- d) $-0.1$.
- e) $1$.

*Questão 3.* A técnica de escrever uma variável Binomial($n,p$) como soma de $n$ indicadores de Bernoulli é útil porque:
- a) Torna a variável independente da distribuição original.
- b) Permite calcular $E[X] = n p$ usando apenas linearidade da esperança, sem somatório complicado.
- c) Elimina a necessidade da fórmula da distribuição Binomial.
- d) Só funciona quando $p = 0.5$.
- e) Transforma a Binomial em uma distribuição Normal.

== Gabarito comentado

1. *(c)* -- $E[2X+3Y-1] = 2(3) + 3(5) - 1 = 6+15-1=20$. A alternativa (e) é a pegadinha: linearidade não exige independência.
2. *(b)* -- $E[X] = (-1)(0.2) + (0)(0.5) + (1)(0.3) = -0.2+0+0.3=0.1$.
3. *(b)* -- é exatamente a técnica do exemplo resolvido desta seção.

== Referências

- MEYER, P. L. *Probabilidade: Aplicações à Estatística*. Cap. 6 (Esperança matemática).
- MAGALHÃES, M. N. *Probabilidade e Variáveis Aleatórias*. Cap. 4.
- ROSS, S. *Probabilidade: Um Curso Moderno com Aplicações*. Cap. 4 (Valor esperado).
