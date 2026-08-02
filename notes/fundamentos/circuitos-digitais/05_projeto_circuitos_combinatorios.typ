#import "@preview/mousse-notes:1.1.0": *

= Projeto de Circuitos Combinatórios
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.5]

== Introdução

Com formalização (03) e minimização (04) estabelecidas, esta subseção fecha o fluxo de projeto combinacional: da especificação em linguagem natural até o circuito físico final, reutilizando blocos combinacionais padronizados sempre que possível.

== Definições formais

#definition(name: "Fluxo de projeto de circuito combinacional", id: "def-fluxo-projeto-combinacional")[
  + Traduzir a especificação (em linguagem natural) para uma *tabela-verdade*.
  + Extrair a forma canônica (SOP ou POS, 03).
  + *Minimizar* a expressão (mapa de Karnaugh ou Quine-McCluskey, 04).
  + Implementar com portas lógicas (ou blocos combinacionais padronizados).
]

#definition(name: "Blocos combinacionais padronizados", id: "def-blocos-combinacionais")[
  - *Multiplexador (MUX)*: seleciona uma dentre $2^n$ entradas de dados, com base em $n$ bits de seleção, para a saída.
  - *Decodificador*: ativa exatamente uma dentre $2^n$ saídas, com base em uma entrada de $n$ bits.
  - *Codificador (encoder)*: operação inversa do decodificador -- converte uma entre $2^n$ linhas ativas em um código de $n$ bits.
  - *Comparador*: produz saídas indicando se duas entradas são iguais, ou qual é maior.
  - *Somador*: soma binária (02) implementada em hardware -- meio-somador (2 entradas) e somador completo (3 entradas, incluindo carry).
  Esses blocos são reutilizados como componentes prontos em projetos maiores, evitando reprojetar cada função do zero a partir da tabela-verdade.
]

== Exemplo resolvido

#example(name: "Projetando um multiplexador 2-para-1", id: "ex-projeto-mux-2-1")[
  Um MUX 2-para-1 tem entradas de dados $D_0, D_1$, seleção $S$, e saída $Y = D_S$.

  #table(
    columns: 4,
    [*S*], [*$D_0$*], [*$D_1$*], [*Y*],
    [0], [0], [--], [0],
    [0], [1], [--], [1],
    [1], [--], [0], [0],
    [1], [--], [1], [1],
  )

  A expressão booleana correspondente (considerando os "--" como *don't care*, simplificando diretamente por inspeção): $Y = S' D_0 + S D_1$ -- quando $S=0$, seleciona $D_0$; quando $S=1$, seleciona $D_1$. Circuito: duas portas AND (uma para cada termo) e uma porta OR combinando as saídas, com um inversor gerando $S'$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Reutilizar blocos padronizados não substitui entender o fluxo de projeto")[
  A POSCOMP frequentemente cobra a construção de blocos maiores (ex.: um decodificador 3-para-8) *a partir* de portas básicas, exigindo o fluxo completo de 04/05, não apenas o reconhecimento do bloco como caixa-preta.
]

#remark(name: "Don't care (\"--\") na tabela-verdade é uma oportunidade de simplificação, não um erro")[
  Entradas marcadas como "não importa" (don't care) podem ser tratadas como 0 *ou* 1, o que for mais conveniente para simplificar a expressão -- ignorar essa flexibilidade ao montar o mapa de Karnaugh leva a circuitos desnecessariamente complexos.
]

== Questões estilo POSCOMP

*Questão 1.* Um bloco combinacional que seleciona uma entre $2^n$ entradas de dados, com base em $n$ bits de controle, é um:
- a) Decodificador.
- b) Codificador.
- c) Multiplexador.
- d) Comparador.
- e) Somador completo.

*Questão 2.* Em um projeto de circuito combinacional, a etapa que ocorre imediatamente após extrair a forma canônica da tabela-verdade é:
- a) Implementação direta com portas, sem mais nenhuma etapa.
- b) Minimização da expressão (ex.: via mapa de Karnaugh).
- c) Conversão para código Gray.
- d) Definição da tabela-verdade (etapa anterior, não posterior).
- e) Cálculo de overflow.

*Questão 3.* Em uma tabela-verdade de projeto, uma entrada marcada como "don't care":
- a) Deve sempre ser tratada como 0.
- b) Deve sempre ser tratada como 1.
- c) Pode ser tratada como 0 ou 1, conforme o que simplifique melhor a expressão.
- d) Indica um erro na especificação.
- e) Não pode aparecer em um mapa de Karnaugh.

== Gabarito comentado

1. *(c)* -- definição direta de multiplexador.
2. *(b)* -- o fluxo de projeto desta seção coloca minimização logo após a forma canônica.
3. *(c)* -- don't cares são explorados livremente para simplificar, conforme a observação desta seção.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 4 (Blocos combinacionais: MUX, decodificadores, somadores).
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 6.
