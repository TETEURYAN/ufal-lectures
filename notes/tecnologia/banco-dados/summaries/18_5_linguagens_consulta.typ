#import "@preview/mousse-notes:1.1.0": *

= 18.5 --- Linguagens de Consulta

== Introdução

Linguagens de consulta permitem recuperar e manipular dados. A POSCOMP explora tanto os fundamentos formais (álgebra e cálculo relacional) quanto SQL na prática -- em especial junções, agregação com `GROUP BY`/`HAVING` e subconsultas. É o subtópico com maior densidade de questões objetivas envolvendo código.

== Definições formais

#definition(name: "Álgebra relacional", id: "def-algebra-relacional")[
  Linguagem procedural cujos operandos são relações e cujos operadores básicos são: seleção (`σ`, filtra tuplas por predicado), projeção (`π`, seleciona colunas), união, diferença, produto cartesiano e renomeação. Junção (`⋈`), interseção e divisão são operadores derivados, expressáveis a partir dos básicos.
]

#definition(name: "Cálculo relacional", id: "def-calculo-relacional")[
  Linguagem declarativa (não procedural) que descreve *o que* se quer, não *como* obter -- por meio de fórmulas lógicas sobre tuplas (cálculo de tuplas) ou domínios (cálculo de domínios). SQL é declarativo e inspirado no cálculo relacional; sua equivalência de poder expressivo com a álgebra relacional é conhecida como *completude relacional*.
]

#definition(name: "Tipos de junção em SQL", id: "def-tipos-juncao")[
  - *Inner join*: retorna apenas as tuplas com correspondência em ambos os lados.
  - *Left/right outer join*: preserva todas as tuplas de um dos lados, preenchendo com `NULL` quando não há correspondência.
  - *Full outer join*: preserva as tuplas de ambos os lados.
  - *Natural join*: inner join implícito por todas as colunas de mesmo nome.
  - *Self join*: junção de uma tabela consigo mesma, usando aliases.
]

== Exemplo resolvido

#example(name: "WHERE vs. HAVING e subconsulta correlacionada", id: "ex-sql-having")[
  Considere `Matricula(aluno_id, disciplina_id, nota)`.

  ```sql
  -- Filtra alunos com média >= 7, agrupando por aluno
  SELECT aluno_id, AVG(nota) AS media
  FROM Matricula
  WHERE nota IS NOT NULL
  GROUP BY aluno_id
  HAVING AVG(nota) >= 7;

  -- Subconsulta correlacionada: alunos com nota acima da média da própria disciplina
  SELECT m1.aluno_id, m1.disciplina_id
  FROM Matricula m1
  WHERE m1.nota > (
    SELECT AVG(m2.nota)
    FROM Matricula m2
    WHERE m2.disciplina_id = m1.disciplina_id
  );
  ```

  Em álgebra relacional, a primeira consulta corresponde aproximadamente a uma agregação agrupada seguida de uma seleção sobre o resultado agregado (`σ` aplicado *depois* do agrupamento, nunca antes -- por isso `HAVING`, e não `WHERE`, filtra por `AVG(nota)`).
]

== Atenção -- pegadinhas comuns

#remark(name: "WHERE filtra linhas, HAVING filtra grupos")[
  `WHERE` é aplicado *antes* do agrupamento (não pode referenciar funções de agregação). `HAVING` é aplicado *depois* do `GROUP BY` (pode e geralmente referencia agregações como `AVG`, `COUNT`, `SUM`).
]

#remark(name: "NATURAL JOIN é arriscado")[
  `NATURAL JOIN` une automaticamente por *todas* as colunas de mesmo nome -- se houver uma coluna homônima não intencional (ex.: duas tabelas com `data_criacao`), o resultado muda silenciosamente. `JOIN ... USING(col)` ou `JOIN ... ON` são mais seguros e explícitos.
]

#remark(name: "Lógica de três valores com NULL")[
  Em SQL, comparações envolvendo `NULL` resultam em `UNKNOWN`, não em `TRUE`/`FALSE`. Por isso `coluna = NULL` nunca é verdadeiro (é preciso `IS NULL`), e `NOT IN` com uma subconsulta que retorna `NULL` pode silenciosamente não retornar nenhuma linha.
]

== Questões estilo POSCOMP

*Questão 1.* Em uma consulta SQL com `GROUP BY`, a cláusula que filtra grupos com base no resultado de uma função de agregação é:
- a) `WHERE`.
- b) `HAVING`.
- c) `ORDER BY`.
- d) `DISTINCT`.
- e) `LIMIT`.

*Questão 2.* Assinale a alternativa correta sobre álgebra relacional e cálculo relacional:
- a) Álgebra relacional é declarativa; cálculo relacional é procedural.
- b) Ambos têm exatamente o mesmo poder expressivo, mas a álgebra é procedural e o cálculo é declarativo.
- c) SQL é baseado exclusivamente na álgebra relacional.
- d) Junção é um operador básico da álgebra relacional, não derivado.
- e) Cálculo relacional não possui fundamentação lógica formal.

*Questão 3.* Um `LEFT OUTER JOIN` entre as tabelas `Aluno` e `Matricula` (à direita), pela chave `aluno_id`:
- a) Retorna apenas alunos que possuem ao menos uma matrícula.
- b) Retorna todos os alunos, com `NULL` nos campos de `Matricula` para os que não têm matrícula.
- c) Retorna apenas matrículas sem aluno correspondente.
- d) É equivalente a um `INNER JOIN` quando não há valores nulos.
- e) Nunca retorna valores nulos.

*Questão 4.* Sobre o uso de `NULL` em predicados SQL, é correto afirmar:
- a) `coluna = NULL` é a forma correta de testar se uma coluna é nula.
- b) Comparações com `NULL` seguem lógica booleana de dois valores (verdadeiro/falso).
- c) Uma comparação envolvendo `NULL` resulta em `UNKNOWN`, exigindo `IS NULL` para o teste correto.
- d) `NULL` é tratado como zero em comparações numéricas.
- e) `NOT IN` com subconsulta contendo `NULL` sempre se comporta como esperado.

== Gabarito comentado

1. *(b)* -- `HAVING` filtra após o agrupamento, podendo usar agregações; `WHERE` não pode.
2. *(b)* -- Codd provou a equivalência de poder expressivo entre álgebra e cálculo relacional (completude relacional); a álgebra é procedural, o cálculo é declarativo.
3. *(b)* -- `LEFT OUTER JOIN` preserva todas as linhas da tabela à esquerda (`Aluno`), preenchendo com `NULL` quando não há correspondência em `Matricula`.
4. *(c)* -- SQL usa lógica de três valores; `= NULL` nunca é verdadeiro, sendo necessário `IS NULL`.

== Referências

- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*. Caps. 6--8 (Álgebra/cálculo relacional e SQL).
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*. Caps. 2--3, 5 (Álgebra relacional e SQL).
