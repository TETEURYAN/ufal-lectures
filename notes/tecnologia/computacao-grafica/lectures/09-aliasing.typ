#import "@preview/mousse-notes:1.1.0": *
= 20.9 -- Aliasing e Técnicas de Antialiasing

== Introdução

Rasterizar geometria contínua em uma grade discreta de pixels é, em essência,
um problema de *amostragem de sinal*. Quando a amostragem é insuficiente para
representar os detalhes da cena, surge o *serrilhado* ("aliasing"): bordas
"escadinhas" (jaggies), padrões de moiré em texturas de alta frequência, e
"efeito roda de carroça" em animações. A POSCOMP cobra tanto a causa
(teorema da amostragem) quanto as técnicas de correção.

== Aliasing e o teorema da amostragem

#definition(id: "def-aliasing")[
  *Aliasing* é o efeito visual causado por *subamostragem*: quando a taxa de
  amostragem (resolução de pixels, ou taxa de quadros no caso temporal) é
  insuficiente para capturar a frequência espacial (ou temporal) do sinal
  original, componentes de alta frequência "se disfarçam" (do inglês *alias*)
  como padrões de baixa frequência incorretos na imagem final.
]

#theorem(id: "thm-nyquist")[
  Pelo *teorema da amostragem de Nyquist-Shannon*, um sinal contínuo só pode
  ser reconstruído sem perdas a partir de amostras discretas se a *taxa de
  amostragem* for pelo menos o *dobro* da maior frequência presente no sinal
  (a "frequência de Nyquist"). Em computação gráfica, isso significa: se a
  cena (ou textura) contém detalhes que variam mais rápido do que a grade de
  pixels consegue amostrar, o resultado é aliasing.
]

#remark[
  Aliasing não é exclusivamente espacial. *Aliasing temporal* ocorre quando a
  taxa de quadros (frame rate) é baixa demais para capturar movimento rápido
  -- o clássico "efeito roda de carroça", em que rodas giratórias parecem
  girar devagar, parar ou até inverter o sentido em vídeo.
]

== Técnicas de antialiasing

#definition(id: "def-antialiasing")[
  As técnicas de *antialiasing* atacam o problema de duas formas gerais:
  aumentando a taxa de amostragem, ou filtrando (fazendo a média de) o sinal
  antes de amostrá-lo. As principais técnicas são:
  - *Supersampling* (SSAA): renderiza a cena em uma resolução mais alta que a
    final (ex.: $2 times$ ou $4 times$ o número de amostras por pixel) e faz a
    *média* das amostras de cada pixel de saída -- eficaz, mas custoso, pois
    recalcula shading em cada subamostra;
  - *Multisampling* (MSAA): amostra a *cobertura geométrica* (e profundidade)
    em múltiplos pontos por pixel, mas calcula o *shading* uma única vez por
    polígono coberto -- ataca o serrilhado nas bordas dos polígonos a um custo
    bem menor que SSAA, mas não resolve aliasing dentro de texturas/shaders;
  - *Amostragem por área* (area sampling): calcula analiticamente a fração de
    cobertura de um pixel por uma primitiva (em vez de amostrar pontos
    discretos), ponderando a cor pela área coberta;
  - *Filtros de pós-processamento* (ex.: FXAA): detectam bordas serrilhadas na
    imagem já renderizada e as suavizam por um filtro de borrão direcionado --
    muito barato, mas trabalha sobre a imagem final, sem acesso à geometria.
]

#remark[
  MSAA é mais barato que SSAA porque separa dois custos que SSAA sempre
  acopla: o custo de *shading* (calcular a cor de um fragmento) do custo de
  *cobertura* (saber quanto de um pixel um polígono ocupa). SSAA multiplica os
  dois; MSAA multiplica só o segundo. É a distinção mais cobrada entre essas
  duas técnicas em prova.
]

#example(id: "q-ssaa-custo")[
  Uma cena é renderizada com SSAA $4 times$ (amostragem $2 times 2$ por
  pixel de saída). Se a imagem final tem $800 times 600$ pixels, quantos
  fragmentos (amostras) precisam ter sua cor calculada antes da redução por
  média?
]

#solution[
  Com $4$ amostras por pixel de saída:
  $ 800 times 600 times 4 = 1"."920"."000 "amostras". $
  Cada uma dessas $1.920.000$ amostras é sombreada individualmente antes de
  serem promediadas em blocos de $4$ para formar os $800 times 600 = 480.000$
  pixels finais.
]

#example(id: "q-aliasing-conceitual")[
  (Múltipla escolha) Qual das afirmações sobre aliasing e antialiasing está
  correta?
  + MSAA recalcula o shading em cada subamostra, assim como SSAA.
  + O teorema de Nyquist-Shannon é específico de computação gráfica e não se
    aplica a processamento de sinais em geral.
  + Aliasing temporal pode ocorrer mesmo sem nenhum problema de resolução
    espacial, bastando uma taxa de quadros insuficiente.
  + Mipmapping (20.8) não tem relação alguma com o problema de aliasing.
]

#solution[
  Resposta: alternativa *(3)*. MSAA evita recalcular shading por subamostra
  (diferencial em relação a SSAA); Nyquist-Shannon vem da teoria geral de
  sinais, não é exclusivo de CG; e mipmapping é justamente uma técnica de
  pré-filtragem que mitiga aliasing espacial em texturas (20.8).
]

== Referências

- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Cap. sobre
  aliasing e técnicas de antialiasing.
- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Cap. sobre
  antialiasing.
- cienciadacomputacao.wiki.br -- Tópico 20.9.
