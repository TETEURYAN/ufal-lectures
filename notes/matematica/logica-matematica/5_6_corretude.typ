#import "@preview/mousse-notes:1.1.0": *

= 5.6 --- Corretude

== Introdução

Corretude (soundness) é a primeira das duas pontes entre sintaxe ($tack.r$) e semântica ($models$, 5.5): garante que o sistema dedutivo nunca "mente" -- tudo que se consegue provar é, de fato, semanticamente verdadeiro. Sem corretude, um sistema dedutivo seria inútil (poderia provar afirmações falsas).

== Definições formais

#definition(name: "Corretude (Soundness)", id: "def-corretude")[
  Um sistema dedutivo é *correto (sound)* se, para todo conjunto de fórmulas $Gamma$ e fórmula $phi$:
  $ Gamma tack.r phi arrow.r.double Gamma models phi $
  Ou seja: tudo que é *provável* sintaticamente é *verdadeiro* semanticamente (em todo modelo das premissas). Em outras palavras, o sistema não permite derivar conclusões falsas a partir de premissas verdadeiras.
]

== Propriedade relevante

#theorem(name: "Corretude da dedução natural (esboço)", id: "thm-corretude-deducao-natural")[
  Se cada regra de inferência do sistema *preserva verdade* (isto é: sempre que as premissas da regra são verdadeiras em uma estrutura $cal(M)$, a conclusão também é verdadeira em $cal(M)$), então o sistema como um todo é correto.
]

#proof[
  Por indução no comprimento da derivação: o caso base (premissas de $Gamma$ e axiomas) é trivialmente verdadeiro em qualquer modelo de $Gamma$ (premissas) ou em todo modelo (axiomas, se logicamente válidos por construção). O passo indutivo segue diretamente da hipótese de que cada regra preserva verdade -- se todas as fórmulas usadas até um passo já são verdadeiras em um dado modelo de $Gamma$, a nova fórmula obtida pela regra também é. Como isso vale para *qualquer* modelo de $Gamma$, conclui-se $Gamma models phi$.
]

== Exemplo resolvido

#example(name: "Por que Modus Ponens preserva verdade", id: "ex-modus-ponens-preserva-verdade")[
  A regra Modus Ponens (de $alpha$ e $alpha->beta$, derive $beta$) preserva verdade: se em uma estrutura $cal(M)$ tanto $alpha$ quanto $alpha->beta$ são verdadeiras, então, pela tabela-verdade de $->$ (5.4), $beta$ *precisa* ser verdadeira nessa estrutura (a única forma de $alpha->beta$ ser verdadeira com $alpha$ verdadeira é $beta$ também ser verdadeira). Se o sistema dedutivo só usa regras com essa propriedade, ele é correto por indução (teorema desta seção).
]

== Atenção -- pegadinhas comuns

#remark(name: "Corretude vs. Completude -- a comparação mais cobrada da disciplina")[
  - *Corretude*: "tudo que é provável é verdadeiro" -- $tack.r phi arrow.r.double models phi$. Protege contra provar coisas falsas.
  - *Completude* (5.7): "tudo que é verdadeiro é provável" -- $models phi arrow.r.double tack.r phi$. Protege contra a existência de verdades que o sistema é incapaz de provar.
  Um sistema pode, em princípio, ter uma propriedade sem a outra: um sistema *trivial* (sem nenhuma regra de inferência) é vacuamente correto (nunca prova nada falso, porque nunca prova nada), mas está longe de ser completo. Um sistema com uma regra "inválida" adicionada seria incorreto, mesmo que ainda pudesse provar tudo que é verdadeiro.
]

#remark(name: "Corretude é a propriedade \"mais fácil\" e mais fundamental de se exigir")[
  Praticamente todo sistema dedutivo *usado na prática* é projetado para ser correto por construção (cada regra é verificada uma a uma) -- completude é o resultado mais difícil e surpreendente (5.7), não algo garantido automaticamente.
]

== Questões estilo POSCOMP

*Questão 1.* Um sistema dedutivo é dito correto (sound) quando:
- a) Toda fórmula verdadeira é derivável no sistema.
- b) Toda fórmula derivável no sistema é semanticamente verdadeira (em todo modelo das premissas).
- c) O sistema é capaz de decidir qualquer fórmula em tempo finito.
- d) O sistema não possui nenhum axioma.
- e) $Gamma$ é sempre finito.

*Questão 2.* Um sistema dedutivo sem nenhuma regra de inferência (que nunca deriva nada além dos próprios axiomas triviais) é:
- a) Necessariamente incorreto.
- b) Vacuamente correto, mas não necessariamente completo.
- c) Necessariamente completo.
- d) Indecidível por definição.
- e) Equivalente à lógica de predicados.

*Questão 3.* A propriedade que garante que a regra Modus Ponens não pode ser usada para provar uma fórmula falsa a partir de premissas verdadeiras é diretamente relacionada a:
- a) Completude.
- b) Compacidade.
- c) Corretude.
- d) Decidibilidade.
- e) Löwenheim-Skolem.

== Gabarito comentado

1. *(b)* -- definição direta de corretude: $tack.r arrow.r.double models$.
2. *(b)* -- sem regras de inferência, nunca se deriva algo falso (correto vacuamente), mas certamente não se deriva tudo que é verdadeiro (incompleto).
3. *(c)* -- preservação de verdade pelas regras de inferência é exatamente o que fundamenta a corretude do sistema.

== Referências

- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 2 (Teorema da corretude).
- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 2.
