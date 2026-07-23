#import "@preview/mousse-notes:1.1.0": *
= 23.7 -- Filtragem e Restauração

== Introdução

Esta seção completa a filtragem espacial iniciada em 23.1, distinguindo
filtros *lineares* de *não lineares*, e introduz a *restauração* de
imagens: ao contrário do realce (23.6, sem critério objetivo único), a
restauração assume um *modelo explícito de degradação* (borramento, ruído)
e busca invertê-lo o melhor possível segundo um critério matemático.

== Filtros lineares × não lineares

#definition(id: "def-filtro-linear")[
  Um filtro espacial é *linear* quando seu resultado é uma combinação linear
  (convolução, @def-convolucao) dos valores da vizinhança -- ex.: filtro da
  média, filtro gaussiano, laplaciano. Um filtro é *não linear* quando
  aplica uma operação não linear à vizinhança -- ex.: filtro de *mediana*,
  filtros de *máximo*/*mínimo*, filtros de *moda*.
]

#definition(id: "def-filtro-mediana")[
  O *filtro de mediana* substitui cada pixel pela *mediana* dos valores de
  sua vizinhança (ex.: $3 times 3$), ordenando os valores e escolhendo o do
  meio -- não é uma convolução, pois não é uma soma ponderada linear dos
  vizinhos.
]

#remark[
  *Armadilha clássica de prova*: o filtro de mediana e o filtro de média
  parecem cumprir papel semelhante (suavizar/remover ruído), mas se
  comportam de forma muito diferente em bordas -- o filtro de média sempre
  borra bordas (é linear, "mistura" valores de regiões diferentes); o filtro
  de mediana tende a *preservar* bordas nítidas, pois a mediana de uma
  vizinhança com uma borda tende a escolher um valor de um dos dois lados,
  não uma mistura dos dois. Por isso o filtro de mediana é preferido para
  remover ruído sem borrar contornos.
]

== Modelos de ruído

#definition(id: "def-ruido-impulsivo")[
  O *ruído impulsivo* ("sal e pimenta") corrompe uma fração dos pixels da
  imagem, substituindo-os por valores extremos (branco ou preto),
  independentemente do valor original; os demais pixels permanecem
  intactos.
]

#definition(id: "def-ruido-gaussiano")[
  O *ruído gaussiano* soma a cada pixel um valor aleatório com distribuição
  normal $cal(N)(mu, sigma^2)$, afetando *todos* os pixels da imagem com
  intensidade variável (tipicamente $mu=0$).
]

#remark[
  O filtro de mediana é especialmente eficaz contra ruído impulsivo
  (elimina os valores extremos isolados sem afetar o resto da imagem); já
  para ruído gaussiano, que afeta todos os pixels, filtros lineares
  (média, gaussiano) ou filtros de mediana com janela maior tendem a
  funcionar melhor -- a escolha do filtro depende do *modelo de ruído*
  presente, não existe um filtro universalmente melhor.
]

== Modelo de degradação e restauração

#definition(id: "def-modelo-degradacao")[
  O *modelo de degradação-restauração* assume que a imagem observada $g$
  resulta de uma imagem original $f$ passada por um sistema de degradação
  linear invariante ao deslocamento, com resposta ao impulso $h$
  (ex.: desfoque de movimento, desfoque de foco), somado a ruído aditivo
  $eta$:
  $ g(x,y) = (h * f)(x,y) + eta(x,y), $
  o que, pelo teorema da convolução (@thm-convolucao-frequencia), equivale
  no domínio da frequência a
  $ G(u,v) = H(u,v) F(u,v) + N(u,v). $
]

#definition(id: "def-filtro-inverso")[
  O *filtro inverso* tenta reverter a degradação diretamente:
  $ hat(F)(u,v) = G(u,v) / H(u,v). $
]

#remark[
  O filtro inverso funciona bem *sem ruído*, mas é numericamente instável
  na presença de ruído: nas frequências em que $H(u,v)$ é pequeno (perto de
  zero), dividir por $H$ *amplifica drasticamente* o ruído $N(u,v)/H(u,v)$
  nessa frequência, muitas vezes dominando o resultado. Isso motiva o uso
  do filtro de Wiener.
]

#theorem(id: "thm-filtro-wiener", name: "Filtro de Wiener")[
  O *filtro de Wiener* minimiza o erro quadrático médio entre a imagem
  restaurada e a original, resultando em
  $ hat(F)(u,v) = [ 1/H(u,v) dot |H(u,v)|^2 / (|H(u,v)|^2 + S_eta(u,v)\/S_f (u,v)) ] G(u,v), $
  em que $S_f$ e $S_eta$ são as densidades espectrais de potência do sinal
  original e do ruído, respectivamente.
]

#remark[
  Quando não há ruído ($S_eta = 0$), o filtro de Wiener se reduz exatamente
  ao filtro inverso ($hat(F) = G\/H$). Quando $H(u,v) -> 0$ em alguma
  frequência, o termo $|H|^2 \/ (|H|^2 + S_eta\/S_f)$ tende a zero *junto*
  com $H$, evitando a divisão explosiva por um valor próximo de zero -- essa
  é a vantagem central do filtro de Wiener sobre o filtro inverso puro.
]

== Exemplo resolvido

#example(id: "ex-mediana-vs-media")[
  A vizinhança $3 times 3$ de um pixel de borda é
  $ f = mat(10, 10, 10; 10, 10, 200; 10, 10, 200) $
  (canto com ruído impulsivo isolado no valor $200$, repetido em dois
  pixels). Compare o resultado do filtro de média e do filtro de mediana
  nesse pixel central.
]

#solution[
  Média: $(10 dot 7 + 200 dot 2)/9 = (70+400)/9 approx 52.2$ -- puxado para
  cima pelos dois valores extremos.

  Mediana: ordenando os $9$ valores
  $(10,10,10,10,10,10,10,200,200)$, o valor central (5º de 9) é $10$ --
  a mediana ignora completamente os dois valores extremos isolados, desde
  que sejam minoria na vizinhança.

  O exemplo ilustra por que o filtro de mediana é robusto a ruído
  impulsivo: valores extremos isolados não têm influência sobre a mediana
  enquanto forem minoria na janela.
]

== Questões estilo POSCOMP

#example(id: "q-filtragem-1")[
  (Múltipla escolha) Em relação a filtros de mediana e filtros de média,
  é correto afirmar que:
  + Ambos são filtros lineares, pois processam uma vizinhança de pixels.
  + O filtro de mediana tende a preservar bordas melhor que o filtro de
    média, que tende a borrá-las.
  + O filtro de média é mais eficaz que o de mediana contra ruído
    impulsivo.
  + O filtro de mediana pode ser expresso como uma convolução com uma
    máscara fixa.
]

#solution[
  Resposta: alternativa *(2)*. O filtro de mediana é não linear
  (@def-filtro-mediana) e não pode ser escrito como convolução (elimina as
  alternativas 1 e 4); e é justamente mais eficaz que a média contra ruído
  impulsivo, não o contrário (elimina a 3) -- ver @ex-mediana-vs-media.
]

#example(id: "q-filtragem-2")[
  Explique por que o filtro inverso puro é numericamente problemático para
  restaurar imagens degradadas por um sistema $H(u,v)$ que se anula (ou
  fica muito pequeno) em algumas frequências, e como o filtro de Wiener
  contorna esse problema.
]

#solution[
  O filtro inverso calcula $hat(F) = G\/H$; nas frequências em que
  $H(u,v) approx 0$, essa divisão amplifica desproporcionalmente qualquer
  ruído presente em $G$ nessa frequência, mesmo que o ruído original seja
  pequeno (@def-filtro-inverso). O filtro de Wiener multiplica o filtro
  inverso por um fator adicional que depende da razão ruído/sinal
  ($S_eta \/ S_f$); nas frequências em que $H$ é pequeno, esse fator
  também tende a zero, atenuando a amplificação do ruído em vez de deixá-la
  explodir, ao custo de não restaurar perfeitamente essas frequências.
]

== Referências

- GONZALEZ, R. C.; WOODS, R. E. *Digital Image Processing*. Cap. sobre
  filtragem no domínio espacial e restauração de imagens.
- MARQUES FILHO, O.; VIEIRA NETO, H. *Processamento Digital de Imagens*.
  Cap. sobre filtros de ordem estatística e restauração.
- cienciadacomputacao.wiki.br -- Tópico 23.7.
