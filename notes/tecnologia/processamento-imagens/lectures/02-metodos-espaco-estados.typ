#import "@preview/mousse-notes:1.1.0": *
= 23.2 -- Métodos de Espaço de Estados

== Introdução

Nem toda tarefa de PDI trata uma imagem isolada: em vídeo e em visão
computacional é comum acompanhar como um objeto (uma posição, uma
orientação, uma forma) *evolui ao longo do tempo* através de uma sequência
de observações ruidosas. Os *métodos de espaço de estados* modelam esse
problema de forma probabilística -- um estado oculto que evolui segundo uma
dinâmica, observado indiretamente a cada instante -- e fornecem os
algoritmos clássicos de *rastreamento* (tracking) usados como base de
sistemas de visão computacional modernos.

== Estado, dinâmica e observação

#definition(id: "def-espaco-estados")[
  Um sistema em *espaço de estados* é descrito por um vetor de estado oculto
  $x_k$ no instante $k$ (ex.: posição e velocidade de um objeto), que evolui
  segundo um *modelo de dinâmica*
  $ x_k = F_k x_(k-1) + w_k, $
  e é observado indiretamente por um vetor de medição $z_k$ segundo um
  *modelo de observação*
  $ z_k = H_k x_k + v_k, $
  em que $F_k$ é a matriz de transição de estado, $H_k$ a matriz de
  observação, e $w_k$, $v_k$ são ruídos de processo e de medição,
  tipicamente gaussianos de média zero e covariâncias $Q_k$ e $R_k$.
]

#example(id: "ex-modelo-velocidade-constante")[
  Um objeto se movendo em 1D com velocidade aproximadamente constante pode
  ser modelado com estado $x_k = mat(p_k; v_k)$ (posição e velocidade) e
  $ F = mat(1, Delta t; 0, 1), quad H = mat(1, 0), $
  em que $H$ indica que apenas a *posição* é observada diretamente -- a
  velocidade é inferida pelo filtro a partir da sequência de posições.
]

== Filtro de Kalman: predição, correção e inovação

#definition(id: "def-filtro-kalman")[
  O *filtro de Kalman* estima recursivamente $x_k$ a partir de $z_k$, em
  dois passos por instante de tempo:

  *Predição* (usa apenas a dinâmica):
  $ hat(x)_(k|k-1) = F_k hat(x)_(k-1|k-1), quad
    P_(k|k-1) = F_k P_(k-1|k-1) F_k^T + Q_k. $

  *Correção* (incorpora a medição $z_k$):
  $ y_k = z_k - H_k hat(x)_(k|k-1), $
  $ K_k = P_(k|k-1) H_k^T (H_k P_(k|k-1) H_k^T + R_k)^(-1), $
  $ hat(x)_(k|k) = hat(x)_(k|k-1) + K_k y_k, quad
    P_(k|k) = (I - K_k H_k) P_(k|k-1), $
  em que $P_k$ é a covariância do erro de estimação e $K_k$ é o *ganho de
  Kalman*.
]

#definition(id: "def-inovacao")[
  O termo $y_k = z_k - H_k hat(x)_(k|k-1)$ é chamado de *inovação* (ou
  resíduo): a diferença entre a medição observada e a medição *prevista*
  pelo modelo antes de olhar para $z_k$. Quanto maior a inovação, mais o
  filtro corrige sua estimativa -- ponderada pelo ganho $K_k$.
]

#remark[
  O ganho de Kalman $K_k$ pondera automaticamente a confiança entre modelo e
  medição: se o ruído de medição $R_k$ é grande (sensor ruim), $K_k$
  diminui e o filtro confia mais na predição do modelo; se $Q_k$ é grande
  (dinâmica pouco confiável), $K_k$ aumenta e o filtro confia mais na nova
  medição. É essa ponderação -- não uma média fixa -- que caracteriza o
  filtro de Kalman como *ótimo* (no sentido de mínimo erro quadrático) para
  sistemas lineares gaussianos.
]

== Dinâmicas não lineares

O filtro de Kalman clássico (1960) é ótimo apenas quando $F$ e $H$ são
*lineares* e os ruídos são gaussianos. Para dinâmicas não lineares, usam-se
extensões:

#definition(id: "def-extensoes-kalman")[
  - *Filtro de Kalman Estendido (EKF)*: lineariza $F$ e $H$ por uma
    expansão de Taylor de primeira ordem (matriz Jacobiana) em torno da
    estimativa atual, a cada passo.
  - *Filtro de Kalman Unscented (UKF)*: propaga um conjunto determinístico
    de pontos amostrais ("sigma points") pela dinâmica não linear, evitando
    calcular Jacobianas.
  - *Filtro de partículas*: representa a distribuição do estado por um
    conjunto de amostras ponderadas (partículas), atualizadas por
    reamostragem; lida com dinâmicas e ruídos arbitrários (não gaussianos,
    multimodais). O algoritmo CONDENSATION (Isard & Blake, 1998) é a
    aplicação clássica de filtro de partículas ao rastreamento visual de
    contornos.
]

#remark[
  Pegadinha comum: EKF e UKF ainda assumem ruído *gaussiano* (só a dinâmica
  pode ser não linear); apenas o filtro de partículas dispensa essa
  suposição, ao custo de maior complexidade computacional.
]

Métodos de espaço de estados são a base de algoritmos de rastreamento
multiobjeto usados em visão computacional, como o *SORT* (Simple Online and
Realtime Tracking, 2016), que combina filtro de Kalman (predição de
posição/tamanho de caixas delimitadoras) com associação de detecções
quadro a quadro, e de sistemas de fusão sensorial câmera-IMU em robótica e
veículos autônomos.

== Exemplo resolvido

#example(id: "ex-kalman-1d")[
  Um sensor mede a posição de um objeto parado ($v=0$, $F=1$, $H=1$),
  com estimativa anterior $hat(x)_(k-1|k-1) = 10$, variância
  $P_(k-1|k-1) = 4$, ruído de processo $Q=0$ e ruído de medição $R=1$.
  Uma nova medição $z_k = 12$ chega. Calcule $hat(x)_(k|k)$.
]

#solution[
  Predição: $hat(x)_(k|k-1) = 10$, $P_(k|k-1) = 4$ (pois $Q=0$).

  Ganho de Kalman: $K_k = 4/(4+1) = 0.8$.

  Inovação: $y_k = 12 - 10 = 2$.

  Correção: $hat(x)_(k|k) = 10 + 0.8 dot 2 = 11.6$, $P_(k|k) = (1-0.8) dot 4 = 0.8$.

  A estimativa se move na direção da medição, mas não coincide com ela --
  o filtro pondera pela confiança relativa entre predição ($P=4$) e
  medição ($R=1$).
]

== Questões estilo POSCOMP

#example(id: "q-espaco-estados-1")[
  (Múltipla escolha) No filtro de Kalman, o termo $K_k$ (ganho de Kalman)
  tende a se aproximar de zero quando:
  + O ruído de medição $R_k$ é muito pequeno em relação a $P_(k|k-1)$.
  + O ruído de medição $R_k$ é muito grande em relação a $P_(k|k-1)$.
  + A inovação $y_k$ é igual a zero.
  + O sistema é não linear.
]

#solution[
  Resposta: alternativa *(2)*. Pela fórmula
  $K_k = P_(k|k-1) H_k^T (H_k P_(k|k-1) H_k^T + R_k)^(-1)$, quando $R_k$
  domina o denominador, $K_k -> 0$ e o filtro praticamente ignora a
  medição, confiando na predição do modelo.
]

#example(id: "q-espaco-estados-2")[
  Explique, em poucas frases, por que o filtro de partículas é preferível
  ao filtro de Kalman estendido (EKF) quando a distribuição do estado é
  multimodal (ex.: rastrear um objeto que pode estar em duas posições
  plausíveis).
]

#solution[
  O EKF representa a incerteza do estado por uma única gaussiana
  (média + covariância), incapaz de expressar duas hipóteses distintas
  simultaneamente. O filtro de partículas representa a distribuição por um
  conjunto de amostras, podendo concentrar partículas em múltiplas regiões
  do espaço de estados ao mesmo tempo -- capturando a multimodalidade que
  uma única gaussiana não captura.
]

== Referências

- FORSYTH, D. A.; PONCE, J. *Computer Vision: A Modern Approach*. Cap.
  sobre rastreamento e filtro de Kalman.
- ISARD, M.; BLAKE, A. "CONDENSATION -- Conditional Density Propagation
  for Visual Tracking". *IJCV*, 1998.
- cienciadacomputacao.wiki.br -- Tópico 23.2.
