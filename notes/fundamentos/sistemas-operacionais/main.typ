#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Sistemas Operacionais],
  subtitle: [Conceitos e Princípios],
  subsubtitle: [
    Notas de aula, Maio de 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [NASA Joke],
  )[Never underestimate the bandwidth of a station wagon full of tapes hurtling down the highway..],
  
  font-style: "serif",
)


#include "lectures/01-introducao.typ"
#include "lectures/02-tarefas.typ"

#bibliography("bibliography.bib", full: true,style: "apa",title: "Referências Bibliográficas",)