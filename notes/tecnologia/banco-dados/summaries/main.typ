#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Banco de Dados],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [W. Edwards Deming],
  )[In God we trust; all others bring data.],

  font-style: "serif",
)

#include "18_1_modelo_de_dados.typ"
#include "18_2_modelagem_projeto.typ"
#include "18_3_sgbd_arquitetura_seguranca_integridade.typ"
#include "18_4_concorrencia_recuperacao_transacoes.typ"
#include "18_5_linguagens_consulta.typ"
#include "18_6_bancos_dados_distribuidos.typ"
#include "18_7_mineracao_dados.typ"
