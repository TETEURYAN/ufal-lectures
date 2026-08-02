#import "@preview/mousse-notes:1.1.0": *

= 22.19 --- Agentes Inteligentes

== Introdução

"Agente" é o conceito unificador de toda a IA moderna: quase todos os tópicos anteriores (busca, representação de conhecimento, aprendizado) podem ser vistos como componentes de um agente que percebe um ambiente e age sobre ele. Russell & Norvig organizam seu livro-texto inteiro em torno dessa ideia.

== Definições formais

#definition(name: "Agente e agente racional", id: "def-agente-racional")[
  Um *agente* é qualquer entidade que *percebe* seu ambiente por meio de *sensores* e *age* sobre esse ambiente por meio de *atuadores*. Um *agente racional* escolhe, a cada instante, a ação que maximiza sua *medida de desempenho esperada*, dado o histórico de percepções até o momento e o conhecimento embutido no agente -- "racional" aqui não significa onisciente ou infalível, apenas que age da melhor forma possível com a informação disponível.
]

#definition(name: "PEAS: especificação do ambiente de tarefa", id: "def-peas")[
  Framework para especificar o ambiente de um agente: *P*erformance (medida de desempenho), *E*nvironment (ambiente), *A*ctuators (atuadores disponíveis), *S*ensors (sensores disponíveis). Especificar PEAS é o primeiro passo para projetar qualquer agente.
]

#definition(name: "Tipos de agente (por arquitetura interna)", id: "def-tipos-agente")[
  - *Reativo simples*: escolhe ação baseada apenas na percepção atual, via regras condição-ação -- sem memória do histórico.
  - *Reativo baseado em modelo*: mantém um *estado interno* que rastreia aspectos do ambiente não diretamente observáveis na percepção atual, combinando percepção com um modelo de como o mundo evolui.
  - *Baseado em objetivos*: além do estado, considera *metas* explícitas, escolhendo ações que levam ao objetivo (frequentemente usando busca, 22.3--22.5, internamente).
  - *Baseado em utilidade*: generaliza o baseado em objetivos com uma função de *utilidade*, permitindo comparar diferentes estados-objetivo por "quão bom" cada um é, não apenas se satisfaz ou não a meta.
]

== Exemplo resolvido

#example(name: "PEAS para um táxi autônomo", id: "ex-peas-taxi-autonomo")[
  #table(
    columns: 2,
    [*Componente*], [*Especificação*],
    [Performance], [Segurança, tempo de viagem, obediência às leis de trânsito, conforto do passageiro],
    [Environment], [Ruas, outros veículos, pedestres, sinalização, condições climáticas],
    [Actuators], [Volante, acelerador, freio, buzina, sinalizadores],
    [Sensors], [Câmeras, radar/lidar, GPS, velocímetro, sensores de outros veículos do próprio carro],
  )
  Esse mesmo táxi é tipicamente um agente *baseado em utilidade*: precisa comparar rotas alternativas não apenas por "chegar ou não ao destino" (objetivo binário), mas por uma combinação de segurança, tempo e conforto -- exigindo uma função de utilidade que pondere esses fatores.
]

== Atenção -- pegadinhas comuns

#remark(name: "Racionalidade não é onisciência nem perfeição")[
  Um agente racional pode falhar (ex.: um sensor com ruído leva a uma decisão que se revela ruim) sem deixar de ser racional -- racionalidade é sobre agir da melhor forma *dado o que se sabe e percebe*, não sobre garantir sempre o melhor resultado possível no mundo real.
]

#remark(name: "A hierarquia de tipos de agente é cumulativa em sofisticação, não uma escolha binária")[
  Da reativa simples até a baseada em utilidade, cada tipo agrega capacidade sobre o anterior (estado interno, depois metas, depois comparação quantitativa entre estados) -- não são categorias mutuamente exclusivas e desconexas, mas um espectro crescente de sofisticação de arquitetura interna.
]

== Questões estilo POSCOMP

*Questão 1.* Um agente que escolhe ações apenas com base na percepção atual, via regras condição-ação, sem manter nenhum estado interno sobre o histórico, é classificado como:
- a) Baseado em utilidade.
- b) Baseado em objetivos.
- c) Reativo simples.
- d) Reativo baseado em modelo.
- e) Racional onisciente.

*Questão 2.* No framework PEAS, a sigla "S" refere-se a:
- a) Estado (State).
- b) Sensores (Sensors).
- c) Solução (Solution).
- d) Segurança (Safety).
- e) Estratégia (Strategy).

*Questão 3.* Um agente racional é definido como aquele que:
- a) Sempre alcança o resultado ótimo no mundo real, sem exceção.
- b) Escolhe a ação que maximiza seu desempenho esperado, dado o histórico de percepções e seu conhecimento.
- c) Nunca comete erros, mesmo com sensores ruidosos.
- d) É necessariamente baseado em utilidade.
- e) Não usa nenhuma informação do ambiente.

== Gabarito comentado

1. *(c)* -- ausência de estado interno, decidindo apenas pela percepção atual, é a definição de agente reativo simples.
2. *(b)* -- PEAS = Performance, Environment, Actuators, Sensors.
3. *(b)* -- definição direta de racionalidade em termos de desempenho esperado, não de garantia de resultado perfeito.

== Referências

- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 2 (Agentes inteligentes).
- Stanford CS221 (stanford-cs221.github.io) -- módulos de agentes e tomada de decisão (MDPs, jogos).
