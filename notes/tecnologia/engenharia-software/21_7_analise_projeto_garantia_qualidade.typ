#import "@preview/mousse-notes:1.1.0": *

= 21.7 --- Métodos de Análise e de Projeto de Software. Garantia de Qualidade de Software

== Introdução

Esta subseção do edital reúne dois temas: como transformar requisitos em uma solução estruturada (análise e projeto) e como garantir, ao longo de todo o processo, que o resultado tem qualidade (SQA). São tratados juntos aqui porque a garantia de qualidade se aplica -- entre outras atividades -- diretamente às revisões dos artefatos de análise e projeto.

== Métodos de Análise e Projeto de Software

#definition(name: "Análise vs. projeto (design)", id: "def-analise-projeto")[
  - *Análise*: entender e modelar o *problema* e o domínio -- o que o sistema precisa representar e fazer, geralmente de forma independente de tecnologia (ex.: diagrama de casos de uso, modelo conceitual de domínio).
  - *Projeto (design)*: definir a *solução* -- como o sistema será estruturado para atender à análise, incluindo decisões de arquitetura, componentes, estruturas de dados e algoritmos.
]

#definition(name: "Projeto arquitetural vs. projeto detalhado", id: "def-projeto-arquitetural-detalhado")[
  - *Projeto arquitetural*: decisões de alto nível sobre a organização geral do sistema -- subsistemas, camadas (layers), padrões arquiteturais (ex.: cliente-servidor, arquitetura em camadas, microsserviços).
  - *Projeto detalhado*: refina cada componente da arquitetura até o nível de classes, algoritmos e estruturas de dados prontos para implementação.
]

#example(name: "Do requisito ao projeto", id: "ex-analise-projeto-uml")[
  Para o requisito funcional "o sistema deve permitir que o cliente adicione produtos ao carrinho" (21.6):
  - *Análise*: um diagrama de caso de uso com o ator "Cliente" e o caso de uso "Adicionar produto ao carrinho", além de um modelo conceitual com as entidades `Produto` e `Carrinho`.
  - *Projeto arquitetural*: decidir que o sistema seguirá uma arquitetura em camadas (apresentação, negócio, dados), com o carrinho persistido em um serviço de sessão.
  - *Projeto detalhado*: especificar a classe `Carrinho` com seus atributos, métodos (`adicionarItem()`, `removerItem()`) e o algoritmo de cálculo do total.
]

== Garantia de Qualidade de Software (SQA)

#definition(name: "Garantia de Qualidade de Software (SQA)", id: "def-sqa")[
  Conjunto de atividades *sistemáticas e planejadas*, aplicadas ao longo de todo o processo (não só ao final), para garantir que o software e o processo que o produz estejam em conformidade com padrões e procedimentos estabelecidos -- inclui revisões técnicas formais, auditorias de processo, controle de aderência a padrões (21.11) e coleta de métricas.
]

#definition(name: "SQA vs. Controle de Qualidade (QC)", id: "def-sqa-vs-qc")[
  - *SQA (garantia)*: orientada a *processo*, preventiva -- busca evitar que defeitos sejam introduzidos, atuando sobre como o software é produzido.
  - *QC (controle)*: orientada a *produto*, detectiva -- busca encontrar defeitos já existentes no artefato produzido (ex.: por meio de testes, tratados em 21.8).
  As duas são complementares: SQA reduz a taxa de introdução de defeitos; QC (incluindo teste) detecta os que ainda assim ocorreram.
]

== Atenção -- pegadinhas comuns

#remark(name: "Revisão técnica formal não é a mesma coisa que teste")[
  Uma revisão técnica formal (ex.: inspeção de código, walkthrough) é uma atividade de SQA *estática* -- analisa o artefato (código, documento) sem executá-lo. Teste (21.8) é uma atividade *dinâmica* -- exige execução do software. Ambas são complementares, não substitutas uma da outra.
]

#remark(name: "SQA não é responsabilidade exclusiva de um \"time de qualidade\" separado")[
  Embora exista frequentemente um papel/time dedicado a SQA, a garantia de qualidade eficaz depende do envolvimento de toda a equipe (desenvolvedores, analistas, gestores) ao longo do processo -- não é algo verificado apenas ao final por um grupo isolado.
]

== Questões estilo POSCOMP

*Questão 1.* A atividade de definir como um sistema será estruturado em camadas, subsistemas e padrões arquiteturais, antes de detalhar classes e algoritmos, corresponde ao:
- a) Projeto detalhado.
- b) Projeto arquitetural.
- c) Teste de sistema.
- d) Controle de configuração.
- e) Levantamento de requisitos.

*Questão 2.* A diferença central entre Garantia de Qualidade (SQA) e Controle de Qualidade (QC) é que:
- a) SQA é orientada a produto; QC é orientada a processo.
- b) SQA é preventiva e orientada a processo; QC é detectiva e orientada a produto.
- c) Não há diferença conceitual entre os dois termos.
- d) QC só pode ser aplicado após a entrega final do software.
- e) SQA substitui completamente a necessidade de testes.

*Questão 3.* Uma inspeção de código realizada sem executar o programa é um exemplo de atividade de qualidade:
- a) Dinâmica, do tipo teste de sistema.
- b) Estática, típica de garantia de qualidade (SQA).
- c) De gerenciamento de configuração.
- d) De reengenharia.
- e) De teste de aceitação.

== Gabarito comentado

1. *(b)* -- decisões estruturais de alto nível, antes do detalhamento, definem o projeto arquitetural.
2. *(b)* -- SQA é preventiva/processual; QC é detectiva/orientada ao produto, conforme a definição desta seção.
3. *(b)* -- análise sem execução é uma atividade estática, característica de SQA (revisões técnicas formais).

== Referências

- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 9--10 (Projeto) e Cap. 17 (Garantia de qualidade).
- SOMMERVILLE, I. *Engenharia de Software*. Cap. 6--7 (Modelagem e projeto de sistemas) e Cap. 24 (Melhoria de processo).
