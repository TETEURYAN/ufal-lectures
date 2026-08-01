#import "@preview/mousse-notes:1.1.0": *

= 7.3 --- Análise Exploratória de Dados

== Introdução

Antes de qualquer teste formal, a Análise Exploratória de Dados (AED) organiza e resume um conjunto de dados por meio de tabelas e gráficos, revelando padrões, tendências e valores atípicos. Na POSCOMP, o mais cobrado é reconhecer qual tipo de gráfico/tabela é adequado para cada tipo de variável, e interpretar corretamente um boxplot.

== Definições formais

#definition(name: "Tipos de variável", id: "def-tipos-variavel")[
  - *Qualitativa (categórica) nominal*: categorias sem ordem natural (ex.: cor dos olhos).
  - *Qualitativa ordinal*: categorias com ordem natural (ex.: nível de escolaridade).
  - *Quantitativa discreta*: valores numéricos contáveis, geralmente inteiros (ex.: número de filhos).
  - *Quantitativa contínua*: valores numéricos em um intervalo real, resultantes de medição (ex.: altura, tempo).
]

#definition(name: "Tabela de frequências", id: "def-tabela-frequencia")[
  Para um conjunto de $n$ observações agrupadas em $k$ classes ou categorias:
  - *Frequência absoluta* $f_i$: número de observações na classe $i$.
  - *Frequência relativa*: $f_i \/ n$ (proporção do total).
  - *Frequência acumulada*: soma das frequências (absolutas ou relativas) até a classe $i$, inclusive.
  Para variáveis contínuas agrupadas em classes de igual amplitude, um critério comum para o número de classes $k$ é a *regra de Sturges*: $k approx 1 + 3.322 log_10(n)$.
]

#definition(name: "Boxplot (diagrama de caixa)", id: "def-boxplot")[
  Representação gráfica baseada em cinco números: mínimo, primeiro quartil ($Q_1$), mediana ($Q_2$), terceiro quartil ($Q_3$) e máximo. A caixa vai de $Q_1$ a $Q_3$ (contendo os 50% centrais dos dados, com altura igual ao *intervalo interquartil* $I Q R = Q_3 - Q_1$); as hastes (*whiskers*) se estendem até o menor/maior valor dentro de $1.5 times I Q R$ além da caixa; pontos além disso são marcados individualmente como *outliers* (valores atípicos).
]

== Exemplo resolvido

#example(name: "Boxplot e forma da distribuição", id: "ex-boxplot-forma")[
  A figura abaixo compara um boxplot com a curva de densidade de uma distribuição Normal padrão subjacente. Repare que, quando os dados são aproximadamente simétricos, a mediana fica no centro da caixa e as hastes têm comprimentos parecidos -- desvios dessa simetria (mediana deslocada para um dos lados da caixa, ou hastes de comprimentos muito diferentes) indicam *assimetria* na distribuição dos dados.

  #figure(
    image("figures/boxplot-vs-pdf.svg", width: 70%),
    caption: [Boxplot alinhado à densidade de uma Normal padrão $N(0, sigma^2)$. Fonte: Wikimedia Commons, CC BY-SA (Jhguch, Chen-Pan Liao, Ederporto / RIDC NeuroMat).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "Histograma exige variável quantitativa contínua (ou discreta agrupada)")[
  Histograma é construído sobre classes de um intervalo contínuo, com barras justapostas (sem espaço entre elas). Para variáveis qualitativas (ou quantitativas discretas com poucos valores distintos), o gráfico adequado é o de *barras*, com espaço entre elas -- uma confusão comum em provas objetivas.
]

#remark(name: "Outlier no boxplot não é automaticamente um erro de medição")[
  Um ponto marcado como outlier pelo critério de $1.5 times I Q R$ é estatisticamente atípico em relação ao restante da amostra, mas isso não significa necessariamente erro de coleta -- pode ser uma observação legítima e informativa, e deve ser investigada, não descartada por padrão.
]

== Questões estilo POSCOMP

*Questão 1.* Uma variável que representa o número de filhos de uma pessoa é classificada como:
- a) Qualitativa nominal.
- b) Qualitativa ordinal.
- c) Quantitativa discreta.
- d) Quantitativa contínua.
- e) Nenhuma das anteriores.

*Questão 2.* Em um boxplot, a altura da caixa (entre $Q_1$ e $Q_3$) representa:
- a) O desvio-padrão dos dados.
- b) A amplitude total dos dados.
- c) O intervalo interquartil ($I Q R$), contendo os 50% centrais dos dados.
- d) A média dos dados.
- e) A moda dos dados.

*Questão 3.* Para representar graficamente a distribuição de uma variável quantitativa contínua agrupada em classes, o gráfico apropriado é:
- a) Gráfico de barras.
- b) Gráfico de setores (pizza).
- c) Histograma.
- d) Diagrama de dispersão.
- e) Gráfico de linhas temporal.

== Gabarito comentado

1. *(c)* -- número de filhos é contável (0, 1, 2, ...), logo quantitativa discreta.
2. *(c)* -- por definição, a caixa do boxplot vai de $Q_1$ a $Q_3$, cuja diferença é o $I Q R$.
3. *(c)* -- histograma é o gráfico padrão para variáveis contínuas agrupadas em classes.

== Referências

- BUSSAB, W. O.; MORETTIN, P. A. *Estatística Básica*. Cap. 2--3 (Resumo de dados e AED).
- TRIOLA, M. F. *Introdução à Estatística*. Cap. 2 (Resumindo dados com frequência e gráficos).
