#import "@preview/mousse-notes:1.1.0": *

= 21.5 --- Gerenciamento de Configuração de Software

== Introdução

À medida que um sistema evolui (21.1), múltiplas versões de código, documentos e artefatos precisam ser controladas de forma disciplinada -- é o papel do Gerenciamento de Configuração de Software (GCS/SCM). É um assunto mais prático que teórico, com boa cobrança conceitual na POSCOMP sobre os elementos e o vocabulário do controle de versão.

== Definições formais

#definition(name: "Item de configuração e baseline", id: "def-item-configuracao-baseline")[
  Um *item de configuração* é qualquer artefato controlado pelo GCS (código-fonte, documentação, casos de teste, especificações). Uma *baseline* é um conjunto de itens de configuração formalmente revisado e congelado em um ponto específico, que só pode ser alterado por um procedimento formal de controle de mudanças -- serve como ponto de referência estável para o restante do desenvolvimento.
]

#definition(name: "Controle de versão: centralizado vs. distribuído", id: "def-controle-versao")[
  - *Centralizado* (ex.: CVS, Subversion/SVN): existe um único repositório central autoritativo; todo histórico de versões fica nele, e os clientes precisam de conexão com o servidor central para a maioria das operações.
  - *Distribuído* (ex.: Git, Mercurial): cada desenvolvedor tem uma cópia *completa* do repositório e seu histórico, podendo trabalhar (inclusive fazer commits) offline, sincronizando com outros repositórios posteriormente.
]

#definition(name: "Controle de mudanças", id: "def-controle-mudancas")[
  Processo formal para avaliar, aprovar (ou rejeitar) e rastrear solicitações de alteração em itens de configuração já baseados (baseline), tipicamente envolvendo um comitê ou responsável de controle de mudanças (CCB -- *Change Control Board*), evitando que alterações não controladas corrompam a integridade de uma baseline estável.
]

== Exemplo resolvido

#example(name: "CVS como exemplo histórico de controle de versão centralizado", id: "ex-cvs-historico")[
  O CVS (*Concurrent Versions System*) é um sistema clássico de controle de versão centralizado, historicamente ensinado em cursos de engenharia de software -- por exemplo, na disciplina *1.124J (Foundations of Software Engineering, MIT, 2000)*, que dedica uma aula inteira ("Source Code Management Using CVS") ao tema. No modelo do CVS:
  - Desenvolvedores fazem `checkout` de uma cópia de trabalho a partir do repositório central.
  - Alterações são registradas via `commit`, incrementando a revisão de cada arquivo individualmente.
  - Conflitos entre alterações concorrentes de dois desenvolvedores no mesmo arquivo são detectados no momento do `commit`/`update`, exigindo resolução manual.
  Sistemas modernos como o Git resolvem as mesmas necessidades (rastrear histórico, permitir trabalho concorrente, gerenciar conflitos), mas de forma *distribuída* -- cada desenvolvedor tem o histórico completo localmente, e a noção de "o" repositório central é apenas uma convenção de equipe, não uma exigência técnica do sistema.
]

== Atenção -- pegadinhas comuns

#remark(name: "Baseline não significa \"versão final\"")[
  Uma baseline é apenas um ponto de referência *estável e controlado* em um momento do projeto -- pode haver (e geralmente há) várias baselines ao longo do desenvolvimento (ex.: baseline de requisitos, baseline de projeto), não apenas uma no final.
]

#remark(name: "Gerenciamento de configuração não é sinônimo de controle de versão")[
  Controle de versão (Git, CVS...) é *uma parte* do gerenciamento de configuração, focada em rastrear mudanças em artefatos. GCS é mais amplo: inclui também identificação de itens de configuração, controle formal de mudanças, auditoria de configuração e relato de status -- versão é só uma das facetas.
]

== Questões estilo POSCOMP

*Questão 1.* Um conjunto de itens de configuração formalmente revisado e congelado, que só pode ser alterado por um procedimento formal de controle de mudanças, é chamado de:
- a) Repositório distribuído.
- b) Baseline.
- c) Sprint.
- d) Pull request.
- e) Item de risco.

*Questão 2.* A principal diferença entre um sistema de controle de versão centralizado (ex.: CVS) e um distribuído (ex.: Git) é que:
- a) Sistemas centralizados não permitem múltiplos desenvolvedores.
- b) Em sistemas distribuídos, cada desenvolvedor tem uma cópia completa do repositório e seu histórico, podendo trabalhar offline.
- c) Sistemas distribuídos não suportam controle de conflitos.
- d) CVS é mais recente que Git.
- e) Não há diferença conceitual relevante entre os dois modelos.

*Questão 3.* Gerenciamento de Configuração de Software (GCS) é mais bem descrito como:
- a) Sinônimo exato de controle de versão de código-fonte.
- b) Um conjunto de práticas que inclui identificação de itens de configuração, controle de versão, controle formal de mudanças e auditoria -- controle de versão é apenas uma parte.
- c) Uma técnica exclusiva do modelo em cascata.
- d) Uma característica de qualidade do modelo ISO/IEC 25010.
- e) Um sinônimo de metodologia ágil.

== Gabarito comentado

1. *(b)* -- definição direta de baseline, conforme esta seção.
2. *(b)* -- é exatamente a diferença central entre os dois modelos de controle de versão.
3. *(b)* -- GCS é mais amplo que controle de versão, incluindo também controle de mudanças e auditoria.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 25 (Gerenciamento de configuração).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 29 (Gerenciamento de configuração de software).
- MIT OpenCourseWare -- 1.124J *Foundations of Software Engineering* (Fall 2000), aula "Source Code Management Using CVS".
