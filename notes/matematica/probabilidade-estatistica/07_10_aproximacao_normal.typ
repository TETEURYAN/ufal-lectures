#import "@preview/mousse-notes:1.1.0": *

= 7.10 --- Aproximação Normal

== Introdução

A distribuição Normal (7.7) é especial porque a soma (ou média) de muitas variáveis aleatórias independentes tende a se comportar como uma Normal, *mesmo que as variáveis originais não sejam normais* -- é o Teorema Central do Limite (TCL), um dos resultados mais importantes da disciplina e item certo na POSCOMP.

== Definições formais

#definition(name: "Padronização (variável Z)", id: "def-padronizacao-z")[
  Se $X ~ N(mu, sigma^2)$, a variável padronizada $Z = (X-mu)/sigma$ segue uma Normal padrão, $Z ~ N(0,1)$. Isso permite calcular qualquer probabilidade de uma Normal usando uma única tabela (a da Normal padrão), convertendo o problema original via $Z$.
]

== Propriedade relevante

#theorem(name: "Teorema Central do Limite (TCL)", id: "thm-tcl")[
  Sejam $X_1, X_2, dots, X_n$ variáveis aleatórias independentes e identicamente distribuídas (i.i.d.), com média $mu$ e variância $sigma^2$ finitas. Para $n$ suficientemente grande (regra prática: $n >= 30$), a média amostral $macron(X) = 1/n sum_(i=1)^n X_i$ é aproximadamente Normal:
  $ (macron(X) - mu)/(sigma\/sqrt(n)) approx.eq Z ~ N(0,1) $
  independentemente da forma da distribuição original de $X_i$ (desde que tenha média e variância finitas).
]

#proof[
  Uma justificativa intuitiva (não a prova formal via funções características): $macron(X)$ é uma soma de $n$ variáveis "pequenas" e aproximadamente independentes; cada termo contribui pouco individualmente, e o efeito agregado de muitos fatores pequenos e independentes tende a produzir uma distribuição em forma de sino -- o mesmo mecanismo por trás de erros de medição, ruído agregado, etc. A prova rigorosa usa convergência de funções características para a da Normal.
]

== Exemplo resolvido

#example(name: "Aplicação do TCL a uma média amostral", id: "ex-tcl-media-amostral")[
  O tempo de atendimento em um caixa tem média $mu = 5$ min e desvio-padrão $sigma = 2$ min (distribuição desconhecida). Para uma amostra de $n=64$ atendimentos, qual a probabilidade de a média amostral ser maior que 5.5 min?

  Pelo TCL, $macron(X) approx N(mu, sigma^2\/n) = N(5, 2^2\/64) = N(5, 0.0625)$, com desvio-padrão $sigma_(macron(X)) = 2\/sqrt(64) = 0.25$.

  $ Z = (5.5 - 5)/0.25 = 2 $

  Consultando a tabela da Normal padrão, $P(Z > 2) approx 0.0228$. Ou seja, apesar de não sabermos a distribuição individual dos tempos de atendimento, o TCL permite calcular essa probabilidade usando apenas $mu$ e $sigma$.
]

== Regra empírica (68--95--99.7)

#figure(
  image("figures/standard-deviation-diagram.svg", width: 75%),
  caption: [Regra empírica da Normal: aproximadamente 68%, 95% e 99.7% dos valores caem dentro de 1, 2 e 3 desvios-padrão da média, respectivamente. Fonte: Wikimedia Commons, CC BY 2.5 (M. W. Toews).],
)

== Atenção -- pegadinhas comuns

#remark(name: "TCL é sobre a MÉDIA (ou soma), não sobre a variável original")[
  O TCL não afirma que $X_i$ individualmente se torna Normal -- a distribuição original pode ser qualquer uma (Binomial, Exponencial, Uniforme...). O que se aproxima de Normal é a *média amostral* (ou soma) de várias observações independentes.
]

#remark(name: "Correção de continuidade ao aproximar Binomial por Normal")[
  Ao usar a Normal para aproximar uma Binomial($n,p$) discreta (válido quando $n p >= 5$ e $n(1-p) >= 5$, aproximadamente), aplica-se a *correção de continuidade*: $P(X <= k)$ é aproximado por $P(Y <= k+0.5)$ com $Y ~ N(n p, n p(1-p))$, compensando a passagem de uma variável discreta para uma contínua.
]

== Questões estilo POSCOMP

*Questão 1.* O Teorema Central do Limite garante que, para $n$ grande, a distribuição da média amostral $macron(X)$ é aproximadamente Normal:
- a) Apenas se a distribuição original de $X_i$ já for Normal.
- b) Independentemente da distribuição original de $X_i$, desde que média e variância sejam finitas.
- c) Apenas para distribuições discretas.
- d) Apenas quando $sigma$ é desconhecido.
- e) Apenas se $n < 30$.

*Questão 2.* Segundo a regra empírica da distribuição Normal, a proporção de valores dentro de 2 desvios-padrão da média é de aproximadamente:
- a) 68%.
- b) 75%.
- c) 95%.
- d) 99.7%.
- e) 50%.

*Questão 3.* Ao aproximar uma distribuição Binomial por uma Normal para calcular $P(X <= k)$, a correção de continuidade consiste em:
- a) Multiplicar a probabilidade final por 0.5.
- b) Calcular $P(Y <= k + 0.5)$ na Normal aproximante, em vez de $P(Y <= k)$.
- c) Ignorar o desvio-padrão da Binomial.
- d) Usar $n$ no lugar de $n-1$ no cálculo da variância.
- e) Substituir $p$ por $1-p$.

== Gabarito comentado

1. *(b)* -- é exatamente o enunciado do TCL: a distribuição original pode ser qualquer uma, desde que $mu$ e $sigma^2$ sejam finitos.
2. *(c)* -- regra empírica: ~68% em 1 desvio-padrão, ~95% em 2, ~99.7% em 3 (ver figura desta seção).
3. *(b)* -- a correção de continuidade desloca o ponto de corte em 0.5 para compensar a discretização.

== Referências

- MEYER, P. L. *Probabilidade: Aplicações à Estatística*. Cap. 8 (Teorema Central do Limite).
- MAGALHÃES, M. N. *Probabilidade e Variáveis Aleatórias*. Cap. 6.
- MONTGOMERY, D. C.; RUNGER, G. C. *Estatística Aplicada e Probabilidade para Engenheiros*. Cap. 5 (Aproximação Normal).
