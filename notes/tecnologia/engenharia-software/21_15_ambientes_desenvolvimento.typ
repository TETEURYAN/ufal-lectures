#import "@preview/mousse-notes:1.1.0": *

= 21.15 --- Ambientes de Desenvolvimento de Software

== Introdução

Fechando a disciplina, esta subseção trata das ferramentas e infraestrutura que apoiam todas as atividades anteriores -- de codificação a integração e entrega. É a subseção mais próxima da prática cotidiana de desenvolvimento.

== Definições formais

#definition(name: "Ambiente de Desenvolvimento Integrado (IDE)", id: "def-ide")[
  Ferramenta que integra em uma única aplicação editor de código, compilador/interpretador, depurador e (frequentemente) integração com controle de versão (21.5) -- reduz o custo de alternar entre ferramentas separadas para cada etapa do ciclo de codificação.
]

#definition(name: "Ferramentas CASE (Computer-Aided Software Engineering)", id: "def-ferramentas-case")[
  Ferramentas que dão suporte automatizado a atividades de engenharia de software, classificadas por fase de apoio:
  - *Upper CASE*: apoia atividades iniciais -- análise de requisitos, modelagem, projeto (ex.: ferramentas de diagramação UML).
  - *Lower CASE*: apoia atividades finais -- codificação, teste, depuração, geração de código a partir de modelos.
]

#definition(name: "Integração Contínua e Entrega Contínua (CI/CD)", id: "def-cicd")[
  - *Integração Contínua (CI)*: prática de integrar (mesclar) alterações de código ao repositório principal com alta frequência, disparando automaticamente build e testes a cada integração, para detectar conflitos e regressões o mais cedo possível.
  - *Entrega/Implantação Contínua (CD)*: estende a CI automatizando também a preparação (entrega) ou a publicação efetiva (implantação) do software em ambientes de homologação/produção, reduzindo o tempo entre uma mudança de código e sua disponibilização.
]

== Exemplo resolvido

#example(name: "Pipeline simplificado de CI/CD", id: "ex-pipeline-cicd")[
  #table(
    columns: 2,
    [*Etapa*], [*O que acontece*],
    [1. Commit], [Desenvolvedor envia uma alteração ao repositório compartilhado (21.5).],
    [2. Build automático], [Servidor de CI compila o projeto automaticamente, disparado pelo commit.],
    [3. Testes automáticos], [Suíte de testes unitários e de integração (21.8) roda automaticamente sobre o build.],
    [4. Relatório], [Se algo falhar, a equipe é notificada imediatamente -- corrigir cedo é mais barato que corrigir tarde.],
    [5. Entrega/Implantação], [Se tudo passar, o pacote é automaticamente disponibilizado em homologação (CD) ou até em produção (implantação contínua).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "CI não é apenas \"usar controle de versão\"")[
  Usar Git (21.5) é necessário, mas não suficiente, para dizer que uma equipe pratica Integração Contínua -- CI exige especificamente a automação de build e testes a *cada* integração, com feedback rápido, não apenas o versionamento do código em si.
]

#remark(name: "Entrega contínua não é o mesmo que implantação contínua")[
  Entrega contínua garante que o software está *sempre pronto* para ser implantado (passou por todas as validações automatizadas), mas a implantação em produção pode ainda exigir aprovação manual. Implantação contínua vai além: toda mudança que passa no pipeline é automaticamente publicada em produção, sem intervenção manual.
]

== Questões estilo POSCOMP

*Questão 1.* Uma ferramenta que apoia especificamente a fase de modelagem e análise de requisitos, como diagramação UML, é classificada como uma ferramenta:
- a) Lower CASE.
- b) Upper CASE.
- c) De controle de versão distribuído.
- d) De teste de aceitação.
- e) De gerenciamento de configuração exclusivamente.

*Questão 2.* A prática de integrar alterações de código ao repositório principal com alta frequência, disparando build e testes automaticamente a cada integração, é chamada de:
- a) Entrega Contínua.
- b) Implantação Contínua.
- c) Integração Contínua.
- d) Engenharia reversa.
- e) Reestruturação.

*Questão 3.* A diferença entre Entrega Contínua e Implantação Contínua é que:
- a) São termos idênticos, sem diferença prática.
- b) Entrega Contínua garante que o software está pronto para implantação, que pode exigir aprovação manual; Implantação Contínua publica automaticamente em produção, sem intervenção manual.
- c) Implantação Contínua não envolve testes automatizados.
- d) Entrega Contínua só se aplica a sistemas desktop.
- e) Implantação Contínua é sinônimo de engenharia reversa.

== Gabarito comentado

1. *(b)* -- apoio a atividades iniciais (requisitos, modelagem) caracteriza uma ferramenta Upper CASE.
2. *(c)* -- integração frequente com build/teste automático a cada mudança é a definição de Integração Contínua.
3. *(b)* -- a distinção está exatamente na presença (entrega) ou ausência (implantação) de uma etapa manual de aprovação antes de ir para produção.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 25 (Ferramentas e ambientes de desenvolvimento).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 32 (Ambientes CASE).
- FOWLER, M. *Continuous Integration* (martinfowler.com) -- referência amplamente citada sobre CI/CD.
