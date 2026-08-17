#import "@preview/mousse-notes:1.1.0": *
= 20.7 -- O Processo de Rendering: Luz, Superfícies Ocultas e Shading

== Introdução

"Rendering" é o processo de converter uma cena 3D descrita geometricamente
(20.6) em uma imagem 2D com aparência realista, resolvendo três problemas:
quais superfícies são visíveis (remoção de superfícies ocultas), qual cor cada
ponto visível deve ter (modelos de iluminação) e como interpolar essa cor
sobre um polígono (modelos de sombreamento). É o subtópico mais denso
conceitualmente da disciplina para a POSCOMP.

== Fontes de luz e modelo de iluminação de Phong

#definition(id: "def-fontes-luz")[
  Os tipos clássicos de fonte de luz em síntese de imagens são:
  - *luz ambiente*: intensidade constante, uniforme em toda a cena, aproxima a
    luz indireta refletida por todo o ambiente;
  - *luz pontual* (point light): emite em todas as direções a partir de um
    ponto, com atenuação pela distância;
  - *luz direcional*: todos os raios são paralelos (fonte a distância
    infinita, como o Sol), sem atenuação por distância;
  - *luz spot*: pontual, mas restrita a um cone de direção.
]

#theorem(id: "thm-phong-iluminacao")[
  O *modelo de iluminação de Phong* estima a intensidade de luz refletida em
  um ponto como a soma de três componentes:
  $ I = I_a k_a + I_d k_d (N dot L) + I_s k_s (R dot V)^n, $
  em que $I_a, I_d, I_s$ são as intensidades ambiente/difusa/especular da
  fonte, $k_a,k_d,k_s in [0,1]$ são os coeficientes de reflexão do material,
  $N$ é a normal da superfície, $L$ o vetor unitário em direção à luz, $V$ o
  vetor unitário em direção ao observador, $R$ o vetor de reflexão de $L$ em
  torno de $N$, e $n$ o *expoente de brilho* ("shininess"): quanto maior $n$,
  mais concentrado e pontual o brilho especular.
]

#remark[
  O termo difuso ($I_d k_d (N dot L)$) modela reflexão *lambertiana*
  (fosca, uniforme em todas as direções de observação) -- por isso não depende
  de $V$. O termo especular *depende* de $V$: é o único responsável pelos
  brilhos ("highlights") que mudam de posição conforme o observador se move.
  Confundir os dois termos é armadilha recorrente.
]

#example(id: "q-phong-difuso")[
  Em um ponto da superfície, a normal é $N = (0,1,0)$ e o vetor unitário em
  direção à fonte de luz é $L = (0, 1/sqrt(2), 1/sqrt(2))$. Com
  $I_d = 1$ e $k_d = 0.8$, calcule a componente difusa da iluminação.
]

#solution[
  $ N dot L = 0 dot 0 + 1 dot 1/sqrt(2) + 0 dot 1/sqrt(2) = 1/sqrt(2) approx 0.707. $
  $ I_"difusa" = I_d k_d (N dot L) = 1 dot 0.8 dot 0.707 approx 0.566. $
]

== Remoção de superfícies ocultas

#definition(id: "def-zbuffer")[
  O algoritmo do *Z-buffer* mantém, para cada pixel, além da cor, o valor de
  profundidade ($z$) do fragmento mais próximo da câmera já desenhado naquele
  pixel. Ao rasterizar um novo fragmento, sua profundidade é comparada com o
  valor armazenado: se for mais próxima da câmera, a cor e a profundidade do
  pixel são atualizadas; caso contrário, o fragmento é descartado.
]

#definition(id: "def-painters")[
  O *algoritmo do pintor* (painter's algorithm / depth sort) ordena os
  polígonos da cena por profundidade (do mais distante ao mais próximo) e os
  desenha nessa ordem, deixando os mais próximos sobrepor os mais distantes.
]

#remark[
  O algoritmo do pintor é mais barato em memória (não precisa de um buffer por
  pixel), mas *falha* quando polígonos se interceptam ou formam um ciclo de
  sobreposição (A na frente de B, B na frente de C, C na frente de A) -- nesses
  casos não existe uma ordenação global válida, exigindo subdivisão dos
  polígonos. O Z-buffer, por comparar profundidade *por pixel*, resolve
  corretamente esses casos sem pré-ordenar nada, ao custo de um buffer de
  profundidade do tamanho da tela.
]

#definition(id: "def-backface-culling")[
  *Back-face culling* descarta, antes mesmo da rasterização, as faces cuja
  normal aponta para longe do observador (i.e., $N dot V < 0$), pois essas
  faces pertencem ao lado "de trás" de um sólido opaco fechado e nunca seriam
  visíveis de qualquer forma -- uma otimização, não uma técnica geral de
  remoção de superfícies ocultas (não resolve oclusão entre objetos distintos).
]

== Modelos de sombreamento (shading)

#definition(id: "def-modelos-shading")[
  Dado um modelo de iluminação (como Phong), os modelos de sombreamento
  definem *onde* e *com que frequência* ele é avaliado sobre um polígono:
  - *Shading constante* (flat shading): a iluminação é calculada uma única vez
    por face, usando a normal da face -- rápido, mas revela as arestas entre
    polígonos (aparência "facetada");
  - *Shading de Gouraud*: a iluminação é calculada nos *vértices* (usando
    normais de vértice), e as *cores* resultantes são interpoladas
    (bilinearmente) sobre a face -- suaviza a aparência, mas pode perder ou
    distorcer brilhos especulares pequenos que caem entre vértices;
  - *Shading de Phong* (interpolação de normais, não confundir com o modelo de
    iluminação de Phong): a *normal* é interpolada sobre a face, e a
    iluminação é recalculada em *cada pixel* -- mais caro computacionalmente,
    mas reproduz brilhos especulares com muito mais fidelidade.
]

#remark[
  Ordem crescente de custo computacional e qualidade: *flat* $<$ *Gouraud*
  $<$ *Phong (interpolação de normais)*. A POSCOMP gosta de testar se o
  candidato sabe que "shading de Phong" (técnica de interpolação) e "modelo de
  iluminação de Phong" (a fórmula de $I$) são coisas *diferentes*, embora do
  mesmo autor (Bui Tuong Phong).
]

#example(id: "q-shading-comparacao")[
  (Múltipla escolha) Qual das afirmações a seguir está correta?
  + Gouraud shading interpola normais por pixel; Phong shading interpola cores
    por vértice.
  + Flat shading é o mais custoso computacionalmente, pois recalcula a
    iluminação a cada pixel.
  + Phong shading (interpolação de normais) tende a representar melhor
    highlights especulares pequenos do que Gouraud shading.
  + O Z-buffer exige ordenar previamente os polígonos por profundidade antes
    de desenhar.
]

#solution[
  Resposta: alternativa *(3)*. As alternativas (1) e (2) trocam as
  características de Gouraud e Phong / flat e Phong; a (4) descreve o
  algoritmo do pintor, não o Z-buffer (que dispensa ordenação prévia).
]

== Referências

- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Caps. sobre
  iluminação, sombreamento e visibilidade.
- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Caps. sobre modelos
  de iluminação e remoção de superfícies ocultas.
- cienciadacomputacao.wiki.br -- Tópico 20.7.
