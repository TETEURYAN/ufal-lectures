#import "@preview/mousse-notes:1.1.0": *
= 20.8 -- Aplicação de Texturas

== Introdução

Modelar cada detalhe de superfície (madeira, tijolo, pele) diretamente na
geometria da malha é caro demais. *Mapeamento de textura* resolve isso
"colando" uma imagem 2D sobre a superfície de um objeto 3D, dando a ilusão de
detalhe sem aumentar a contagem de polígonos. A POSCOMP costuma cobrar o
conceito de coordenadas de textura e os métodos de filtragem/amostragem.

== Coordenadas de textura

#definition(id: "def-coord-textura")[
  *Coordenadas de textura* (usualmente chamadas $(u,v)$, no intervalo
  $[0,1] times [0,1]$) são atribuídas a cada vértice de uma malha, associando
  cada ponto da superfície 3D a um ponto da imagem de textura 2D. Durante a
  rasterização, as coordenadas $(u,v)$ são interpoladas sobre a face (de forma
  análoga à interpolação de cor no shading de Gouraud) para determinar, pixel
  a pixel, qual texel (pixel da textura) usar.
]

#definition(id: "def-mapeamento-textura")[
  O *mapeamento de textura* é o processo de definir a função que leva pontos
  da superfície do objeto às coordenadas $(u,v)$. Métodos comuns incluem
  mapeamento planar, cilíndrico, esférico e o desdobramento explícito da malha
  ("UV unwrapping"), conforme a topologia do objeto.
]

#remark[
  Texturas não servem só para cor: *mapas de relevo* (bump mapping) e *mapas
  normais* (normal mapping) usam a mesma ideia de coordenadas $(u,v)$, mas
  para perturbar a *normal* usada no cálculo de iluminação (20.7) em vez da
  cor -- simulando rugosidade sem alterar a geometria real da malha.
]

== Filtragem e amostragem de textura

#definition(id: "def-filtragem-textura")[
  Como a resolução da textura raramente coincide exatamente com a resolução de
  tela após a projeção, é preciso *filtrar* os texels:
  - *Nearest neighbor* (vizinho mais próximo): usa o texel cujo centro está
    mais perto da coordenada $(u,v)$ amostrada -- rápido, mas produz
    serrilhado/pixelização visível (blocos), especialmente quando a textura é
    ampliada;
  - *Filtragem bilinear*: interpola entre os $4$ texels vizinhos mais
    próximos, suavizando a transição;
  - *Mipmapping*: pré-computa versões da textura em resoluções cada vez
    menores (cada nível com metade da resolução do anterior), e escolhe (ou
    interpola entre) o nível de resolução mais apropriado à distância do
    objeto -- reduz tanto o aliasing quanto o custo de acesso à memória para
    texturas distantes/minificadas.
]

#remark[
  Mipmapping ataca principalmente o problema de *minificação* (textura vista
  de longe, mapeada para poucos pixels): sem ele, muitos texels de alta
  frequência caem dentro de um único pixel de tela, causando um tipo de
  aliasing espacial (tema de 20.9). A filtragem bilinear sozinha resolve
  magnificação (textura "de perto"), mas não minificação.
]

#example(id: "q-textura-uv")[
  Um quadrado com vértices $(0,0)$, $(2,0)$, $(2,2)$, $(0,2)$ no espaço do
  objeto recebe coordenadas de textura $(0,0)$, $(1,0)$, $(1,1)$, $(0,1)$,
  respectivamente (mapeamento planar direto). Um ponto no meio da face, em
  $(1,1)$ no espaço do objeto, corresponde a qual coordenada de textura
  (assumindo interpolação bilinear)?
]

#solution[
  O mapeamento é linear e uniforme: a razão entre a posição do ponto e o lado
  do quadrado ($1/2$ em cada eixo) se preserva nas coordenadas $(u,v)$:
  $ u = 1/2 dot (1-0) = 0.5, quad v = 1/2 dot (1-0) = 0.5. $
  O ponto central do quadrado mapeia para o texel central $(0.5, 0.5)$ da
  textura.
]

#example(id: "q-mipmap")[
  (Múltipla escolha) O uso de mipmapping ajuda principalmente a resolver qual
  problema?
  + Distorção de perspectiva ao projetar a textura sobre superfícies curvas.
  + Aliasing e custo de acesso à memória quando a textura é vista à distância
    (minificada).
  + Perda de precisão de cor ao converter de RGB para escala de cinza.
  + Ausência de coordenadas de textura em malhas sem UV unwrapping definido.
]

#solution[
  Resposta: alternativa *(2)*. Mipmapping é uma técnica de pré-filtragem para
  minificação; não resolve distorção geométrica, profundidade de cor, nem
  substitui a necessidade de coordenadas $(u,v)$ bem definidas.
]

== Referências

- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Cap. sobre
  mapeamento de textura.
- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Cap. sobre
  texturização.
- cienciadacomputacao.wiki.br -- Tópico 20.8.
