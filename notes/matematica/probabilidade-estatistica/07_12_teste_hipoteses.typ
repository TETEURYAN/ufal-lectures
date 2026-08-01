#import "@preview/mousse-notes:1.1.0": *

= 7.12 --- Teste de Hipóteses para Médias. Testes do Qui-Quadrado

== Introdução

Teste de hipóteses formaliza a decisão entre duas afirmações concorrentes sobre um parâmetro populacional, usando a amostra como evidência. Além do teste para médias (baseado na Normal/TCL de 7.10), o teste Qui-Quadrado estende a ideia para verificar aderência a uma distribuição ou independência entre variáveis categóricas -- ambos muito cobrados na POSCOMP.

== Definições formais

#definition(name: "Hipóteses nula e alternativa; erros tipo I e II", id: "def-hipoteses-erros")[
  - *Hipótese nula* $H_0$: afirmação padrão a ser testada (ex.: $mu = mu_0$), assumida verdadeira até evidência em contrário.
  - *Hipótese alternativa* $H_1$: o que se aceita caso $H_0$ seja rejeitada.
  - *Erro tipo I*: rejeitar $H_0$ quando ela é verdadeira, com probabilidade $alpha$ (*nível de significância*, escolhido a priori -- comumente 0.05).
  - *Erro tipo II*: não rejeitar $H_0$ quando ela é falsa, com probabilidade $beta$. O *poder do teste* é $1-beta$ (probabilidade de rejeitar corretamente uma $H_0$ falsa).
  - *Valor-p*: probabilidade de observar um resultado tão ou mais extremo que o obtido, assumindo $H_0$ verdadeira. Rejeita-se $H_0$ se valor-p $< alpha$.
]

#definition(name: "Teste Z para a média", id: "def-teste-z-media")[
  Para testar $H_0: mu = mu_0$ com $sigma$ conhecido (ou $n$ grande, via TCL), a estatística de teste é:
  $ Z = (macron(X) - mu_0)/(sigma\/sqrt(n)) $
  Compara-se $Z$ com o valor crítico $z_(alpha\/2)$ (teste bilateral) ou $z_alpha$ (unilateral); rejeita-se $H_0$ se $Z$ cair na região crítica.
]

#definition(name: "Teste Qui-Quadrado", id: "def-teste-qui-quadrado")[
  Compara frequências *observadas* ($O_i$) com frequências *esperadas* ($E_i$) sob $H_0$, usando a estatística:
  $ chi^2 = sum_i (O_i - E_i)^2/E_i $
  que segue (aproximadamente) uma distribuição Qui-Quadrado com $k$ graus de liberdade sob $H_0$. Duas aplicações clássicas:
  - *Teste de aderência*: $H_0$ afirma que os dados seguem uma distribuição específica; graus de liberdade $= ("número de categorias" - 1)$.
  - *Teste de independência*: $H_0$ afirma que duas variáveis categóricas (em uma tabela de contingência $r times c$) são independentes; graus de liberdade $= (r-1)(c-1)$.
]

== Exemplo resolvido

#example(name: "Teste Z bilateral para a média", id: "ex-teste-z-media")[
  Uma máquina deveria produzir peças com comprimento médio $mu_0 = 50$ mm. Uma amostra de $n=64$ peças tem $macron(x) = 50.8$ mm, com $sigma = 3.2$ mm (conhecido). Teste $H_0: mu=50$ contra $H_1: mu eq.not 50$, com $alpha=0.05$ ($z_(alpha\/2) = 1.96$).

  $ Z = (50.8-50)/(3.2\/sqrt(64)) = 0.8/0.4 = 2.0 $

  Como $|Z| = 2.0 > 1.96$, *rejeita-se $H_0$*: há evidência de que a média real difere de 50 mm ao nível de 5%.
]

#example(name: "Teste Qui-Quadrado de aderência", id: "ex-teste-qui-quadrado")[
  Um dado é lançado 60 vezes; espera-se, sob $H_0$ (dado honesto), $E_i = 10$ para cada face. As frequências observadas são $8,12,9,11,7,13$.

  $ chi^2 = (8-10)^2/10 + (12-10)^2/10 + (9-10)^2/10 + (11-10)^2/10 + (7-10)^2/10 + (13-10)^2/10 = 0.4+0.4+0.1+0.1+0.9+0.9 = 2.8 $

  Com $k-1 = 5$ graus de liberdade e $alpha=0.05$, o valor crítico da tabela Qui-Quadrado é $chi^2_(0.05,5) approx 11.07$. Como $2.8 < 11.07$, *não se rejeita $H_0$*: não há evidência de que o dado seja viciado.
]

== Atenção -- pegadinhas comuns

#remark(name: "Não rejeitar H0 não é o mesmo que provar H0 verdadeira")[
  "Não rejeitar $H_0$" significa apenas que a amostra não forneceu evidência suficiente contra $H_0$ -- não é uma prova de que $H_0$ é verdadeira. É um erro comum de interpretação tratar "não rejeitou" como sinônimo de "confirmou".
]

#remark(name: "Valor-p pequeno vs. nível de significância")[
  A regra de decisão é sempre relativa ao $alpha$ escolhido *antes* do teste: valor-p $< alpha$ rejeita $H_0$; valor-p $>= alpha$ não rejeita. Trocar essa desigualdade, ou comparar o valor-p com a estatística de teste (em vez de com $alpha$), é um erro recorrente em prova.
]

== Questões estilo POSCOMP

*Questão 1.* Rejeitar a hipótese nula quando ela é, na verdade, verdadeira caracteriza o:
- a) Erro tipo II.
- b) Erro tipo I.
- c) Nível de confiança.
- d) Poder do teste.
- e) Valor-p.

*Questão 2.* No teste Qui-Quadrado de independência para uma tabela de contingência com $r=3$ linhas e $c=4$ colunas, os graus de liberdade são:
- a) $12$.
- b) $7$.
- c) $6$.
- d) $3$.
- e) $4$.

*Questão 3.* Se o valor-p de um teste é $0.03$ e o nível de significância adotado é $alpha=0.05$, a decisão correta é:
- a) Não rejeitar $H_0$, pois $0.03 < 0.05$.
- b) Rejeitar $H_0$, pois o valor-p é menor que $alpha$.
- c) O teste é inconclusivo.
- d) Aumentar o tamanho da amostra antes de decidir.
- e) Rejeitar $H_1$.

== Gabarito comentado

1. *(b)* -- definição direta de erro tipo I.
2. *(c)* -- graus de liberdade $= (r-1)(c-1) = (3-1)(4-1) = 6$.
3. *(b)* -- valor-p menor que $alpha$ leva à rejeição de $H_0$.

== Referências

- BUSSAB, W. O.; MORETTIN, P. A. *Estatística Básica*. Cap. 12--13 (Testes de hipóteses e Qui-Quadrado).
- TRIOLA, M. F. *Introdução à Estatística*. Cap. 8--9.
- MONTGOMERY, D. C.; RUNGER, G. C. *Estatística Aplicada e Probabilidade para Engenheiros*. Cap. 9--10.
