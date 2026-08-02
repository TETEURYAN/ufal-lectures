#import "@preview/mousse-notes:1.1.0": *

= 22.10 --- Raciocínio Não-Monotônico

== Introdução

A lógica clássica (Lógica Matemática, 5.1--5.7) é *monotônica*: adicionar novas premissas nunca invalida conclusões já derivadas ($Gamma tack.r phi arrow.r.double Gamma union {psi} tack.r phi$, para qualquer $psi$ nova). Mas o raciocínio do senso comum não funciona assim -- aprender um novo fato frequentemente nos faz *retirar* uma conclusão anterior. Formalizar esse comportamento é o objetivo do raciocínio não-monotônico.

== Definições formais

#definition(name: "Raciocínio monotônico vs. não-monotônico", id: "def-raciocinio-nao-monotonico")[
  Um sistema de inferência é *monotônico* se o conjunto de conclusões deriváveis só pode *crescer* (nunca encolher) à medida que se adicionam novas premissas. É *não-monotônico* se novas informações podem tornar uma conclusão previamente válida *inválida* -- modelando raciocínio sob suposições padrão (defaults) que podem ser refutadas por exceções.
]

#definition(name: "Suposição de mundo fechado (CWA) e regras default", id: "def-cwa-regras-default")[
  - *Suposição de mundo fechado (Closed-World Assumption)*: tudo que não é explicitamente conhecido como verdadeiro é assumido *falso* -- uma forma simples e comum de não-monotonicidade (aprender um novo fato pode reverter essa suposição).
  - *Regra default* (lógica de default, Reiter 1980): regra da forma "se $A$ é verdadeiro, e é *consistente* assumir $B$, então conclua $B$" -- permite conclusões *provisórias*, sujeitas a revisão caso surja informação que torne $B$ inconsistente.
]

== Exemplo resolvido

#example(name: "O exemplo clássico do pinguim", id: "ex-tweety-pinguim")[
  Base de conhecimento com uma regra default: "pássaros normalmente voam" (default: se $x$ é pássaro, e é consistente assumir que $x$ voa, então conclua que $x$ voa).

  + Fato: `Tweety é um pássaro.` $arrow.r$ Por default, conclui-se `Tweety voa` (nenhuma informação contradiz isso ainda).
  + Novo fato: `Tweety é um pinguim.` (e sabe-se que pinguins não voam) $arrow.r$ a conclusão anterior `Tweety voa` deixa de ser consistente e é *retirada*; a conclusão correta passa a ser `Tweety não voa`.

  A adição do fato "Tweety é um pinguim" fez o conjunto de conclusões *encolher* (perdeu "Tweety voa") -- exatamente o comportamento que a lógica clássica monotônica não consegue capturar diretamente.
]

== Atenção -- pegadinhas comuns

#remark(name: "Não-monotonicidade não é inconsistência lógica")[
  Retirar uma conclusão anterior ao saber de uma exceção não é uma contradição -- é o sistema revisando corretamente uma suposição *provisória* (default) diante de melhor informação. A lógica clássica subjacente permanece consistente; é o *mecanismo de inferência* que precisa de regras especiais (default, CWA) para lidar com exceções.
]

#remark(name: "Raciocínio não-monotônico exige revisão de crenças (belief revision)")[
  Sistemas que implementam raciocínio não-monotônico precisam rastrear *quais* conclusões dependem de quais suposições default, para poder retirá-las corretamente quando uma exceção aparece (ex.: sistemas de manutenção de verdade, *Truth Maintenance Systems*, TMS) -- simplesmente adicionar o novo fato sem esse rastreamento pode deixar conclusões obsoletas na base de conhecimento.
]

== Questões estilo POSCOMP

*Questão 1.* Um sistema de inferência é dito não-monotônico quando:
- a) O conjunto de conclusões deriváveis só pode crescer com novas premissas.
- b) Novas informações podem invalidar conclusões previamente derivadas.
- c) É equivalente à lógica proposicional clássica.
- d) Nunca permite revisão de conclusões.
- e) Não pode representar exceções.

*Questão 2.* No exemplo do pinguim desta seção, a retirada da conclusão "Tweety voa" ao saber que "Tweety é um pinguim" ilustra:
- a) Uma contradição lógica na base de conhecimento.
- b) O comportamento característico de uma regra default sendo revisada por uma exceção.
- c) Um erro de implementação do sistema.
- d) Que pássaros nunca voam.
- e) Que a lógica clássica é, por natureza, não-monotônica.

*Questão 3.* A Suposição de Mundo Fechado (CWA) estabelece que:
- a) Todo fato desconhecido é assumido verdadeiro.
- b) Todo fato não explicitamente conhecido como verdadeiro é assumido falso.
- c) Nenhuma suposição pode ser feita sobre fatos desconhecidos.
- d) É equivalente à lógica de primeira ordem completa.
- e) Só se aplica a sistemas monotônicos.

== Gabarito comentado

1. *(b)* -- definição direta de raciocínio não-monotônico.
2. *(b)* -- é exatamente o mecanismo de regra default sendo corretamente revisado, não uma contradição.
3. *(b)* -- definição direta da Suposição de Mundo Fechado.

== Referências

- REITER, R. *A Logic for Default Reasoning* (1980) -- artigo original da lógica de default.
- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 12 (Representação de conhecimento: raciocínio não-monotônico).
- LUGER, G. *Inteligência Artificial*. Cap. 9 (Raciocínio não-monotônico).
