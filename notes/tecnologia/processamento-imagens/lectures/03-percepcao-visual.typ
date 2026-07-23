#import "@preview/mousse-notes:1.1.0": *
= 23.3 -- Noções de Percepção Visual Humana

== Introdução

Muitas escolhas de engenharia em PDI (quantos bits por pixel usar, que
frequências de amostragem espacial bastam, como projetar um algoritmo de
realce) só fazem sentido à luz de como o *sistema visual humano* percebe
luminância e contraste. Esta seção resume os fatos de percepção mais
cobrados pela POSCOMP: adaptação de brilho, lei de Weber, bandas de Mach e
contraste simultâneo.

== Formação da imagem no olho

#definition(id: "def-retina-fotorreceptores")[
  A luz projetada na *retina* é captada por dois tipos de fotorreceptores:
  *cones* (concentrados na fóvea, responsáveis pela visão de cor e de
  detalhes finos, ativos em boa iluminação -- visão fotópica) e *bastonetes*
  (distribuídos pela periferia da retina, muito mais sensíveis à luz mas
  sem discriminação de cor, dominantes em baixa iluminação -- visão
  escotópica).
]

#remark[
  A maior densidade de cones fica na *fóvea*: por isso a acuidade visual
  (capacidade de distinguir detalhes) é máxima no centro do campo visual e
  cai rapidamente em direção à periferia -- relevante para entender por que
  o olho "varre" uma cena com movimentos sacádicos em vez de perceber tudo
  com a mesma nitidez de uma só vez.
]

== Adaptação de brilho e lei de Weber

#definition(id: "def-adaptacao-brilho")[
  O sistema visual humano não percebe *luminância absoluta*, e sim
  *luminância relativa* a um nível de adaptação local -- o mesmo objeto
  parece ter brilhos diferentes dependendo do fundo em que está inserido.
  Esse fenômeno é chamado de *adaptação de brilho*.
]

#theorem(id: "thm-lei-weber", name: "Lei de Weber")[
  A menor variação de intensidade $Delta I$ perceptível pelo olho humano,
  relativa a um fundo de intensidade $I$, é aproximadamente proporcional a
  $I$:
  $ (Delta I) / I approx "constante" ("razão de Weber"). $
  Ou seja, o olho é sensível a *razões* de intensidade, não a diferenças
  absolutas: distinguir dois níveis de cinza é mais difícil quando o fundo é
  muito claro ou muito escuro do que em iluminação intermediária.
]

#remark[
  Consequência prática direta da lei de Weber: a percepção de brilho é
  aproximadamente *logarítmica* em relação à intensidade física -- daí o uso
  comum de transformações logarítmicas para realce (retomado em 23.6) e a
  justificativa perceptual para quantizar com mais níveis nas regiões de
  intensidade em que o olho é mais sensível.
]

== Bandas de Mach e contraste simultâneo

#definition(id: "def-bandas-mach")[
  As *bandas de Mach* são um efeito de contraste espacial: em uma transição
  abrupta entre duas regiões de intensidade constante, o olho humano percebe
  faixas mais claras e mais escuras nas bordas da transição que não existem
  fisicamente na imagem -- um artefato do processamento de bordas pelo
  próprio sistema visual (inibição lateral dos fotorreceptores).
]

#definition(id: "def-contraste-simultaneo")[
  O *contraste simultâneo* é o efeito pelo qual a intensidade percebida de
  uma região depende das intensidades de suas vizinhas: um mesmo quadrado de
  cinza médio parece mais claro sobre um fundo escuro e mais escuro sobre um
  fundo claro.
]

#align(center)[
  #grid(
    columns: 3,
    column-gutter: 1.2cm,
    align: center + horizon,
    [
      #box(width: 2.6cm, height: 2.6cm, fill: rgb(20, 20, 20))[
        #align(center + horizon)[#box(width: 1cm, height: 1cm, fill: rgb(140, 140, 140))]
      ]
      #v(0.3em)
      #text(size: 0.8em)[fundo escuro]
    ],
    [
      #box(width: 2.6cm, height: 2.6cm, fill: rgb(120, 120, 120))[
        #align(center + horizon)[#box(width: 1cm, height: 1cm, fill: rgb(140, 140, 140))]
      ]
      #v(0.3em)
      #text(size: 0.8em)[fundo médio]
    ],
    [
      #box(width: 2.6cm, height: 2.6cm, fill: rgb(230, 230, 230))[
        #align(center + horizon)[#box(width: 1cm, height: 1cm, fill: rgb(140, 140, 140))]
      ]
      #v(0.3em)
      #text(size: 0.8em)[fundo claro]
    ],
  )
]

#remark[
  Os três quadrados centrais acima têm exatamente o *mesmo* nível de cinza
  ($140$); a percepção de brilho diferente entre eles ilustra o contraste
  simultâneo -- um lembrete de que "igual na matriz de pixels" não é o
  mesmo que "igual na percepção".
]

== Resolução espacial e temporal da visão

#remark[
  A acuidade visual limita a resolução espacial útil de uma imagem: acima de
  certa densidade de pixels por grau de campo visual, o olho já não
  distingue detalhes adicionais -- um dos fundamentos práticos por trás dos
  critérios de amostragem discutidos em 23.4. De forma análoga, a *taxa de
  fusão de cintilação* (flicker fusion rate, tipicamente entre $50$ e
  $60 "Hz"$ para humanos) limita a resolução temporal percebida, motivando
  as taxas de quadros usadas em vídeo.
]

== Questões estilo POSCOMP

#example(id: "q-percepcao-1")[
  (Múltipla escolha) A lei de Weber afirma que:
  + A menor diferença de intensidade perceptível é uma constante absoluta,
    independente do brilho de fundo.
  + A menor diferença de intensidade perceptível é aproximadamente
    proporcional ao brilho de fundo.
  + O olho humano percebe luminância absoluta, não relativa.
  + Bastonetes são responsáveis pela visão de cor em ambientes claros.
]

#solution[
  Resposta: alternativa *(2)*, conforme @thm-lei-weber. A alternativa (4)
  descreve os *cones*, não os bastonetes.
]

#example(id: "q-percepcao-2")[
  Explique por que as bandas de Mach são consideradas um artefato de
  *percepção*, e não uma propriedade física da imagem.
]

#solution[
  Porque a variação de brilho percebida nas bordas de uma transição de
  intensidade não corresponde a nenhuma variação real dos valores de pixel
  na imagem -- a imagem tem uma transição abrupta e constante de cada lado,
  mas o sistema visual, por inibição lateral entre fotorreceptores, realça
  perceptualmente a borda, criando faixas mais claras e mais escuras que só
  existem na percepção do observador.
]

== Referências

- GONZALEZ, R. C.; WOODS, R. E. *Digital Image Processing*. Cap. sobre
  fundamentos de percepção visual.
- MARQUES FILHO, O.; VIEIRA NETO, H. *Processamento Digital de Imagens*.
  Cap. sobre o sistema visual humano.
- cienciadacomputacao.wiki.br -- Tópico 23.3.
