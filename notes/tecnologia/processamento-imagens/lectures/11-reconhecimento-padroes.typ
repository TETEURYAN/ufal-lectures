#import "@preview/mousse-notes:1.1.0": *
= 23.11 -- Reconhecimento de Padrões

== Introdução

Reconhecimento de Padrões é a etapa final da cadeia PDI → Análise → Visão
Computacional (@def-pdi-vs-vc, 23.10): a partir dos descritores extraídos
de uma imagem já segmentada (área, compacidade, momentos, ou vetores de
características aprendidos por uma rede neural), decide-se a qual *classe*
um objeto ou região pertence.

== Padrões, características e classes

#definition(id: "def-padrao-caracteristicas")[
  Um *padrão* é representado por um *vetor de características*
  $x = (x_1, dots, x_n) in RR^n$ (ex.: área, perímetro, compacidade de uma
  região -- 23.10). Um *classificador* é uma função que mapeia $x$ para uma
  entre $c$ *classes* $omega_1, dots, omega_c$.
]

#definition(id: "def-aprendizado-sup-nao-sup")[
  Em *aprendizado supervisionado*, o classificador é treinado com exemplos
  rotulados $(x_i, omega_i)$ (a classe correta é conhecida durante o
  treino). Em *aprendizado não supervisionado*, não há rótulos: o objetivo
  é agrupar padrões similares em *clusters*, sem saber de antemão a que
  classe cada padrão pertence.
]

== Classificadores de distância

#definition(id: "def-classificador-distancia-minima")[
  O *classificador de distância mínima* representa cada classe $omega_j$
  por um protótipo (tipicamente a média $m_j$ dos vetores de treino dessa
  classe) e atribui a um novo padrão $x$ a classe cujo protótipo está mais
  próximo:
  $ omega(x) = "argmin"_j space d(x, m_j), $
  com $d$ tipicamente a distância Euclidiana
  $d(x,m_j) = sqrt(sum_(i=1)^n (x_i - m_(j,i))^2)$.
]

#definition(id: "def-knn")[
  O classificador *k-vizinhos mais próximos (k-NN)* atribui a $x$ a classe
  *majoritária* entre os $k$ padrões de treino mais próximos de $x$
  (por alguma métrica de distância), sem construir um protótipo por classe.
]

#remark[
  Pegadinha clássica: o classificador de distância mínima assume
  implicitamente que cada classe forma um agrupamento aproximadamente
  esférico e compacto em torno de sua média -- ele falha quando classes têm
  formas alongadas, múltiplos agrupamentos, ou variância muito diferente
  entre si. O k-NN não assume essa forma (é não paramétrico), mas é mais
  caro computacionalmente (precisa calcular distância a todo o conjunto de
  treino a cada classificação) e sensível à escolha de $k$: $k$ pequeno
  aumenta a sensibilidade a ruído/outliers; $k$ grande tende a suavizar
  demais a fronteira de decisão, podendo ignorar estrutura local relevante.
]

== Agrupamento não supervisionado: k-means

#definition(id: "def-kmeans")[
  O algoritmo *k-means* particiona $N$ padrões em $k$ clusters, iterando
  até convergência:
  + Inicializa $k$ centróides (aleatoriamente ou por heurística).
  + *Atribuição*: associa cada padrão ao centróide mais próximo.
  + *Atualização*: recalcula cada centróide como a média dos padrões a ele
    atribuídos.
  + Repete os passos 2--3 até que as atribuições não mudem (ou até um
    critério de parada).
]

#remark[
  K-means converge para um *mínimo local*, não necessariamente global -- o
  resultado depende da inicialização dos centróides, e é prática comum
  rodar o algoritmo várias vezes com inicializações diferentes e manter o
  melhor resultado. Além disso, exige que o número de clusters $k$ seja
  escolhido *a priori*, ao contrário de métodos hierárquicos de
  agrupamento.
]

== Avaliação de classificadores

#definition(id: "def-matriz-confusao")[
  A *matriz de confusão* de um classificador binário cruza a classe
  verdadeira com a classe prevista, definindo verdadeiros positivos (VP),
  falsos positivos (FP), verdadeiros negativos (VN) e falsos negativos
  (FN). A partir dela:
  $ "acurácia" = (V P + V N) / (V P + V N + F P + F N), quad
    "precisão" = (V P) / (V P + F P), quad
    "revocação" = (V P) / (V P + F N). $
]

#remark[
  Em conjuntos de dados desbalanceados (uma classe muito mais frequente que
  a outra), acurácia alta pode esconder um classificador inútil -- um
  classificador que sempre prevê a classe majoritária tem acurácia alta,
  mas revocação zero na classe minoritária. Precisão e revocação (ou sua
  combinação, o F1-score) são mais informativas nesses casos.
]

== Exemplo resolvido

#example(id: "ex-classificador-distancia")[
  Duas classes têm protótipos $m_1 = (0,0)$ e $m_2 = (6,0)$ (distância
  Euclidiana). Classifique o padrão $x=(2,1)$ pelo classificador de
  distância mínima.
]

#solution[
  $ d(x,m_1) = sqrt(2^2+1^2) = sqrt(5) approx 2.24, $
  $ d(x,m_2) = sqrt((2-6)^2+1^2) = sqrt(17) approx 4.12. $
  Como $d(x,m_1) < d(x,m_2)$, $x$ é classificado como $omega_1$.
]

== Questões estilo POSCOMP

#example(id: "q-reconhecimento-1")[
  (Múltipla escolha) Sobre k-means e k-NN, é correto afirmar que:
  + Ambos são algoritmos de aprendizado supervisionado.
  + K-means é não supervisionado (agrupamento); k-NN é supervisionado
    (classificação, requer exemplos rotulados).
  + K-NN não depende de um parâmetro escolhido pelo usuário.
  + K-means garante convergência para o mínimo global, independentemente
    da inicialização.
]

#solution[
  Resposta: alternativa *(2)*. K-means agrupa dados não rotulados
  (@def-aprendizado-sup-nao-sup); k-NN classifica com base em exemplos de
  treino rotulados. A (3) é falsa pois k-NN depende do parâmetro $k$; a
  (4) é falsa pois k-means converge apenas para um mínimo local
  (@def-kmeans).
]

#example(id: "q-reconhecimento-2")[
  Um classificador binário tem $V P = 90$, $F P = 5$, $V N = 2$,
  $F N = 3$ em um conjunto de teste desbalanceado. Calcule acurácia,
  precisão e revocação, e comente se a acurácia é uma métrica confiável
  aqui.
]

#solution[
  $ "acurácia" = (90+2)/(90+2+5+3) = 92/100 = 0.92, $
  $ "precisão" = 90/(90+5) = 90/95 approx 0.947, $
  $ "revocação" = 90/(90+3) = 90/93 approx 0.968. $
  A acurácia parece alta, mas o conjunto é desbalanceado (só $5$ exemplos
  negativos verdadeiros entre $100$): um classificador que sempre prevê a
  classe positiva teria acurácia $95/100=0.95$, ainda maior, apesar de
  ignorar completamente a classe negativa -- reforçando que acurácia
  isolada pode enganar em cenários desbalanceados.
]

== Referências

- GONZALEZ, R. C.; WOODS, R. E. *Digital Image Processing*. Cap. sobre
  reconhecimento de padrões.
- DUDA, R. O.; HART, P. E.; STORK, D. G. *Pattern Classification*. Cap.
  sobre classificadores de distância mínima e k-NN.
- cienciadacomputacao.wiki.br -- Tópico 23.11.
