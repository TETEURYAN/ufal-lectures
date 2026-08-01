#import "@preview/mousse-notes:1.1.0": *

= 7.7 --- Distribuições de Probabilidades de Variáveis Aleatórias Unidimensionais e Bidimensionais

== Introdução

Uma variável aleatória mapeia resultados do espaço amostral (7.5) para números reais, permitindo tratar probabilidade com ferramentas algébricas. A POSCOMP cobra reconhecer o cenário certo para cada distribuição clássica -- discreta ou contínua -- e, ocasionalmente, o caso bidimensional (duas variáveis aleatórias conjuntas).

== Definições formais

#definition(name: "Variável aleatória discreta e contínua", id: "def-variavel-aleatoria")[
  Uma *variável aleatória* (v.a.) $X$ é uma função que associa um número real a cada resultado do espaço amostral.
  - *Discreta*: assume um conjunto finito ou infinito enumerável de valores, descrita por uma *função de probabilidade* (PMF) $p(x) = P(X=x)$, com $p(x) >= 0$ e $sum_x p(x) = 1$.
  - *Contínua*: assume valores em um intervalo real, descrita por uma *função densidade de probabilidade* (PDF) $f(x) >= 0$ com $integral_(-infinity)^(infinity) f(x) dif x = 1$; probabilidades são áreas: $P(a <= X <= b) = integral_a^b f(x) dif x$ (e $P(X=x)=0$ para qualquer ponto único).
  - Em ambos os casos, a *função de distribuição acumulada* (CDF) é $F(x) = P(X <= x)$.
]

#definition(name: "Distribuição conjunta (caso bidimensional)", id: "def-distribuicao-conjunta")[
  Para duas variáveis aleatórias discretas $X, Y$, a *função de probabilidade conjunta* é $p(x,y) = P(X=x, Y=y)$. As *distribuições marginais* são obtidas somando sobre a outra variável: $p_X(x) = sum_y p(x,y)$ e $p_Y(y) = sum_x p(x,y)$. $X$ e $Y$ são *independentes* se $p(x,y) = p_X(x) dot p_Y(y)$ para todo par $(x,y)$.
]

#definition(name: "Distribuições discretas clássicas", id: "def-distribuicoes-discretas")[
  - *Bernoulli($p$)*: modela um único ensaio com dois resultados (sucesso/fracasso), $P(X=1)=p$, $P(X=0)=1-p$.
  - *Binomial($n,p$)*: número de sucessos em $n$ ensaios de Bernoulli independentes e idênticos. $P(X=x) = binom(n,x) p^x (1-p)^(n-x)$, $x=0,1,dots,n$.
  - *Poisson($lambda$)*: número de ocorrências de um evento raro em um intervalo fixo de tempo/espaço, com taxa média $lambda$. $P(X=x) = (e^(-lambda) lambda^x)/x!$, $x=0,1,2,dots$
]

#definition(name: "Distribuições contínuas clássicas", id: "def-distribuicoes-continuas")[
  - *Uniforme contínua* $U(a,b)$: mesma densidade em todo o intervalo $[a,b]$: $f(x) = 1/(b-a)$.
  - *Normal (Gaussiana)* $N(mu, sigma^2)$: $f(x) = 1/(sigma sqrt(2pi)) e^(-(x-mu)^2/(2sigma^2))$ -- simétrica em torno de $mu$, formato de sino (ver 7.10).
  - *Exponencial($lambda$)*: modela o tempo até o próximo evento em um processo de Poisson de taxa $lambda$: $f(x) = lambda e^(-lambda x)$, $x >= 0$. Tem a propriedade de *falta de memória*: $P(X > s+t | X>s) = P(X>t)$.
]

== Tabela comparativa

#table(
  columns: 4,
  [*Distribuição*], [*PMF / PDF*], [*$E[X]$*], [*Var(X)*],
  [Bernoulli($p$)], [$p^x (1-p)^(1-x)$], [$p$], [$p(1-p)$],
  [Binomial($n,p$)], [$binom(n,x) p^x (1-p)^(n-x)$], [$n p$], [$n p (1-p)$],
  [Poisson($lambda$)], [$e^(-lambda) lambda^x \/ x!$], [$lambda$], [$lambda$],
  [Uniforme $U(a,b)$], [$1\/(b-a)$], [$(a+b)\/2$], [$(b-a)^2\/12$],
  [Normal $N(mu,sigma^2)$], [$1/(sigma sqrt(2pi)) e^(-(x-mu)^2/(2sigma^2))$], [$mu$], [$sigma^2$],
  [Exponencial($lambda$)], [$lambda e^(-lambda x)$], [$1\/lambda$], [$1\/lambda^2$],
)

As derivações de $E[X]$ e $"Var"(X)$ desta tabela são desenvolvidas em 7.8 e 7.9.

== Exemplo resolvido

#example(name: "Escolhendo a distribuição certa", id: "ex-escolha-distribuicao")[
  Uma linha de produção tem 2% de peças defeituosas, independentemente entre si. Em um lote de 50 peças, qual a probabilidade de exatamente 2 serem defeituosas?

  O número de defeituosas $X$ em $n=50$ ensaios independentes com $p=0.02$ segue Binomial($n=50, p=0.02$):
  $ P(X=2) = binom(50,2) (0.02)^2 (0.98)^(48) = 1225 times 0.0004 times 0.98^(48) approx 0.186 $

  Como $n$ é grande e $p$ é pequeno (regra prática: $n>=20$ e $p<=0.05$), essa Binomial também poderia ser *aproximada* por uma Poisson($lambda = n p = 1$), dando $P(X=2) approx e^(-1) 1^2\/2! approx 0.184$ -- bem próximo do valor exato, ilustrando a aproximação Binomial-Poisson.
]

== Atenção -- pegadinhas comuns

#remark(name: "Binomial conta sucessos; Poisson conta ocorrências em um contínuo")[
  Binomial pressupõe um número *fixo e conhecido* de ensaios $n$. Poisson é usada quando não há um "número de ensaios" natural, apenas uma taxa média de ocorrências por unidade de tempo/espaço -- por isso Poisson é o modelo padrão para "número de chamadas por hora", "número de acidentes por km", etc.
]

#remark(name: "Densidade contínua não é probabilidade")[
  Para uma v.a. contínua, $f(x)$ pode ser maior que 1 -- não é uma probabilidade, é uma *densidade*. Só a área sob a curva (integral) tem interpretação de probabilidade. Além disso, $P(X=x)=0$ para qualquer valor pontual $x$, então $P(X<=x) = P(X<x)$ em variáveis contínuas (mas não em discretas).
]

== Questões estilo POSCOMP

*Questão 1.* O número de clientes que chegam a uma loja em uma hora, quando não há um limite fixo de "tentativas", é mais bem modelado por uma distribuição:
- a) Binomial.
- b) Bernoulli.
- c) Poisson.
- d) Uniforme.
- e) Normal.

*Questão 2.* Sobre uma variável aleatória contínua $X$ com densidade $f(x)$, é correto afirmar que:
- a) $f(x)$ é sempre menor ou igual a 1.
- b) $P(X = x_0)$ é sempre positivo para qualquer $x_0$ fixo.
- c) $P(a <= X <= b)$ é dada pela área sob $f(x)$ entre $a$ e $b$.
- d) $f(x)$ representa diretamente uma probabilidade.
- e) A soma de todos os valores de $f(x)$ é igual a 1.

*Questão 3.* Duas variáveis aleatórias discretas $X$ e $Y$ são independentes se, e somente se:
- a) $p(x,y) = p_X(x) + p_Y(y)$ para todo $(x,y)$.
- b) $p(x,y) = p_X(x) dot p_Y(y)$ para todo $(x,y)$.
- c) $p_X(x) = p_Y(y)$ para todo $x=y$.
- d) A correlação entre elas é igual a 1.
- e) Suas distribuições marginais são idênticas.

== Gabarito comentado

1. *(c)* -- contagem de ocorrências por unidade de tempo, sem número fixo de tentativas, é o cenário clássico de Poisson.
2. *(c)* -- por definição, probabilidade em variáveis contínuas é área sob a densidade.
3. *(b)* -- definição de independência para distribuições conjuntas discretas.

== Referências

- MEYER, P. L. *Probabilidade: Aplicações à Estatística*. Cap. 5--7 (Variáveis aleatórias e distribuições clássicas).
- MAGALHÃES, M. N. *Probabilidade e Variáveis Aleatórias*. Cap. 3--5.
- MONTGOMERY, D. C.; RUNGER, G. C. *Estatística Aplicada e Probabilidade para Engenheiros*. Caps. 3--5.
