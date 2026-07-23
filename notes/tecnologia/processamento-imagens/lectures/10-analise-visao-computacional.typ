#import "@preview/mousse-notes:1.1.0": *
= 23.10 -- Análise de Imagens e Noções de Visão Computacional

== Introdução

#definition(id: "def-pdi-vs-vc")[
  *Processamento de Imagens* opera no nível do *pixel*: recebe uma imagem e
  devolve outra imagem (filtrada, realçada, restaurada -- 23.1 a 23.9).
  *Visão Computacional* opera no nível da *interpretação*: recebe uma
  imagem (ou uma imagem já processada) e devolve uma descrição de mais
  alto nível -- quais objetos existem, onde estão, o que representam.
  *Análise de Imagens* é a ponte entre os dois: extrai, de uma imagem já
  processada, regiões, bordas e descritores que servirão de entrada para
  tarefas de interpretação (23.11).
]

#remark[
  Pegadinha recorrente de prova: tratar "processamento de imagens" e "visão
  computacional" como sinônimos, ou classificar segmentação (que já produz
  uma descrição estrutural da imagem -- regiões, bordas) puramente como
  PDI de baixo nível. Segmentação é o passo de transição: usa técnicas de
  PDI, mas seu propósito é preparar a imagem para análise/interpretação.
]

== Segmentação por limiarização

#definition(id: "def-limiarizacao")[
  *Limiarização* (thresholding) segmenta uma imagem em duas classes
  (objeto/fundo) comparando cada pixel a um limiar $T$:
  $ g(x,y) = cases(1 & "se" f(x,y) > T, 0 & "caso contrário"). $
]

#theorem(id: "thm-otsu", name: "Método de Otsu")[
  O *método de Otsu* escolhe $T$ automaticamente, maximizando a variância
  *entre classes* (equivalentemente, minimizando a variância *dentro* de
  cada classe), assumindo que o histograma da imagem é aproximadamente
  bimodal (duas classes bem separadas).
]

#remark[
  Otsu falha (produz um limiar ruim) quando o histograma não é bimodal --
  por exemplo, iluminação não uniforme na cena, que faz o "fundo" ocupar uma
  faixa larga e sobreposta à faixa do "objeto". Nesses casos usa-se
  limiarização *adaptativa* (limiar calculado localmente, por região da
  imagem, em vez de um único $T$ global).
]

== Detecção de bordas

#definition(id: "def-gradiente-imagem")[
  O *gradiente* de uma imagem em $(x,y)$ é o vetor
  $ nabla f = mat(diff f\/diff x; diff f\/diff y), $
  cuja magnitude $|nabla f| = sqrt((diff f\/diff x)^2 + (diff f\/diff y)^2)$
  indica a intensidade da variação local (força da borda) e cuja direção
  indica a orientação perpendicular à borda. Os operadores de *Sobel* e
  *Prewitt* são máscaras $3 times 3$ que aproximam $diff f\/diff x$ e
  $diff f\/diff y$ por convolução.
]

#remark[
  O gradiente (Sobel/Prewitt) é sensível a ruído porque deriva a imagem
  (amplifica altas frequências, @thm-convolucao-frequencia). O detector de
  *Canny* mitiga isso combinando várias etapas: suavização gaussiana prévia,
  cálculo do gradiente, *supressão não máxima* (afina bordas largas para
  $1$ pixel, mantendo só o pico local do gradiente na direção perpendicular
  à borda) e *limiarização por histerese* (dois limiares: pixels acima do
  limiar alto são bordas certas; pixels entre os dois limiares só viram
  borda se conectados a uma borda certa). É considerado o detector de
  bordas "padrão-ouro" justamente por combinar essas etapas, não por usar
  uma única máscara mais sofisticada.
]

== Segmentação baseada em região

#definition(id: "def-crescimento-regiao")[
  *Crescimento de regiões* (region growing) parte de pixels-semente e
  agrega iterativamente pixels vizinhos (@def-vizinhanca, 23.3) que
  satisfazem um critério de similaridade (ex.: diferença de intensidade
  abaixo de um limiar), até que nenhum vizinho elegível reste.
]

#remark[
  Alternativa "de cima para baixo": *split-and-merge* começa com a imagem
  inteira como uma região, divide-a recursivamente em quadrantes enquanto
  um critério de homogeneidade não for satisfeito (*split*), e depois funde
  regiões adjacentes homogêneas entre si (*merge*) -- ao contrário do
  crescimento de regiões, que é "de baixo para cima" (parte de sementes
  individuais).
]

== Morfologia matemática

#definition(id: "def-morfologia-basica")[
  Para uma imagem binária $A$ e um elemento estruturante $B$:
  - *Erosão* $A ominus B$: um pixel pertence ao resultado só se $B$,
    centrado nesse pixel, cabe *inteiramente* dentro de $A$ -- encolhe
    regiões e remove ruído fino.
  - *Dilatação* $A plus.circle B$: um pixel pertence ao resultado se $B$,
    centrado nesse pixel, toca $A$ em *algum* ponto -- expande regiões e
    preenche pequenos buracos.
]

#definition(id: "def-abertura-fechamento")[
  A *abertura* de $A$ por $B$ é definida como
  $ "abertura"(A,B) = (A ominus B) plus.circle B $
  (erosão seguida de dilatação): remove pequenas saliências e ruído fino,
  preservando o tamanho geral da região. O *fechamento* de $A$ por $B$ é
  definido como
  $ "fechamento"(A,B) = (A plus.circle B) ominus B $
  (dilatação seguida de erosão): preenche pequenos buracos e reentrâncias,
  preservando o tamanho geral da região.
]

#remark[
  Pegadinha clássica: abertura e fechamento *não* são operações inversas
  uma da outra (ao contrário do que os nomes sugerem) -- aplicar abertura e
  depois fechamento não recupera a imagem original. Ambas são, porém,
  *idempotentes*: aplicar abertura duas vezes em sequência dá o mesmo
  resultado que aplicar uma vez.
]

== Descritores de região e de contorno

#definition(id: "def-descritores-regiao")[
  Descritores básicos de uma região segmentada incluem *área* (número de
  pixels), *perímetro* (comprimento do contorno) e a *compacidade*
  (circularidade)
  $ C = "perímetro"^2 / "área", $
  mínima ($C = 4pi$) para um círculo perfeito, e maior para formas
  irregulares ou alongadas -- um descritor invariante a escala e rotação,
  útil como entrada para reconhecimento de padrões (23.11).
]

== Exemplo resolvido

#example(id: "ex-compacidade")[
  Uma região quadrada de lado $L$ tem área $L^2$ e perímetro $4L$. Calcule
  sua compacidade $C$ e compare com a de um círculo de mesma área.
]

#solution[
  $ C_"quadrado" = (4L)^2 / L^2 = 16. $
  Para um círculo de área $A = pi r^2$, o perímetro é $2 pi r$, logo
  $ C_"círculo" = (2 pi r)^2 / (pi r^2) = 4 pi approx 12.57. $
  O quadrado tem compacidade maior que o círculo -- coerente com o círculo
  minimizar a compacidade entre todas as formas de mesma área, por ter a
  razão perímetro/área mais eficiente.
]

== Questões estilo POSCOMP

#example(id: "q-analise-1")[
  (Múltipla escolha) O detector de bordas de Canny é considerado robusto
  principalmente porque:
  + Usa uma única máscara de convolução maior que a de Sobel.
  + Combina suavização prévia, supressão não máxima e limiarização por
    histerese em um pipeline de múltiplas etapas.
  + Elimina completamente a necessidade de calcular o gradiente da imagem.
  + Funciona exclusivamente no domínio da frequência.
]

#solution[
  Resposta: alternativa *(2)*.
]

#example(id: "q-analise-2")[
  Explique a diferença entre *abertura* e *fechamento* morfológicos, e dê
  um exemplo de defeito de imagem binária que cada uma corrige melhor.
]

#solution[
  Abertura (erosão seguida de dilatação) remove pequenas saliências e
  ruído fino isolado (pontos brancos espúrios sobre um fundo escuro),
  preservando o tamanho geral dos objetos. Fechamento (dilatação seguida
  de erosão) preenche pequenos buracos e reentrâncias dentro dos objetos
  (pontos pretos espúrios dentro de uma região branca), também preservando
  o tamanho geral -- são operações complementares, mas não inversas uma da
  outra (@def-abertura-fechamento).
]

== Referências

- GONZALEZ, R. C.; WOODS, R. E. *Digital Image Processing*. Cap. sobre
  segmentação e morfologia matemática.
- SZELISKI, R. *Computer Vision: Algorithms and Applications*. Cap. sobre
  segmentação e detecção de bordas.
- cienciadacomputacao.wiki.br -- Tópico 23.10.
