#import "@preview/mousse-notes:1.1.0": *

= 5.7 --- Completude

== Introdução

Completude é a segunda ponte entre sintaxe e semântica, na direção oposta à corretude (5.6): garante que o sistema dedutivo consegue provar *tudo* que é semanticamente verdadeiro -- nenhuma verdade "escapa" da capacidade de prova do sistema. É um dos resultados mais celebrados da lógica do século XX, devido a Kurt Gödel.

== Definições formais

#definition(name: "Completude", id: "def-completude")[
  Um sistema dedutivo é *completo* se, para todo conjunto de fórmulas $Gamma$ e fórmula $phi$:
  $ Gamma models phi arrow.r.double Gamma tack.r phi $
  Ou seja: toda fórmula que é *verdadeira* em todo modelo de $Gamma$ (consequência semântica) é também *derivável* sintaticamente a partir de $Gamma$.
]

== Propriedade relevante

#theorem(name: "Teorema da Completude de Gödel (1929)", id: "thm-completude-godel")[
  A lógica de primeira ordem clássica, com um sistema dedutivo adequado (ex.: dedução natural ou o sistema de Hilbert), é completa: $Gamma models phi arrow.r.double Gamma tack.r phi$, para quaisquer $Gamma$ e $phi$ na linguagem de primeira ordem.
]

#proof[
  Esboço (via o método de Henkin): mostra-se, contrapositivamente, que se $Gamma$ não deriva $phi$ (isto é, $Gamma union {not phi}$ é sintaticamente consistente -- não permite derivar uma contradição), então $Gamma union {not phi}$ tem um modelo (construído explicitamente por meio de "constantes de testemunha" adicionadas à linguagem). Esse modelo satisfaz $Gamma$ mas não $phi$, logo $Gamma$ não implica semanticamente $phi$ (contrapositiva de $Gamma models phi$). A demonstração completa está fora do escopo desta revisão, mas a ideia central -- consistência sintática implica existência de modelo -- é o que a prova costuma cobrar conceitualmente.
]

== Exemplo resolvido

#example(name: "O que a completude garante na prática", id: "ex-completude-pratica")[
  Suponha que, por meio de uma tabela-verdade (5.4) ou análise semântica, você verifique que uma fórmula $phi$ é uma tautologia (verdadeira em toda estrutura, logo $emptyset models phi$). O Teorema da Completude garante que existe *necessariamente* uma derivação sintática $tack.r phi$ no sistema dedutivo -- mesmo que você ainda não a tenha encontrado. Completude não diz *como* encontrar a prova (isso pode ser difícil, ou até indecidível em geral -- 5.10), apenas garante que ela *existe*.
]

== Atenção -- pegadinhas comuns

#remark(name: "Corretude e Completude são \"setas\" opostas -- não confunda a direção")[
  Retomando a comparação de 5.6: *corretude* é $tack.r arrow.r.double models$ (prova implica verdade); *completude* é $models arrow.r.double tack.r$ (verdade implica prova). Juntas, formam uma equivalência ($tack.r arrow.l.r.double models$) -- mas cada uma sozinha é uma implicação em um único sentido, e a prova adora testar se você sabe qual seta vai para qual lado.
]

#remark(name: "Completude (Gödel 1929) não é o mesmo que os Teoremas da Incompletude (Gödel 1931)")[
  São resultados *diferentes*, do mesmo autor, frequentemente confundidos: o Teorema da Completude (1929) é sobre lógica de *primeira ordem* e é um resultado *positivo* (o sistema é completo). Os Teoremas da Incompletude (1931) são sobre sistemas formais suficientemente fortes para *aritmética* (segunda ordem, ou primeira ordem com axiomas específicos como Peano) e são resultados *negativos* (existem verdades aritméticas não prováveis dentro do próprio sistema). Fora do escopo direto do edital, mas frequentemente citado como pegadinha em provas.
]

== Questões estilo POSCOMP

*Questão 1.* O Teorema da Completude de Gödel (1929), para lógica de primeira ordem, estabelece que:
- a) $Gamma tack.r phi arrow.r.double Gamma models phi$.
- b) $Gamma models phi arrow.r.double Gamma tack.r phi$.
- c) Toda fórmula é decidível.
- d) Todo sistema formal suficientemente forte é incompleto.
- e) $tack.r$ e $models$ nunca coincidem.

*Questão 2.* Se uma fórmula $phi$ é uma tautologia (verdadeira em todo modelo), o Teorema da Completude garante que:
- a) $phi$ é indecidível.
- b) Existe uma derivação sintática $tack.r phi$ no sistema dedutivo.
- c) $phi$ é uma contradição.
- d) $phi$ não pode ser expressa em lógica de primeira ordem.
- e) $phi$ é falsa em pelo menos um modelo.

*Questão 3.* O Teorema da Completude de Gödel (1929) e os Teoremas da Incompletude de Gödel (1931):
- a) São o mesmo resultado, apenas com nomes diferentes.
- b) Tratam de sistemas e propriedades diferentes: o primeiro é sobre completude da lógica de primeira ordem; os segundos, sobre limitações de sistemas formais para aritmética.
- c) Ambos provam que a lógica de primeira ordem é incompleta.
- d) Ambos são resultados sobre decidibilidade, não sobre completude.
- e) Foram refutados posteriormente por outros lógicos.

== Gabarito comentado

1. *(b)* -- direção correta da completude: verdade semântica implica prova sintática.
2. *(b)* -- exatamente o que o exemplo desta seção ilustra: completude garante existência (não construção) da prova.
3. *(b)* -- são resultados distintos, frequentemente confundidos apenas pelo nome do autor em comum.

== Referências

- GÖDEL, K. *Die Vollständigkeit der Axiome des logischen Funktionenkalküls* (1929) -- artigo original do Teorema da Completude.
- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 2 (Teorema da completude).
- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 2.
