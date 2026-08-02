#import "@preview/mousse-notes:1.1.0": *

= Funções e Formas Booleanas, Álgebra Booleana, Minimização de Funções Booleanas
#text(size: 9pt, style: "italic")[Edital POSCOMP: 6.5]

== Introdução

A mesma base teórica desta seção -- álgebra booleana axiomática -- é aplicada diretamente em Circuitos Digitais (subtópicos 11.1, 11.3, 11.4), onde portas lógicas, tabelas-verdade e mapas de Karnaugh já foram tratados com exemplos completos de conversão, minimização e projeto de circuito. Aqui o foco é a *fundamentação algébrica abstrata*: os axiomas que tornam essas técnicas válidas, não a aplicação em hardware.

== Definições formais

#definition(name: "Álgebra booleana (axiomática)", id: "def-algebra-booleana-axiomatica")[
  Uma álgebra booleana é uma estrutura $(B, +, dot, ', 0, 1)$ -- um conjunto $B$ com duas operações binárias ($+$, $dot$), uma operação unária ($'$, complemento) e dois elementos distintos $0, 1 in B$ -- satisfazendo, para todos $x,y,z in B$:
  - *Comutatividade*: $x+y=y+x$; $x dot y = y dot x$.
  - *Distributividade*: $x dot (y+z) = (x dot y)+(x dot z)$; $x+(y dot z)=(x+y) dot (x+z)$.
  - *Elemento neutro*: $x+0=x$; $x dot 1 = x$.
  - *Complemento*: $x + x' = 1$; $x dot x' = 0$.
  O exemplo mais familiar é $B = {0,1}$ com $+$=OR, $dot$=AND, $'$=NOT (a álgebra booleana de dois valores usada em circuitos digitais), mas a definição axiomática admite outras álgebras booleanas (ex.: a álgebra dos subconjuntos de um conjunto $S$, com $union, inter, "complemento", emptyset, S$).
]

== Propriedade relevante

#theorem(name: "Princípio da Dualidade", id: "thm-principio-dualidade")[
  Todo teorema válido em álgebra booleana permanece válido se trocarmos simultaneamente $+ arrow.l.r dot$ e $0 arrow.l.r 1$ em toda a expressão -- o *dual* de um teorema verdadeiro é automaticamente verdadeiro.
]

#proof[
  Os axiomas de álgebra booleana (definição acima) já são apresentados em pares duais (comutatividade de $+$ com comutatividade de $dot$; elemento neutro $0$ de $+$ com elemento neutro $1$ de $dot$; etc.) -- qualquer prova que usa apenas esses axiomas, ao ter cada passo trocado por seu dual, continua sendo uma sequência válida de aplicações de axiomas, agora provando o teorema dual.
]

== Exemplo resolvido

#example(name: "Provando a lei de absorção a partir dos axiomas", id: "ex-lei-absorcao-axiomas")[
  Provar $x + (x dot y) = x$ usando apenas os axiomas:
  $ x + (x dot y) = (x dot 1) + (x dot y) quad & "(elemento neutro: " x=x dot 1 ")" \
  = x dot (1+y) quad & "(distributividade)" \
  = x dot 1 quad & "(" 1+y=1 ", consequência dos axiomas)" \
  = x quad & "(elemento neutro)" $
  Pelo princípio da dualidade, o teorema dual $x dot (x+y) = x$ também vale automaticamente, sem precisar refazer a prova -- basta trocar $+ arrow.l.r dot$ em cada passo.
]

== Atenção -- pegadinhas comuns

#remark(name: "Dualidade troca operadores E constantes, não apenas um dos dois")[
  Um erro comum é aplicar dualidade trocando apenas $+$ por $dot$ (ou vice-versa) e esquecer de também trocar $0$ por $1$ na mesma expressão -- a troca precisa ser *simultânea e completa* para o teorema dual ser garantidamente válido.
]

#remark(name: "A aplicação prática (portas, Karnaugh) já está em Circuitos Digitais")[
  Tabela-verdade, formas canônicas (SOP/POS) e minimização por mapa de Karnaugh -- com exemplos completos passo a passo -- estão detalhados em Circuitos Digitais, subtópicos 11.3 e 11.4. O que esta seção acrescenta é a garantia *axiomática* de que essas manipulações (ex.: simplificar uma expressão) são sempre corretas, por decorrerem logicamente dos axiomas de álgebra booleana, não de regras ad-hoc.
]

== Questões estilo POSCOMP

*Questão 1.* Segundo os axiomas de álgebra booleana, o elemento neutro da operação $dot$ é:
- a) $0$.
- b) $1$.
- c) $x'$.
- d) Não existe elemento neutro para $dot$.
- e) Depende de cada álgebra booleana específica, sem padrão.

*Questão 2.* O princípio da dualidade em álgebra booleana afirma que:
- a) Todo teorema tem exatamente uma prova.
- b) Trocando simultaneamente $+ arrow.l.r dot$ e $0 arrow.l.r 1$ em um teorema válido, obtém-se outro teorema válido.
- c) Álgebra booleana não admite mais de uma interpretação.
- d) $x+x'=0$ para todo $x$.
- e) A dualidade só se aplica a circuitos com portas NAND.

*Questão 3.* O dual da identidade $x dot (x+y) = x$, pelo princípio da dualidade, é:
- a) $x dot (x dot y) = x$.
- b) $x + (x dot y) = x$.
- c) $x + x' = 1$.
- d) $x dot 0 = 0$.
- e) $x + 1 = x$.

== Gabarito comentado

1. *(b)* -- $x dot 1 = x$ é o axioma de elemento neutro para $dot$.
2. *(b)* -- definição direta do princípio da dualidade desta seção.
3. *(b)* -- trocando $dot arrow.l.r +$ (e não havendo constantes $0$ ou $1$ nesta identidade específica) obtém-se exatamente a lei de absorção provada no exemplo desta seção.

== Referências

- ROSEN, K. H. *Matemática Discreta e suas Aplicações*. Cap. 12 (Álgebra booleana).
- HUNTINGTON, E. V. *Sets of Independent Postulates for the Algebra of Logic* (1904) -- axiomatização clássica.
- Circuitos Digitais (11.1, 11.3, 11.4) -- aplicação em portas lógicas, tabelas-verdade e mapas de Karnaugh.
