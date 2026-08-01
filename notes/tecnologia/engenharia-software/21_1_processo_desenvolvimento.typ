#import "@preview/mousse-notes:1.1.0": *

= 21.1 --- Processo de Desenvolvimento de Software

== Introdução

Engenharia de Software trata do desenvolvimento *sistemático* de software, em contraste com programação ad-hoc. O ponto de partida conceitual é o *processo*: o conjunto organizado de atividades que leva de uma necessidade a um produto de software. A POSCOMP costuma cobrar essa subseção com questões de associação conceito ↔ definição.

== Definições formais

#definition(name: "Processo de software", id: "def-processo-software")[
  Conjunto estruturado de atividades necessárias para desenvolver um sistema de software, tipicamente organizadas em quatro atividades fundamentais (Sommerville):
  - *Especificação*: definir o que o software deve fazer e suas restrições.
  - *Desenvolvimento*: projetar e implementar o software conforme a especificação.
  - *Validação*: checar se o software atende ao que o cliente espera.
  - *Evolução*: modificar o software para atender a novas necessidades.
]

#definition(name: "Modelo de processo vs. metodologia", id: "def-modelo-processo-metodologia")[
  Um *modelo de processo* é uma representação abstrata e simplificada de um processo de software (ex.: cascata, espiral -- ver 21.2), descrevendo a ordem/organização geral das atividades. Uma *metodologia* é mais concreta: um conjunto específico de métodos, técnicas, ferramentas e notações que instancia um modelo de processo na prática (ex.: Scrum é uma metodologia ágil concreta; RUP instancia um processo iterativo).
]

== Exemplo resolvido

#example(name: "Mapeando um projeto às quatro atividades fundamentais", id: "ex-quatro-atividades")[
  Uma equipe recebe o pedido de um cliente para um sistema de agendamento de consultas médicas.
  - *Especificação*: levantar com o cliente quais tipos de usuário existem (paciente, médico, recepção), quais operações são necessárias, restrições legais (ex.: LGPD).
  - *Desenvolvimento*: projetar o banco de dados, a interface, implementar as funcionalidades.
  - *Validação*: apresentar o sistema ao cliente, rodar testes de aceitação, confirmar que atende à necessidade original.
  - *Evolução*: meses depois, adicionar suporte a telemedicina, uma necessidade que surgiu após o uso real do sistema.
]

== Atenção -- pegadinhas comuns

#remark(name: "Processo ad-hoc não é \"ausência de processo\"")[
  Mesmo um time sem processo formal definido segue *implicitamente* alguma sequência de atividades -- a diferença de um processo definido é que este é explícito, documentado, repetível e passível de melhoria (base conceitual dos modelos de maturidade como o CMMI, tratado em 21.3).
]

#remark(name: "Modelo de processo não é a mesma coisa que ferramenta")[
  Um erro comum é confundir "modelo de processo" (uma abstração, como cascata ou ágil) com uma ferramenta específica (ex.: Jira, Git). A ferramenta *apoia* a execução de um processo/metodologia, mas não o define.
]

== Questões estilo POSCOMP

*Questão 1.* Associe corretamente cada atividade fundamental do processo de software à sua descrição: (I) Especificação, (II) Desenvolvimento, (III) Validação, (IV) Evolução -- (a) modificar o sistema para atender a novas necessidades; (b) definir o que o sistema deve fazer; (c) checar se o sistema atende ao que o cliente espera; (d) projetar e implementar o sistema.
- a) I-b, II-d, III-c, IV-a.
- b) I-a, II-b, III-c, IV-d.
- c) I-c, II-a, III-b, IV-d.
- d) I-d, II-b, III-a, IV-c.
- e) I-b, II-c, III-d, IV-a.

*Questão 2.* A diferença entre um "modelo de processo" e uma "metodologia" é:
- a) Não há diferença; os termos são sinônimos.
- b) Modelo de processo é uma abstração geral (ex.: cascata); metodologia é uma instanciação concreta com métodos, técnicas e notações específicas (ex.: Scrum).
- c) Metodologia é sempre mais abstrata que modelo de processo.
- d) Modelo de processo só existe para desenvolvimento ágil.
- e) Metodologia se refere apenas a ferramentas de software.

*Questão 3.* Um time de desenvolvimento sem um processo formal e documentado:
- a) Não segue processo algum, em qualquer sentido.
- b) Ainda segue implicitamente alguma sequência de atividades, mas de forma não explícita nem necessariamente repetível.
- c) Está automaticamente em conformidade com o nível mais alto de maturidade CMMI.
- d) Não pode produzir software funcional.
- e) Está usando o modelo em cascata por padrão.

== Gabarito comentado

1. *(a)* -- mapeamento direto conforme a definição de processo de software desta seção.
2. *(b)* -- modelo de processo é abstrato; metodologia é a instanciação concreta.
3. *(b)* -- processo ad-hoc ainda é um processo, apenas implícito e não documentado.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 2 (Processos de software).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 2 (Processo de software).
- cienciadacomputacao.wiki.br -- Tópico 21, subtópico 21.1.
