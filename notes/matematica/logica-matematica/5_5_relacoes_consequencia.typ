#import "@preview/mousse-notes:1.1.0": *

= 5.5 --- Relações de Consequência

== Introdução

Existem duas formas, aparentemente distintas, de dizer "$phi$ decorre de $Gamma$": uma sintática (existe uma derivação, 5.3) e uma semântica (é verdadeira em todo modelo). Esta subseção define ambas com precisão; a relação entre elas é o assunto de corretude (5.6) e completude (5.7).

== Definições formais

#definition(name: "Consequência semântica (⊨)", id: "def-consequencia-semantica")[
  $Gamma models phi$ ("$phi$ é consequência semântica de $Gamma$") significa: para toda estrutura $cal(M)$, se $cal(M) models psi$ para toda $psi in Gamma$ (isto é, $cal(M)$ é *modelo* de $Gamma$), então $cal(M) models phi$. Em outras palavras: não existe nenhuma estrutura que satisfaça todas as premissas de $Gamma$ e, ao mesmo tempo, torne $phi$ falsa.
]

#definition(name: "Consequência sintática (⊢)", id: "def-consequencia-sintatica")[
  $Gamma tack.r phi$ ("$phi$ é derivável a partir de $Gamma$") significa que existe uma derivação formal de $phi$ a partir das premissas de $Gamma$ em um sistema dedutivo fixado (5.3) -- uma noção puramente sintática, sem nenhuma referência a estruturas ou verdade.
]

== Exemplo resolvido

#example(name: "Verificando consequência semântica por tabela-verdade", id: "ex-consequencia-semantica-tabela")[
  Verifique se ${p -> q, p} models q$ (Modus Ponens é semanticamente válido?).

  #table(
    columns: 4,
    [*$p$*], [*$q$*], [*$p -> q$*], [*$q$* (conclusão)],
    [V], [V], [V], [V],
    [V], [F], [F], [--],
    [F], [V], [V], [V],
    [F], [F], [V], [F],
  )

  Nas linhas em que *ambas* as premissas ($p->q$ e $p$) são verdadeiras (só a primeira linha: $p$=V, $q$=V), a conclusão $q$ também é verdadeira. Não há nenhuma linha em que as premissas sejam ambas verdadeiras e $q$ seja falso -- logo ${p->q, p} models q$.
]

== Atenção -- pegadinhas comuns

#remark(name: "⊨ e ⊢ são definidos de formas completamente diferentes")[
  $Gamma models phi$ fala sobre *todas as estruturas/modelos possíveis* (uma noção infinita, semântica). $Gamma tack.r phi$ fala sobre a *existência de uma sequência finita de símbolos* seguindo regras sintáticas (uma noção sintática, mecanicamente verificável). Não é óbvio, a priori, que essas duas noções coincidam -- é exatamente isso que os teoremas de corretude (5.6, $tack.r arrow.r.double models$) e completude (5.7, $models arrow.r.double tack.r$) estabelecem, tornando-as equivalentes para lógica de primeira ordem clássica.
]

#remark(name: "Γ pode ser infinito em ambas as definições")[
  Nada nas definições de $models$ ou $tack.r$ exige que $Gamma$ seja finito -- uma derivação individual é sempre finita (sequência finita de passos), mas pode usar premissas de um $Gamma$ infinito, desde que cada premissa usada apareça em algum passo. Essa observação é a base da compacidade (5.8).
]

== Questões estilo POSCOMP

*Questão 1.* A notação $Gamma models phi$ significa que:
- a) Existe uma derivação sintática de $phi$ a partir de $Gamma$.
- b) Toda estrutura que satisfaz todas as fórmulas de $Gamma$ também satisfaz $phi$.
- c) $phi$ é uma fórmula atômica.
- d) $Gamma$ é insatisfazível.
- e) $phi$ pertence sintaticamente a $Gamma$.

*Questão 2.* A principal diferença entre $Gamma tack.r phi$ e $Gamma models phi$ é que:
- a) Não há diferença; são notações alternativas para o mesmo conceito, por definição.
- b) $tack.r$ é uma noção sintática (existência de derivação); $models$ é uma noção semântica (verdade em todo modelo).
- c) $models$ só se aplica a lógica proposicional; $tack.r$ só a lógica de primeira ordem.
- d) $tack.r$ é sempre mais fraco que $models$, para qualquer sistema dedutivo.
- e) $Gamma$ deve ser finito para $models$, mas pode ser infinito para $tack.r$.

*Questão 3.* Se ${p, p -> q} models q$, isso significa que:
- a) Existe pelo menos uma estrutura em que $p$, $p->q$ são verdadeiras e $q$ é falsa.
- b) Não existe nenhuma estrutura em que $p$ e $p->q$ sejam verdadeiras e $q$ seja falsa.
- c) $q$ é uma tautologia.
- d) $p$ e $q$ são logicamente equivalentes.
- e) $p$ é insatisfazível.

== Gabarito comentado

1. *(b)* -- definição direta de consequência semântica.
2. *(b)* -- distinção central desta seção: sintático vs. semântico.
3. *(b)* -- é exatamente a definição de $models$ aplicada a este caso (Modus Ponens é semanticamente válido, conforme o exemplo desta seção).

== Referências

- MENDELSON, E. *Introduction to Mathematical Logic*. Cap. 1--2.
- ENDERTON, H. *A Mathematical Introduction to Logic*. Cap. 1--2 (Consequência semântica e sintática).
