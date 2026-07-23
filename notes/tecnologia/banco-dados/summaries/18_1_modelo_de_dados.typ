#import "@preview/mousse-notes:1.1.0": *

= 18.1 --- Modelo de Dados

== Introdução

Um modelo de dados é o conjunto de conceitos usados para descrever a estrutura de um banco de dados: quais tipos de informação existem, como se relacionam e quais restrições valem sobre eles. A POSCOMP costuma cobrar aqui a arquitetura de três esquemas (ANSI/SPARC), os tipos de independência de dados e a distinção entre os níveis conceitual, lógico e físico -- temas curtos, mas frequentes na prova.

== Definições formais

#definition(name: "Modelo de Dados", id: "def-modelo-dados")[
  Conjunto de conceitos que permite descrever a estrutura de um banco de dados: os tipos de dados, os relacionamentos entre eles e as restrições de consistência que devem ser respeitadas.
]

#definition(name: "Esquema vs. Instância", id: "def-esquema-instancia")[
  O *esquema* é a descrição do banco de dados (a estrutura, definida no momento do projeto e raramente alterada). A *instância* (ou estado) é o conteúdo do banco de dados em um determinado instante, que muda a cada operação de inserção, remoção ou atualização.
]

#definition(name: "Arquitetura ANSI/SPARC (três esquemas)", id: "def-ansi-sparc")[
  Organização de um SGBD em três níveis de abstração:
  - *Nível interno (físico)*: como os dados são de fato armazenados (arquivos, índices, blocos).
  - *Nível conceitual (lógico)*: estrutura completa do banco para toda a comunidade de usuários, independente de detalhes físicos (ex.: um esquema relacional).
  - *Nível externo (visões)*: o que cada grupo de usuários enxerga -- subconjuntos ou combinações do esquema conceitual (ex.: views).
]

#definition(name: "Independência de Dados", id: "def-independencia-dados")[
  Capacidade de alterar o esquema em um nível sem exigir alteração do esquema no nível superior.
  - *Independência física*: mudar a organização de armazenamento (novo índice, nova estrutura de arquivo) sem afetar o esquema conceitual.
  - *Independência lógica*: mudar o esquema conceitual (ex.: adicionar uma entidade) sem afetar os esquemas externos e as aplicações existentes.
]

== Modelos de dados usuais

Historicamente, os modelos evoluíram do hierárquico e em rede (SGBDs de navegação, anos 1960-70) para o relacional (Codd, 1970), e depois surgiram extensões orientadas a objetos e objeto-relacionais.

#table(
  columns: 3,
  [*Modelo*], [*Estrutura básica*], [*Característica marcante*],
  [Hierárquico], [Árvore de registros], [Relacionamento 1:N rígido, navegação top-down],
  [Em rede (CODASYL)], [Grafo de registros], [Permite N:M via ponteiros, navegação por conjuntos],
  [Relacional], [Tabelas (relações)], [Baseado em álgebra/cálculo relacional, independência de dados forte],
  [Orientado a objetos], [Objetos com identidade], [Encapsula dados e comportamento, herança],
  [Entidade-Relacionamento], [Entidades e relacionamentos], [Modelo *conceitual*, não é implementado diretamente por um SGBD],
)

== Exemplo resolvido

#example(name: "Três esquemas de um sistema acadêmico", id: "ex-tres-esquemas")[
  Considere um sistema de matrículas universitárias.
  - *Nível interno*: a tabela `Aluno` está armazenada em um arquivo indexado por hash na coluna `matricula`.
  - *Nível conceitual*: o esquema relacional define `Aluno(matricula, nome, curso)` e `Matricula(matricula, cod_disciplina, semestre)`.
  - *Nível externo*: a secretaria enxerga uma visão só com `nome` e `curso`; a coordenação enxerga uma visão com `matricula` e as disciplinas cursadas.

  Se o DBA trocar o índice hash por uma B+-tree (nível interno), nada muda no nível conceitual nem nas visões -- isso é independência *física*.
]

== Atenção -- pegadinhas comuns

#remark(name: "Esquema não é instância")[
  Provas costumam trocar os termos propositalmente: "o valor atual de uma tabela" é a *instância*, não o *esquema*. O esquema é a definição da estrutura, e mudar raramente.
]

#remark(name: "Independência lógica é a mais difícil de garantir")[
  Um erro comum é achar que independência física é "mais importante" ou mais difícil. Na prática, a independência *lógica* é mais difícil de obter, pois mudanças no esquema conceitual tendem a se propagar para aplicações que dependem diretamente dele.
]

== Questões estilo POSCOMP

*Questão 1.* Na arquitetura ANSI/SPARC de três esquemas, o nível que descreve como os dados são fisicamente armazenados, incluindo estruturas de índice, é chamado de:
- a) Nível conceitual.
- b) Nível externo.
- c) Nível interno.
- d) Nível lógico-relacional.
- e) Nível de visão.

*Questão 2.* Assinale a alternativa correta sobre independência de dados:
- a) Independência física garante que aplicações não precisem ser alteradas quando o esquema conceitual muda.
- b) Independência lógica garante que o esquema conceitual não precise mudar quando a organização física dos arquivos muda.
- c) Independência física permite reorganizar índices e arquivos de armazenamento sem alterar o esquema conceitual.
- d) Independência lógica e física são sinônimos na arquitetura ANSI/SPARC.
- e) Nenhuma das alternativas anteriores.

*Questão 3.* O modelo de dados que serve tipicamente como ferramenta de modelagem *conceitual*, e não como modelo diretamente implementado por um SGBD comercial, é o:
- a) Modelo relacional.
- b) Modelo em rede.
- c) Modelo entidade-relacionamento.
- d) Modelo orientado a objetos.
- e) Modelo hierárquico.

== Gabarito comentado

1. *(c)* -- por definição, o nível interno trata do armazenamento físico e das estruturas de acesso (índices, hashing, clustering).
2. *(c)* -- independência física é justamente a possibilidade de mudar a organização de armazenamento sem afetar o esquema conceitual (e, por consequência, as aplicações). As alternativas (a) e (b) trocam as definições de física e lógica.
3. *(c)* -- o modelo ER é uma ferramenta de projeto conceitual; na implementação, ele é mapeado para o modelo relacional (ou outro modelo lógico).

== Referências

- ELMASRI, R.; NAVATHE, S. B. *Sistemas de Banco de Dados*. Cap. 2 (Modelagem de dados e arquitetura de três esquemas).
- SILBERSCHATZ, A.; KORTH, H.; SUDARSHAN, S. *Sistema de Banco de Dados*. Cap. 1 (Introdução, arquitetura de SGBD).
