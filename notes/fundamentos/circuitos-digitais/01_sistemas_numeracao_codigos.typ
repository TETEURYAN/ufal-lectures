#import "@preview/mousse-notes:1.1.0": *

= Sistemas de Numeração e Códigos
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.1]

== Introdução

Todo circuito digital opera sobre representações binárias -- entender como converter entre bases e codificar informação é pré-requisito para tudo o que segue na disciplina. É também o bloco mais "calculável" da prova: espere questões de conversão direta.

== Definições formais

#definition(name: "Sistema de numeração posicional", id: "def-sistema-numeracao-posicional")[
  Em um sistema posicional de base $b$, um número é representado por dígitos $d_n dots d_1 d_0 . d_(-1) dots$ (cada um em $\{0, dots, b-1\}$), com valor $sum_i d_i times b^i$. Os sistemas mais usados em circuitos digitais são *binário* ($b=2$), *octal* ($b=8$) e *hexadecimal* ($b=16$, dígitos $0$--$9$, A--F), além do *decimal* ($b=10$) para interface com humanos.
]

#definition(name: "Códigos BCD e Gray", id: "def-codigos-bcd-gray")[
  - *BCD (Binary-Coded Decimal)*: cada dígito decimal é representado independentemente por 4 bits binários (0000 a 1001) -- facilita conversão para exibição decimal, ao custo de desperdiçar combinações (1010--1111 não usadas).
  - *Código Gray*: sequência de códigos binários em que dois valores *consecutivos* diferem em exatamente *1 bit*. Evita múltiplas transições de bit simultâneas em contadores/sensores físicos, reduzindo glitches (relevante para hazards, ver 09).
]

== Exemplo resolvido

#example(name: "Conversão entre bases", id: "ex-conversao-bases")[
  Converter $173_10$ para binário, octal e hexadecimal:

  - *Binário* (divisões sucessivas por 2, lendo os restos de baixo para cima): $173 = 128+32+8+4+1 = 10101101_2$.
  - *Octal*: agrupando o binário em grupos de 3 bits a partir da direita ($010 space 101 space 101$) $arrow.r$ $255_8$.
  - *Hexadecimal*: agrupando em grupos de 4 bits ($1010 space 1101$) $arrow.r$ $"AD"_16$.

  Verificação: $10 times 16 + 13 = 173$. ✓
]

#example(name: "Conversão para BCD e Gray", id: "ex-conversao-bcd-gray")[
  $173_10$ em *BCD*: cada dígito decimal vira 4 bits -- $1 arrow.r 0001$, $7 arrow.r 0111$, $3 arrow.r 0011$ $arrow.r$ `0001 0111 0011`.

  $1010_2$ (decimal 10) em *Gray*: $g_i = b_i xor b_(i+1)$ (bit mais significativo do Gray = bit mais significativo do binário; demais = XOR de bits binários adjacentes). Para `1010`: $g_3=1$, $g_2 = 1 xor 0=1$, $g_1 = 0 xor 1=1$, $g_0 = 1 xor 0=1$ $arrow.r$ `1111`.
]

== Atenção -- pegadinhas comuns

#remark(name: "BCD não é o mesmo que converter o número inteiro para binário")[
  $173$ em BCD é `0001 0111 0011` (dígito a dígito); $173$ em binário puro é `10101101` -- resultados completamente diferentes, e confundir os dois é o erro mais comum desta seção.
]

#remark(name: "Álgebra booleana subjacente é tratada em Matemática Discreta")[
  A base algébrica formal por trás dessas representações (operações e propriedades booleanas) é tratada em Matemática Discreta, subtópico 6.5 (Álgebra Booleana) -- ainda sem material escrito neste repositório no momento desta seção. Aqui o foco é a aplicação prática: representação numérica e, a partir de 03, sua manipulação em portas lógicas.
]

== Questões estilo POSCOMP

*Questão 1.* O número decimal $45$ corresponde, em binário, a:
- a) `101100`.
- b) `101101`.
- c) `100101`.
- d) `110101`.
- e) `101111`.

*Questão 2.* O número hexadecimal `2F` corresponde, em decimal, a:
- a) $45$.
- b) $47$.
- c) $31$.
- d) $63$.
- e) $79$.

*Questão 3.* A principal vantagem do código Gray sobre o binário puro em aplicações como contadores físicos é:
- a) Ocupar menos bits para o mesmo intervalo de valores.
- b) Permitir aritmética mais rápida.
- c) Garantir que valores consecutivos difiram em apenas 1 bit, reduzindo glitches em transições.
- d) Ser diretamente compatível com BCD.
- e) Eliminar a necessidade de portas lógicas.

== Gabarito comentado

1. *(b)* -- $45 = 32+8+4+1 = 101101_2$.
2. *(a)* -- $2 times 16 + 15 = 32+13=45$.
3. *(c)* -- definição direta da propriedade do código Gray desta seção.

== Referências

- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 1--2 (Sistemas de numeração e códigos).
- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 1 (Sistemas de numeração).
- cienciadacomputacao.wiki.br -- Tópico 11, subtópico 11.1.
