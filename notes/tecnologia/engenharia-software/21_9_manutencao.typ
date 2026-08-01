#import "@preview/mousse-notes:1.1.0": *

= 21.9 --- Manutenção

== Introdução

Manutenção é a fase do ciclo de vida (21.2) que começa após a entrega e tipicamente consome a *maior parte* do custo total de um sistema ao longo de sua vida útil. Abre a cadeia conceitual manutenção → engenharia reversa (21.13) → reengenharia (21.14), muito cobrada em conjunto na POSCOMP.

== Definições formais

#definition(name: "Tipos de manutenção", id: "def-tipos-manutencao")[
  - *Corretiva*: corrige defeitos identificados após a entrega (o sistema não faz o que deveria, segundo sua própria especificação).
  - *Adaptativa*: adapta o sistema a mudanças no ambiente (novo sistema operacional, nova versão de uma biblioteca, nova legislação) sem alterar sua funcionalidade original.
  - *Perfectiva*: aprimora o sistema além do que foi originalmente especificado -- novas funcionalidades, melhorias de desempenho ou usabilidade solicitadas pelos usuários.
  - *Preventiva*: reestrutura ou documenta o sistema para facilitar manutenções *futuras*, sem alterar o comportamento observável atual (ex.: refatoração para reduzir complexidade).
]

== Exemplo resolvido

#example(name: "Classificando quatro chamados de manutenção", id: "ex-classificar-manutencao")[
  - "O relatório mensal está somando os valores errados" $arrow.r$ *corretiva* (o sistema não faz o que deveria).
  - "Precisamos migrar o banco de dados para a nova versão exigida pelo fornecedor" $arrow.r$ *adaptativa* (mudança de ambiente externo).
  - "Os usuários pediram um novo filtro de busca por data" $arrow.r$ *perfectiva* (nova funcionalidade, além do especificado originalmente).
  - "Vamos reescrever este módulo confuso antes que fique impossível de manter" $arrow.r$ *preventiva* (sem mudar o comportamento, só facilitar manutenções futuras).
]

== Atenção -- pegadinhas comuns

#remark(name: "Perfectiva é a categoria mais frequente, não a corretiva")[
  Estudos clássicos de manutenção de software (ex.: Lientz & Swanson) mostram que a manutenção *perfectiva* costuma ser a fatia maior do esforço total de manutenção -- contraintuitivo para quem assume que "manutenção" significa principalmente "corrigir bugs" (corretiva).
]

#remark(name: "Adaptativa não é o mesmo que corretiva")[
  Uma mudança motivada por um defeito interno é corretiva; uma mudança motivada por uma alteração *externa* ao sistema (ambiente, legislação, plataforma) é adaptativa, mesmo que o sistema em si não tivesse nenhum "erro" antes da mudança externa -- distinção que a prova gosta de testar com cenários.
]

== Questões estilo POSCOMP

*Questão 1.* A atualização de um sistema para funcionar com uma nova versão do sistema operacional, sem alterar suas funcionalidades, é um exemplo de manutenção:
- a) Corretiva.
- b) Adaptativa.
- c) Perfectiva.
- d) Preventiva.
- e) Reversa.

*Questão 2.* Segundo estudos clássicos sobre manutenção de software, a categoria que tipicamente representa a maior parcela do esforço total de manutenção é:
- a) Corretiva.
- b) Adaptativa.
- c) Perfectiva.
- d) Preventiva.
- e) Todas têm exatamente a mesma proporção sempre.

*Questão 3.* Associe: (I) Corretiva, (II) Adaptativa, (III) Perfectiva, (IV) Preventiva -- (a) refatorar código sem mudar comportamento, para facilitar manutenções futuras; (b) corrigir um defeito identificado; (c) adicionar funcionalidade não prevista originalmente; (d) adaptar a mudanças no ambiente externo.
- a) I-b, II-d, III-c, IV-a.
- b) I-a, II-b, III-c, IV-d.
- c) I-c, II-a, III-b, IV-d.
- d) I-b, II-a, III-d, IV-c.
- e) I-d, II-c, III-b, IV-a.

== Gabarito comentado

1. *(b)* -- mudança motivada por ambiente externo, sem alterar funcionalidade, é manutenção adaptativa.
2. *(c)* -- manutenção perfectiva tipicamente domina o esforço total, segundo a literatura clássica citada nesta seção.
3. *(a)* -- mapeamento direto conforme as definições desta seção.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 9 (Evolução de software).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 27 (Manutenção e reengenharia).
- LIENTZ, B.; SWANSON, E. *Software Maintenance Management* (1980) -- estudo clássico sobre distribuição de esforço por tipo de manutenção.
