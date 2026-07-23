#import "@preview/mousse-notes:1.1.0": *
= 23.1 -- Introdução aos Filtros Digitais

== Introdução

Processamento de Imagens (PDI) trata do tratamento computacional de imagens
digitais -- operações que recebem uma imagem e devolvem outra imagem (ou um
conjunto de descritores). É importante já de início distinguir PDI de *Visão
Computacional*: PDI opera no nível do *pixel* (filtrar, realçar, restaurar),
enquanto Visão Computacional busca *interpretar* o conteúdo da imagem
(reconhecer objetos, cenas). Essa distinção volta a aparecer em @def-pdi-vs-vc
no tópico 23.10, mas já orienta a leitura de toda a disciplina: os tópicos
23.1 a 23.9 são majoritariamente PDI "de baixo nível"; 23.10 e 23.11 sobem
para a interpretação.

Filtros digitais são a ferramenta central do PDI no domínio espacial: quase
toda operação de realce, suavização, detecção de bordas ou remoção de ruído
é, no fundo, um filtro aplicado sobre a vizinhança de cada pixel.

== Imagem digital

#definition(id: "def-imagem-digital")[
  Uma *imagem digital* é uma função discreta e quantizada
  $ f: {0,1,dots,M-1} times {0,1,dots,N-1} -> {0,1,dots,L-1}, $
  que associa a cada posição (pixel) $(x,y)$ um valor de intensidade
  $f(x,y)$, com $M times N$ o tamanho da imagem (linhas/colunas) e $L$ o
  número de níveis de cinza possíveis (tipicamente $L=256$, ou seja, 8 bits
  por pixel).
]

Uma imagem $4 times 4$ pequena pode ser vista como uma matriz de
intensidades -- e visualizada como um mosaico de quadrados em tons de cinza:

#align(center)[
  #grid(
    columns: 4,
    rows: 4,
    gutter: 1pt,
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(20, 20, 20)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(60, 60, 60)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(100, 100, 100)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(140, 140, 140)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(60, 60, 60)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(180, 180, 180)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(220, 220, 220)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(180, 180, 180)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(100, 100, 100)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(220, 220, 220)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(250, 250, 250)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(220, 220, 220)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(140, 140, 140)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(180, 180, 180)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(220, 220, 220)),
    rect(width: 1.1cm, height: 1.1cm, fill: rgb(250, 250, 250)),
  )
]

== Filtragem no domínio espacial: correlação e convolução

#definition(id: "def-mascara")[
  Uma *máscara* (ou *kernel*) $w$ de tamanho $(2a+1) times (2b+1)$ é uma
  pequena matriz de pesos que define, para cada pixel $(x,y)$ de uma imagem
  $f$, como combinar a vizinhança de $f$ em torno de $(x,y)$ para produzir a
  imagem de saída $g$.
]

#definition(id: "def-correlacao")[
  A *correlação* de $f$ com a máscara $w$ é
  $ g(x,y) = sum_(s=-a)^(a) sum_(t=-b)^(b) w(s,t) space f(x+s, y+t). $
]

#definition(id: "def-convolucao")[
  A *convolução* de $f$ com a máscara $w$ é
  $ g(x,y) = sum_(s=-a)^(a) sum_(t=-b)^(b) w(s,t) space f(x-s, y-t), $
  isto é, a correlação de $f$ com a máscara $w$ *rotacionada 180°*
  ($w(-s,-t)$).
]

#remark[
  *Armadilha clássica de prova*: correlação e convolução só coincidem quando
  a máscara é *simétrica* (ex.: filtro de média, gaussiano). Para máscaras
  assimétricas (ex.: máscaras de Sobel, usadas para detectar bordas), rodar a
  máscara $180°$ antes de aplicar faz diferença no resultado. Bibliotecas de
  PDI costumam implementar "convolução" fazendo, na prática, correlação --
  vale checar a convenção de cada ferramenta.
]

== Vizinhança e tratamento de bordas

#definition(id: "def-vizinhanca")[
  A *vizinhança-4* de $(x,y)$ é o conjunto de pixels
  ${(x+1,y),(x-1,y),(x,y+1),(x,y-1)}$; a *vizinhança-8* acrescenta os quatro
  vizinhos diagonais. Vizinhança e conectividade definem, por exemplo, quando
  dois pixels pertencem à mesma região conexa (relevante em 23.10).
]

#remark[
  Ao aplicar uma máscara $(2a+1)times(2b+1)$ perto da borda da imagem, parte
  da vizinhança "cai fora" do domínio de $f$. As estratégias usuais são:
  *zero-padding* (assume-se $f=0$ fora da imagem), *replicação* (repete a
  borda), *espelhamento* e *não processar* a borda (saída menor que a
  entrada). A escolha altera o resultado nas bordas e é um detalhe que provas
  costumam cobrar de forma conceitual.
]

== Exemplo resolvido

#example(id: "ex-convolucao-manual")[
  Considere a sub-imagem $3 times 3$ centrada em um pixel $p$
  $ f = mat(10, 20, 30; 40, 50, 60; 70, 80, 90) $
  e o filtro da média $3 times 3$
  $ w = 1/9 mat(1,1,1; 1,1,1; 1,1,1). $
  Como $w$ é simétrica, correlação e convolução coincidem aqui. Calcule o
  valor filtrado de $p$.
]

#solution[
  $ g(p) = 1/9 (10+20+30+40+50+60+70+80+90) = 450/9 = 50. $
  O filtro da média substitui cada pixel pela média aritmética de sua
  vizinhança $3 times 3$ -- suaviza a imagem e atenua ruído, ao custo de
  borrar bordas (retomado em 23.7).
]

== Questões estilo POSCOMP

#example(id: "q-filtros-1")[
  (Múltipla escolha) Sobre filtragem espacial em imagens digitais, é
  correto afirmar que:
  + Correlação e convolução são sempre operações idênticas, para qualquer
    máscara.
  + A convolução aplica a máscara rotacionada $180°$ em relação à
    correlação; ambas coincidem apenas quando a máscara é simétrica.
  + Convolução só pode ser aplicada a máscaras de tamanho $3 times 3$.
  + Filtros no domínio espacial não podem apresentar problemas de borda.
]

#solution[
  Resposta: alternativa *(2)*, pela definição de convolução como correlação
  com a máscara rotacionada (@def-convolucao).
]

#example(id: "q-filtros-2")[
  Um filtro de média $3 times 3$ é aplicado a uma imagem. Descreva o efeito
  esperado no resultado e explique, em uma frase, por que esse tipo de
  filtro é chamado de *filtro passa-baixa*.
]

#solution[
  O resultado é uma versão suavizada (borrada) da imagem original, pois a
  média local atenua variações rápidas de intensidade (altas frequências
  espaciais) e preserva variações lentas (baixas frequências) -- daí o nome
  passa-baixa, conceito que se formaliza no domínio da frequência em 23.5.
]

== Referências

- GONZALEZ, R. C.; WOODS, R. E. *Digital Image Processing*. Cap. sobre
  filtragem no domínio espacial.
- MARQUES FILHO, O.; VIEIRA NETO, H. *Processamento Digital de Imagens*.
  Cap. sobre filtragem espacial.
- cienciadacomputacao.wiki.br -- Tópico 23.1.
