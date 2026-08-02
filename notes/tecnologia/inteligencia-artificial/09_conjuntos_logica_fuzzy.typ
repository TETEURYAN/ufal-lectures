#import "@preview/mousse-notes:1.1.0": *

= 22.13 --- Conjuntos e Lógica Fuzzy

== Introdução

Lógica Fuzzy (Lógica Matemática, 5.12) já introduziu a ideia de graus de verdade contínuos no intervalo $[0,1]$. Aqui o foco é a estrutura matemática que sustenta essa lógica: *conjuntos fuzzy*, sua função de pertinência e suas operações -- e a aplicação prática mais comum: controle fuzzy.

== Definições formais

#definition(name: "Conjunto Fuzzy", id: "def-conjunto-fuzzy")[
  Generaliza um conjunto clássico: em vez de uma função de pertinência binária ($mu_A (x) in {0,1}$: $x$ pertence ou não a $A$), um conjunto fuzzy $A$ tem uma *função de pertinência* $mu_A: X -> [0,1]$, indicando o *grau* com que $x$ pertence a $A$. Um conjunto clássico é o caso particular em que $mu_A$ só assume os valores extremos $0$ ou $1$.
]

#definition(name: "Operações entre conjuntos fuzzy", id: "def-operacoes-conjuntos-fuzzy")[
  Generalizando as operações clássicas (Zadeh, 1965):
  - *União*: $mu_(A union B) (x) = max(mu_A (x), mu_B (x))$.
  - *Interseção*: $mu_(A inter B) (x) = min(mu_A (x), mu_B (x))$.
  - *Complemento*: $mu_(A^c) (x) = 1 - mu_A (x)$.
  Diferente dos conjuntos clássicos, em geral $mu_A (x) + mu_(A^c)(x)$ pode ser tratado como sempre somando 1 nessa definição padrão, mas $A inter A^c$ *não* é necessariamente vazio ($min(mu_A (x), 1-mu_A (x))$ só é zero quando $mu_A (x) in {0,1}$) -- reflexo direto da rejeição do princípio do terceiro excluído já visto na lógica fuzzy (5.12).
]

== Exemplo resolvido

#example(name: "Conjunto fuzzy \"temperatura quente\"", id: "ex-conjunto-fuzzy-temperatura")[
  Seja $A$ = "temperatura quente", com função de pertinência (simplificada): $mu_A (20°C) = 0$, $mu_A (25°C) = 0.3$, $mu_A (30°C) = 0.7$, $mu_A (35°C) = 1.0$. Seja $B$ = "temperatura agradável", com $mu_B (20°C)=0.6$, $mu_B (25°C)=1.0$, $mu_B (30°C)=0.4$, $mu_B (35°C)=0$.

  Em $25°C$: $mu_(A union B)(25) = max(0.3, 1.0) = 1.0$ (bem "quente ou agradável"); $mu_(A inter B)(25) = min(0.3,1.0) = 0.3$ (pouco "quente e agradável" simultaneamente). Um *sistema de controle fuzzy* (ex.: ar-condicionado) usaria regras como "SE temperatura é quente ENTÃO potência de refrigeração é alta", combinando graus de pertinência em vez de decisões binárias abruptas.
]

== Atenção -- pegadinhas comuns

#remark(name: "Fuzzy não modela incerteza probabilística, modela vagueza (revisão)")[
  Como já destacado em Lógica Matemática (5.12): $mu_A (x) = 0.7$ não significa "70% de chance de $x$ pertencer a $A$" -- significa que $x$ pertence a $A$ *em grau* 0.7, uma questão de fronteira vaga do conceito ("quente" não tem um limiar binário natural), não de desconhecimento sobre um fato determinado.
]

#remark(name: "Interseção de um conjunto fuzzy com seu complemento pode não ser vazia")[
  Ao contrário da teoria clássica de conjuntos, $A inter A^c$ em lógica fuzzy só é vazio nos pontos onde $mu_A(x) in {0,1}$ -- em qualquer ponto com pertinência intermediária, há sobreposição não nula entre um conjunto e seu complemento, uma consequência direta e frequentemente cobrada da rejeição do terceiro excluído.
]

== Questões estilo POSCOMP

*Questão 1.* A função de pertinência de um conjunto fuzzy assume valores em:
- a) $\{0, 1\}$ apenas.
- b) O intervalo $[0,1]$.
- c) Números inteiros positivos.
- d) $\{-1, 0, 1\}$.
- e) Qualquer número real, sem limite.

*Questão 2.* Considerando $mu_A (x) = 0.6$ e $mu_B (x) = 0.9$ para um mesmo $x$, o valor de $mu_(A inter B)(x)$ segundo a definição padrão de Zadeh é:
- a) $1.5$.
- b) $0.9$.
- c) $0.6$.
- d) $0.54$.
- e) $0$.

*Questão 3.* Sobre conjuntos fuzzy, é correto afirmar que:
- a) $A inter A^c$ é sempre o conjunto vazio, como na teoria clássica.
- b) A função de pertinência é sempre binária.
- c) $A inter A^c$ pode ser não vazio, para pontos com pertinência intermediária.
- d) O complemento de um conjunto fuzzy não pode ser calculado.
- e) Conjuntos fuzzy são um caso particular de conjuntos clássicos, não o contrário.

== Gabarito comentado

1. *(b)* -- definição direta de função de pertinência fuzzy.
2. *(c)* -- interseção fuzzy usa o mínimo: $min(0.6, 0.9) = 0.6$.
3. *(c)* -- é exatamente a observação desta seção, decorrente da rejeição do terceiro excluído em lógica fuzzy.

== Referências

- ZADEH, L. *Fuzzy Sets* (1965) -- artigo original da teoria de conjuntos fuzzy.
- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. sobre incerteza (menção a lógica fuzzy).
- Lógica Matemática (5.12, Lógicas não-clássicas) -- fundamentos da lógica fuzzy usados nesta seção.
