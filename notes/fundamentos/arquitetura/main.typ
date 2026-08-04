#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Arquitetura e Organização de Computadores],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Gordon E. Moore, "Cramming More Components onto Integrated Circuits" (1965)],
  )[The complexity for minimum component costs has increased at a rate of roughly a factor of two per year.],

  font-style: "serif",
)

#include "01_von_neumann_isa_microarquitetura.typ"
#include "02_metricas_desempenho_cpu.typ"
#include "03_linguagens_montagem.typ"
#include "04_modos_enderecamento_conjunto_instrucoes.typ"
#include "05_interrupcoes_excecoes.typ"
#include "06_barramento_interfaces_perifericos.typ"
#include "07_organizacao_memoria.typ"
#include "08_memoria_auxiliar.typ"
#include "09_arquiteturas_risc_cisc.typ"
#include "10_pipeline.typ"
#include "11_paralelismo_baixa_granularidade.typ"
#include "12_superescalares_superpipeline.typ"
#include "13_multiprocessadores.typ"
#include "14_multicomputadores.typ"
#include "15_arquiteturas_paralelas_nao_convencionais.typ"
