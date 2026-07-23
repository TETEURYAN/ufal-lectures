#import "@preview/mousse-notes:1.1.0": *

= 18.2 --- Modelagem e Projeto de Banco de Dados

== Introdução

O projeto de um banco de dados segue tipicamente três fases: modelagem conceitual (diagrama entidade-relacionamento), projeto lógico (mapeamento para o modelo relacional) e normalização (eliminar redundância e anomalias). A POSCOMP cobra fortemente cardinalidades de relacionamento, dependências funcionais e as formas normais até BCNF -- é um dos assuntos com mais questões objetivas de Banco de Dados.

== Definições formais

#definition(name: "Entidade, Atributo e Relacionamento", id: "def-er-basico")[
  Uma *entidade* é um objeto do mundo real distinguível dos demais (ex.: um aluno). Um *atributo* descreve uma propriedade de uma entidade ou relacionamento, podendo ser simples, composto, monovalorado, multivalorado ou derivado. Um *relacionamento* é uma associação entre duas ou mais entidades.
]

#definition(name: "Chaves", id: "def-chaves")[
  - *Superchave*: conjunto de atributos que identifica uma tupla de forma única.
  - *Chave candidata*: superchave minimal (nenhum subconjunto próprio ainda identifica a tupla unicamente).
  - *Chave primária*: a chave candidata escolhida para identificar as tuplas da relação.
  - *Chave estrangeira*: atributo (ou conjunto) que referencia a chave primária de outra relação (ou da mesma), garantindo integridade referencial.
]

#definition(name: "Dependência Funcional", id: "def-dependencia-funcional")[
  Dado um esquema de relação $R$ e dois subconjuntos de atributos $X, Y subset.eq R$, dizemos que $X arrow.r Y$ (lê-se "$X$ determina $Y$") se, para quaisquer duas tuplas com o mesmo valor em $X$, os valores em $Y$ também são iguais.
]

#definition(name: "Formas Normais", id: "def-formas-normais")[
  - *1FN*: todos os atributos possuem domínios atômicos (sem grupos repetitivos ou atributos multivalorados).
  - *2FN*: está em 1FN e todo atributo não-chave depende *totalmente* da chave primária (sem dependência parcial em relação a uma chave composta).
  - *3FN*: está em 2FN e não há dependência *transitiva* de atributo não-chave sobre a chave primária (nenhum atributo não-chave depende de outro atributo não-chave).
  - *BCNF (Boyce-Codd)*: para toda dependência funcional não trivial $X arrow.r Y$ válida em $R$, $X$ é uma superchave de $R$.
]

== Propriedade relevante

#theorem(name: "Decomposição sem perda e preservação de dependências", id: "thm-decomposicao")[
  Ao decompor uma relação $R$ em $R_1$ e $R_2$ para eliminar uma anomalia, a decomposição é *sem perda de junção* (lossless-join) se $R_1 inter R_2$ for uma chave (superchave) de pelo menos uma delas. Toda decomposição em BCNF pode ser feita sem perda, mas nem sempre preserva todas as dependências funcionais originais -- por isso 3FN é, na prática, frequentemente preferida a BCNF em projetos reais, pois garante simultaneamente as duas propriedades.
]

#proof[
  Se $R_1 inter R_2 arrow.r R_1$ (ou $R_1 inter R_2 arrow.r R_2$), então o atributo em comum determina funcionalmente todos os atributos de uma das partes, o que é suficiente para reconstruir $R$ exatamente via $R_1 join R_2$ (junção natural), sem gerar tuplas espúrias.
]

== Exemplo resolvido

#example(name: "Normalização até 3FN", id: "ex-normalizacao")[
  Considere a relação não normalizada:

  `Matricula(aluno_id, aluno_nome, disciplina_id, disciplina_nome, professor, sala_professor, nota)`

  com as dependências funcionais: `aluno_id -> aluno_nome`; `disciplina_id -> disciplina_nome, professor`; `professor -> sala_professor`; `(aluno_id, disciplina_id) -> nota`.

  - *1FN*: já satisfeita (atributos atômicos).
  - *2FN*: `aluno_nome` depende só de `aluno_id` (parte da chave composta `(aluno_id, disciplina_id)`) -- dependência parcial. Decompomos:
    `Aluno(aluno_id, aluno_nome)`, `Disciplina(disciplina_id, disciplina_nome, professor)`, `Matricula(aluno_id, disciplina_id, nota)`.
  - *3FN*: em `Disciplina`, `sala_professor` depende de `professor`, que não é chave -- dependência transitiva. Decompomos novamente:
    `Disciplina(disciplina_id, disciplina_nome, professor)`, `Professor(professor, sala_professor)`.

  Resultado final em 3FN: `Aluno`, `Disciplina`, `Professor`, `Matricula`.
]

== Atenção -- pegadinhas comuns

#remark(name: "2FN só é relevante com chave composta")[
  Se a chave primária é um único atributo, a relação está automaticamente em 2FN sempre que está em 1FN -- não existe dependência parcial possível em relação a uma chave simples.
]

#remark(name: "3FN vs. BCNF")[
  A diferença só aparece quando há *sobreposição de chaves candidatas*. BCNF é mais restritiva: pode exigir decompor uma relação que já está em 3FN, perdendo a preservação de alguma dependência funcional. Provas gostam de pedir um exemplo clássico com duas chaves candidatas que se sobrepõem parcialmente.
]

#remark(name: "Anomalias motivam a normalização")[
  As três anomalias clássicas de uma relação não normalizada: *inserção* (não dá para inserir um professor sem uma disciplina associada), *remoção* (apagar a última disciplina de um professor apaga também o dado do professor) e *atualização* (mudar a sala de um professor exige atualizar várias linhas).
]

== Questões estilo POSCOMP

*Questão 1.* Uma relação $R(A, B, C, D)$ tem chave primária $(A, B)$ e a dependência funcional $C arrow.r D$, onde $C$ não é subconjunto de nenhuma chave candidata. $R$ viola:
- a) 1FN, apenas.
- b) 2FN, apenas.
- c) 3FN, mas está em 2FN.
- d) BCNF, mas está em 3FN.
- e) Nenhuma forma normal é violada.

*Questão 2.* Sobre chave candidata e chave primária, é correto afirmar:
- a) Toda relação possui exatamente uma chave candidata.
- b) A chave primária é sempre composta por mais de um atributo.
- c) Uma chave candidata é uma superchave minimal; a chave primária é a candidata escolhida para identificar as tuplas.
- d) Chave estrangeira e chave candidata são conceitos equivalentes.
- e) Uma relação em BCNF não pode ter mais de uma chave candidata.

*Questão 3.* Em uma decomposição de $R$ em $R_1$ e $R_2$, a propriedade de junção sem perda (lossless-join) é garantida quando:
- a) $R_1 union R_2 = R$, apenas.
- b) $R_1 inter R_2$ é uma superchave de $R_1$ ou de $R_2$.
- c) $R_1$ e $R_2$ possuem o mesmo número de atributos.
- d) Todas as dependências funcionais de $R$ são preservadas.
- e) $R_1$ e $R_2$ não compartilham nenhum atributo.

*Questão 4.* Qual das alternativas descreve corretamente a diferença entre 3FN e BCNF?
- a) BCNF é menos restritiva que 3FN.
- b) 3FN exige que não haja dependência transitiva; BCNF exige que todo determinante de uma DF não trivial seja superchave, sendo estritamente mais restritiva.
- c) 3FN e BCNF são sempre equivalentes para qualquer esquema de relação.
- d) BCNF só se aplica a relações com chave simples.
- e) 3FN elimina dependências parciais; BCNF elimina apenas dependências multivaloradas.

== Gabarito comentado

1. *(c)* -- $C arrow.r D$ com $C$ não sendo (nem contendo) chave é dependência transitiva de atributo não-chave sobre outro não-chave: viola 3FN, mas como não há dependência parcial em relação à chave composta $(A,B)$ descrita, 2FN está satisfeita.
2. *(c)* -- definição direta: candidata = superchave minimal; primária = a candidata escolhida.
3. *(b)* -- é exatamente a condição suficiente de junção sem perda vista no teorema desta seção.
4. *(b)* -- BCNF é estritamente mais restritiva que 3FN (toda relação em BCNF está em 3FN, mas a recíproca não vale).

== Referências

- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*. Caps. 3--4 (Modelo ER) e 14--15 (Dependências funcionais e normalização).
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*. Cap. 7 (Projeto de banco de dados relacional).
