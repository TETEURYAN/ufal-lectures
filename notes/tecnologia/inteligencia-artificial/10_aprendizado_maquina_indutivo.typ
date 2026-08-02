#import "@preview/mousse-notes:1.1.0": *

= 22.14 --- Aprendizado de Máquina

== Introdução

Até aqui, o conhecimento (regras, redes semânticas, bases lógicas) foi assumido dado por um especialista humano. Aprendizado de máquina inverte essa premissa: o sistema constrói ou refina seu próprio conhecimento a partir de dados/experiência -- fundamento de praticamente toda IA aplicada moderna.

== Definições formais

#definition(name: "Aprendizado de máquina (definição de Mitchell)", id: "def-aprendizado-maquina")[
  Um programa aprende com a experiência $E$, em relação a uma classe de tarefas $T$ e uma medida de desempenho $P$, se seu desempenho em tarefas de $T$, medido por $P$, melhora com a experiência $E$ (Tom Mitchell, 1997).
]

#definition(name: "Tipos de aprendizado", id: "def-tipos-aprendizado-maquina")[
  - *Supervisionado*: aprende uma função a partir de exemplos rotulados (entrada, saída correta) -- ex.: classificação, regressão.
  - *Não-supervisionado*: encontra estrutura/padrões em dados *sem* rótulos -- ex.: agrupamento (clustering), redução de dimensionalidade.
  - *Por reforço*: um agente aprende por tentativa e erro, recebendo recompensas/punições ao interagir com um ambiente, sem exemplos rotulados diretos -- otimiza uma política de ação ao longo do tempo.
]

== Exemplo resolvido

#example(name: "Classificando três cenários de aprendizado", id: "ex-classificar-tipos-aprendizado")[
  - Treinar um sistema com milhares de e-mails marcados como "spam"/"não-spam" para classificar novos e-mails $arrow.r$ *supervisionado*.
  - Agrupar clientes de um e-commerce por padrão de compra, sem categorias pré-definidas $arrow.r$ *não-supervisionado*.
  - Um agente joga xadrez repetidamente, recebendo recompensa positiva ao vencer e negativa ao perder, ajustando sua estratégia $arrow.r$ *por reforço*.
]

= 22.15 --- Aprendizado Indutivo

== Introdução

Aprendizado indutivo é o paradigma central do aprendizado supervisionado: generalizar uma regra a partir de *exemplos específicos* -- o oposto lógico da dedução (que parte do geral para o específico), com todos os riscos que a indução carrega.

== Definições formais

#definition(name: "Aprendizado indutivo e viés indutivo", id: "def-aprendizado-indutivo")[
  *Aprendizado indutivo* infere uma hipótese geral $h$ (uma função ou regra) a partir de um conjunto finito de exemplos de treinamento $(x_i, y_i)$, de forma que $h$ generalize corretamente para exemplos *não vistos*. Como infinitas hipóteses são consistentes com qualquer conjunto finito de exemplos, todo algoritmo de aprendizado indutivo precisa de um *viés indutivo* (inductive bias): suposições adicionais (ex.: preferir hipóteses mais simples, "navalha de Occam") que restringem o espaço de hipóteses candidatas, tornando a generalização possível.
]

== Exemplo resolvido

#example(name: "Induzindo uma regra a partir de exemplos", id: "ex-inducao-regra")[
  Exemplos de treinamento para o conceito "fruta cítrica": (laranja, sim), (limão, sim), (maçã, não), (tangerina, sim), (banana, não). Um algoritmo indutivo pode generalizar para a hipótese "frutas de casca ácida e polpa segmentada são cítricas" -- uma regra *não explicitamente dada*, mas induzida a partir do padrão nos exemplos. Se um novo exemplo (kiwi, não) for observado depois, e a hipótese o classificasse incorretamente como cítrico, isso indicaria a necessidade de refinar a hipótese -- o processo indutivo é inerentemente sujeito a erro e revisão.
]

== Atenção -- pegadinhas comuns

#remark(name: "Sem viés indutivo, generalizar é impossível (não é \"livre de suposições\")")[
  Um algoritmo que apenas memoriza exemplos vistos, sem nenhuma suposição adicional sobre a forma da hipótese, não generaliza para exemplos novos de forma alguma (qualquer generalização seria arbitrária). O viés indutivo não é uma limitação a evitar -- é uma condição *necessária* para o aprendizado funcionar.
]

#remark(name: "Indução não garante conclusões verdadeiras, apenas plausíveis")[
  Diferente da dedução (Lógica Matemática, 5.3--5.7), que preserva verdade com certeza, a indução extrapola de casos específicos observados para um padrão geral -- sempre sujeita a exemplos futuros que a contradigam (o problema filosófico da indução, tratado por Hume). O ajuste excessivo aos exemplos de treinamento, à custa de generalização, é o fenômeno de *overfitting*, revisitado em 22.16.
]

== Questões estilo POSCOMP

*Questão 1.* Um agente que joga um jogo repetidamente, ajustando sua estratégia com base em recompensas e punições recebidas ao longo das partidas, está usando aprendizado:
- a) Supervisionado.
- b) Não-supervisionado.
- c) Por reforço.
- d) Dedutivo.
- e) Baseado em regras fixas.

*Questão 2.* A necessidade de um "viés indutivo" em aprendizado de máquina existe porque:
- a) Torna o algoritmo mais lento.
- b) Sem alguma restrição sobre o espaço de hipóteses, infinitas hipóteses seriam consistentes com os exemplos, impossibilitando generalização não arbitrária.
- c) É uma falha de projeto a ser eliminada.
- d) Só se aplica a aprendizado não-supervisionado.
- e) Substitui a necessidade de exemplos de treinamento.

*Questão 3.* Agrupar documentos de texto por similaridade de conteúdo, sem categorias pré-definidas, é um exemplo de aprendizado:
- a) Supervisionado.
- b) Por reforço.
- c) Não-supervisionado.
- d) Indutivo dedutivo.
- e) Baseado exclusivamente em regras lógicas.

== Gabarito comentado

1. *(c)* -- recompensas/punições por tentativa e erro caracterizam aprendizado por reforço.
2. *(b)* -- é exatamente a justificativa da necessidade de viés indutivo apresentada nesta seção.
3. *(c)* -- ausência de rótulos/categorias pré-definidas caracteriza aprendizado não-supervisionado (clustering).

== Referências

- MITCHELL, T. *Machine Learning* (1997) -- definição clássica de aprendizado de máquina.
- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 18--19 (Aprendizado a partir de exemplos).
- Stanford CS221 (stanford-cs221.github.io) -- módulo de machine learning (classificação de sentimento).
