#import "@preview/mousse-notes:1.1.0": *

= Aritmética Binária
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.2]

== Introdução

Circuitos aritméticos (somadores, subtratores) implementam diretamente as regras de aritmética binária desta seção. O complemento de 2 e a detecção de overflow são os pontos mais cobrados -- e mais confundidos -- da disciplina.

== Definições formais

#definition(name: "Soma binária", id: "def-soma-binaria")[
  Segue as mesmas regras da soma decimal, com base 2: $0+0=0$, $0+1=1$, $1+1=10$ (soma 0, vai-um 1), $1+1+1=11$ (soma 1, vai-um 1, quando há carry de entrada).
]

#definition(name: "Complemento de 2", id: "def-complemento-2")[
  Representação padrão de inteiros com sinal em circuitos digitais. Para um número de $n$ bits, o complemento de 2 de $x$ é obtido invertendo todos os bits de $x$ e somando 1. Com $n$ bits, representa-se o intervalo $[-2^(n-1), 2^(n-1)-1]$; o bit mais significativo indica o sinal (0 = positivo, 1 = negativo), mas *não* é um "bit de sinal" isolado -- participa da aritmética normalmente.
]

#definition(name: "Overflow (estouro aritmético)", id: "def-overflow")[
  Ocorre quando o resultado de uma soma/subtração em complemento de 2 excede a faixa representável em $n$ bits. Detecta-se comparando o carry *para dentro* do bit de sinal com o carry *para fora* dele: se forem diferentes, há overflow. Regra prática equivalente: overflow só pode ocorrer ao somar dois números de *mesmo sinal*, produzindo um resultado de sinal *oposto*.
]

== Exemplo resolvido

#example(name: "Soma com overflow em complemento de 2 (4 bits)", id: "ex-soma-overflow")[
  Somar $5 + 5$ em complemento de 2 de 4 bits (faixa representável: $[-8, 7]$):

  $ 5 = 0101_2, quad 0101 + 0101 = 1010_2 $

  O resultado `1010` em complemento de 2 de 4 bits representa $-6$ (não $10$, fora da faixa) -- claramente incorreto ($5+5=10$). Verificando: somamos dois números *positivos* e obtivemos um resultado de bit de sinal $1$ (negativo) -- sinais de entrada iguais, sinal de saída diferente $arrow.r$ *overflow*. O carry para dentro do bit de sinal (posição 3) é 1 (de $1{+}1$ na posição 2); o carry para fora do bit de sinal é 0 -- carries diferentes, confirmando overflow pela regra alternativa.
]

#example(name: "Subtração via complemento de 2", id: "ex-subtracao-complemento2")[
  Calcular $6 - 3$ em 4 bits: $6 = 0110_2$; complemento de 2 de $3$ ($0011_2$) é `1101` (inverte: `1100`, soma 1: `1101`). Soma: $0110 + 1101 = 10011_2$ -- descartando o carry final (bit 5, além da largura de 4 bits): resultado `0011` $= 3$. Correto: $6-3=3$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Overflow só é possível somando operandos de mesmo sinal")[
  Somar um número positivo com um negativo *nunca* gera overflow (o resultado está sempre entre os dois operandos em magnitude) -- overflow só é possível somando dois positivos (resultado aparentemente negativo) ou dois negativos (resultado aparentemente positivo). Uma pegadinha clássica é perguntar sobre overflow em uma soma de sinais opostos, cuja resposta correta é sempre "não há overflow".
]

#remark(name: "Carry final descartado não é a mesma coisa que overflow")[
  Na subtração via complemento de 2, o carry que "sobra" além da largura de bits é *descartado* normalmente (não indica erro) -- overflow é detectado pela regra de sinais/carries do bit de sinal, um conceito diferente do carry de descarte visto no exemplo de subtração desta seção.
]

== Questões estilo POSCOMP

*Questão 1.* Em complemento de 2 de 8 bits, a faixa de valores representáveis é:
- a) $[0, 255]$.
- b) $[-128, 127]$.
- c) $[-127, 127]$.
- d) $[-256, 255]$.
- e) $[-255, 256]$.

*Questão 2.* Somando dois números representados em complemento de 2, overflow pode ocorrer quando:
- a) Os dois operandos têm sinais opostos.
- b) Os dois operandos têm o mesmo sinal e o resultado tem sinal diferente de ambos.
- c) O resultado é exatamente zero.
- d) Um dos operandos é zero.
- e) A subtração é usada em vez da soma.

*Questão 3.* O complemento de 2 de `0110` (4 bits) é:
- a) `1001`.
- b) `1010`.
- c) `0111`.
- d) `1000`.
- e) `1101`.

== Gabarito comentado

1. *(b)* -- fórmula padrão $[-2^(n-1), 2^(n-1)-1]$ com $n=8$.
2. *(b)* -- é exatamente a condição de overflow discutida nesta seção; soma de sinais opostos nunca gera overflow.
3. *(b)* -- inverte `0110` $arrow.r$ `1001`, soma 1 $arrow.r$ `1010`.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 1 (Aritmética binária e complemento de 2).
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 2.
