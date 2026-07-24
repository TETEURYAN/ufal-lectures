#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Redes de Computadores],
  subtitle: [Conceitos e Princípios],
  subsubtitle: [
    Notas de aula, Julho de 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Andrew S. Tanenbaum],
  )[The nice thing about standards is that there are so many to choose from.],

  font-style: "serif",
)


#include "lectures/01-enlace-transmissao.typ"
#include "lectures/02-protocolos-servicos.typ"
#include "lectures/03-topologias-arquitetura.typ"
