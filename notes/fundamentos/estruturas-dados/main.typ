#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Algoritmos e Estruturas de Dados],
  subtitle: [Metodologia, Estruturas Lineares, Árvores, Hashing e Ordenação],
  subsubtitle: [
    Notas de aula e resumo de estudo
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Niklaus Wirth],
  )[Algorithms + Data Structures = Programs.],

  font-style: "serif",
)

#include "lectures/01-metodologia-desenvolvimento-algoritmos.typ"
#include "lectures/02-tipos-de-dados.typ"
#include "lectures/03-comandos-linguagem-programacao.typ"
#include "lectures/04-recursividade.typ"
#include "lectures/05-modularidade-abstracao.typ"
#include "lectures/06-estrategias-depuracao.typ"
#include "lectures/07-cadeias-processamento.typ"
#include "lectures/08-estruturas-lineares.typ"
#include "lectures/09-arvores.typ"
#include "lectures/10-tabelas-hash.typ"
#include "lectures/11-pesquisa-ordenacao.typ"
#include "lectures/12-garbage-collection.typ"
#include "lectures/13-tecnicas-projeto-algoritmos.typ"
