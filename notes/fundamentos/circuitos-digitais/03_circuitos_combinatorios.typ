#import "@preview/mousse-notes:1.1.0": *

= Representação e Manipulação de Circuitos Combinatórios
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.3]

== Introdução

Um circuito combinacional é a forma mais simples de circuito digital: sua saída depende *apenas* das entradas atuais, sem nenhuma noção de estado passado. Esta subseção conecta álgebra booleana (aplicada, não a teoria abstrata -- tratada em Matemática Discreta, 6.5) a portas lógicas físicas.

== Definições formais

#definition(name: "Circuito combinacional", id: "def-circuito-combinacional")[
  Circuito cuja saída, em qualquer instante, é uma função *exclusivamente* das entradas presentes naquele instante -- não possui elementos de memória nem realimentação (feedback). Contrasta diretamente com circuito *sequencial* (06), cuja saída também depende de um estado interno armazenado.
]

#definition(name: "Formas canônicas: soma de produtos e produto de somas", id: "def-formas-canonicas")[
  Toda função booleana pode ser expressa de forma canônica a partir de sua tabela-verdade:
  - *Soma de produtos (SOP)*: OR de termos AND (*mintermos*), um para cada linha da tabela onde a saída é 1.
  - *Produto de somas (POS)*: AND de termos OR (*maxtermos*), um para cada linha onde a saída é 0.
]

== Exemplo resolvido

#example(name: "Da tabela-verdade ao circuito com portas lógicas", id: "ex-tabela-verdade-circuito")[
  Função $F(A,B,C)$ = 1 quando pelo menos duas das três entradas são 1 (função "maioria"):

  #table(
    columns: 4,
    [*A*], [*B*], [*C*], [*F*],
    [0],[0],[0],[0], [0],[0],[1],[0], [0],[1],[0],[0], [0],[1],[1],[1],
    [1],[0],[0],[0], [1],[0],[1],[1], [1],[1],[0],[1], [1],[1],[1],[1],
  )

  *Forma SOP* (mintermos onde $F=1$): $F = A'B C + A B' C + A B C' + A B C$ (usando $X'$ para $not X$).

  Essa expressão (antes de simplificar -- ver 04) já pode ser implementada diretamente: 4 portas AND de 3 entradas (uma por termo), com uma porta OR de 4 entradas combinando as saídas. A simplificação via mapa de Karnaugh (04) reduzirá isso para $F = A B + A C + B C$, com apenas 3 portas AND de 2 entradas.

  #figure(
    image("figures/logic-gates.svg", width: 70%),
    caption: [Símbolos padrão das portas AND, OR e NOT (inversor) usadas para implementar expressões booleanas como circuito. Fonte: Wikimedia Commons, CC BY/GFDL (Vaughan Pratt).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "NAND e NOR são portas universais")[
  Qualquer função booleana pode ser implementada usando *apenas* portas NAND (ou apenas portas NOR) -- por isso são chamadas *portas universais*. Isso decorre de AND, OR e NOT poderem ser construídos só com NAND (ex.: $not A = A "NAND" A$) ou só com NOR. Na prática industrial, NAND/NOR são frequentemente mais baratas de fabricar (menos transistores) que AND/OR, tornando essa equivalência funcional relevante além do interesse teórico.
]

#remark(name: "SOP a partir da tabela-verdade sempre funciona, mas raramente é a forma mais simples")[
  A forma canônica SOP (um termo AND por linha com saída 1) é mecânica e sempre correta, mas geralmente não é a expressão mínima -- daí a necessidade da etapa de minimização (04) antes de projetar o circuito físico final.
]

== Questões estilo POSCOMP

*Questão 1.* Um circuito cuja saída depende exclusivamente das entradas presentes no instante atual, sem nenhum elemento de memória, é classificado como:
- a) Sequencial síncrono.
- b) Sequencial assíncrono.
- c) Combinacional.
- d) Uma máquina de estados.
- e) Um registrador.

*Questão 2.* Qualquer função booleana pode ser implementada usando exclusivamente portas:
- a) XOR.
- b) NAND (ou exclusivamente NOR).
- c) AND.
- d) OR.
- e) Buffer.

*Questão 3.* A forma canônica "soma de produtos" (SOP) de uma função booleana é construída a partir de:
- a) Um termo OR para cada linha da tabela-verdade onde a saída é 0.
- b) Um termo AND para cada linha da tabela-verdade onde a saída é 1, unidos por OR.
- c) Apenas as entradas que nunca aparecem na tabela-verdade.
- d) Uma única porta XOR.
- e) A expressão já simplificada pelo mapa de Karnaugh.

== Gabarito comentado

1. *(c)* -- ausência de memória e dependência só das entradas atuais define circuito combinacional.
2. *(b)* -- NAND (e, separadamente, NOR) são portas universais, conforme a observação desta seção.
3. *(b)* -- definição direta de forma canônica SOP (soma de mintermos).

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 2--3 (Álgebra booleana e circuitos combinacionais).
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 3--4.
- Matemática Discreta (6.5, Álgebra Booleana) -- fundamentação algébrica abstrata, ainda sem material escrito neste repositório no momento desta seção.
