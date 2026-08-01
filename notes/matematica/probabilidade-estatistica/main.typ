#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Probabilidade e Estatística],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [George E. P. Box],
  )[All models are wrong, but some are useful.],

  font-style: "serif",
)

#include "07_1_eventos.typ"
#include "07_2_experimentos_aleatorios.typ"
#include "07_3_analise_exploratoria.typ"
#include "07_4_descricao_estatistica.typ"
#include "07_5_espacos_amostrais.typ"
#include "07_6_probabilidades_espacos_discretos.typ"
#include "07_7_distribuicoes_probabilidade.typ"
#include "07_8_esperanca_matematica.typ"
#include "07_9_variancia_correlacao.typ"
#include "07_10_aproximacao_normal.typ"
#include "07_11_estimacao.typ"
#include "07_12_teste_hipoteses.typ"
#include "07_13_comparacao_medias.typ"
#include "07_14_regressao_correlacao.typ"
