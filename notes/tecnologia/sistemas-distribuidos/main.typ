#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Sistemas Distribuídos],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Leslie Lamport],
  )[A distributed system is one in which the failure of a computer you didn't even know existed can render your own computer unusable.],

  font-style: "serif",
)

#include "25_1_problemas_basicos.typ"
#include "25_2_compartilhamento_informacao.typ"
#include "25_3_comunicacao_processos.typ"
#include "25_4_tolerancia_falhas.typ"
#include "25_5_sistemas_operacionais_distribuidos.typ"
