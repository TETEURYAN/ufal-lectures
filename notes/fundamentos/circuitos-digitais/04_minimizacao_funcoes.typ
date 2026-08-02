#import "@preview/mousse-notes:1.1.0": *

= Minimização e Otimização de Funções Combinatórias
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.4]

== Introdução

A forma canônica SOP (03) sempre funciona, mas raramente é a expressão mais simples. Minimizar reduz o número de portas e entradas necessárias -- menor custo, menor área de chip, menor consumo. O mapa de Karnaugh é a técnica manual mais cobrada na POSCOMP.

== Definições formais

#definition(name: "Mapa de Karnaugh (mapa K)", id: "def-mapa-karnaugh")[
  Representação tabular de uma função booleana em que células adjacentes (na horizontal, vertical, ou "dando a volta" nas bordas) diferem em exatamente 1 bit de entrada -- construída com codificação *Gray* (01) entre linhas/colunas. Agrupar células adjacentes com valor 1 em blocos de tamanho potência de 2 ($1, 2, 4, 8, dots$) produz termos simplificados: quanto maior o grupo, menos literais o termo resultante precisa.
]

#definition(name: "Método de Quine-McCluskey", id: "def-quine-mccluskey")[
  Método tabular e sistemático (não gráfico) de minimização, mais adequado que o mapa K para funções com muitas variáveis (onde o mapa K se torna difícil de visualizar). Combina mintermos que diferem em 1 bit repetidamente, marcando termos "essenciais" (que cobrem algum mintermo que nenhum outro termo cobre) até obter a expressão mínima -- mesmo princípio do mapa K, mas executável algoritmicamente.
]

== Exemplo resolvido

#example(name: "Simplificação por mapa de Karnaugh", id: "ex-simplificacao-mapa-karnaugh")[
  Retomando a função "maioria" $F(A,B,C)$ de 03 (SOP: $A'B C + A B' C + A B C' + A B C$):

  #table(
    columns: 3,
    [], [*C=0*], [*C=1*],
    [*AB=00*], [0], [0],
    [*AB=01*], [0], [1],
    [*AB=11*], [1], [1],
    [*AB=10*], [0], [1],
  )

  Agrupando células adjacentes com valor 1 na tabela acima: a coluna inteira $C{=}1$ nas linhas $A B{=}01$ e $A B{=}11$ forma um par adjacente (variam só em $A$) $arrow.r$ elimina $A$, sobrando o termo $B C$. As duas células com $A B{=}11$ (linha inteira, $C{=}0$ e $C{=}1$) formam outro par (variam só em $C$) $arrow.r$ elimina $C$, sobrando $A B$. E o par com $C{=}1$ nas linhas $A B{=}11$ e $A B{=}10$ (variam só em $B$) $arrow.r$ elimina $B$, sobrando $A C$. Resultado minimizado: $F = A B + A C + B C$ -- de 4 termos de 3 literais (12 literais totais) para 3 termos de 2 literais (6 literais), reduzindo o número de entradas de porta necessárias.

  #figure(
    image("figures/karnaugh-map.svg", width: 45%),
    caption: [Exemplo de mapa de Karnaugh 4×4 com agrupamentos de células adjacentes destacados -- mesmo princípio do exemplo acima, em uma função de 4 variáveis. Fonte: Wikimedia Commons, domínio público.],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "Grupos devem ter tamanho potência de 2, e maiores são sempre melhores")[
  Um agrupamento válido no mapa K deve ter $1, 2, 4, 8, dots$ células (nunca 3, 5, 6...) -- e o objetivo é sempre usar os *maiores* grupos possíveis primeiro (cobrindo mais 1's com menos literais), preenchendo o restante com grupos menores só quando necessário.
]

#remark(name: "Mapa K \"dá a volta\" nas bordas -- não é uma grade plana isolada")[
  Células nas extremidades opostas de uma linha ou coluna do mapa K são consideradas *adjacentes* (o mapa é topologicamente um toro) -- esquecer disso é um erro comum que faz perder agrupamentos válidos e simplificações possíveis.
]

== Questões estilo POSCOMP

*Questão 1.* Em um mapa de Karnaugh, um agrupamento válido de células com valor 1 deve ter tamanho:
- a) Qualquer número inteiro positivo.
- b) Uma potência de 2 ($1, 2, 4, 8, dots$).
- c) Sempre exatamente 4.
- d) Um número primo.
- e) Igual ao número de variáveis da função.

*Questão 2.* O método de Quine-McCluskey é preferível ao mapa de Karnaugh principalmente quando:
- a) A função tem poucas variáveis (2 ou 3).
- b) A função tem muitas variáveis, tornando a visualização gráfica do mapa K difícil.
- c) A função já está em sua forma mínima.
- d) Não há necessidade de minimização.
- e) A função é puramente sequencial.

*Questão 3.* Simplificando a função $F = A'B + A B$ por mapa de Karnaugh (ou álgebra booleana direta), obtém-se:
- a) $F = A$.
- b) $F = B$.
- c) $F = A + B$.
- d) $F = A B$.
- e) $F = 0$.

== Gabarito comentado

1. *(b)* -- regra fundamental de agrupamento válido no mapa K.
2. *(b)* -- Quine-McCluskey escala melhor que o mapa K para funções com muitas variáveis.
3. *(b)* -- $A'B + A B = B(A'+A) = B times 1 = B$.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 3 (Simplificação de funções booleanas).
- QUINE, W. V. O. *The Problem of Simplifying Truth Functions* (1952) -- referência original do método tabular.
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 4 (Mapas de Karnaugh).
