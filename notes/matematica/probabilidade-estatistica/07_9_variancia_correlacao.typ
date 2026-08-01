#import "@preview/mousse-notes:1.1.0": *

= 7.9 --- Variância e Coeficientes de Correlação

== Introdução

Se a esperança (7.8) resume a posição central de uma variável aleatória, a variância resume sua dispersão em torno dessa média. Quando há duas variáveis envolvidas, covariância e correlação medem o quanto elas variam *juntas* -- e a diferença entre correlação nula e independência é um dos pontos mais cobrados desta subseção.

== Definições formais

#definition(name: "Variância e desvio-padrão", id: "def-variancia-va")[
  A variância de uma variável aleatória $X$ é:
  $ "Var"(X) = E[(X - E[X])^2] = E[X^2] - (E[X])^2 $
  (a segunda forma, mais usada em cálculos, segue expandindo o quadrado e aplicando linearidade da esperança). O desvio-padrão é $sigma_X = sqrt("Var"(X))$.
]

#definition(name: "Covariância e correlação de Pearson", id: "def-covariancia-correlacao")[
  Para duas variáveis aleatórias $X, Y$:
  $ "Cov"(X,Y) = E[X Y] - E[X] E[Y] $
  O *coeficiente de correlação de Pearson* normaliza a covariância para o intervalo $[-1,1]$:
  $ rho_(X,Y) = "Cov"(X,Y)/(sigma_X sigma_Y) $
  $rho = 1$ indica relação linear positiva perfeita; $rho=-1$, relação linear negativa perfeita; $rho=0$, ausência de relação *linear* (não necessariamente ausência de qualquer relação -- ver observação abaixo).
]

== Propriedade relevante

#theorem(name: "Variância de combinações lineares", id: "thm-variancia-combinacao")[
  Para constantes $a,b in RR$ e variáveis aleatórias $X, Y$:
  $ "Var"(a X + b) = a^2 "Var"(X) $
  $ "Var"(X plus.minus Y) = "Var"(X) + "Var"(Y) plus.minus 2"Cov"(X,Y) $
  Em particular, se $X$ e $Y$ são *independentes* (logo $"Cov"(X,Y)=0$): $"Var"(X+Y) = "Var"(X) + "Var"(Y)$.
]

#proof[
  $"Var"(a X+b) = E[(a X+b - E[a X+b])^2] = E[(a X+b-a E[X]-b)^2] = E[a^2(X-E[X])^2] = a^2 "Var"(X)$, usando linearidade da esperança (7.8) para eliminar $b$. Para a soma, $"Var"(X+Y) = E[((X-E[X])+(Y-E[Y]))^2] = E[(X-E[X])^2] + E[(Y-E[Y])^2] + 2E[(X-E[X])(Y-E[Y])] = "Var"(X)+"Var"(Y)+2"Cov"(X,Y)$; o caso $X-Y$ segue de forma análoga, com o sinal do termo cruzado invertido.
]

== Exemplo resolvido

#example(name: "Variância da Binomial via indicadores", id: "ex-variancia-binomial-indicadores")[
  Retomando a decomposição $X = I_1 + dots + I_n$ do exemplo de 7.8 (indicadores de Bernoulli *independentes*, cada um com $"Var"(I_k) = p(1-p)$):

  $ "Var"(X) = "Var"(I_1 + dots + I_n) = "Var"(I_1) + dots + "Var"(I_n) = n p (1-p) $

  A igualdade da soma das variâncias só vale aqui porque os $I_k$ são independentes entre si (ao contrário da esperança em 7.8, que não precisaria dessa hipótese).
]

== Atenção -- pegadinhas comuns

#remark(name: "Correlação zero não implica independência")[
  $rho_(X,Y)=0$ significa apenas ausência de relação *linear*. É possível ter $Y = X^2$ com $X$ simétrica em torno de zero -- forte dependência (determinística!), mas correlação de Pearson nula, pois a relação é puramente quadrática, não linear. A implicação inversa, porém, *é* verdadeira: independência sempre implica $"Cov"(X,Y)=0$.
]

#remark(name: "Var(X - Y) tem sinal + antes da covariância, não -")[
  Um erro comum é escrever $"Var"(X-Y) = "Var"(X) - "Var"(Y)$ (a variância nunca pode ser negativa, então essa forma nem sempre faz sentido) ou esquecer o sinal do termo cruzado: a fórmula correta é $"Var"(X-Y) = "Var"(X)+"Var"(Y)-2"Cov"(X,Y)$ -- o termo de covariância troca de sinal, mas as variâncias individuais sempre se *somam*.
]

== Questões estilo POSCOMP

*Questão 1.* Se $"Var"(X) = 4$, o valor de $"Var"(3X + 5)$ é:
- a) $12$.
- b) $17$.
- c) $36$.
- d) $9$.
- e) $4$.

*Questão 2.* Se $X$ e $Y$ são independentes, com $"Var"(X)=3$ e $"Var"(Y)=5$, então $"Var"(X-Y)$ vale:
- a) $-2$.
- b) $2$.
- c) $8$.
- d) $15$.
- e) Não é possível calcular sem conhecer $"Cov"(X,Y)$.

*Questão 3.* Um coeficiente de correlação de Pearson igual a zero entre $X$ e $Y$ permite concluir que:
- a) $X$ e $Y$ são independentes.
- b) Não existe nenhuma relação, linear ou não, entre $X$ e $Y$.
- c) Não existe relação *linear* entre $X$ e $Y$, mas pode haver relação não linear.
- d) $X$ e $Y$ têm a mesma variância.
- e) $X$ e $Y$ são mutuamente exclusivos.

== Gabarito comentado

1. *(c)* -- $"Var"(3X+5) = 3^2 dot "Var"(X) = 9 times 4 = 36$ (a constante aditiva não afeta a variância).
2. *(c)* -- independência implica $"Cov"(X,Y)=0$, logo $"Var"(X-Y) = "Var"(X)+"Var"(Y) = 3+5=8$.
3. *(c)* -- correlação de Pearson mede apenas associação linear; ausência dela não descarta dependência não linear.

== Referências

- MEYER, P. L. *Probabilidade: Aplicações à Estatística*. Cap. 6 (Variância e covariância).
- MAGALHÃES, M. N. *Probabilidade e Variáveis Aleatórias*. Cap. 4--5.
- BUSSAB, W. O.; MORETTIN, P. A. *Estatística Básica*. Cap. 9 (Correlação).
