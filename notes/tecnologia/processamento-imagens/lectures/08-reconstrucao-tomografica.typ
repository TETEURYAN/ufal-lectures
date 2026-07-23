#import "@preview/mousse-notes:1.1.0": *
= 23.8 -- Reconstrução Tomográfica de Imagens

== Introdução

Tomografia computadorizada (CT) não fotografa a cena diretamente: um
detector mede *projeções* -- somas de atenuação ao longo de raios que
atravessam o objeto, em vários ângulos -- e o problema de PDI é
*reconstruir* a imagem 2D (um corte transversal) a partir dessas projeções
1D. É uma aplicação direta e muito cobrada da teoria de transformadas vista
em 23.5.

== Transformada de Radon e sinograma

#definition(id: "def-transformada-radon")[
  A *transformada de Radon* de uma imagem $f(x,y)$ no ângulo $theta$ é a
  projeção (integral de linha) de $f$ ao longo de todas as retas
  perpendiculares à direção $theta$:
  $ p_theta (t) = integral_(-infinity)^(infinity) f(t cos theta - s sin theta,
      space t sin theta + s cos theta) space d s, $
  em que $t$ é a posição ao longo do detector e $s$ percorre o raio.
  Fisicamente, $p_theta(t)$ é a atenuação total medida pelo detector na
  posição $t$, para a projeção tomada no ângulo $theta$.
]

#definition(id: "def-sinograma")[
  O *sinograma* é a imagem 2D formada pelas projeções $p_theta(t)$
  empilhadas, com um eixo para $t$ e outro para $theta in [0, pi)$. Um único
  ponto da imagem original, ao ser projetado em todos os ângulos, traça uma
  curva senoidal no sinograma -- daí o nome.
]

== Teorema da fatia central (Fourier Slice Theorem)

#theorem(id: "thm-fatia-central", name: "Teorema da Fatia Central")[
  A Transformada de Fourier 1D de uma projeção $p_theta(t)$ (em relação a
  $t$) é igual a uma *fatia* radial, no ângulo $theta$, da Transformada de
  Fourier 2D da imagem original $f(x,y)$:
  $ P_theta (omega) = F(omega cos theta, omega sin theta). $
]

#remark[
  O teorema da fatia central é o elo formal entre 23.5 (transformadas) e a
  reconstrução tomográfica: ele garante que, medindo projeções em
  *ângulos suficientes* $theta in [0,pi)$, é possível preencher todo o
  domínio de frequência 2D de $F(u,v)$ com fatias radiais e, por
  transformada inversa, recuperar $f(x,y)$ -- essa é a base teórica de que
  a reconstrução a partir de projeções é, em princípio, exata.
]

== Retroprojeção e retroprojeção filtrada

#definition(id: "def-retroprojecao")[
  A *retroprojeção simples* (backprojection) reconstrói uma estimativa de
  $f(x,y)$ somando, para cada ponto $(x,y)$, o valor de cada projeção
  $p_theta$ no ponto correspondente, sobre todos os ângulos:
  $ hat(f)(x,y) = integral_0^pi p_theta (x cos theta + y sin theta) space d theta. $
]

#remark[
  A retroprojeção simples reconstrói uma imagem *borrada*: como as fatias
  de frequência do teorema da fatia central são mais densas perto da
  origem (baixas frequências) e mais esparsas nas frequências altas, a
  retroprojeção simples pondera as baixas frequências em excesso -- o
  artefato clássico é um borramento proporcional a $1/r$ no domínio da
  frequência, onde $r$ é a distância à origem.
]

#definition(id: "def-retroprojecao-filtrada")[
  A *retroprojeção filtrada* (filtered backprojection, FBP) corrige esse
  borramento aplicando, a cada projeção $p_theta$, um *filtro rampa*
  (proporcional a $|omega|$ no domínio da frequência, compensando
  exatamente a densidade $1/|omega|$ das fatias) antes de retroprojetar:
  $ hat(f)(x,y) = integral_0^pi
      [p_theta * h_"rampa"](x cos theta + y sin theta) space d theta. $
]

#remark[
  Na prática, o filtro rampa puro amplifica ruído de alta frequência (o
  mesmo problema visto no filtro inverso, 23.7); por isso, implementações
  reais combinam o filtro rampa com uma janela passa-baixa (ex.: Shepp-Logan,
  Hamming) para limitar essa amplificação -- uma aplicação direta de
  filtragem em frequência (23.5, 23.6) dentro do próprio problema de
  reconstrução.
]

== Exemplo resolvido

#example(id: "ex-radon-conceitual")[
  Um objeto tem uma única pequena região densa fora do centro do campo de
  varredura. Descreva, qualitativamente, como essa região aparece no
  sinograma.
]

#solution[
  Como a região está fora do centro de rotação, sua posição projetada $t$
  varia de forma senoidal conforme o ângulo $theta$ varre $[0,pi)$: o
  sinograma mostra um traço curvo (senoidal) de alta intensidade, e não uma
  linha reta horizontal -- uma linha reta só ocorreria se a região
  estivesse exatamente no centro de rotação (projeção em $t=0$ para todo
  $theta$).
]

== Questões estilo POSCOMP

#example(id: "q-tomografia-1")[
  (Múltipla escolha) O teorema da fatia central relaciona:
  + A DFT 1D de uma projeção com uma linha horizontal da DFT 2D da imagem.
  + A DFT 1D de uma projeção no ângulo $theta$ com uma fatia radial, no
    mesmo ângulo, da DFT 2D da imagem original.
  + A retroprojeção filtrada com a transformada DCT usada em compressão.
  + O sinograma com o histograma da imagem original.
]

#solution[
  Resposta: alternativa *(2)*, conforme @thm-fatia-central.
]

#example(id: "q-tomografia-2")[
  Por que a retroprojeção simples (sem filtro) produz uma imagem borrada, e
  qual a ideia central da retroprojeção filtrada para corrigir isso?
]

#solution[
  A retroprojeção simples soma projeções sem compensar que, pelo teorema
  da fatia central, as fatias de frequência ficam mais densas perto da
  origem -- isso sobrepondera as baixas frequências e produz um borramento
  proporcional a $1/r$ (@def-retroprojecao). A retroprojeção filtrada
  aplica, a cada projeção, um filtro rampa ($|omega|$) antes de somar,
  compensando exatamente essa densidade desigual das fatias no domínio da
  frequência (@def-retroprojecao-filtrada).
]

== Referências

- GONZALEZ, R. C.; WOODS, R. E. *Digital Image Processing*. Cap. sobre
  reconstrução de imagens a partir de projeções.
- KAK, A. C.; SLANEY, M. *Principles of Computerized Tomographic Imaging*.
  Cap. sobre retroprojeção filtrada.
- cienciadacomputacao.wiki.br -- Tópico 23.8.
