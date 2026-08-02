#import "@preview/mousse-notes:1.1.0": *

= 22.9 --- Sistemas de Produção com Encadeamento para a Frente e Encadeamento para trás

== Introdução

Sistemas de produção são a arquitetura clássica para implementar raciocínio baseado em regras -- a base de sistemas especialistas (22.17). A escolha entre encadear "para frente" ou "para trás" muda fundamentalmente a estratégia de busca sobre a base de regras, e é o ponto mais cobrado desta subseção.

== Definições formais

#definition(name: "Sistema de produção", id: "def-sistema-producao")[
  Arquitetura composta por três elementos: uma *memória de trabalho* (fatos conhecidos no momento), uma *base de regras* (produções da forma `SE condição ENTÃO ação/conclusão`), e um *motor de inferência* que repete um ciclo *casamento-seleção-execução* (match-select-execute): identifica quais regras têm suas condições satisfeitas pela memória de trabalho, seleciona uma (por algum critério de resolução de conflito) e a executa, atualizando a memória de trabalho.
]

#definition(name: "Encadeamento para a frente (forward chaining)", id: "def-encadeamento-frente")[
  Estratégia *orientada a dados*: parte dos fatos conhecidos na memória de trabalho e aplica regras cujas condições são satisfeitas, derivando novos fatos, até que nenhuma regra nova se aplique ou o objetivo seja alcançado. Adequada quando há muitos fatos iniciais e se quer descobrir *tudo* que pode ser derivado (ex.: sistemas de monitoramento).
]

#definition(name: "Encadeamento para trás (backward chaining)", id: "def-encadeamento-tras")[
  Estratégia *orientada a objetivo*: parte de uma hipótese/objetivo específico e busca regras cuja *conclusão* corresponda a esse objetivo, tentando recursivamente provar as *condições* dessas regras como novos subobjetivos, até reduzir tudo a fatos já conhecidos. Adequada quando há um objetivo específico a verificar, evitando derivar fatos irrelevantes (ex.: sistemas de diagnóstico, respondendo "o paciente tem a doença X?").
]

== Exemplo resolvido

#example(name: "Forward vs. backward chaining na mesma base de regras", id: "ex-forward-backward-chaining")[
  Base de regras: `R1: SE tem_febre E tem_tosse ENTÃO suspeita_gripe`. `R2: SE suspeita_gripe E tem_dor_corpo ENTÃO diagnostico_gripe`. Fatos conhecidos: `tem_febre`, `tem_tosse`, `tem_dor_corpo`.

  - *Forward chaining*: memória inicial = {tem_febre, tem_tosse, tem_dor_corpo}. R1 casa (condições satisfeitas) $arrow.r$ deriva `suspeita_gripe`. Memória atualizada permite R2 casar $arrow.r$ deriva `diagnostico_gripe`. Processo para (nenhuma regra nova se aplica).
  - *Backward chaining*, objetivo `diagnostico_gripe`: busca regra com essa conclusão $arrow.r$ R2, cujas condições são `suspeita_gripe` (subobjetivo) e `tem_dor_corpo` (já é fato, ok). Para `suspeita_gripe`: busca R1, condições `tem_febre` e `tem_tosse` (ambos já fatos, ok) $arrow.r$ `suspeita_gripe` provado $arrow.r$ `diagnostico_gripe` provado.

  Ambos chegam à mesma conclusão aqui, mas backward chaining nunca precisou considerar regras irrelevantes ao objetivo `diagnostico_gripe`, enquanto forward chaining derivaria *qualquer* conclusão alcançável a partir dos fatos, relevante ou não.
]

== Atenção -- pegadinhas comuns

#remark(name: "Escolha depende da razão entre fatos e objetivos possíveis")[
  Regra prática: se o número de fatos iniciais é pequeno e o número de conclusões possíveis é grande, *backward chaining* tende a ser mais eficiente (evita explorar conclusões irrelevantes). Se há muitos fatos e poucos objetivos específicos de interesse, *forward chaining* pode ser mais direto. Não existe uma resposta "sempre melhor" -- depende da estrutura do problema.
]

#remark(name: "Resolução de conflitos não é a mesma coisa que encadeamento")[
  Quando múltiplas regras casam simultaneamente com a memória de trabalho, o motor de inferência precisa de uma estratégia de *resolução de conflitos* (ex.: prioridade, especificidade, regra mais recente) para escolher qual executar primeiro -- uma questão ortogonal à direção do encadeamento (frente ou trás), frequentemente confundida com ela.
]

== Questões estilo POSCOMP

*Questão 1.* Um sistema de diagnóstico médico que parte de uma hipótese específica ("o paciente tem a doença X?") e busca confirmar as condições necessárias está usando:
- a) Encadeamento para a frente.
- b) Encadeamento para trás.
- c) Busca em largura apenas.
- d) Representação procedural exclusivamente.
- e) Simulated annealing.

*Questão 2.* O ciclo básico do motor de inferência de um sistema de produção é:
- a) Compilação-execução-parada.
- b) Casamento-seleção-execução.
- c) Busca-heurística-objetivo.
- d) Unificação-resolução-refutação.
- e) Indução-dedução-abdução.

*Questão 3.* Forward chaining tende a ser menos eficiente que backward chaining quando:
- a) Há poucos fatos iniciais e muitas conclusões possíveis irrelevantes ao objetivo de interesse.
- b) Há um único objetivo e muitos fatos relevantes apenas a ele.
- c) Não existem regras na base de conhecimento.
- d) O sistema não tem memória de trabalho.
- e) Backward chaining nunca é mais eficiente, em nenhum cenário.

== Gabarito comentado

1. *(b)* -- partir de uma hipótese e buscar confirmar suas condições é a definição de encadeamento para trás.
2. *(b)* -- ciclo casamento-seleção-execução é a definição padrão do motor de inferência de um sistema de produção.
3. *(a)* -- forward chaining explora todas as derivações possíveis a partir dos fatos, incluindo irrelevantes ao objetivo, sendo menos direcionado nesse cenário.

== Referências

- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 9 (Inferência em lógica de primeira ordem: encadeamento).
- LUGER, G. *Inteligência Artificial*. Cap. 6 (Sistemas de produção).
- GIARRATANO, J.; RILEY, G. *Expert Systems: Principles and Programming*. Cap. sobre motores de inferência.
