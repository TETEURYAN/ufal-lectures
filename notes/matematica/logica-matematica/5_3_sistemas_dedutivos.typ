#import "@preview/mousse-notes:1.1.0": *

= 5.3 --- Sistemas Dedutivos

== Introdução

Um sistema dedutivo formaliza a noção de "prova": um procedimento puramente sintático (manipulação de símbolos, sem apelar a significado) que permite derivar novas fórmulas a partir de outras. É o lado *sintático* da lógica, em contraste com o lado *semântico* (verdade em uma estrutura, tratado em 5.4).

== Definições formais

#definition(name: "Sistema dedutivo e derivação", id: "def-sistema-dedutivo")[
  Um sistema dedutivo é definido por um conjunto de *axiomas* (fórmulas aceitas sem prova) e um conjunto de *regras de inferência* (que permitem obter uma fórmula a partir de outras já estabelecidas). Uma *derivação* de $phi$ a partir de um conjunto de premissas $Gamma$ é uma sequência finita de fórmulas, cada uma sendo um axioma, uma premissa de $Gamma$, ou obtida das anteriores por uma regra de inferência, terminando em $phi$. Escreve-se $Gamma tack.r phi$ ("$Gamma$ prova/deriva $phi$").
]

#definition(name: "Dedução natural: regras principais", id: "def-deducao-natural")[
  Sistema dedutivo organizado por regras de *introdução* e *eliminação* para cada conectivo -- mais próximo do raciocínio informal que um sistema puramente axiomático. Regras usadas nesta seção:
  - *Modus Ponens* ($->$-eliminação): de $alpha$ e $alpha -> beta$, deriva-se $beta$.
  - *$->$-introdução (prova condicional)*: se, *supondo* $alpha$ como hipótese adicional, deriva-se $beta$, então (descartando a hipótese) deriva-se $alpha -> beta$.
  - *Reiteração*: uma fórmula já estabelecida pode ser repetida enquanto a hipótese que a originou ainda estiver em vigor.
]

== Exemplo resolvido

#example(name: "Derivação passo a passo: prova de p -> (q -> p)", id: "ex-derivacao-natural")[
  Vamos derivar $tack.r p -> (q -> p)$ (uma tautologia, sem premissas) usando dedução natural:

  #table(
    columns: 3,
    [*Passo*], [*Fórmula*], [*Justificativa*],
    [1], [$p$], [Hipótese (para $->$-introdução externa)],
    [2], [$q$], [Hipótese (para $->$-introdução interna)],
    [3], [$p$], [Reiteração do passo 1 (hipótese ainda em vigor)],
    [4], [$q -> p$], [$->$-introdução, descartando a hipótese do passo 2 (usa 2--3)],
    [5], [$p -> (q -> p)$], [$->$-introdução, descartando a hipótese do passo 1 (usa 1--4)],
  )

  No passo 5, como a derivação de $q->p$ (passos 2--4) não depende de mais nenhuma premissa externa além da hipótese já descartada em 1, obtemos $p -> (q->p)$ como *teorema* (derivável sem premissas nenhuma) do sistema.
]

== Atenção -- pegadinhas comuns

#remark(name: "Derivação é sintaxe pura -- não apela a valores-verdade")[
  Cada passo da derivação do exemplo é justificado apenas pela *forma* da regra aplicada, nunca por "isso é intuitivamente verdadeiro". Essa é a marca do lado sintático da lógica -- o vínculo entre essa noção ($tack.r$) e a de verdade semântica ($models$, 5.5) é precisamente o conteúdo dos teoremas de corretude (5.6) e completude (5.7).
]

#remark(name: "Hipótese descartada não pode mais ser usada depois de fechado o escopo")[
  Uma vez que uma hipótese (ex.: passo 2 do exemplo) é "descartada" por uma $->$-introdução, ela não está mais disponível para justificar passos posteriores fora daquele escopo -- controlar corretamente o escopo das hipóteses é o erro mais comum ao montar uma derivação de dedução natural.
]

== Questões estilo POSCOMP

*Questão 1.* Em um sistema dedutivo, a notação $Gamma tack.r phi$ significa que:
- a) $phi$ é verdadeira em todo modelo de $Gamma$.
- b) Existe uma derivação sintática de $phi$ a partir das premissas em $Gamma$.
- c) $phi$ é uma tautologia.
- d) $Gamma$ é inconsistente.
- e) $phi$ é indecidível.

*Questão 2.* A regra de inferência que permite obter $beta$ a partir de $alpha$ e $alpha -> beta$ é conhecida como:
- a) $and$-introdução.
- b) Reiteração.
- c) Modus Ponens.
- d) $->$-introdução.
- e) $forall$-eliminação.

*Questão 3.* Sobre a regra de $->$-introdução (prova condicional), é correto afirmar que:
- a) Permite derivar $alpha -> beta$ assumindo $alpha$ como hipótese, derivando $beta$, e então descartando a hipótese.
- b) Só pode ser usada quando $alpha$ já é um teorema provado separadamente.
- c) Elimina a necessidade de qualquer hipótese no sistema.
- d) É equivalente à regra de Modus Ponens.
- e) Só se aplica a fórmulas atômicas.

== Gabarito comentado

1. *(b)* -- $tack.r$ denota consequência *sintática*: existência de uma derivação formal, não uma afirmação sobre modelos (isso seria $models$, 5.5).
2. *(c)* -- definição direta de Modus Ponens.
3. *(a)* -- é exatamente o mecanismo usado nos passos 4 e 5 do exemplo desta seção.

== Referências

- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 1--2 (Sistemas dedutivos axiomáticos).
- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 2 (Dedução natural).
- GENTZEN, G. *Investigations into Logical Deduction* (1935) -- referência original da dedução natural.
