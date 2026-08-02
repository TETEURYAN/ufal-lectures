#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Engenharia de Software],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Fred Brooks, "The Mythical Man-Month"],
  )[Adding manpower to a late software project makes it later.],

  font-style: "serif",
)

#include "21_1_processo_desenvolvimento.typ"
#include "21_2_ciclo_vida.typ"
#include "21_3_qualidade_software.typ"
#include "21_4_planejamento_gerenciamento.typ"
#include "21_5_gerenciamento_configuracao.typ"
#include "21_6_engenharia_requisitos.typ"
#include "21_7_analise_projeto_garantia_qualidade.typ"
#include "21_8_verificacao_validacao_teste.typ"
#include "21_9_manutencao.typ"
#include "21_10_documentacao.typ"
#include "21_11_padroes_desenvolvimento.typ"
#include "21_12_reuso.typ"
#include "21_13_engenharia_reversa.typ"
#include "21_14_reengenharia.typ"
#include "21_15_ambientes_desenvolvimento.typ"
