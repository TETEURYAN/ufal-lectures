#import "@preview/mousse-notes:1.1.0": *

= 7.14 --- Regressão e Correlação

== Introdução

Enquanto a correlação de Pearson (7.9) mede o *grau* de associação linear entre duas variáveis, a regressão linear vai além: constrói um modelo para *prever* uma variável a partir da outra. É o fechamento natural da disciplina, combinando esperança, variância e covariância em um único método.

== Definições formais

#definition(name: "Regressão linear simples", id: "def-regressao-linear-simples")[
  Modelo que descreve a relação entre uma variável resposta $Y$ e uma variável explicativa $X$ como:
  $ Y = beta_0 + beta_1 X + epsilon.alt $
  onde $beta_0$ (intercepto) e $beta_1$ (inclinação) são parâmetros a estimar, e $epsilon.alt$ é um erro aleatório com $E[epsilon.alt]=0$. Pelo *método dos mínimos quadrados* (que minimiza a soma dos quadrados dos resíduos), os estimadores são:
  $ b_1 = S_(x y)/S_(x x) = (sum_i (x_i - macron(x))(y_i - macron(y)))/(sum_i (x_i-macron(x))^2), quad quad b_0 = macron(y) - b_1 macron(x) $
]

#definition(name: "Coeficiente de determinação", id: "def-coeficiente-determinacao")[
  $R^2$ mede a proporção da variabilidade de $Y$ explicada pelo modelo de regressão em $X$:
  $ R^2 = ("SQ"_"regressão")/("SQ"_"total") = 1 - ("SQ"_"resíduos")/("SQ"_"total") $
  com $R^2 in [0,1]$. Na regressão linear *simples* (uma única variável explicativa), $R^2 = rho_(X,Y)^2$, o quadrado do coeficiente de correlação de Pearson (@def-covariancia-correlacao).
]

== Exemplo resolvido

#example(name: "Ajuste de reta por mínimos quadrados", id: "ex-minimos-quadrados")[
  Dados $(x,y)$: $(1,2), (2,3), (3,5), (4,6), (5,9)$, com $macron(x)=3$, $macron(y)=5$.

  #table(
    columns: 5,
    [*$x_i$*], [*$y_i$*], [*$x_i - macron(x)$*], [*$y_i - macron(y)$*], [*$(x_i-macron(x))(y_i-macron(y))$*],
    [1], [2], [$-2$], [$-3$], [6],
    [2], [3], [$-1$], [$-2$], [2],
    [3], [5], [0], [0], [0],
    [4], [6], [1], [1], [1],
    [5], [9], [2], [4], [8],
  )

  $S_(x y) = 6+2+0+1+8 = 17$. $S_(x x) = 4+1+0+1+4=10$.

  $ b_1 = 17/10 = 1.7, quad quad b_0 = 5 - (1.7)(3) = 5 - 5.1 = -0.1 $

  Reta ajustada: $hat(y) = -0.1 + 1.7 x$. Para $x=6$ (dentro de uma extrapolação moderada), a previsão seria $hat(y) = -0.1+1.7(6)=10.1$.
]

#figure(
  image("figures/linear-regression.svg", width: 65%),
  caption: [Reta de mínimos quadrados ajustada a um conjunto de pontos dispersos. Fonte: Wikimedia Commons, domínio público (Sewaqu).],
)

== Atenção -- pegadinhas comuns

#remark(name: "Regressão não é simétrica; correlação é")[
  $rho_(X,Y) = rho_(Y,X)$ (correlação é simétrica), mas a reta de regressão de $Y$ sobre $X$ é, em geral, *diferente* da reta de regressão de $X$ sobre $Y$ -- os mínimos quadrados minimizam resíduos verticais em um caso e horizontais no outro. Regressão pressupõe uma direção causal ou preditiva assumida no modelo; correlação não.
]

#remark(name: "R² alto não implica relação causal")[
  Assim como correlação (7.9), um $R^2$ próximo de 1 indica bom ajuste linear aos dados observados, não uma relação de causa e efeito. Variáveis podem estar associadas por uma causa comum (variável confundidora) sem que uma cause a outra.
]

#remark(name: "Cuidado com extrapolação")[
  O modelo ajustado só tem respaldo empírico dentro (ou próximo) do intervalo de valores de $X$ observados na amostra. Prever $Y$ para um $X$ muito além desse intervalo é *extrapolação* e pode ser altamente impreciso, mesmo com $R^2$ alto dentro do intervalo original.
]

== Questões estilo POSCOMP

*Questão 1.* Na regressão linear simples $Y = beta_0 + beta_1 X + epsilon.alt$, o coeficiente $beta_1$ é estimado pelo método dos mínimos quadrados de forma a:
- a) Maximizar a soma dos resíduos.
- b) Minimizar a soma dos quadrados dos resíduos.
- c) Maximizar $R^2$ artificialmente sem relação com os dados.
- d) Igualar $macron(x)$ e $macron(y)$.
- e) Minimizar apenas o intercepto $beta_0$.

*Questão 2.* Se o coeficiente de correlação de Pearson entre $X$ e $Y$ é $rho = 0.8$, o coeficiente de determinação $R^2$ da regressão linear simples de $Y$ sobre $X$ é:
- a) $0.8$.
- b) $0.64$.
- c) $1.6$.
- d) $0.4$.
- e) Não é possível calcular sem mais informações.

*Questão 3.* Usar um modelo de regressão ajustado para prever $Y$ em um valor de $X$ muito fora do intervalo observado na amostra é chamado de:
- a) Interpolação.
- b) Correlação espúria.
- c) Extrapolação, que deve ser evitada ou tratada com cautela.
- d) Regressão múltipla.
- e) Padronização.

== Gabarito comentado

1. *(b)* -- é a própria definição do método dos mínimos quadrados.
2. *(b)* -- $R^2 = rho^2 = 0.8^2 = 0.64$, válido para regressão linear simples.
3. *(c)* -- extrapolação é prever fora do intervalo observado, o que compromete a confiabilidade da previsão.

== Referências

- BUSSAB, W. O.; MORETTIN, P. A. *Estatística Básica*. Cap. 14--15 (Regressão e correlação).
- TRIOLA, M. F. *Introdução à Estatística*. Cap. 10 (Correlação e regressão).
- MONTGOMERY, D. C.; RUNGER, G. C. *Estatística Aplicada e Probabilidade para Engenheiros*. Cap. 11 (Regressão linear simples).
