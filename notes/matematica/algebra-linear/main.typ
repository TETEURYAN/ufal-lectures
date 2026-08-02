#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Álgebra Linear],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Gilbert Strang, "Introduction to Linear Algebra"],
  )[Linear algebra has become as basic and as applicable as calculus, and fortunately it is easier.],

  font-style: "serif",
)

#include "01_sistemas_lineares_gauss.typ"
#include "02_espacos_vetoriais_subespacos.typ"
#include "03_bases_somas_diretas.typ"
#include "04_programacao_linear.typ"
#include "05_transformacoes_lineares_matrizes.typ"
#include "06_autovalores_diagonalizacao.typ"
#include "07_produto_interno_ortonormal_projecoes.typ"
#include "08_movimentos_rigidos.typ"
#include "09_metodo_minimos_quadrados.typ"
#include "10_transformacoes_espacos_produto_interno.typ"
#include "11_representacao_adjunta_operadores.typ"
#include "12_teorema_espectral.typ"
#include "13_formas_canonicas.typ"
