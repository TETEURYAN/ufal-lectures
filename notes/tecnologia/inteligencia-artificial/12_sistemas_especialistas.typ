#import "@preview/mousse-notes:1.1.0": *

= 22.17 --- Sistemas Especialistas

== Introdução

Sistemas especialistas foram a primeira aplicação comercialmente bem-sucedida de IA: programas que emulam o julgamento de um especialista humano em um domínio *estreito e bem definido*, combinando as ideias de sistemas de produção (22.9) e representação de conhecimento (22.8) com um componente essencial: a capacidade de *explicar* seu raciocínio.

== Definições formais

#definition(name: "Sistema Especialista", id: "def-sistema-especialista")[
  Programa que resolve problemas em um domínio específico no nível de um especialista humano, tipicamente estruturado em:
  - *Base de conhecimento*: fatos e regras do domínio, fornecidos por um *engenheiro de conhecimento* em colaboração com especialistas humanos.
  - *Motor de inferência*: aplica encadeamento para frente ou para trás (22.9) sobre a base de conhecimento.
  - *Módulo de explicação*: justifica ao usuário *como* e *por que* chegou a uma conclusão (ex.: listando a cadeia de regras usadas) -- diferencial central frente a um sistema de produção genérico.
  - *Interface com o usuário*: coleta informações do usuário e apresenta conclusões/recomendações.
]

== Exemplo resolvido

#example(name: "MYCIN: sistema especialista histórico", id: "ex-mycin-sistema-especialista")[
  *MYCIN* (Stanford, década de 1970) diagnosticava infecções bacterianas sanguíneas e recomendava antibióticos, usando uma base de cerca de 600 regras `SE-ENTÃO` com *fatores de certeza* (22.11) para lidar com incerteza médica. Uma consulta típica: o médico informa sintomas e resultados de exames; MYCIN encadeia regras para trás (22.9), a partir da hipótese "há uma infecção bacteriana tratável", pedindo informações adicionais quando necessário, até recomendar um antibiótico específico -- e podia explicar, regra a regra, por que chegou àquela recomendação.
]

== Atenção -- pegadinhas comuns

#remark(name: "Sistema especialista é uma aplicação especializada de sistema de produção, não um conceito distinto")[
  Arquiteturalmente, um sistema especialista *é* um sistema de produção (22.9) com base de conhecimento e motor de inferência, aplicado a um domínio específico e acrescido de um módulo de explicação -- a POSCOMP às vezes testa se o candidato reconhece essa relação de especialização, em vez de tratá-los como tópicos totalmente separados.
]

#remark(name: "Sistemas especialistas têm domínio estreito -- não são IA geral")[
  Um sistema especialista é competente *apenas* dentro do domínio para o qual sua base de conhecimento foi construída (ex.: diagnóstico de infecções sanguíneas, no caso do MYCIN) -- fora desse escopo, não tem capacidade de raciocínio alguma. Essa limitação de escopo, não a falta de sofisticação da inferência, é a principal diferença frente a sistemas de IA mais gerais.
]

== Questões estilo POSCOMP

*Questão 1.* O componente de um sistema especialista responsável por justificar ao usuário como uma conclusão foi alcançada é o(a):
- a) Base de conhecimento.
- b) Motor de inferência.
- c) Módulo de explicação.
- d) Interface de usuário exclusivamente.
- e) Fator de certeza.

*Questão 2.* O sistema MYCIN, um marco histórico de sistemas especialistas, foi projetado para:
- a) Jogar xadrez em nível competitivo.
- b) Diagnosticar infecções bacterianas sanguíneas e recomendar antibióticos.
- c) Traduzir textos entre idiomas.
- d) Controlar robôs industriais.
- e) Resolver problemas de otimização combinatória geral.

*Questão 3.* Arquiteturalmente, um sistema especialista pode ser descrito como:
- a) Um tipo de rede neural profunda.
- b) Um sistema de produção (22.9) especializado em um domínio, com módulo de explicação adicional.
- c) Um algoritmo de busca cega sem heurística.
- d) Equivalente a um algoritmo genético.
- e) Um sistema que dispensa qualquer base de conhecimento.

== Gabarito comentado

1. *(c)* -- justificar o raciocínio ao usuário é a função definidora do módulo de explicação.
2. *(b)* -- MYCIN é o exemplo histórico clássico de sistema especialista para diagnóstico médico, conforme esta seção.
3. *(b)* -- reconhece a relação de especialização entre sistemas especialistas e sistemas de produção, ponto central da observação desta seção.

== Referências

- SHORTLIFFE, E. *Computer-Based Medical Consultations: MYCIN* (1976) -- referência original do sistema MYCIN.
- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. sobre sistemas baseados em conhecimento.
- GIARRATANO, J.; RILEY, G. *Expert Systems: Principles and Programming*. Cap. 1--2.
