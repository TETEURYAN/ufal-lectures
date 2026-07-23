#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Computação Gráfica],
  subtitle: [Conceitos e Princípios],
  subsubtitle: [
    Notas de aula, Julho de 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Ivan Sutherland, "The Ultimate Display", 1965],
  )[The screen is a window through which one sees a virtual world. The challenge is to make that world look real, act real, sound real, feel real.],

  font-style: "serif",
)


#include "lectures/01-transformacoes-geometricas.typ"
#include "lectures/02-coordenadas-2d-recorte.typ"
#include "lectures/03-projecoes.typ"
#include "lectures/04-camera-virtual.typ"
#include "lectures/05-coordenadas-3d.typ"
#include "lectures/06-objetos-cenas-3d.typ"
#include "lectures/07-rendering-shading.typ"
#include "lectures/08-texturas.typ"
#include "lectures/09-aliasing.typ"
#include "lectures/10-visualizacao.typ"
