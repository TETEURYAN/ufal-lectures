#import "@preview/mousse-notes:1.1.0": *

= 7.4 --- Descrição Estatística dos Dados

== Introdução

Complementando a análise gráfica de 7.3, medidas de posição e de dispersão resumem um conjunto de dados em poucos números. É um dos assuntos mais recorrentes da POSCOMP, especialmente a diferença entre variância amostral e populacional -- um erro clássico de prova.

== Definições formais

#definition(name: "Medidas de posição (tendência central)", id: "def-medidas-posicao")[
  Para uma amostra $x_1, dots, x_n$:
  - *Média aritmética*: $macron(x) = 1/n sum_(i=1)^n x_i$.
  - *Mediana*: valor central dos dados ordenados (média dos dois centrais, se $n$ for par) -- não é afetada por outliers, ao contrário da média.
  - *Moda*: valor(es) de maior frequência. Uma distribuição pode ser amodal, unimodal, bimodal, etc.
]

#definition(name: "Medidas de dispersão", id: "def-medidas-dispersao")[
  - *Amplitude*: $max(x_i) - min(x_i)$.
  - *Variância amostral*: $s^2 = 1/(n-1) sum_(i=1)^n (x_i - macron(x))^2$ (divide por $n-1$, não por $n$ -- ver observação abaixo).
  - *Variância populacional*: $sigma^2 = 1/N sum_(i=1)^N (x_i - mu)^2$ (divide por $N$, o tamanho da população inteira).
  - *Desvio-padrão*: $s = sqrt(s^2)$ (amostral) ou $sigma = sqrt(sigma^2)$ (populacional) -- mesma unidade dos dados originais, ao contrário da variância.
  - *Coeficiente de variação*: $C V = s\/macron(x)$ (ou $sigma\/mu$), útil para comparar a dispersão relativa de variáveis com unidades ou escalas diferentes.
]

== Exemplo resolvido

#example(name: "Cálculo de média, variância amostral e desvio-padrão", id: "ex-media-variancia")[
  Considere a amostra de notas: $2, 4, 4, 6, 8$ ($n=5$).

  Média: $macron(x) = (2+4+4+6+8)/5 = 24/5 = 4.8$.

  Desvios ao quadrado: $(2-4.8)^2=7.84$, $(4-4.8)^2=0.64$ (duas vezes), $(6-4.8)^2=1.44$, $(8-4.8)^2=10.24$.

  Soma dos desvios ao quadrado: $7.84+0.64+0.64+1.44+10.24 = 20.8$.

  Variância amostral: $s^2 = 20.8\/(5-1) = 5.2$. Desvio-padrão amostral: $s = sqrt(5.2) approx 2.28$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Por que dividir por n-1 na variância amostral?")[
  Dividir por $n-1$ (em vez de $n$) corrige o viés que surgiria ao usar $macron(x)$ (estimada a partir da própria amostra) no lugar da verdadeira média populacional $mu$ -- essa correção é conhecida como *graus de liberdade* perdidos ao estimar $macron(x)$. Questões de prova frequentemente testam se o candidato sabe qual fórmula usar dependendo se os dados são "a população toda" ou "uma amostra".
]

#remark(name: "Média é sensível a outliers; mediana não")[
  Um único valor extremo pode distorcer bastante a média, mas quase não afeta a mediana. Em distribuições assimétricas (ex.: renda), a mediana costuma ser uma medida de posição mais representativa que a média.
]

#remark(name: "Desvio-padrão vs. variância: unidades")[
  A variância está em unidades ao quadrado (ex.: $"cm"^2$ se os dados são em cm), o que dificulta a interpretação direta. O desvio-padrão, por ser a raiz quadrada da variância, volta à unidade original dos dados -- por isso é a medida de dispersão mais reportada na prática.
]

== Questões estilo POSCOMP

*Questão 1.* Dada uma amostra de tamanho $n$, a fórmula correta da variância amostral é:
- a) $1/n sum (x_i - macron(x))^2$.
- b) $1/(n-1) sum (x_i - macron(x))^2$.
- c) $1/n sum (x_i - macron(x))$.
- d) $sum (x_i - macron(x))^2$.
- e) $1/(n+1) sum (x_i - macron(x))^2$.

*Questão 2.* Em uma distribuição fortemente assimétrica com poucos valores extremos muito altos, a medida de tendência central menos afetada por esses valores é:
- a) A média aritmética.
- b) A mediana.
- c) A variância.
- d) O desvio-padrão.
- e) A amplitude.

*Questão 3.* O coeficiente de variação é especialmente útil para:
- a) Calcular a média de dados qualitativos.
- b) Comparar a dispersão relativa de duas variáveis com escalas ou unidades diferentes.
- c) Substituir o cálculo da mediana.
- d) Eliminar outliers automaticamente de uma amostra.
- e) Determinar o número de classes de um histograma.

== Gabarito comentado

1. *(b)* -- variância amostral usa $n-1$ no denominador (correção de graus de liberdade).
2. *(b)* -- a mediana é robusta a valores extremos, diferente da média.
3. *(b)* -- por ser adimensional (razão entre desvio-padrão e média), o CV permite comparar dispersões de variáveis em escalas distintas.

== Referências

- BUSSAB, W. O.; MORETTIN, P. A. *Estatística Básica*. Cap. 3 (Medidas-resumo).
- TRIOLA, M. F. *Introdução à Estatística*. Cap. 3 (Estatísticas descritivas).
