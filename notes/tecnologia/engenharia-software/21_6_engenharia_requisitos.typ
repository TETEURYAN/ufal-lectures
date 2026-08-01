#import "@preview/mousse-notes:1.1.0": *

= 21.6 --- Engenharia de Requisitos

== Introdução

Requisitos definem *o que* o sistema deve fazer -- a base de toda especificação (21.1). Erros de requisitos são os mais caros de corrigir quanto mais tarde são descobertos, o que torna esta subseção uma das mais valorizadas na prática (e na POSCOMP).

== Definições formais

#definition(name: "Requisitos funcionais vs. não-funcionais", id: "def-requisitos-funcionais-nao-funcionais")[
  - *Requisito funcional*: descreve uma funcionalidade/serviço que o sistema deve prover (ex.: "o sistema deve permitir que o usuário redefina sua senha").
  - *Requisito não-funcional*: descreve uma restrição ou qualidade sobre *como* o sistema deve se comportar, não uma funcionalidade específica (ex.: desempenho, segurança, usabilidade, disponibilidade -- "o sistema deve responder a 95% das requisições em menos de 200ms"). Requisitos não-funcionais mal especificados (vagos, não mensuráveis) são uma fonte clássica de ambiguidade contratual.
]

#definition(name: "Técnicas de elicitação de requisitos", id: "def-elicitacao-requisitos")[
  Métodos para descobrir/extrair requisitos junto aos interessados (*stakeholders*): entrevistas (estruturadas ou não), questionários, observação do trabalho real do usuário (*etnografia*), workshops/JAD (*Joint Application Development*, sessões colaborativas com múltiplos stakeholders), e prototipação (21.2) usada especificamente para esclarecer requisitos incertos.
]

#definition(name: "Especificação de requisitos: casos de uso e histórias de usuário", id: "def-especificacao-requisitos")[
  - *Caso de uso*: descreve uma interação completa entre um *ator* (usuário ou sistema externo) e o sistema para atingir um objetivo, tipicamente com um fluxo principal e fluxos alternativos/exceção.
  - *História de usuário*: descrição curta e informal de uma necessidade, no formato "Como #emph[papel], quero #emph[funcionalidade], para que #emph[benefício]" -- comum em contextos ágeis (21.2), como ponto de partida para conversas de refinamento, não como especificação completa e fechada.
]

== Exemplo resolvido

#example(name: "Requisito funcional, não-funcional e história de usuário", id: "ex-requisitos-exemplo")[
  Para um sistema de e-commerce:
  - *Requisito funcional*: "O sistema deve permitir que o cliente adicione produtos ao carrinho de compras."
  - *Requisito não-funcional*: "A página de listagem de produtos deve carregar em no máximo 2 segundos com até 10.000 usuários simultâneos."
  - *História de usuário correspondente*: "Como cliente, quero adicionar produtos ao carrinho, para que eu possa comprar vários itens em uma única finalização de compra."
]

== Atenção -- pegadinhas comuns

#remark(name: "Requisito não-funcional vago não é testável")[
  "O sistema deve ser rápido" não é um requisito não-funcional utilizável -- precisa ser quantificado ("responder em até X ms para Y% das requisições") para ser verificável na fase de testes (21.8). A prova costuma pedir para identificar requisitos mal especificados por falta de critério mensurável.
]

#remark(name: "História de usuário não substitui especificação detalhada")[
  Uma história de usuário é deliberadamente informal -- um "convite à conversa", não uma especificação completa. Detalhes de comportamento (critérios de aceitação) são normalmente elaborados à parte, durante o refinamento, não embutidos na história em si.
]

== Questões estilo POSCOMP

*Questão 1.* "O sistema deve criptografar todos os dados armazenados em disco usando AES-256" é um exemplo de requisito:
- a) Funcional.
- b) Não-funcional.
- c) De processo.
- d) De gerenciamento de configuração.
- e) De manutenção.

*Questão 2.* A técnica de elicitação de requisitos que consiste em observar diretamente o usuário realizando seu trabalho, no seu ambiente real, é chamada de:
- a) Entrevista estruturada.
- b) JAD (Joint Application Development).
- c) Etnografia (observação).
- d) Prototipação descartável.
- e) Revisão de código.

*Questão 3.* Associe: (I) Requisito funcional, (II) Requisito não-funcional, (III) História de usuário -- (a) descrição informal e curta de uma necessidade, ponto de partida para conversa; (b) descreve uma funcionalidade específica; (c) descreve uma restrição de qualidade, como desempenho ou segurança.
- a) I-b, II-c, III-a.
- b) I-a, II-b, III-c.
- c) I-c, II-a, III-b.
- d) I-b, II-a, III-c.
- e) I-c, II-b, III-a.

== Gabarito comentado

1. *(b)* -- criptografia é uma restrição de segurança sobre como os dados são tratados, não uma funcionalidade em si -- requisito não-funcional.
2. *(c)* -- observação direta do trabalho real do usuário é a definição de etnografia como técnica de elicitação.
3. *(a)* -- mapeamento direto conforme as definições desta seção.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 4--5 (Engenharia de requisitos).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 7--8 (Engenharia de requisitos).
- COHN, M. *User Stories Applied*. Cap. 1--2 (Histórias de usuário).
