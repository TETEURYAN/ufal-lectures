#import "@preview/mousse-notes:1.1.0": *
#set page(paper: "us-letter")
#show: book.with(
  title: [Circuitos Digitais],
  subtitle: [Resumo POSCOMP],
  subsubtitle: [
    Revisão por subtópicos do edital, 2026
  ],
  subsubsubtitle: [
    Cs. #smallcaps[Matheus Ryan], Universidade Federal de Alagoas
  ],
  author: "Matheus Ryan",
  epigraph: quote(
    attribution: [Gottfried Wilhelm Leibniz, "Explication de l'Arithmétique Binaire" (1703)],
  )[Binary is the base of all arithmetic, whereby all numbers are written with two characters, 0 and 1.],

  font-style: "serif",
)

#include "01_sistemas_numeracao_codigos.typ"
#include "02_aritmetica_binaria.typ"
#include "03_circuitos_combinatorios.typ"
#include "04_minimizacao_funcoes.typ"
#include "05_projeto_circuitos_combinatorios.typ"
#include "06_componentes_sequenciais_memoria.typ"
#include "07_projeto_circuitos_sequenciais.typ"
#include "08_maquinas_estado_finito.typ"
#include "09_circuitos_sincronos_assincronos.typ"
#include "10_componentes_armazenamento.typ"
#include "11_projeto_sistemas_digitais.typ"
#include "12_principios_tecnicas_projeto.typ"
#include "13_familias_logicas.typ"
#include "14_dispositivos_logicos_programaveis.typ"
