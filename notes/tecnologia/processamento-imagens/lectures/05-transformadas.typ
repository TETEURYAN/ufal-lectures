#import "@preview/mousse-notes:1.1.0": *
= 23.5 -- Transformadas de Imagens

== Introdução

Além do domínio espacial (tratado em 23.1), uma imagem pode ser analisada em
outros *domínios de transformada*, nos quais operações que são complexas no
espaço original (como filtrar por faixa de frequência) tornam-se simples
(multiplicação ponto a ponto). A Transformada Discreta de Fourier (DFT) é a
mais cobrada, seguida da Transformada Discreta do Cosseno (DCT, base da
compressão JPEG) e de menções às transformadas de Walsh-Hadamard e wavelets.

== Transformada Discreta de Fourier 2D

#definition(id: "def-dft-2d")[
  Para uma imagem $f(x,y)$ de tamanho $M times N$, a *DFT 2D* é
  $ F(u,v) = sum_(x=0)^(M-1) sum_(y=0)^(N-1) f(x,y)
      e^(-j 2 pi (u x\/M + v y\/N)), $
  e a transformada inversa (IDFT) recupera $f$ a partir de $F$:
  $ f(x,y) = 1/(M N) sum_(u=0)^(M-1) sum_(v=0)^(N-1) F(u,v)
      e^(j 2 pi (u x\/M + v y\/N)). $
  $F(u,v)$ é, em geral, complexo; $u,v$ indexam *frequências espaciais*
  horizontais e verticais.
]

#definition(id: "def-espectro")[
  O *espectro de magnitude* $|F(u,v)|$ mede a energia de cada frequência
  espacial (independente de sua posição na imagem); o *espectro de fase*
  $angle F(u,v)$ codifica onde essas componentes estão posicionadas.
  Frequências baixas (próximas de $F(0,0)$, a *componente DC* -- o brilho
  médio da imagem) correspondem a variações lentas de intensidade;
  frequências altas correspondem a bordas e detalhes finos e a ruído.
]

#remark[
  Pegadinha clássica: reconstruir uma imagem usando apenas a *magnitude* de
  $F$ (descartando a fase) produz uma imagem irreconhecível, enquanto usar
  apenas a *fase* (com magnitude constante) preserva a maior parte da
  estrutura reconhecível da imagem original. A fase carrega mais informação
  estrutural do que a magnitude, ao contrário do que a intuição costuma
  sugerir.
]

== Propriedades e o teorema da convolução

#theorem(id: "thm-convolucao-frequencia", name: "Teorema da Convolução")[
  Se $g = f * w$ é a convolução espacial de $f$ com a máscara $w$
  (@def-convolucao, tópico 23.1), então, no domínio da frequência,
  $ G(u,v) = F(u,v) dot W(u,v), $
  isto é, convolução no espaço equivale a *multiplicação ponto a ponto* no
  domínio da frequência (e vice-versa: multiplicação no espaço equivale a
  convolução na frequência).
]

#remark[
  O teorema da convolução é a justificativa formal por trás de "filtro
  passa-baixa suaviza, passa-alta realça bordas": um filtro de média
  (@ex-convolucao-manual) tem $W(u,v)$ concentrado em baixas frequências, e
  multiplicar $F$ por essa $W$ atenua as altas frequências de $f$. Ele
  também explica por que, na prática, filtrar imagens grandes com máscaras
  grandes é feito via FFT (Transformada Rápida de Fourier) -- multiplicar no
  domínio da frequência é assintoticamente mais barato que convoluir
  diretamente no espaço para máscaras grandes.
]

Outras propriedades relevantes da DFT: *linearidade* (
  $"DFT"(a f_1 + b f_2) = a F_1 + b F_2$), *periodicidade* ($F(u,v)$ é
periódica em $u$ e $v$, com período $M$ e $N$), e *deslocamento* (deslocar
$f$ no espaço multiplica $F$ por um fator de fase, sem alterar
$|F(u,v)|$).

== Transformada Discreta do Cosseno (DCT)

#definition(id: "def-dct")[
  A *Transformada Discreta do Cosseno (DCT)* representa um bloco de imagem
  como soma de funções cosseno de frequências crescentes, com coeficientes
  reais (ao contrário da DFT, que produz coeficientes complexos). Para um
  bloco 1D de $N$ amostras,
  $ C(u) = alpha(u) sum_(x=0)^(N-1) f(x) cos[(pi (2x+1) u)/(2N)], $
  com $alpha(0) = sqrt(1\/N)$ e $alpha(u) = sqrt(2\/N)$ para $u > 0$.
]

#remark[
  A DCT *concentra energia* em poucos coeficientes de baixa frequência de
  forma ainda mais eficiente que a DFT para imagens naturais (que têm
  correlação espacial forte entre pixels vizinhos), e evita a
  descontinuidade artificial nas bordas do bloco que a DFT introduz (por
  assumir periodicidade). É por isso -- concentração de energia + números
  reais -- que a DCT (em blocos $8 times 8$) é a base da compressão JPEG:
  poucos coeficientes de baixa frequência bastam para reconstruir a maior
  parte da informação visual do bloco.
]

== Outras transformadas: Walsh-Hadamard e wavelets

#remark[
  A *transformada de Walsh-Hadamard* usa funções-base que valem apenas
  $+1$ ou $-1$ (em vez de senos/cossenos), o que a torna muito rápida de
  calcular (só somas e subtrações), ao custo de pior concentração de
  energia que a DCT. Já a *transformada wavelet* substitui as funções-base
  de frequência fixa (senos/cossenos, que cobrem toda a imagem) por
  funções-base localizadas tanto em frequência quanto em espaço,
  permitindo *análise multirresolução* -- é a base de padrões de compressão
  como o JPEG2000 e de técnicas de remoção de ruído que preservam bordas
  melhor que filtros puramente espectrais.
]

== Exemplo resolvido

#example(id: "ex-dft-1d")[
  Calcule a DFT 1D da sequência $f = (1, 1, 1, 1)$ (constante, $N=4$).
]

#solution[
  $ F(u) = sum_(x=0)^(3) f(x) e^(-j 2 pi u x\/4) = sum_(x=0)^(3) e^(-j pi u x\/2). $
  Para $u=0$: $F(0) = 1+1+1+1 = 4$ (a componente DC, igual à soma dos
  valores -- coerente com $f$ ser um sinal constante). Para $u=1,2,3$, a
  soma de exponenciais complexas igualmente espaçadas ao redor do círculo
  unitário se cancela, dando $F(u) = 0$. Uma sequência constante no espaço
  concentra *toda* sua energia na frequência zero, como esperado.
]

== Questões estilo POSCOMP

#example(id: "q-transformadas-1")[
  (Múltipla escolha) Segundo o teorema da convolução, a convolução de duas
  funções no domínio espacial corresponde, no domínio da frequência, a:
  + Convolução das transformadas.
  + Soma das transformadas.
  + Multiplicação ponto a ponto das transformadas.
  + Divisão ponto a ponto das transformadas.
]

#solution[
  Resposta: alternativa *(3)*, conforme @thm-convolucao-frequencia.
]

#example(id: "q-transformadas-2")[
  Por que a DCT, e não a DFT, é a transformada escolhida no padrão JPEG?
]

#solution[
  Porque a DCT produz coeficientes *reais* (mais simples de quantizar e
  codificar que os complexos da DFT) e concentra a energia de blocos de
  imagem natural em poucos coeficientes de baixa frequência de forma mais
  eficiente, sem introduzir as descontinuidades artificiais de borda que a
  suposição de periodicidade da DFT causaria -- resultando em melhor razão
  de compressão para a mesma qualidade percebida.
]

== Referências

- GONZALEZ, R. C.; WOODS, R. E. *Digital Image Processing*. Cap. sobre
  processamento no domínio da frequência.
- MARQUES FILHO, O.; VIEIRA NETO, H. *Processamento Digital de Imagens*.
  Cap. sobre transformadas.
- cienciadacomputacao.wiki.br -- Tópico 23.5.
