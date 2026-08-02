#import "@preview/mousse-notes:1.1.0": *

= 21.10 --- Documentação

== Introdução

Documentação registra decisões, comportamento e uso do sistema para públicos diferentes -- da equipe de desenvolvimento ao usuário final. É um tema conceitualmente simples, mas a POSCOMP cobra a classificação correta dos tipos de documento e seus públicos-alvo.

== Definições formais

#definition(name: "Documentação de processo vs. de produto", id: "def-documentacao-processo-produto")[
  - *Documentação de processo*: registra o *desenvolvimento em si* -- planos, cronogramas, atas de reunião, relatórios de progresso, registros de controle de mudanças (21.5). Tem valor principalmente durante o desenvolvimento, como histórico e rastreabilidade.
  - *Documentação de produto*: descreve o *sistema entregue* -- desde a especificação e o projeto até manuais. Tem valor contínuo durante toda a vida útil do sistema, inclusive na manutenção (21.9).
]

#definition(name: "Documentação técnica vs. documentação de usuário", id: "def-documentacao-tecnica-usuario")[
  - *Documentação técnica (de desenvolvedor)*: destinada a quem vai manter/evoluir o sistema -- especificações, diagramas de projeto, comentários de API, guias de arquitetura.
  - *Documentação de usuário*: destinada a quem vai *operar* o sistema -- manuais de uso, guias de instalação, tutoriais, mensagens de ajuda embutidas na interface.
]

== Exemplo resolvido

#example(name: "Classificando documentos de um projeto", id: "ex-classificar-documentacao")[
  - Ata de uma reunião de planejamento de sprint $arrow.r$ documentação de *processo*.
  - Manual do usuário explicando como emitir um relatório $arrow.r$ documentação de *produto*, tipo *usuário*.
  - Diagrama de arquitetura de componentes do sistema $arrow.r$ documentação de *produto*, tipo *técnica*.
  - Registro formal de uma solicitação de mudança aprovada pelo CCB (21.5) $arrow.r$ documentação de *processo*.
]

== Atenção -- pegadinhas comuns

#remark(name: "Documentação desatualizada pode ser pior do que a ausência dela")[
  Um manual técnico ou de usuário desatualizado pode induzir a equipe (ou o usuário) a erro ativamente, ao contrário da simples ausência de documentação, que ao menos não gera falsa confiança -- por isso manter documentação sincronizada com o sistema real é tão valorizado quanto produzi-la.
]

#remark(name: "Documentação de processo não perde valor no final do projeto")[
  Um erro comum é achar que documentos de processo (atas, planos) só têm utilidade durante o desenvolvimento. Eles continuam relevantes depois, para auditoria, rastreabilidade de decisões e como insumo para estimar projetos futuros semelhantes.
]

== Questões estilo POSCOMP

*Questão 1.* Um manual explicando ao usuário final como instalar e configurar o sistema é um exemplo de documentação:
- a) De processo.
- b) De produto, do tipo técnica.
- c) De produto, do tipo usuário.
- d) De gerenciamento de configuração exclusivamente.
- e) De teste de aceitação.

*Questão 2.* Um cronograma de projeto e as atas de reuniões de acompanhamento são exemplos de documentação:
- a) De produto.
- b) De processo.
- c) De usuário.
- d) De teste.
- e) De reengenharia.

*Questão 3.* Sobre o valor da documentação desatualizada, é correto afirmar que:
- a) É sempre preferível a nenhuma documentação, sem exceção.
- b) Pode induzir a erro de forma mais prejudicial do que a simples ausência de documentação, ao gerar falsa confiança.
- c) Não afeta a manutenção do sistema.
- d) Só é um problema para documentação de processo.
- e) É automaticamente corrigida por ferramentas de controle de versão.

== Gabarito comentado

1. *(c)* -- manual voltado à instalação/uso pelo usuário final é documentação de produto, tipo usuário.
2. *(b)* -- cronograma e atas registram o desenvolvimento em si, sendo documentação de processo.
3. *(b)* -- documentação desatualizada pode enganar ativamente quem a consulta, sendo potencialmente pior que sua ausência.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 2 (Documentação de processo e produto no contexto do processo de software).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 29 (Documentação técnica).
