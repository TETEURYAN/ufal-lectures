#import "@preview/mousse-notes:1.1.0": *

= Tipos de Dados Básicos e Estruturados

== Introdução

Antes de manipular qualquer valor, um algoritmo precisa saber *o que* aquele valor é e *quais
operações* são válidas sobre ele. Isso é formalizado pelo conceito de tipo de dado. Distinguir tipos
básicos (indivisíveis) de tipos estruturados (compostos a partir de outros tipos) é pré-requisito
para entender estruturas de dados mais complexas (listas, árvores, hashes) nos próximos tópicos.

== Definições formais

#definition(id: "def-tipo-dado")[
  Um *tipo de dado* é definido por um par $(D, O)$, em que $D$ é um *domínio* (conjunto de valores
  possíveis) e $O$ é um conjunto de *operações* válidas sobre esses valores.
]

#definition(id: "def-tipo-basico")[
  Um *tipo de dado básico* (ou *primitivo* / *escalar*) representa um único valor indivisível pela
  linguagem — não é decomposto em outros tipos. Os tipos básicos mais comuns são:
  - *Inteiro* ($ZZ$): valores numéricos sem parte fracionária.
  - *Real / ponto flutuante* ($RR$, aproximado): valores numéricos com parte fracionária,
    representados com precisão finita (padrão IEEE 754).
  - *Caractere*: um símbolo de um alfabeto (ASCII, Unicode).
  - *Booleano*: domínio $\{"verdadeiro", "falso"\}$, com operações lógicas ($and, or, not$).
]

#definition(id: "def-tipo-estruturado")[
  Um *tipo de dado estruturado* (ou *composto*) é construído a partir de tipos básicos e/ou outros
  tipos estruturados, agrupando múltiplos valores sob uma única variável. Os principais mecanismos
  de composição são:
  - *Array (vetor/matriz)*: coleção homogênea, de tamanho fixo, indexada por posição.
  - *Registro (struct/record)*: coleção heterogênea de campos nomeados.
  - *Conjunto (set)*: coleção não ordenada de valores distintos.
  - *Arquivo*: sequência de registros persistida em memória secundária.
  - *Tipos abstratos de dados (TADs)*: listas, pilhas, filas, árvores, grafos — definidos pelo
    comportamento (interface) e não pela representação interna (ver tópicos 9.8–9.10).
]

#remark[
  Um *Tipo Abstrato de Dados (TAD)* separa *o que* uma estrutura faz (sua interface: por exemplo,
  `empilhar`/`desempilhar` de uma pilha) de *como* ela é implementada (array ou lista encadeada). Isso
  é diferente de um tipo estruturado "cru" como um array, que expõe diretamente sua representação.
]

== Classificação quanto à tipagem

#definition(id: "def-tipagem")[
  Uma linguagem tem tipagem *estática* quando o tipo de cada variável é verificado em tempo de
  compilação, e *dinâmica* quando a verificação ocorre em tempo de execução. Uma linguagem tem
  tipagem *forte* quando não permite operações entre tipos incompatíveis sem conversão explícita, e
  *fraca* quando realiza conversões implícitas (coerção) livremente.
]

#figure(
  table(
    columns: 3,
    stroke: 0.5pt,
    align: left,
    [*Linguagem*], [*Estática/Dinâmica*], [*Forte/Fraca*],
    [C], [Estática], [Fraca (permite coerções implícitas amplas)],
    [Java], [Estática], [Forte],
    [Python], [Dinâmica], [Forte],
    [JavaScript], [Dinâmica], [Fraca],
  ),
  caption: [Classificação de linguagens quanto à tipagem — combinações são independentes entre si.],
)

== Exemplo resolvido

#example(id: "ex-tipos-registro")[
  Um cadastro de aluno guarda nome (cadeia de caracteres), matrícula (inteiro) e coeficiente de
  rendimento (real). Modele isso como um tipo estruturado em pseudocódigo:

  ```
  tipo Aluno = registro
      nome: cadeia
      matricula: inteiro
      cr: real
  fim-registro

  var a: Aluno
  a.nome ← "Maria"
  a.matricula ← 20231234
  a.cr ← 8.7
  ```

  Note que `Aluno` combina três tipos básicos diferentes (cadeia, inteiro, real) em um único tipo
  estruturado heterogêneo — um *registro*. Um `array` de `Aluno` seria uma estrutura homogênea de
  registros, útil para representar uma turma inteira.
]

== Armadilhas comuns

#remark[
  - *Array não é TAD*: um array expõe acesso direto por índice como parte de sua definição; uma
    pilha implementada com array esconde esse acesso atrás de `empilhar`/`desempilhar` — a
    interface é o TAD, o array é apenas um detalhe de implementação possível.
  - *Tipagem estática $eq.not$ tipagem forte*: são eixos independentes. C é estaticamente tipada mas
    fracamente tipada (permite `int x = 'a';` sem erro). Python é dinamicamente tipada mas
    fortemente tipada (`"2" + 2` gera erro em vez de coagir).
  - *Ponto flutuante não é "real" matemático*: por ter precisão finita (IEEE 754), operações como
    $0.1 + 0.2 = 0.3$ podem falhar numericamente — comparar reais por igualdade exata é uma
    armadilha clássica de implementação.
]

== Questões

#example(id: "q-tipos-1")[
  *(Múltipla escolha)* Sobre tipos de dados, é correto afirmar que:

  (a) Todo tipo estruturado é um tipo abstrato de dados.
  (b) Tipagem estática implica necessariamente tipagem forte.
  (c) Um registro (struct) permite agrupar campos de tipos diferentes sob um único identificador.
  (d) Um array é, por definição, um tipo abstrato de dados.
  (e) Tipos básicos podem ser decompostos em tipos mais simples pela linguagem.
]

#example(id: "q-tipos-2")[
  *(Dissertativa curta)* Diferencie tipagem forte de tipagem estática, dando um exemplo de
  linguagem para cada uma das quatro combinações possíveis (estática/forte, estática/fraca,
  dinâmica/forte, dinâmica/fraca).
]

#solution[
  *Q1*: (c) — registros agrupam campos heterogêneos; as demais alternativas descrevem
  confusões clássicas entre tipo estruturado/TAD e entre os dois eixos de tipagem.

  *Q2*: Ver @def-tipagem e a tabela de exemplos — Java (estática/forte), C (estática/fraca),
  Python (dinâmica/forte), JavaScript (dinâmica/fraca).
]

== Referências

- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 10 (tipos e estruturas elementares).
- Sedgewick, R.; Wayne, K. *Algorithms*, cap. 1.2.
- Ziviani, N. *Projeto de Algoritmos*, cap. 2.
