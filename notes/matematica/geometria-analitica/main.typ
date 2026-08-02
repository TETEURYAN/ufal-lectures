#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Geometria Analítica],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [René Descartes, "Discurso do Método"],
  )[Each problem that I solved became a rule which served afterwards to solve other problems.],

  font-style: "serif",
)

#include "01_matrizes_sistemas_lineares.typ"
#include "02_vetores_algebra_vetorial.typ"
#include "03_produtos_escalar_vetorial_misto.typ"
#include "04_reta_plano_espaco.typ"
#include "05_planos.typ"
#include "06_posicoes_relativas_distancias_angulos.typ"
#include "07_circulo_esfera.typ"
#include "08_coordenadas_polares_cilindricas_esfericas.typ"
