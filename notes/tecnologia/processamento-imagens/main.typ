#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Processamento de Imagens],
  subtitle: [Conceitos e Princípios],
  subsubtitle: [
    Notas de aula, Julho de 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [David Marr, "Vision", 1982],
  )[Vision is a process that produces from images of the external world a description that is useful to the viewer and not cluttered with irrelevant information.],

  font-style: "serif",
)


#include "lectures/01-filtros-digitais.typ"
#include "lectures/02-metodos-espaco-estados.typ"
#include "lectures/03-percepcao-visual.typ"
#include "lectures/04-amostragem-quantizacao.typ"
#include "lectures/05-transformadas.typ"
#include "lectures/06-realce.typ"
#include "lectures/07-filtragem-restauracao.typ"
#include "lectures/08-reconstrucao-tomografica.typ"
#include "lectures/09-exemplos-computacionais.typ"
#include "lectures/10-analise-visao-computacional.typ"
#include "lectures/11-reconhecimento-padroes.typ"
