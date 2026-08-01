#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Lógica Matemática],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Bertrand Russell, "Mysticism and Logic"],
  )[Mathematics may be defined as the subject in which we never know what we are talking about, nor whether what we are saying is true.],

  font-style: "serif",
)

#include "5_1_logica_proposicional_predicados.typ"
#include "5_2_linguagem_proposicional_primeira_ordem.typ"
#include "5_3_sistemas_dedutivos.typ"
#include "5_4_tabelas_verdade_estruturas.typ"
#include "5_5_relacoes_consequencia.typ"
#include "5_6_corretude.typ"
#include "5_7_completude.typ"
#include "5_8_compacidade.typ"
#include "5_9_lowenheim_skolem.typ"
#include "5_10_decidibilidade.typ"
#include "5_11_prova_automatica_teoremas.typ"
#include "5_12_logicas_nao_classicas.typ"
