#import "@preview/mousse-notes:1.1.0": *
= 23.4 -- Amostragem e Quantização de Imagens

== Introdução

Digitalizar uma imagem exige duas decisões independentes: *onde* medir a
intensidade luminosa (amostragem espacial) e *com que precisão* representar
o valor medido (quantização). Escolher mal qualquer uma delas introduz
artefatos visíveis e mensuráveis -- aliasing por amostragem insuficiente,
falso contorno por quantização insuficiente -- e é um dos temas mais
diretamente ligados à teoria de sinais dentro da POSCOMP.

== Amostragem espacial

#definition(id: "def-amostragem")[
  *Amostragem* é o processo de converter uma imagem de intensidade contínua
  $f(x,y)$ em uma grade discreta de $M times N$ pixels, medindo (ou
  integrando) a intensidade em posições espaçadas regularmente.
]

#theorem(id: "thm-nyquist", name: "Teorema da Amostragem (Nyquist-Shannon)")[
  Um sinal com largura de banda limitada à frequência máxima $f_"max"$ pode
  ser reconstruído exatamente a partir de amostras tomadas a uma taxa
  $ f_s >= 2 f_"max" $
  (a *taxa de Nyquist*). Se $f_s < 2 f_"max"$, ocorre *aliasing*: componentes
  de alta frequência do sinal original são reconstruídos incorretamente como
  componentes de baixa frequência, indistinguíveis do sinal verdadeiro.
]

#remark[
  Em imagens, aliasing aparece como padrões de moiré (em texturas de alta
  frequência, como tecidos xadrez fotografados de longe) e como
  serrilhamento ("jaggies") em bordas diagonais. A prevenção passa por
  filtrar (borrar) o sinal *antes* de amostrar, removendo frequências acima
  de $f_s\/2$ (filtro anti-aliasing) -- amostrar mais rápido sem filtrar não
  resolve o problema por si só.
]

== Quantização

#definition(id: "def-quantizacao")[
  *Quantização* é o processo de mapear o valor de intensidade contínuo (ou
  de alta precisão) de cada amostra para um dos $L$ níveis discretos
  disponíveis, tipicamente $L = 2^k$ para uma representação de $k$ bits por
  pixel (ex.: $k=8 => L=256$ níveis de cinza).
]

#definition(id: "def-falso-contorno")[
  *Falso contorno* (false contouring) é o artefato visual que surge quando
  $L$ é pequeno demais: regiões de variação suave de intensidade na cena
  real são reproduzidas como faixas ("degraus") de intensidade constante
  visivelmente distintas, criando contornos que não existem na cena
  original.
]

Abaixo, a mesma rampa de intensidade quantizada com poucos níveis (à
esquerda, falso contorno visível) e com muitos níveis (à direita, transição
suave):

#align(center)[
  #grid(
    columns: 2,
    column-gutter: 1.5cm,
    align: center,
    [
      #grid(
        columns: 8,
        rows: 1,
        gutter: 0pt,
        ..range(8).map(i => rect(width: 0.5cm, height: 1.5cm, fill: rgb(i * 32, i * 32, i * 32))),
      )
      #v(0.3em)
      #text(size: 0.8em)[$L=8$ níveis]
    ],
    [
      #grid(
        columns: 16,
        rows: 1,
        gutter: 0pt,
        ..range(16).map(i => rect(width: 0.25cm, height: 1.5cm, fill: rgb(i * 16, i * 16, i * 16))),
      )
      #v(0.3em)
      #text(size: 0.8em)[$L=16$ níveis]
    ],
  )
]

#remark[
  *Isopreference curves* (Gonzalez & Woods): para imagens com muitos
  detalhes, o olho tolera *menos* níveis de quantização sem perceber falso
  contorno; para imagens muito suaves (poucos detalhes), o falso contorno
  fica mais evidente e exige *mais* níveis. Ou seja, resolução espacial
  (amostragem) e resolução de intensidade (quantização) não são
  independentes na percepção de qualidade -- uma pode compensar
  parcialmente a outra.
]

== Compromisso resolução espacial × resolução de intensidade

#remark[
  Reduzir a resolução espacial ($M times N$) tende a produzir uma imagem
  "pixelizada" (blocos visíveis); reduzir a resolução de intensidade ($L$)
  tende a produzir falso contorno. São dois eixos distintos de degradação --
  uma pegadinha comum de prova é tratá-los como sinônimos ou assumir que
  aumentar um compensa a redução do outro sem limite.
]

== Exemplo resolvido

#example(id: "ex-nyquist-camera")[
  Uma textura de tecido possui um padrão periódico com frequência espacial
  máxima de $80$ ciclos por milímetro no plano do sensor. Qual a taxa mínima
  de amostragem (em amostras por milímetro) que uma câmera precisa ter para
  capturar essa textura sem aliasing?
]

#solution[
  Pelo teorema de Nyquist-Shannon (@thm-nyquist),
  $ f_s >= 2 f_"max" = 2 times 80 = 160 "amostras/mm". $
  Um sensor com densidade de pixels abaixo disso produzirá moiré ao
  fotografar esse tecido.
]

== Questões estilo POSCOMP

#example(id: "q-amostragem-1")[
  (Múltipla escolha) O fenômeno de *aliasing* em imagens digitais ocorre
  quando:
  + O número de níveis de quantização $L$ é muito pequeno.
  + A taxa de amostragem espacial é menor que o dobro da maior frequência
    presente na cena.
  + A imagem é comprimida com perdas.
  + O sensor da câmera satura em regiões muito claras.
]

#solution[
  Resposta: alternativa *(2)*, diretamente do teorema de Nyquist-Shannon
  (@thm-nyquist). A alternativa (1) descreve falso contorno, não aliasing --
  uma distinção clássica de prova.
]

#example(id: "q-amostragem-2")[
  Explique por que aumentar a taxa de amostragem de um sensor, *sem* aplicar
  um filtro anti-aliasing antes da amostragem, não elimina totalmente o
  risco de aliasing para cenas com frequências arbitrariamente altas.
]

#solution[
  Porque, para qualquer taxa de amostragem finita $f_s$ escolhida, sempre é
  possível haver conteúdo na cena com frequência espacial acima de
  $f_s\/2$ (por exemplo, texturas muito finas ou bordas muito nítidas); sem
  um filtro passa-baixa que remova essas frequências antes da amostragem,
  elas continuam sendo mal representadas como aliasing. Aumentar $f_s$
  reduz a faixa de frequências problemáticas, mas não a elimina em
  princípio -- só a filtragem anti-aliasing garante a condição do teorema de
  Nyquist-Shannon para o conteúdo específico da cena.
]

== Referências

- GONZALEZ, R. C.; WOODS, R. E. *Digital Image Processing*. Cap. sobre
  amostragem e quantização, incluindo isopreference curves.
- MARQUES FILHO, O.; VIEIRA NETO, H. *Processamento Digital de Imagens*.
  Cap. sobre aquisição e digitalização de imagens.
- cienciadacomputacao.wiki.br -- Tópico 23.4.
