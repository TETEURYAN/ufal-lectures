#import "@preview/mousse-notes:1.1.0": *

= Linguagens Regulares e a Hierarquia de Chomsky

// ═══════════════════════════════════════════════════════════════
// PARTE I — HIERARQUIA DE CHOMSKY
// ═══════════════════════════════════════════════════════════════

== A Hierarquia de Chomsky

Em 1956, Noam Chomsky propôs uma classificação sistemática das gramáticas formais
que ficou conhecida como *hierarquia de Chomsky*. Ela estratifica as linguagens
em quatro classes aninhadas — cada classe está contida na seguinte — ordenadas
pela expressividade das gramáticas que as geram e pelo poder computacional
necessário para reconhecê-las.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 9pt,
    align: (center, left, left, left),
    table.header(
      [*Tipo*], [*Gramática*], [*Autômato reconhecedor*], [*Restrição da produção*],
    ),
    [3], [Regular],                  [Autômato finito],              [$A -> a B$ ou $A -> a$],
    [2], [Livre de contexto],        [Autômato de pilha],            [$A -> alpha$],
    [1], [Sensível ao contexto],     [Autômato linearmente limitado],[$ alpha A beta -> alpha gamma beta$],
    [0], [Irrestrita (recursivam.)], [Máquina de Turing],            [sem restrição],
  ),
  caption: [Resumo da hierarquia de Chomsky. A contagem parte do tipo mais
            restrito (3) para o mais geral (0).],
)

A inclusão estrita $cal(L)_3 subset.neq cal(L)_2 subset.neq cal(L)_1 subset.neq cal(L)_0$
é um resultado clássico: existem linguagens em cada nível que não pertencem ao
nível inferior.

=== Gramáticas Formais — Definição Geral

Antes de detalhar cada tipo, precisamos da definição comum a todas as classes.

#definition[
  Uma *gramática formal* é uma quádrupla $G = (V, Sigma, R, S)$ onde:
  - $V$ é um conjunto finito de *variáveis* (ou não-terminais);
  - $Sigma$ é um conjunto finito de *terminais*, com $V sect Sigma = emptyset$;
  - $R subset.eq (V union Sigma)^+ times (V union Sigma)^*$ é um conjunto finito de *regras de produção*, escritas $alpha -> beta$;
  - $S in V$ é a *variável inicial*.

  A linguagem *gerada* por $G$ é $L(G) = { w in Sigma^* mid(|) S arrow.double.long^* w }$,
  onde $arrow.double.long^*$ denota o fecho reflexivo-transitivo da relação de
  derivação imediata $arrow.double.long$.
]

=== Tipo 0 — Gramáticas Irrestritas

Não há restrição alguma sobre as produções: $alpha -> beta$ com
$alpha in (V union Sigma)^+$ e $beta in (V union Sigma)^*$. A classe gerada
é exatamente a das *linguagens recursivamente enumeráveis*, reconhecidas por
Máquinas de Turing (MT) não necessariamente paradas.

#example[
  A linguagem $L = { a^n b^n c^n mid(|) n >= 1 }$ é recursivamente enumerável
  (na verdade, decidível) e pode ser gerada por uma gramática irrestrita. Ela
  *não* é livre de contexto — um resultado provado pelo lema do bombeamento
  para LLC, que veremos adiante.
]

=== Tipo 1 — Gramáticas Sensíveis ao Contexto

#definition[
  Uma gramática $G = (V, Sigma, R, S)$ é *sensível ao contexto* (CSG) se toda
  produção tem a forma
  $ alpha_1 A alpha_2 -> alpha_1 gamma alpha_2 $
  com $A in V$, $alpha_1, alpha_2, gamma in (V union Sigma)^*$ e
  $|gamma| >= 1$. A única exceção permitida é $S -> epsilon$ desde que $S$
  não apareça no lado direito de nenhuma produção.
]

A condição $|alpha_1 A alpha_2| <= |alpha_1 gamma alpha_2|$ (i.e., a forma
sentencial nunca encolhe) explica o nome: a variável $A$ é substituída por
$gamma$ apenas quando cercada pelo *contexto* $alpha_1$ e $alpha_2$.

#example[
  Considere $L = { a^n b^n c^n mid(|) n >= 1 }$ com a gramática:

  $ S &-> a B C \
    S &-> a S B C \
    C B &-> B C \
    a B &-> a b \
    b B &-> b b \
    b C &-> b c \
    c C &-> c c $

  A produção $C B -> B C$ é sensível ao contexto (dois símbolos do lado
  esquerdo e dois do lado direito, sem encolhimento). Ela "comuta" $C$ e $B$
  para organizar os blocos na ordem correta.
]

=== Tipo 2 — Gramáticas Livres de Contexto

#definition[
  Uma gramática $G$ é *livre de contexto* (CFG) se toda produção tem a forma
  $ A -> alpha $
  com $A in V$ e $alpha in (V union Sigma)^*$. A variável $A$ pode ser
  substituída por $alpha$ *independentemente* do contexto em que aparece.
]

CFGs são o formalismo central de linguagens de programação (via forma normal de
Backus-Naur) e de parsers. O reconhecimento é decidível em tempo $O(n^3)$ pelo
algoritmo CYK.

#example[
  A linguagem $L = { a^n b^n mid(|) n >= 0 }$ é livre de contexto, gerada por:
  $ S &-> epsilon \
    S &-> a S b $

  Derivação de $a^3 b^3$:
  $ S arrow.double a S b arrow.double a a S b b arrow.double a a a S b b b arrow.double a a a b b b $

  Note que $a^n b^n c^n$ *não* é LLC — a gramática teria que "lembrar" dois
  contadores simultaneamente, algo que uma pilha não consegue.
]

#example[
  Expressões aritméticas com parênteses são LLC. A gramática:
  $ E &-> E + T mid(|) T \
    T &-> T * F mid(|) F \
    F &-> ( E ) mid(|) "id" $
  captura precedência e associatividade à esquerda de $+$ e $*$.
]

=== Tipo 3 — Gramáticas Regulares

#definition[
  Uma gramática $G$ é *regular* (à direita) se toda produção tem a forma
  $ A -> a B quad "ou" quad A -> a quad "ou" quad A -> epsilon $
  com $A, B in V$ e $a in Sigma$. (Existe a variante à esquerda:
  $A -> B a$ ou $A -> a$; ambas geram a mesma classe de linguagens.)
]

Gramáticas regulares são o nível mais restrito da hierarquia: correspondem
exatamente às linguagens reconhecidas por autômatos finitos e descritas por
expressões regulares.

#example[
  A linguagem $L = { a^n b mid(|) n >= 0 } = {b, a b, a a b, ...}$ é gerada por:
  $ S &-> a S \
    S &-> b $
  Aqui cada produção introduz no máximo um terminal *e* passa para outra
  variável à direita — padrão típico de gramáticas regulares.
]

#example[
  A linguagem de identificadores em C — começam com letra ou `_`, seguidos de
  letras, dígitos ou `_` — é regular:
  $ S   &-> "letter" A mid(|) "_" A \
    A   &-> "letter" A mid(|) "digit" A mid(|) "_" A mid(|) epsilon $
  onde `letter` e `digit` são abreviações para as respectivas classes de terminais.
]

// ═══════════════════════════════════════════════════════════════
// PARTE II — O FORMALISMO DAS LINGUAGENS REGULARES
// ═══════════════════════════════════════════════════════════════

== O Formalismo das Linguagens Regulares

Uma das contribuições mais elegantes da teoria da computação é a *equivalência*
entre três modelos aparentemente diferentes para descrever linguagens regulares:
autômatos finitos, expressões regulares e gramáticas regulares. Demonstrar que
eles reconhecem exatamente a mesma classe de linguagens é o teorema de
Kleene (1956).

=== Autômatos Finitos

==== Autômato Finito Determinístico (AFD)

#definition[
  Um *autômato finito determinístico* (AFD) é uma quíntupla
  $M = (Q, Sigma, delta, q_0, F)$ onde:
  - $Q$ é um conjunto finito de *estados*;
  - $Sigma$ é o *alfabeto* de entrada;
  - $delta : Q times Sigma -> Q$ é a *função de transição* (total);
  - $q_0 in Q$ é o *estado inicial*;
  - $F subset.eq Q$ é o conjunto de *estados de aceitação*.

  $M$ *aceita* $w = a_1 a_2 dots a_n in Sigma^*$ se existe uma sequência de
  estados $r_0, r_1, dots, r_n$ tal que $r_0 = q_0$,
  $delta(r_{i-1}, a_i) = r_i$ para todo $i$, e $r_n in F$.

  A *linguagem reconhecida* por $M$ é $L(M) = { w in Sigma^* mid(|) M "aceita" w }$.
]

A condição de determinismo — $delta$ é uma função total, sem ambiguidade —
simplifica a implementação: basta um laço lendo símbolo por símbolo.

#example[
  O AFD abaixo reconhece $L = { w in {0,1}^* mid(|) w "contém" 01 "como substring" }$:

  #table(
    columns: (auto, auto, auto),
    inset: 8pt,
    align: center,
    table.header([$delta$], [*0*], [*1*]),
    [$q_0$ (inicial)],   [$q_1$], [$q_0$],
    [$q_1$],             [$q_1$], [$q_2$],
    [$q_2$ (aceitação)], [$q_2$], [$q_2$],
  )

  $q_0$: ainda não lemos nenhum `0` relevante. $q_1$: acabamos de ler um `0`
  (potencial início de `01`). $q_2$: já lemos `01`, aceitamos tudo daqui em diante.
]

==== Autômato Finito Não-Determinístico (AFN)

#definition[
  Um *AFN* é uma quíntupla $M = (Q, Sigma, delta, q_0, F)$ onde
  $delta : Q times (Sigma union {epsilon}) -> cal(P)(Q)$ mapeia cada par
  (estado, símbolo ou $epsilon$) para um *conjunto* de estados destino.

  $M$ aceita $w$ se *existe* algum caminho de computação que leva de $q_0$ a
  um estado em $F$ ao consumir $w$.
]

#theorem[
  Para todo AFN $M$ existe um AFD $M'$ tal que $L(M) = L(M')$.
]

A prova é construtiva via *construção de subconjuntos*: os estados do AFD
são subconjuntos dos estados do AFN, e $delta'(S, a) = union.big_{q in S} delta(q, a)$.
No pior caso, um AFN com $n$ estados produz um AFD com $2^n$ estados — porém
esse custo é frequentemente bem menor na prática.

#example[
  O AFN de dois estados abaixo reconhece $L = { w mid(|) w "termina em" 1 }$
  sobre $Sigma = {0, 1}$:

  #table(
    columns: (auto, auto, auto),
    inset: 8pt,
    align: center,
    table.header([$delta$], [*0*], [*1*]),
    [$q_0$ (inicial)],   [{$q_0$}],          [{$q_0$, $q_1$}],
    [$q_1$ (aceitação)], [$emptyset$],        [$emptyset$],
  )

  No estado $q_0$, ao ler `1`, o autômato pode optar por ir a $q_1$ (apostando
  que este é o último símbolo) ou permanecer em $q_0$. O não-determinismo "adivinha"
  corretamente.
]

==== Propriedades de Fechamento

As linguagens regulares são fechadas sob as seguintes operações, o que facilita
a construção de autômatos para linguagens compostas:

#table(
  columns: (auto, auto),
  inset: 8pt,
  align: (left, left),
  table.header([*Operação*], [*Resultado*]),
  [União $L_1 union L_2$],            [Regular],
  [Concatenação $L_1 dot L_2$],       [Regular],
  [Fecho de Kleene $L^*$],            [Regular],
  [Complemento $overline(L)$],        [Regular],
  [Interseção $L_1 sect L_2$],        [Regular],
  [Diferença $L_1 without L_2$],      [Regular],
  [Reverso $L^R$],                    [Regular],
  [Homomorfismo $h(L)$],              [Regular],
)

=== Expressões Regulares

#definition[
  Dado um alfabeto $Sigma$, as *expressões regulares* (ERs) sobre $Sigma$ e
  as linguagens que denotam são definidas recursivamente:

  - $emptyset$ é uma ER: denota a linguagem vazia $emptyset$;
  - $epsilon$ é uma ER: denota ${epsilon}$;
  - Para cada $a in Sigma$, $a$ é uma ER: denota ${a}$;
  - Se $r$ e $s$ são ERs, então $(r | s)$, $(r dot s)$ e $r^*$ são ERs,
    denotando $L(r) union L(s)$, $L(r) L(s)$ e $L(r)^*$, respectivamente.
]

A *precedência* (decrescente): fecho $*$ $>$ concatenação $>$ união $|$.
Abreviações comuns: $r^+ = r r^*$, $r? = (r | epsilon)$,
$[a\-z] = a | b | dots | z$.

#example[
  Alguns exemplos comentados de expressões regulares sobre $Sigma = {a, b}$:

  - $a^* b^+$: zero ou mais `a`'s seguidos de um ou mais `b`'s.
    $L = {b, a b, a b b, a a b, a a b b, ...}$

  - $(a b)^*$: concatenações pares alternando `a` e `b`.
    $L = {epsilon, a b, a b a b, a b a b a b, ...}$

  - $(a | b)^* a (a | b)^*$: palavras que *contêm* ao menos um `a`.
    Equivale a $Sigma^* a Sigma^*$.

  - $(b | a b)^* (epsilon | a)$: linguagem das palavras que não têm dois `a`'s
    consecutivos. (Tente verificar que nenhuma derivação produz `aa`.)
]

#example[
  *Aplicação prática — validação de e-mail simplificada:*

  $ "user" = [a\-z A\-Z 0\-9 ._+-]^+ \
    "domain" = [a\-z A\-Z 0\-9 -]^+ \
    "tld" = . [a\-z A\-Z]{2,} \
    "email" = "user" @ "domain" ("." "domain")^* "tld" $

  Ferramentas como lexers (`lex`/`flex`) compilam ERs diretamente em AFDs,
  tornando o reconhecimento linear no tamanho da entrada.
]

==== Teorema de Kleene

#theorem[
  *(Kleene, 1956)* As três classes seguintes coincidem:
  + As linguagens descritas por expressões regulares;
  + As linguagens reconhecidas por algum autômato finito (determinístico ou não);
  + As linguagens geradas por alguma gramática regular.

  Dizemos que todas essas são *linguagens regulares*.
]

A prova é circular entre as três descrições:

- *ER $->$ AFN*: indução estrutural na ER; cada caso base ou operador é
  transformado em um AFN pequeno.
- *AFN $->$ AFD*: construção de subconjuntos.
- *AFD $->$ ER*: eliminação de estados (equações de Arden) ou construção de
  GNFA (autômato com ERs nos rótulos das transições).
- *Gramática regular $->$ AFN* e *AFN $->$ gramática regular*: correspondência
  direta: estados viram variáveis, transições viram produções.

=== Gramáticas Regulares Revisitadas

A equivalência com AFDs pode ser tornada explícita pela seguinte correspondência:

#table(
  columns: (auto, auto),
  inset: 8pt,
  align: (left, left),
  table.header([*AFD*], [*Gramática Regular Equivalente*]),
  [Estado $q_i$],                             [Variável $A_i$],
  [$q_0$ (estado inicial)],                   [$S = A_0$ (variável inicial)],
  [$delta(q_i, a) = q_j$],                    [Produção $A_i -> a A_j$],
  [$delta(q_i, a) = q_j$ e $q_j in F$],      [Também adicionar $A_i -> a$],
  [$q_i in F$ e existe transição de $q_i$],   [Também adicionar $A_i -> epsilon$],
)

#example[
  Retomando o AFD que reconhece palavras sobre ${a,b}$ terminadas em $b$:

  #table(
    columns: (auto, auto, auto),
    inset: 8pt,
    align: center,
    table.header([$delta$], [*a*], [*b*]),
    [$q_0$ (inicial)],   [$q_0$], [$q_1$],
    [$q_1$ (aceitação)], [$q_0$], [$q_1$],
  )

  Gramática regular equivalente (com $S = A_0$, aceitação em $A_1$):
  $ A_0 &-> a A_0 mid(|) b A_1 \
    A_1 &-> a A_0 mid(|) b A_1 mid(|) epsilon $

  A produção $A_1 -> epsilon$ captura o fato de $q_1$ ser de aceitação.
  Simplificando: $A_0 -> a A_0 | b A_1$ e $A_1 -> a A_0 | b A_1 | epsilon$
  gera exatamente $(a | b)^* b$.
]

// ═══════════════════════════════════════════════════════════════
// PARTE III — O LEMA DO BOMBEAMENTO
// ═══════════════════════════════════════════════════════════════

== O Lema do Bombeamento para Linguagens Regulares

Até aqui aprendemos a *reconhecer* e *construir* linguagens regulares. Uma
questão igualmente importante é: como provar que uma linguagem *não* é regular?

As ferramentas diretas — tentar construir um AFD e falhar, ou tentar construir
uma ER sem sucesso — não constituem prova formal de impossibilidade. O *lema
do bombeamento* fornece uma condição necessária para regularidade, e sua negação
é a ferramenta padrão para provar não-regularidade.

=== O Enunciado

#theorem[
  *(Lema do Bombeamento*)
  Seja $L$ uma linguagem regular. Então existe um inteiro $p >= 1$ (chamado
  *comprimento do bombeamento*) tal que toda palavra $w in L$ com $|w| >= p$
  pode ser decomposta em $w = x y z$ satisfazendo:

  + $|y| >= 1$ (o segmento $y$ é não-vazio);
  + $|x y| <= p$ (os segmentos $x$ e $y$ juntos têm comprimento no máximo $p$);
  + Para todo $i >= 0$, a palavra $x y^i z in L$.
]

*Intuição:* Se $L$ é regular, existe um AFD $M$ com $p$ estados que a reconhece.
Ao processar uma palavra $w$ com $|w| >= p$, o autômato visita pelo menos $p+1$
estados, e pelo *princípio da casa dos pombos* algum estado $q$ é visitado duas
vezes. A porção de $w$ lida entre a primeira e a segunda visita a $q$ é $y$.
Como $q$ é atingido repetindo $y$ qualquer número de vezes ($y^i$), o autômato
aceita $x y^i z$ para todo $i >= 0$.

=== Usando o Lema para Provar Não-Regularidade

O lema do bombeamento é usado de forma contrapositiva: se uma linguagem *viola*
a condição, ela não pode ser regular. A estrutura da prova é um *jogo adversarial*:

#table(
  columns: (auto, auto),
  inset: 8pt,
  align: (left, left),
  table.header([*Você (provador)*], [*Adversário*]),
  [Escolhe $w in L$ com $|w| >= p$],      [Fixa $p$ (tamanho do bombeamento)],
  [Analisa toda decomposição $w = x y z$ \ satisfazendo (1) e (2)],
                                           [Escolhe a decomposição $x, y, z$],
  [Exibe $i$ tal que $x y^i z in.not L$],  [],
)

Se você sempre consegue exibir tal $i$, independentemente de como o adversário
escolhe $p$ e a decomposição, então $L$ não é regular.

=== Exemplos Detalhados

==== Exemplo 1 — $L = {a^n b^n mid(|) n >= 0}$

#proof[
  Suponha, por contradição, que $L$ seja regular. Seja $p$ o comprimento do
  bombeamento. Escolha $w = a^p b^p in L$ (com $|w| = 2p >= p$).

  Qualquer decomposição $w = x y z$ com $|x y| <= p$ e $|y| >= 1$ satisfaz:
  $x = a^j$, $y = a^k$, $z = a^{p - j - k} b^p$ para algum $j >= 0$ e
  $k >= 1$ (pois $|x y| <= p$ força $y$ a estar inteiramente na parte de $a$'s).

  Tomando $i = 0$: $x y^0 z = x z = a^{p-k} b^p$. Como $k >= 1$, temos
  $p - k < p$, logo $x z$ tem menos $a$'s do que $b$'s: $x z in.not L$.
  Contradição. Portanto $L$ não é regular. $square$
]

==== Exemplo 2 — $L = {a^(n^2) mid(|) n >= 0} = {epsilon, a, a a a a, a^9, a^{16}, ...}$

#proof[
  Suponha que $L$ seja regular com comprimento de bombeamento $p$. Escolha
  $n$ tal que $n^2 >= p$ e tome $w = a^{n^2}$.

  Qualquer decomposição satisfatória tem $y = a^k$ com $1 <= k <= p$.
  Bombeando uma vez: $x y^2 z = a^{n^2 + k}$.

  Para que $a^{n^2 + k} in L$, precisaríamos $n^2 + k = m^2$ para algum
  inteiro $m$. O próximo quadrado após $n^2$ é $(n+1)^2 = n^2 + 2n + 1$.
  Como $k <= p <= n^2 < 2n + 1$ (para $n$ suficientemente grande),
  temos $n^2 < n^2 + k < (n+1)^2$: não é um quadrado perfeito.
  Portanto $x y^2 z in.not L$. Contradição. $square$
]
==== Exemplo 3 — $L = {w w mid(|) w in {a,b}^*}$ (palavras repetidas)

#proof[
  Suponha que $L$ seja regular com comprimento de bombeamento $p$. Tome
  $w = a^p b a^p b in L$ (cada metade é $a^p b$, com $|w| = 2p + 2 >= p$).

  Por $|x y| <= p$, ambos $x$ e $y$ estão na primeira metade de $a$'s.
  Escreva $x = a^j$, $y = a^k$ ($k >= 1$), $z = a^{p-j-k} b a^p b$.

  Bombeando $i = 0$: $x z = a^{p - k} b a^p b$.
  Para esta palavra estar em $L$, precisaríamos $a^{p-k} b = a^p b$, logo
  $p - k = p$, i.e., $k = 0$. Contradição com $k >= 1$. $square$
]

==== Não-Exemplo — Cuidado ao usar o lema

O lema do bombeamento é uma *condição necessária* mas não suficiente:
existem linguagens não-regulares em que toda palavra longa pode ser bombeada.
O lema apenas permite provar não-regularidade; para provar regularidade
é preciso exibir explicitamente um AFD, ER ou gramática regular.

=== Lema do Bombeamento para Linguagens Livres de Contexto

A estrutura do argumento se repete em outra forma para LLC:

#theorem[
  *(Lema do Bombeamento para LLC)* Seja $L$ uma LLC. Existe $p >= 1$ tal que toda $w in L$ com $|w| >= p$
  pode ser decomposta em $w = u v x y z$ com:
  + $|v y| >= 1$;
  + $|v x y| <= p$;
  + Para todo $i >= 0$, $u v^i x y^i z in L$.
]

O nome *bombeamento* vem de "bombear" $v$ e $y$ simultaneamente (em LLC)
ou apenas $y$ (em linguagens regulares). A aplicação é análoga: escolhe-se
$w$ e exibe-se um $i$ que quebra a condição.

#example[
  Com o lema do bombeamento para LLC é possível provar que
  $L = { a^n b^n c^n mid(|) n >= 0}$ não é livre de contexto. (Qualquer
  decomposição $u v x y z$ forçaria $v$ e $y$ a cobrir no máximo dois
  símbolos distintos, deixando o terceiro "desbalanceado" ao bombear.)
]

// ═══════════════════════════════════════════════════════════════
// RESUMO DO CAPÍTULO
// ═══════════════════════════════════════════════════════════════

== Síntese do Capítulo

Este capítulo apresentou a *hierarquia de Chomsky* e as três descrições
equivalentes das linguagens regulares.

#table(
  columns: (auto, auto),
  inset: 9pt,
  align: (left, left),
  table.header([*Conceito*], [*Ideia central*]),
  [Hierarquia de Chomsky],
    [Quatro classes aninhadas: regular $subset$ LLC $subset$ CSL $subset$ recursivam. enumerável],
  [Gramáticas regulares (Tipo 3)],
    [Produções da forma $A -> a B$ ou $A -> a$; geram exatamente as ling. regulares],
  [Gramáticas LLC (Tipo 2)],
    [Produções $A -> alpha$; reconhecidas por autômatos de pilha (CYK em $O(n^3)$)],
  [Gramáticas CSG (Tipo 1)],
    [Produções não-encolhentes; reconhecidas por autômatos linearmente limitados],
  [AFD / AFN],
    [Modelos operacionais das linguagens regulares; AFN $equiv$ AFD por subconjuntos],
  [Expressões regulares],
    [Notação algébrica; equivalente a AFDs pelo teorema de Kleene],
  [Lema do bombeamento],
    [Condição necessária de regularidade; usado na contrapositiva para provar não-regularidade],
)
