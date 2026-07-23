#import "@preview/mousse-notes:1.1.0": *

= 18.3 --- SGBD: Arquitetura, Segurança, Integridade

== Introdução

Um Sistema de Gerenciamento de Banco de Dados (SGBD) é o software que intermedeia o acesso ao banco, aplicando restrições de integridade e controlando quem pode ler ou modificar o quê. A POSCOMP cobra componentes internos do SGBD, os tipos de restrição de integridade e os mecanismos de controle de acesso -- geralmente em questões conceituais, sem cálculo.

== Definições formais

#definition(name: "SGBD", id: "def-sgbd")[
  Coleção de programas que permite a usuários criar, manter e consultar um banco de dados, oferecendo abstração dos detalhes de armazenamento (ver @def-ansi-sparc), controle de concorrência, recuperação após falhas e mecanismos de segurança.
]

#definition(name: "Restrições de integridade", id: "def-restricoes-integridade")[
  - *Integridade de domínio*: valores de um atributo devem pertencer ao seu domínio (tipo, faixa, formato).
  - *Integridade de entidade*: nenhum atributo que compõe a chave primária pode ser nulo.
  - *Integridade referencial*: todo valor de chave estrangeira deve corresponder a um valor existente de chave primária na relação referenciada, ou ser nulo.
  - *Restrição definida pelo usuário (check constraint)*: regra de negócio adicional expressa explicitamente no esquema.
]

#definition(name: "Controle de acesso", id: "def-controle-acesso")[
  - *DAC (Discretionary Access Control)*: o dono de um objeto concede/revoga privilégios a outros usuários (`GRANT`/`REVOKE` em SQL).
  - *MAC (Mandatory Access Control)*: acesso definido por níveis de classificação fixos (ex.: confidencial, secreto), não discricionário ao dono do objeto.
  - *RBAC (Role-Based Access Control)*: privilégios são atribuídos a papéis (roles), e usuários recebem papéis.
]

== Ações de integridade referencial

Ao definir uma chave estrangeira, o SGBD precisa saber o que fazer quando a linha referenciada é removida ou atualizada:

#table(
  columns: 2,
  [*Ação*], [*Efeito*],
  [`CASCADE`], [Propaga a remoção/atualização para as linhas dependentes.],
  [`RESTRICT` / `NO ACTION`], [Rejeita a operação se existirem linhas dependentes.],
  [`SET NULL`], [Define a chave estrangeira das linhas dependentes como nula.],
  [`SET DEFAULT`], [Define a chave estrangeira das linhas dependentes com um valor padrão.],
)

== Exemplo resolvido

#example(name: "Segurança e integridade em SQL", id: "ex-sgbd-sql")[
  ```sql
  -- Restrição de domínio + entidade + referencial
  CREATE TABLE Matricula (
    aluno_id      INT NOT NULL,
    disciplina_id INT NOT NULL,
    nota          DECIMAL(4,2) CHECK (nota BETWEEN 0 AND 10),
    PRIMARY KEY (aluno_id, disciplina_id),
    FOREIGN KEY (aluno_id) REFERENCES Aluno(aluno_id)
      ON DELETE CASCADE,
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(disciplina_id)
      ON DELETE RESTRICT
  );

  -- Controle de acesso discricionário (DAC)
  GRANT SELECT, INSERT ON Matricula TO secretaria;
  REVOKE INSERT ON Matricula FROM secretaria;
  ```

  Note a diferença de comportamento: remover um `Aluno` remove em cascata suas matrículas, mas remover uma `Disciplina` com matrículas ativas é *rejeitado* pelo SGBD.
]

== Atenção -- pegadinhas comuns

#remark(name: "Entidade vs. referencial")[
  Integridade de *entidade* é sobre a chave primária nunca ser nula; integridade *referencial* é sobre a chave estrangeira sempre apontar para algo válido (ou nulo). Provas trocam essas definições propositalmente.
]

#remark(name: "View como mecanismo de segurança")[
  Uma visão (view) pode restringir o acesso a colunas ou linhas sensíveis sem duplicar dados -- é uma forma de segurança combinada com independência lógica (@def-independencia-dados), não um mecanismo de integridade.
]

== Questões estilo POSCOMP

*Questão 1.* A restrição que impede que um atributo que faz parte da chave primária de uma relação receba valor nulo é chamada de:
- a) Integridade referencial.
- b) Integridade de domínio.
- c) Integridade de entidade.
- d) Integridade definida pelo usuário.
- e) Integridade transacional.

*Questão 2.* Em um modelo de controle de acesso RBAC:
- a) Privilégios são concedidos diretamente pelo dono do objeto a cada usuário.
- b) O acesso é definido por níveis hierárquicos fixos de classificação de segurança.
- c) Privilégios são associados a papéis, e usuários recebem papéis que carregam esses privilégios.
- d) RBAC é sinônimo de MAC.
- e) RBAC não permite revogação de privilégios.

*Questão 3.* Uma chave estrangeira definida com `ON DELETE RESTRICT` faz com que:
- a) A remoção da linha referenciada seja sempre propagada para as linhas dependentes.
- b) A remoção da linha referenciada seja rejeitada se existirem linhas dependentes.
- c) As linhas dependentes tenham a chave estrangeira definida como nula.
- d) A operação seja sempre permitida, ignorando as linhas dependentes.
- e) Nenhuma das anteriores.

== Gabarito comentado

1. *(c)* -- por definição, essa é exatamente a integridade de entidade.
2. *(c)* -- RBAC intermedeia usuários e privilégios por meio de papéis; (a) descreve DAC e (b) descreve MAC.
3. *(b)* -- `RESTRICT`/`NO ACTION` bloqueia a operação enquanto houver dependência; `CASCADE` propagaria, `SET NULL` anularia a FK.

== Referências

- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*. Cap. 5 (Restrições) e Cap. 24 (Segurança).
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*. Cap. 4 (Integridade e segurança em SQL).
