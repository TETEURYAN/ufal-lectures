#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Linguagens Formais e Autômatos],
  subtitle: [Conceitos e Princípios],
  subsubtitle: [
    Notas de aula, Junho de 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Alan Turing],
  )[“Sometimes it is the people no one can imagine anything of who do the things no one can imagine.”],
  
  font-style: "serif",
)


#include "lectures/01_introducao.typ"
#include "lectures/02_conceitos_fundamentais.typ"
#include "lectures/03_expressoes_regulares.typ"
#include "lectures/04_automatos_finitos.typ"
#include "lectures/05_relacao_er_automatos.typ"
#include "lectures/06_exemplos_resolvidos.typ"
#include "lectures/07_exercicios_propostos.typ"
#include "lectures/08_conclusao.typ"