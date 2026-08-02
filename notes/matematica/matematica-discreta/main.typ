#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Matemática Discreta],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Leopold Kronecker],
  )[God made the integers, all else is the work of man.],

  font-style: "serif",
)

#include "01_iteracao_inducao_recursao.typ"
#include "02_conjuntos_algebra_axiomatica.typ"
#include "03_par_ordenado.typ"
#include "04_funcoes.typ"
#include "05_algebra_booleana.typ"
#include "06_relacoes_equivalencia_ordem.typ"
#include "07_reticulados_monoides_grupos_aneis.typ"
#include "08_teoria_dos_codigos.typ"
#include "09_teoria_dos_dominios.typ"
