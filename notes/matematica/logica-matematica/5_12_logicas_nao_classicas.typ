#import "@preview/mousse-notes:1.1.0": *

= 5.12 --- Lógicas não-clássicas

== Introdução

Toda a disciplina até aqui tratou da lógica *clássica*: bivalente (todo enunciado é verdadeiro ou falso, nunca ambos ou nenhum) e com o princípio do terceiro excluído ($p or not p$ sempre tautologia). Lógicas não-clássicas relaxam essas suposições para modelar noções que a lógica clássica não captura bem -- necessidade/possibilidade, incerteza, ou racionalidade construtiva.

== Definições formais

#definition(name: "Lógica Modal", id: "def-logica-modal")[
  Estende a lógica clássica com os operadores $square$ (*necessariamente*) e $diamond$ (*possivelmente*), com $diamond phi equiv not square not phi$. Sua semântica padrão usa *estruturas de Kripke* $cal(M) = (W, R, V)$: um conjunto de *mundos possíveis* $W$, uma *relação de acessibilidade* $R subset.eq W times W$ entre mundos, e uma valoração $V$ de proposições em cada mundo. $square phi$ é verdadeira em um mundo $w$ se $phi$ é verdadeira em *todo* mundo acessível a partir de $w$ via $R$; $diamond phi$, se $phi$ é verdadeira em *algum* mundo acessível.
]

#definition(name: "Lógica Intuicionista", id: "def-logica-intuicionista")[
  Rejeita o princípio do terceiro excluído ($p or not p$ *não* é um teorema em geral) e a eliminação da dupla negação ($not not p -> p$ não vale em geral). Uma prova de $p or q$ exige exibir uma prova de $p$ ou uma prova de $q$ especificamente -- não basta provar que "não é o caso que ambos sejam falsos". Fundamenta a matemática *construtiva*, onde provar a existência de um objeto exige (em princípio) um método para construí-lo.
]

#definition(name: "Lógica Fuzzy (nebulosa)", id: "def-logica-fuzzy")[
  Substitui os dois valores-verdade clássicos $\{V, F\}$ por um *grau de verdade* contínuo no intervalo $[0,1]$, permitindo representar afirmações vagas ("a água está quente", em graus) em vez de estritamente binárias. Conectivos são redefinidos com funções sobre $[0,1]$ (ex.: $not$ como $1-x$, $and$ como mínimo). Amplamente usada em sistemas de controle e Inteligência Artificial -- tratada com mais aplicação em Inteligência Artificial, subtópico 22.13 (Lógica Fuzzy), que ainda não tem material escrito neste repositório no momento desta seção.
]

== Estrutura visual: modelo de Kripke

#figure(
  image("figures/kripke-structure.svg", width: 45%),
  caption: [Estrutura de Kripke com três mundos possíveis ($S_1, S_2, S_3$) e a relação de acessibilidade entre eles, usada para dar semântica aos operadores $square$/$diamond$ da lógica modal. Fonte: Wikimedia Commons, CC BY 3.0.],
)

== Exemplo resolvido

#example(name: "Onde cada lógica não-clássica diverge da clássica", id: "ex-divergencia-nao-classica")[
  - *Modal*: a fórmula $square p -> p$ ("se $p$ é necessário, então $p$") é válida apenas em estruturas de Kripke *reflexivas* (todo mundo acessa a si mesmo) -- não é uma verdade lógica incondicional como as tautologias clássicas, mas depende de propriedades da relação $R$.
  - *Intuicionista*: "existe um número irracional $x$ tal que $x^x$ é racional" tem uma prova clássica não-construtiva (por casos, sem exibir o $x$) -- uma prova intuicionista exigiria exibir esse $x$ explicitamente.
  - *Fuzzy*: "João é alto" pode ter grau de verdade $0.7$ (nem totalmente falso, nem totalmente verdadeiro), algo sem representação direta na lógica clássica bivalente.
]

== Atenção -- pegadinhas comuns

#remark(name: "Lógica não-clássica não significa \"lógica errada\"")[
  Cada lógica não-clássica é formalmente rigorosa dentro de seu próprio sistema de axiomas/regras -- a escolha entre clássica, modal, intuicionista ou fuzzy depende do fenômeno que se quer modelar (verdade atemporal, necessidade, construtividade, vagueza), não de uma ser "mais correta" que outra em abstrato.
]

#remark(name: "Fuzzy não é o mesmo que probabilidade")[
  Um grau de verdade fuzzy $0.7$ para "João é alto" não significa "70% de chance de João ser alto" (uma afirmação probabilística sobre incerteza) -- significa que João é considerado alto *em grau* 0.7, uma questão de vagueza semântica, não de desconhecimento sobre um fato binário. Os dois conceitos são frequentemente confundidos em prova.
]

== Questões estilo POSCOMP

*Questão 1.* Na semântica de Kripke para lógica modal, a fórmula $square phi$ é verdadeira em um mundo $w$ quando:
- a) $phi$ é verdadeira em pelo menos um mundo acessível a partir de $w$.
- b) $phi$ é verdadeira em todo mundo acessível a partir de $w$.
- c) $phi$ é uma tautologia clássica.
- d) $w$ não tem nenhum mundo acessível.
- e) $phi$ é falsa em todo mundo do modelo.

*Questão 2.* A principal característica que a lógica intuicionista rejeita, em relação à lógica clássica, é:
- a) A regra de Modus Ponens.
- b) O princípio do terceiro excluído ($p or not p$ como teorema geral).
- c) A existência de conectivos lógicos.
- d) A noção de prova.
- e) A quantificação universal.

*Questão 3.* Um grau de verdade fuzzy igual a $0.7$ para uma afirmação representa:
- a) Uma probabilidade de 70% de a afirmação ser verdadeira no sentido clássico.
- b) Um grau de pertinência/verdade parcial, não uma medida de incerteza probabilística.
- c) Um erro de medição.
- d) O mesmo que um valor-verdade clássico "verdadeiro".
- e) Uma contradição lógica.

== Gabarito comentado

1. *(b)* -- definição direta de $square$ na semântica de Kripke, conforme esta seção.
2. *(b)* -- rejeição do terceiro excluído é a marca definidora da lógica intuicionista.
3. *(b)* -- grau de verdade fuzzy é sobre vagueza semântica, não sobre probabilidade/incerteza -- distinção explicitada na observação desta seção.

== Referências

- CHELLAS, B. *Modal Logic: An Introduction*. Cap. 1--3 (Semântica de Kripke).
- VAN DALEN, D. *Logic and Structure*. Cap. sobre lógica intuicionista.
- ZADEH, L. *Fuzzy Sets* (1965) -- artigo original da lógica/teoria fuzzy.
