#import "@preview/mousse-notes:1.1.0": *

= Teoria dos Códigos, Canal Binário, Canal Simétrico, Código de Blocos, Matrizes Geradoras e Verificadoras, Códigos de Grupo, Códigos de Hamming
#text(size: 9pt, style: "italic")[Edital POSCOMP: 6.8]

== Introdução

Ao transmitir dados por um canal físico sujeito a ruído, bits podem ser corrompidos. Teoria dos códigos usa as estruturas algébricas de 07 (especialmente grupos) para detectar e corrigir esses erros de forma sistemática -- o código de Hamming é o exemplo canônico, quase sempre cobrado com um cálculo numérico completo.

== Definições formais

#definition(name: "Canal binário simétrico e código de blocos", id: "def-canal-binario-codigo-blocos")[
  Um *canal binário simétrico* transmite bits ($0$ ou $1$), cada um com a mesma probabilidade $p$ de ser invertido (erro) independentemente dos demais. Um *código de blocos* $(n,k)$ codifica $k$ bits de dados em uma *palavra-código* de $n > k$ bits, adicionando $n-k$ bits de redundância -- essa redundância é o que permite detectar/corrigir erros.
]

#definition(name: "Distância de Hamming e capacidade de detecção/correção", id: "def-distancia-hamming")[
  A *distância de Hamming* entre duas palavras de mesmo comprimento é o número de posições em que diferem. A *distância mínima* $d_(min)$ de um código é a menor distância de Hamming entre quaisquer duas palavras-código distintas. Um código com distância mínima $d_(min)$ pode:
  - *Detectar* até $d_(min) - 1$ erros.
  - *Corrigir* até $floor((d_(min)-1)/2)$ erros.
]

#definition(name: "Código de Hamming e matrizes geradora/verificadora", id: "def-codigo-hamming")[
  Código de blocos linear (um *código de grupo*: as palavras-código formam um subgrupo do grupo aditivo de todas as sequências de $n$ bits, 07) que usa bits de paridade em posições potência de 2 ($1,2,4,dots$), cada um verificando um subconjunto específico dos demais bits. A *matriz geradora* $G$ mapeia uma mensagem de $k$ bits para uma palavra-código de $n$ bits; a *matriz verificadora* (de paridade) $H$ calcula a *síndrome* do vetor recebido -- síndrome zero indica ausência de erro (detectável); síndrome não nula aponta diretamente a posição do bit errado, no caso de erro único.
]

== Exemplo resolvido

#example(name: "Codificação e correção com Hamming(7,4)", id: "ex-hamming-7-4-completo")[
  Codificar a mensagem $d = 1011$ ($d_1{=}1, d_2{=}0, d_3{=}1, d_4{=}1$) em Hamming(7,4): bits de paridade nas posições $1,2,4$; dados nas posições $3,5,6,7$.

  $ p_1 = d_1 xor d_2 xor d_4 = "(pos. 3,5,7)" 1 xor 0 xor 1 = 0 $
  $ p_2 = d_1 xor d_3 xor d_4 = "(pos. 3,6,7)" 1 xor 1 xor 1 = 1 $
  $ p_3 = d_2 xor d_3 xor d_4 = "(pos. 5,6,7)" 0 xor 1 xor 1 = 0 $

  Palavra-código transmitida (posições 1--7): $0 1 1 0 0 1 1$.

  #figure(
    image("figures/hamming-7-4.svg", width: 40%),
    caption: [Diagrama de Venn do código Hamming(7,4): cada círculo de paridade cobre um subconjunto dos bits de dados, permitindo localizar o bit com erro pela combinação de paridades violadas. Fonte: Wikimedia Commons, CC BY-SA 3.0/GFDL (Cburnett).],
  )

  Suponha que o bit na *posição 5* seja corrompido durante a transmissão: recebido $= 0 1 1 0 1 1 1$. Recalculando as paridades (síndrome):
  $ c_1 = "pos.1" xor "pos.3" xor "pos.5" xor "pos.7" = 0 xor 1 xor 1 xor 1 = 1 $
  $ c_2 = "pos.2" xor "pos.3" xor "pos.6" xor "pos.7" = 1 xor 1 xor 1 xor 1 = 0 $
  $ c_3 = "pos.4" xor "pos.5" xor "pos.6" xor "pos.7" = 0 xor 1 xor 1 xor 1 = 1 $

  Síndrome $(c_3 c_2 c_1) = 101_2 = 5$ -- aponta *exatamente* a posição 5 como o bit com erro. Invertendo o bit na posição 5, recupera-se a palavra-código original $0110011$, e a mensagem original $d=1011$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Distância mínima 3 detecta 2 erros OU corrige 1 erro -- não ambos ao mesmo tempo com a mesma garantia")[
  O código Hamming(7,4) tem $d_(min)=3$: pode detectar até 2 erros *ou* corrigir 1 erro, mas não as duas coisas simultaneamente com garantia total -- se usado no modo de correção (assumindo no máximo 1 erro), um padrão de exatamente 2 erros pode ser "corrigido" incorretamente para uma palavra-código errada, em vez de apenas detectado como inválido.
]

#remark(name: "Síndrome zero não garante ausência de erro -- garante ausência de erro detectável")[
  Se o número de erros exceder a capacidade de detecção do código ($d_(min)-1$ erros, ou mais), é possível (embora raro) que os erros transformem uma palavra-código válida em *outra* palavra-código válida, produzindo síndrome zero apesar de erros terem ocorrido -- daí a importância de escolher $d_(min)$ adequada ao nível de ruído esperado do canal.
]

== Questões estilo POSCOMP

*Questão 1.* Um código com distância mínima $d_(min) = 5$ é capaz de corrigir até quantos erros?
- a) $5$.
- b) $4$.
- c) $2$.
- d) $1$.
- e) $0$.

*Questão 2.* No exemplo do código Hamming(7,4) desta seção, uma síndrome calculada igual a $101_2 = 5$ indica que:
- a) Não há erro na palavra recebida.
- b) O bit na posição 5 está incorreto e deve ser invertido.
- c) A palavra recebida é inválida e não pode ser corrigida.
- d) Há exatamente 5 bits errados.
- e) O código não é de Hamming.

*Questão 3.* Em um código de blocos $(n,k)$, o número de bits de redundância adicionados é:
- a) $k$.
- b) $n$.
- c) $n - k$.
- d) $n + k$.
- e) $n times k$.

== Gabarito comentado

1. *(c)* -- $floor((5-1)/2) = 2$ erros corrigíveis.
2. *(b)* -- a síndrome, em binário, aponta diretamente a posição do bit único com erro, conforme o exemplo desta seção.
3. *(c)* -- por definição, um código $(n,k)$ adiciona $n-k$ bits de redundância a $k$ bits de dados.

== Referências

- HAMMING, R. W. *Error Detecting and Error Correcting Codes* (1950) -- artigo original.
- ROSEN, K. H. *Matemática Discreta e suas Aplicações*. Cap. 13 (Códigos e álgebra aplicada).
- LIN, S.; COSTELLO, D. *Error Control Coding*. Cap. 3 (Códigos de blocos lineares).
