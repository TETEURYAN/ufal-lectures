#import "@preview/mousse-notes:1.1.0": *
= Conceitos de Tarefas

== Introdução

Uma vez que compreendemos os conceitos básicos dos Sistemas Operacionais, é importante destacar o conceito de tarefas. As tarefas são unidades de trabalho que um Sistema Operacional gerencia e executa. Elas podem ser processos, threads ou outras formas de execução de código. O gerenciamento de tarefas é uma função crucial dos Sistemas Operacionais, pois permite que eles alocem recursos de forma eficiente e garantam a execução correta dos programas.



#definition[
  Tarefa é definida como a execução de um fluxo sequencial de instruções que foram construídas para atender a uma finalidade específica
]


Uma analogia citada por @book para diferenciar programa de tarefa é a de uma receita de bolo:
O programa é como a receita escrita em um livro guardado na estante (estático).

A tarefa é a ação de "executar" a receita na cozinha, onde a cozinheira (o processador) segue os passos, utiliza os ingredientes (entradas) e produz o bolo (saída). Cada vez que a receita é executada, uma nova tarefa é criada, mesmo que o programa (a receita) seja o mesmo. Assim, o programa é a descrição estática do que deve ser feito, enquanto a tarefa é a execução dinâmica dessa descrição.