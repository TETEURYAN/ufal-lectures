#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Inteligência Artificial],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Edsger W. Dijkstra],
  )[The question of whether machines can think is about as relevant as the question of whether submarines can swim.],

  font-style: "serif",
)

#include "01_linguagens_simbolicas_programacao_logica.typ"
#include "02_resolucao_problemas_busca.typ"
#include "03_hill_climbing_best_first_simulated_annealing_astar.typ"
#include "04_busca_maximizacao_grafos_and_or.typ"
#include "05_esquemas_representacao_conhecimento.typ"
#include "06_sistemas_producao.typ"
#include "07_raciocinio_nao_monotonico.typ"
#include "08_conhecimento_incerto_regra_bayes.typ"
#include "09_conjuntos_logica_fuzzy.typ"
#include "10_aprendizado_maquina_indutivo.typ"
#include "11_arvores_decisao_redes_neurais_algoritmos_geneticos.typ"
#include "12_sistemas_especialistas.typ"
#include "13_processamento_linguagem_natural.typ"
#include "14_agentes_inteligentes.typ"
#include "15_robotica.typ"
