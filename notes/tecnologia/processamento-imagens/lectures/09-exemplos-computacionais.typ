#import "@preview/mousse-notes:1.1.0": *
= 23.9 -- Exemplos Computacionais

== Introdução

Este tópico não introduz teoria nova: ele revisita os conceitos de 23.1 a
23.8 sob a forma de implementações práticas, no estilo típico das
bibliotecas usadas em PDI (NumPy, OpenCV, SciPy, scikit-image). A POSCOMP
costuma cobrar esse tipo de conteúdo pedindo para *ler* um trecho curto de
código e prever seu efeito, ou para apontar um erro conceitual comum de
implementação -- não para escrever código do zero.

== Representação de imagens em código

#definition(id: "def-imagem-array")[
  Em bibliotecas como NumPy/OpenCV, uma imagem em tons de cinza é um array
  2D de shape $(M,N)$, tipicamente `dtype=uint8` (inteiro sem sinal de 8
  bits, faixa $[0,255]$); uma imagem colorida RGB é um array 3D de shape
  $(M,N,3)$.
]

#remark[
  *Armadilha muito comum*: operações aritméticas diretas sobre arrays
  `uint8` sofrem *overflow por wraparound*. Por exemplo, `img + 20` em um
  pixel de valor `250` resulta em `14` (não `255` saturado), pois
  `250+20=270`, e `270 mod 256 = 14`. Para operações que podem sair da
  faixa $[0,255]$ (somas, subtrações, filtros com amplificação), converte-se
  para um tipo com sinal ou ponto flutuante antes de operar, e satura ou
  reconverte só ao final -- `cv2.add`/`cv2.subtract` já fazem essa saturação
  automaticamente, ao contrário do operador `+` puro do NumPy.
]

== Transformações pontuais em código

#example(id: "ex-codigo-negativo-gama")[
  ```python
  import numpy as np

  # negativo (def-negativo, 23.6): s = (L-1) - r
  negativo = 255 - img  # img: uint8, sem risco de overflow aqui

  # correção gama (def-transformacao-potencia, 23.6): s = c * r^gamma
  img_f = img.astype(np.float64) / 255.0
  gama = np.power(img_f, 0.5)          # gamma < 1: realça tons escuros
  gama_uint8 = (gama * 255).astype(np.uint8)
  ```
]

#remark[
  Note a normalização para `[0,1]` em `float64` antes de elevar a
  `gamma` -- elevar diretamente um array `uint8` a uma potência fracionária
  não faz sentido aritmético (tipo inteiro) e, mesmo convertido a float sem
  normalizar, a escala $[0,255]^gamma$ produziria valores fora da faixa
  esperada após reescalar.
]

== Filtragem espacial em código

#example(id: "ex-codigo-filtro2d")[
  ```python
  import cv2
  import numpy as np

  kernel = np.array([[0, -1,  0],
                      [-1,  5, -1],
                      [0, -1,  0]])
  nitida = cv2.filter2D(img, -1, kernel)
  ```
]

#remark[
  Apesar do nome sugerir convolução, `cv2.filter2D` calcula, por padrão,
  *correlação* (@def-correlacao, 23.1), não convolução -- a máscara *não* é
  rotacionada $180°$. Para máscaras simétricas (como o kernel de nitidez
  acima) isso não faz diferença, mas para máscaras assimétricas (ex.:
  Sobel) o resultado de `filter2D` só corresponde à definição formal de
  convolução se o kernel for manualmente rotacionado antes.
]

== Filtro de mediana em código

#example(id: "ex-codigo-mediana")[
  ```python
  # filtro de mediana 3x3 (def-filtro-mediana, 23.7): remove ruído
  # impulsivo preservando bordas melhor que um filtro linear de média
  filtrada = cv2.medianBlur(img, 3)
  ```
]

== Equalização de histograma em código

#example(id: "ex-codigo-equalizacao")[
  ```python
  # equalização de histograma (thm-equalizacao-histograma, 23.6)
  equalizada = cv2.equalizeHist(img)  # exige img em tons de cinza (2D)
  ```
]

#remark[
  `cv2.equalizeHist` só aceita imagens de um canal (tons de cinza). Para
  equalizar uma imagem colorida sem distorcer as cores, converte-se para um
  espaço com um canal de luminância separado (ex.: YCrCb ou HSV), equaliza-se
  *apenas* esse canal, e converte-se de volta -- equalizar R, G e B
  independentemente desbalanceia as cores da imagem.
]

== Transformada de Fourier em código

#example(id: "ex-codigo-fft")[
  ```python
  import numpy as np

  # DFT 2D (def-dft-2d, 23.5) via FFT, com a componente DC centralizada
  F = np.fft.fft2(img)
  F_centrada = np.fft.fftshift(F)
  espectro_magnitude = np.log(1 + np.abs(F_centrada))  # def-espectro, 23.5
  ```
]

#remark[
  `np.fft.fftshift` é necessário porque `fft2` devolve a componente DC
  ($F(0,0)$) no *canto* do array, não no centro -- sem o shift, o espectro
  de magnitude visualizado fica com a energia concentrada nos cantos, o que
  dificulta a interpretação visual. O `log(1+|F|)` comprime a enorme faixa
  dinâmica do espectro (a componente DC costuma ser ordens de grandeza
  maior que as demais) para tornar o resultado visualizável.
]

== Questões estilo POSCOMP

#example(id: "q-computacional-1")[
  (Múltipla escolha) Um array `img` do tipo `uint8` contém um pixel de
  valor `250`. Após a operação `img = img + 10` (soma direta em NumPy,
  sem conversão de tipo), o valor desse pixel será:
  + `255` (saturado no valor máximo).
  + `260`.
  + `4` (por overflow com wraparound).
  + Erro de execução (tipo incompatível).
]

#solution[
  Resposta: alternativa *(3)*. `uint8` representa apenas $[0,255]$; a soma
  `250+10=260` sofre wraparound: $260 mod 256 = 4$. NumPy não satura
  automaticamente operações aritméticas em tipos inteiros -- só funções
  específicas como `cv2.add` fazem saturação.
]

#example(id: "q-computacional-2")[
  Um kernel de Sobel (assimétrico) é aplicado a uma imagem usando
  `cv2.filter2D`. O resultado corresponde à *convolução* formal do kernel
  com a imagem, conforme a @def-convolucao (23.1)? Justifique.
]

#solution[
  Não necessariamente. `cv2.filter2D` implementa *correlação*
  (@def-correlacao), não convolução -- a máscara não é rotacionada $180°$
  antes de aplicada. Para um kernel simétrico o resultado seria idêntico,
  mas para um kernel assimétrico como o de Sobel, o resultado de
  `filter2D` só coincide com a convolução formal se o kernel for
  manualmente rotacionado $180°$ antes da chamada.
]

== Referências

- SciPy/NumPy, OpenCV -- documentação oficial de `numpy.fft`,
  `cv2.filter2D`, `cv2.equalizeHist`.
- VAN DER WALT, S. et al. "scikit-image: image processing in Python".
  *PeerJ*, 2014.
- cienciadacomputacao.wiki.br -- Tópico 23.9.
