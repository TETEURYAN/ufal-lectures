#import "@preview/mousse-notes:1.1.0": *

= 5.8 --- Compacidade

== Introdução

O Teorema da Compacidade é uma consequência direta da completude (5.7) e é a ferramenta mais usada em lógica para provar a *existência* de modelos infinitos surpreendentes, sem construí-los diretamente. É conceitualmente simples de enunciar, mas suas aplicações costumam ser o ponto mais abstrato da disciplina em prova.

== Definições formais

#definition(name: "Satisfazibilidade finita", id: "def-satisfazibilidade-finita")[
  Um conjunto de fórmulas $Gamma$ é *finitamente satisfazível* se todo subconjunto finito $Gamma_0 subset.eq Gamma$ tem um modelo (existe uma estrutura que satisfaz simultaneamente todas as fórmulas de $Gamma_0$).
]

== Propriedade relevante

#theorem(name: "Teorema da Compacidade", id: "thm-compacidade")[
  Um conjunto de fórmulas de primeira ordem $Gamma$ é satisfazível (tem um modelo) se, e somente se, $Gamma$ é finitamente satisfazível.
]

#proof[
  A direção "satisfazível $arrow.r.double$ finitamente satisfazível" é trivial: se um único modelo satisfaz todo $Gamma$, ele satisfaz em particular qualquer subconjunto finito. A direção interessante ("finitamente satisfazível $arrow.r.double$ satisfazível") segue do Teorema da Completude (5.7): se $Gamma$ *não* fosse satisfazível, por completude $Gamma$ derivaria uma contradição; mas toda derivação é uma sequência *finita* de passos, usando apenas um subconjunto *finito* $Gamma_0 subset.eq Gamma$ de premissas -- logo esse $Gamma_0$ já seria insatisfazível, contradizendo a hipótese de que todo subconjunto finito de $Gamma$ é satisfazível.
]

== Exemplo resolvido

#example(name: "Aplicação: existência de um modelo infinito", id: "ex-compacidade-modelo-infinito")[
  Seja $Gamma$ um conjunto de sentenças que descreve a aritmética usual (ex.: os axiomas de Peano) mais uma nova constante $c$ e, para cada natural $n$, a sentença $c > n$ (usando $n$ como abreviação do numeral correspondente). Qualquer subconjunto *finito* de $Gamma$ menciona apenas finitas dessas sentenças $c>n$ -- e um modelo padrão dos naturais, interpretando $c$ como um número maior que todos os finitos $n$ mencionados, satisfaz esse subconjunto finito. Logo $Gamma$ é finitamente satisfazível e, pela compacidade, *satisfazível*. Mas qualquer modelo de $Gamma$ tem um elemento ($c$) maior que *todo* natural finito -- ou seja, existe um modelo com elementos "infinitos" (não-standard), mesmo a teoria descrevendo apenas os naturais usuais. Essa é a base da construção de modelos não padrão da aritmética.
]

== Atenção -- pegadinhas comuns

#remark(name: "Compacidade não diz nada sobre um único conjunto finito específico")[
  O teorema conecta satisfazibilidade do conjunto *infinito inteiro* com satisfazibilidade de *cada* subconjunto finito -- não é sobre encontrar um único subconjunto finito satisfazível (isso seria trivial e pouco informativo). A força do teorema está em garantir a existência de um modelo para o conjunto infinito completo.
]

#remark(name: "Compacidade é sobre lógica de primeira ordem clássica -- não vale em geral")[
  O Teorema da Compacidade depende crucialmente das propriedades da lógica de primeira ordem (via completude). Lógicas mais expressivas, como lógica de segunda ordem com semântica padrão, não são compactas em geral -- um lembrete de que "mais expressivo" nem sempre preserva propriedades metateóricas convenientes.
]

== Questões estilo POSCOMP

*Questão 1.* O Teorema da Compacidade afirma que um conjunto de fórmulas de primeira ordem $Gamma$ é satisfazível se, e somente se:
- a) $Gamma$ é finito.
- b) Todo subconjunto finito de $Gamma$ é satisfazível.
- c) $Gamma$ é decidível.
- d) $Gamma$ tem exatamente um modelo.
- e) $Gamma$ não contém quantificadores.

*Questão 2.* No exemplo desta seção (constante $c$ maior que todo natural), o Teorema da Compacidade é usado para concluir que:
- a) A aritmética dos naturais é inconsistente.
- b) Existe um modelo (não-padrão) contendo um elemento maior que todo número natural finito.
- c) Todo subconjunto finito de $Gamma$ é insatisfazível.
- d) A lógica de primeira ordem é incompleta.
- e) $c$ deve ser interpretado como um natural finito específico.

*Questão 3.* O Teorema da Compacidade, como apresentado nesta seção, é obtido como consequência direta de qual outro resultado?
- a) Teorema de Löwenheim-Skolem.
- b) Teorema da Completude.
- c) Teorema da Corretude apenas.
- d) Indecidibilidade da lógica de primeira ordem.
- e) Nenhum; é um axioma independente.

== Gabarito comentado

1. *(b)* -- é o próprio enunciado do teorema desta seção.
2. *(b)* -- exatamente a conclusão do exemplo: existência de um modelo com elemento "infinito" em relação aos naturais padrão.
3. *(b)* -- a prova apresentada nesta seção deriva compacidade diretamente da completude, usando a finitude das derivações.

== Referências

- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 2 (Teorema da compacidade).
- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 2.
