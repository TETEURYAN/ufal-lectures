#import "@preview/mousse-notes:1.1.0": *

= 7.5 --- Espaços Amostrais

== Introdução

O espaço amostral formaliza o conjunto de todos os resultados possíveis de um experimento aleatório (7.2), e é sobre ele que os eventos de 7.1 são definidos como subconjuntos. A POSCOMP cobra principalmente a classificação do espaço amostral (discreto finito, discreto infinito, contínuo) e a contagem de seus elementos em casos simples.

== Definições formais

#definition(name: "Espaço amostral", id: "def-espaco-amostral")[
  O *espaço amostral* $Omega$ de um experimento aleatório é o conjunto de *todos* os resultados possíveis desse experimento, mutuamente exclusivos e coletivamente exaustivos (todo resultado do experimento corresponde a exatamente um elemento de $Omega$). Um evento (@def-evento) é, por definição, um subconjunto de $Omega$.
]

#definition(name: "Classificação do espaço amostral", id: "def-classificacao-espaco")[
  - *Discreto finito*: número finito de resultados (ex.: lançamento de um dado, $Omega={1,...,6}$).
  - *Discreto infinito (enumerável)*: infinitos resultados, mas enumeráveis um a um (ex.: número de lançamentos de uma moeda até sair a primeira cara, $Omega = {1,2,3,...}$).
  - *Contínuo (não enumerável)*: resultados formam um intervalo real (ex.: tempo de espera em uma fila, $Omega = (0, infinity)$).
]

#definition(name: "Espaço amostral equiprovável", id: "def-espaco-equiprovavel")[
  Espaço amostral discreto finito em que todos os resultados têm a mesma probabilidade de ocorrer. Nesse caso (regra de Laplace, base da probabilidade em 7.6):
  $ P(A) = abs(A)/abs(Omega) = ("número de resultados favoráveis a " A)/("número total de resultados possíveis") $
]

== Exemplo resolvido

#example(name: "Espaço amostral do lançamento de dois dados", id: "ex-espaco-dois-dados")[
  No lançamento simultâneo de dois dados honestos distinguíveis, cada resultado é um par ordenado $(i,j)$ com $i, j in {1,...,6}$, totalizando $abs(Omega) = 6 times 6 = 36$ resultados igualmente prováveis (espaço equiprovável, pela regra do produto).

  O evento $A$ = "soma dos dados igual a 7" corresponde a $A = {(1,6),(2,5),(3,4),(4,3),(5,2),(6,1)}$, com $abs(A) = 6$. Logo $P(A) = 6\/36 = 1\/6$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Nem todo espaço amostral finito é equiprovável")[
  A regra de Laplace ($P(A) = \#A \/ \#Omega$) só vale quando os resultados elementares são igualmente prováveis. Um erro clássico é aplicá-la a espaços amostrais mal definidos -- por exemplo, tratar "soma dos dados" (valores de 2 a 12, não equiprováveis) como se cada soma tivesse probabilidade $1/11$, quando na verdade é preciso voltar ao espaço amostral equiprovável dos 36 pares $(i,j)$.
]

#remark(name: "Espaço amostral depende da pergunta, não só do experimento físico")[
  O mesmo experimento físico pode ser descrito por espaços amostrais diferentes conforme o que se quer modelar: lançar dois dados pode ter $Omega$ com 36 pares ordenados (se os dados são distinguíveis) ou 21 combinações não ordenadas (se não são) -- a escolha certa depende do que garante equiprobabilidade dos resultados elementares.
]

== Questões estilo POSCOMP

*Questão 1.* O espaço amostral do experimento "tempo, em minutos, até a chegada do próximo ônibus" é classificado como:
- a) Discreto finito.
- b) Discreto infinito enumerável.
- c) Contínuo.
- d) Equiprovável.
- e) Vazio.

*Questão 2.* No lançamento de dois dados honestos e distinguíveis, a probabilidade de a soma ser igual a 7 é:
- a) $1/12$.
- b) $1/11$.
- c) $1/6$.
- d) $1/36$.
- e) $6/11$.

*Questão 3.* Sobre espaços amostrais equiprováveis, é correto afirmar que:
- a) Todo espaço amostral discreto é automaticamente equiprovável.
- b) A regra de Laplace ($\#A\/\#Omega$) só é válida quando os resultados elementares têm a mesma probabilidade.
- c) Espaços amostrais contínuos são sempre equiprováveis.
- d) Equiprovável é sinônimo de espaço amostral finito.
- e) A soma das probabilidades em um espaço equiprovável é sempre diferente de 1.

== Gabarito comentado

1. *(c)* -- tempo é uma grandeza contínua, o espaço amostral é um intervalo real (não enumerável).
2. *(c)* -- 6 pares favoráveis em 36 possíveis, $6\/36 = 1\/6$ (ver exemplo desta seção).
3. *(b)* -- a regra de Laplace exige equiprobabilidade dos resultados elementares; nem todo espaço discreto satisfaz essa condição.

== Referências

- MEYER, P. L. *Probabilidade: Aplicações à Estatística*. Cap. 2--3 (Espaço amostral e definição clássica de probabilidade).
- MAGALHÃES, M. N. *Probabilidade e Variáveis Aleatórias*. Cap. 1--2.
