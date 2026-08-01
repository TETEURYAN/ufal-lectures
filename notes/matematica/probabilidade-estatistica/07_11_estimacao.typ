#import "@preview/mousse-notes:1.1.0": *

= 7.11 --- Estimação Pontual e por Intervalo

== Introdução

Inferência estatística usa uma amostra para estimar características (parâmetros) da população da qual ela foi extraída. A POSCOMP cobra a diferença entre estimar um único valor (pontual) ou uma faixa de valores plausíveis (intervalar), e a interpretação correta de um intervalo de confiança -- item clássico de pegadinha conceitual.

== Definições formais

#definition(name: "Estimador pontual", id: "def-estimador-pontual")[
  Um *estimador* é uma estatística (função da amostra) usada para estimar um parâmetro populacional desconhecido $theta$. Um estimador $hat(theta)$ é:
  - *Não-viesado (não-tendencioso)*: $E[hat(theta)] = theta$ -- em média, acerta o valor verdadeiro (ex.: $macron(X)$ é um estimador não-viesado de $mu$; $s^2$, com divisor $n-1$, é um estimador não-viesado de $sigma^2$ -- ver 7.4).
  - *Consistente*: $hat(theta)$ se aproxima de $theta$ à medida que o tamanho da amostra $n$ cresce.
]

#definition(name: "Intervalo de confiança para a média", id: "def-intervalo-confianca")[
  Um *intervalo de confiança* de nível $1-alpha$ para a média populacional $mu$, com desvio-padrão populacional $sigma$ conhecido (ou $n$ grande, via TCL de 7.10), é:
  $ macron(X) plus.minus z_(alpha\/2) dot sigma/sqrt(n) $
  onde $z_(alpha\/2)$ é o valor crítico da Normal padrão tal que $P(Z > z_(alpha\/2)) = alpha\/2$ (ex.: $z_(alpha\/2) = 1.96$ para 95% de confiança). Quando $sigma$ é desconhecido e $n$ é pequeno, substitui-se $sigma$ pelo desvio-padrão amostral $s$ e $z$ pelo valor crítico da *distribuição $t$ de Student* com $n-1$ graus de liberdade.
]

== Exemplo resolvido

#example(name: "Intervalo de confiança de 95% para a média", id: "ex-ic-95")[
  Uma amostra de $n=100$ peças tem média $macron(x) = 50$ mm, com desvio-padrão populacional conhecido $sigma = 4$ mm. O intervalo de confiança de 95% ($z_(alpha\/2) = 1.96$) para a média verdadeira $mu$ é:

  $ 50 plus.minus 1.96 dot 4/sqrt(100) = 50 plus.minus 1.96 times 0.4 = 50 plus.minus 0.784 $

  Ou seja, $I C_(95%) = [49.216, 50.784]$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Interpretação correta de um intervalo de confiança")[
  Um IC de 95% *não* significa "há 95% de probabilidade de $mu$ estar neste intervalo específico" -- $mu$ é uma constante fixa (desconhecida), não uma variável aleatória. A interpretação correta (frequentista) é: se o procedimento de amostragem e construção do intervalo fosse repetido muitas vezes, aproximadamente 95% dos intervalos gerados conteriam o verdadeiro $mu$.
]

#remark(name: "Trade-off entre confiança e amplitude do intervalo")[
  Aumentar o nível de confiança (ex.: de 95% para 99%) *aumenta* $z_(alpha\/2)$ e, portanto, alarga o intervalo. Para reduzir a amplitude *sem* perder confiança, a única saída é aumentar o tamanho da amostra $n$ (a amplitude é proporcional a $1\/sqrt(n)$).
]

== Questões estilo POSCOMP

*Questão 1.* Um estimador $hat(theta)$ é dito não-viesado quando:
- a) $"Var"(hat(theta)) = 0$.
- b) $E[hat(theta)] = theta$.
- c) $hat(theta)$ converge para $theta$ quando $n arrow infinity$.
- d) $hat(theta)$ é sempre igual a $theta$.
- e) $hat(theta)$ não depende da amostra.

*Questão 2.* Sobre a interpretação de um intervalo de confiança de 95% para $mu$, é correto afirmar que:
- a) Há 95% de probabilidade de $mu$ estar dentro do intervalo calculado.
- b) Em repetições do procedimento de amostragem, aproximadamente 95% dos intervalos construídos conteriam o verdadeiro $mu$.
- c) 95% dos dados da amostra estão dentro do intervalo.
- d) $mu$ está garantidamente dentro do intervalo.
- e) O intervalo terá sempre a mesma amplitude, independente de $n$.

*Questão 3.* Para reduzir a amplitude de um intervalo de confiança sem reduzir o nível de confiança, deve-se:
- a) Diminuir o tamanho da amostra $n$.
- b) Aumentar o tamanho da amostra $n$.
- c) Aumentar $z_(alpha\/2)$.
- d) Diminuir o nível de confiança.
- e) Usar a mediana em vez da média amostral.

== Gabarito comentado

1. *(b)* -- definição direta de estimador não-viesado.
2. *(b)* -- interpretação frequentista correta, conforme a observação desta seção.
3. *(b)* -- a amplitude do IC é proporcional a $1\/sqrt(n)$; aumentar $n$ reduz a amplitude mantendo a confiança.

== Referências

- BUSSAB, W. O.; MORETTIN, P. A. *Estatística Básica*. Cap. 10--11 (Estimação).
- TRIOLA, M. F. *Introdução à Estatística*. Cap. 7 (Estimativas e tamanhos de amostra).
- MAGALHÃES, M. N. *Probabilidade e Variáveis Aleatórias*. Cap. 7.
