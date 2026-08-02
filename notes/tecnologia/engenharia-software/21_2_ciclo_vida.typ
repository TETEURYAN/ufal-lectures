#import "@preview/mousse-notes:1.1.0": *

= 21.2 --- Ciclo de Vida de Desenvolvimento de Software

== Introdução

O modelo de ciclo de vida (ou modelo de processo) organiza as atividades fundamentais (21.1) no tempo. É o item mais recorrente de Engenharia de Software na POSCOMP: a prova gosta de descrever um cenário de projeto e pedir para identificar o modelo mais adequado, ou de comparar prós/contras entre modelos.

== Definições formais

#definition(name: "Modelo em Cascata (Waterfall)", id: "def-modelo-cascata")[
  Modelo *sequencial*: cada fase (requisitos, projeto, implementação, teste, implantação, manutenção) só começa após a conclusão *completa* da anterior, sem retorno previsto a fases já encerradas. Adequado quando os requisitos são bem compreendidos e estáveis desde o início.
]

#definition(name: "Modelo Incremental", id: "def-modelo-incremental")[
  O sistema é dividido em incrementos funcionais, cada um desenvolvido e entregue separadamente, agregando funcionalidade a cada ciclo. Reduz o risco de entregar, só no final, um sistema que não atende à necessidade real.
]

#definition(name: "Modelo Espiral (Boehm)", id: "def-modelo-espiral")[
  Modelo *iterativo orientado a risco*: cada volta da espiral repete quatro quadrantes -- definir objetivos, identificar e analisar riscos, desenvolver e validar, planejar a próxima iteração. Cada iteração produz um protótipo ou versão mais refinada, com foco explícito em mitigar os riscos mais críticos primeiro.
]

#definition(name: "Prototipação", id: "def-modelo-prototipacao")[
  Constrói-se rapidamente uma versão parcial e simplificada (protótipo) do sistema para validar requisitos ainda incertos com o cliente antes de investir no desenvolvimento completo. Pode ser *descartável* (joga-se fora após esclarecer os requisitos) ou *evolutiva* (o protótipo evolui até virar o sistema final).
]

#definition(name: "Modelos Ágeis (Scrum, XP)", id: "def-modelos-ageis")[
  Família de modelos *iterativos e incrementais* de ciclos curtos (*sprints*, tipicamente 1--4 semanas), priorizando entrega frequente de software funcionando, colaboração próxima com o cliente e resposta rápida a mudanças (Manifesto Ágil, 2001). *Scrum* organiza o trabalho em sprints com papéis definidos (Product Owner, Scrum Master, Time); *XP (Extreme Programming)* acrescenta práticas técnicas como programação em par e integração contínua.
]

== Comparação entre modelos

#table(
  columns: 4,
  [*Modelo*], [*Vantagem principal*], [*Desvantagem principal*], [*Cenário ideal*],
  [Cascata], [Simplicidade e documentação clara por fase], [Rígido; caro corrigir erros descobertos tarde], [Requisitos estáveis e bem compreendidos (ex.: sistemas regulatórios)],
  [Incremental], [Entrega valor cedo; risco distribuído], [Exige arquitetura que suporte incrementos], [Requisitos parcialmente conhecidos, prazo apertado para primeira entrega],
  [Espiral], [Foco explícito em gestão de risco], [Processo mais caro e complexo de gerenciar], [Projetos grandes, de alto risco técnico ou financeiro],
  [Prototipação], [Valida requisitos incertos cedo, com o cliente], [Risco de o protótipo "descartável" virar produção por pressão de prazo], [Requisitos de interface/interação pouco claros],
  [Ágil (Scrum/XP)], [Alta adaptabilidade a mudanças; feedback contínuo], [Exige cliente/PO disponível e disciplina da equipe], [Requisitos voláteis, ambiente de negócio em mudança rápida],
)

#figure(
  image("figures/waterfall-model.svg", width: 55%),
  caption: [Modelo em Cascata: fases sequenciais, sem retorno previsto a fases anteriores. Fonte: Wikimedia Commons, CC BY 3.0 (Peter Kemp / Paul Smith).],
)

#figure(
  image("figures/spiral-model-boehm.svg", width: 55%),
  caption: [Modelo Espiral de Boehm: cada volta repassa os quatro quadrantes (objetivos, riscos, desenvolvimento, planejamento). Fonte: Wikimedia Commons, domínio público.],
)

== Atenção -- pegadinhas comuns

#remark(name: "Cascata \"puro\" é raro na prática, mas ainda cai em prova como modelo de referência")[
  Na indústria real, poucos projetos seguem cascata estritamente sequencial (sem nenhuma iteração) -- mas a POSCOMP cobra o modelo teórico "puro" como referência para contraste com os demais, então é importante saber sua definição exata mesmo que ela raramente apareça 100% fiel na prática.
]

#remark(name: "Ágil não significa \"sem processo\" ou \"sem documentação\"")[
  Um erro comum é achar que metodologias ágeis dispensam disciplina ou planejamento. Scrum e XP têm processos bem definidos (cerimônias, papéis, práticas técnicas) -- a diferença para modelos tradicionais é a *ênfase* (adaptação contínua vs. planejamento antecipado extenso), não a ausência de processo.
]

#remark(name: "Protótipo descartável vs. evolutivo")[
  Confundir os dois é pegadinha clássica: um protótipo *descartável* nunca deveria virar código de produção (foi feito rápido, sem qualidade de produção); um protótipo *evolutivo* é construído desde o início com essa possibilidade em mente.
]

== Questões estilo POSCOMP

*Questão 1.* Um projeto tem requisitos bem compreendidos, estáveis e um contrato que exige documentação detalhada de cada fase antes de avançar. O modelo de ciclo de vida mais adequado é:
- a) Ágil (Scrum).
- b) Cascata.
- c) Prototipação descartável.
- d) Espiral.
- e) Extreme Programming.

*Questão 2.* O modelo Espiral de Boehm se diferencia dos demais principalmente por:
- a) Eliminar completamente a necessidade de testes.
- b) Ter foco explícito em identificação e mitigação de riscos a cada iteração.
- c) Ser idêntico ao modelo em cascata.
- d) Não permitir nenhuma forma de prototipação.
- e) Exigir que todos os requisitos sejam conhecidos antes de iniciar.

*Questão 3.* Associe: (I) Cascata, (II) Espiral, (III) Prototipação, (IV) Ágil -- (a) ciclos curtos e entrega frequente; (b) fases sequenciais sem retorno; (c) versão parcial para validar requisitos incertos; (d) iterações orientadas a risco.
- a) I-b, II-d, III-c, IV-a.
- b) I-a, II-b, III-d, IV-c.
- c) I-c, II-a, III-b, IV-d.
- d) I-d, II-c, III-a, IV-b.
- e) I-b, II-a, III-d, IV-c.

*Questão 4.* Sobre metodologias ágeis, é correto afirmar que:
- a) Dispensam qualquer forma de planejamento ou processo definido.
- b) Priorizam entrega frequente de software funcionando e resposta rápida a mudanças, mas mantêm processos e papéis bem definidos.
- c) São adequadas apenas para projetos com requisitos totalmente estáveis.
- d) XP e Scrum são exatamente o mesmo método, com nomes diferentes.
- e) Não permitem colaboração próxima com o cliente.

== Gabarito comentado

1. *(b)* -- requisitos estáveis e exigência de documentação formal por fase é o cenário clássico do modelo em cascata.
2. *(b)* -- gestão explícita de risco a cada volta da espiral é a marca distintiva do modelo de Boehm.
3. *(a)* -- mapeamento direto conforme as definições desta seção.
4. *(b)* -- ágil tem processo e disciplina próprios; a diferença é a ênfase em adaptação, não ausência de processo.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 2 (Modelos de processo de software).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 3--4 (Modelos de processo prescritivos e ágeis).
- BOEHM, B. *A Spiral Model of Software Development and Enhancement* (1988) -- artigo original do modelo espiral.
