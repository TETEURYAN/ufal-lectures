#import "@preview/mousse-notes:1.1.0": *

= Coordenadas Polares, Cilíndricas e Esféricas
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.10]

== Introdução

Fechando a disciplina: coordenadas cartesianas não são a única forma de localizar pontos. Sistemas polares (2D), cilíndricos e esféricos (3D) simplificam problemas com simetria radial ou angular -- comuns em computação gráfica, robótica e processamento de sinais.

== Definições formais

#definition(name: "Coordenadas polares (2D)", id: "def-coordenadas-polares")[
  Um ponto do plano é descrito por $(r,theta)$: $r >= 0$ é a distância à origem, $theta$ é o ângulo com o eixo $x$ positivo. Conversão para cartesianas: $x = r cos(theta)$, $y = r sin(theta)$; inversamente, $r = sqrt(x^2+y^2)$.
]

#definition(name: "Coordenadas cilíndricas (3D)", id: "def-coordenadas-cilindricas")[
  Estende as polares acrescentando a altura: $(r,theta,z)$, com $x=r cos(theta)$, $y=r sin(theta)$, $z=z$ (inalterado) -- útil para objetos com simetria em torno de um eixo (ex.: um cilindro).
]

#definition(name: "Coordenadas esféricas (3D)", id: "def-coordenadas-esfericas")[
  Um ponto é descrito por $(rho,theta,phi.alt)$: $rho >= 0$ é a distância à origem, $phi.alt in [0,pi]$ é o *ângulo polar* (medido a partir do eixo $z$ positivo), $theta$ é o *ângulo azimutal* (no plano $x y$, como nas polares). Conversão:
  $ x = rho sin(phi.alt) cos(theta), quad y = rho sin(phi.alt) sin(theta), quad z = rho cos(phi.alt) $

  #figure(
    image("figures/spherical-coordinates.svg", width: 45%),
    caption: [Coordenadas esféricas: $rho$ (distância radial), $phi.alt$ (ângulo polar, a partir do eixo $z$) e $theta$ (ângulo azimutal, no plano $x y$). Fonte: Wikimedia Commons, CC BY-SA 4.0 (SharkD).],
  )
]

== Exemplo resolvido

#example(name: "Convertendo um ponto de cartesianas para esféricas", id: "ex-cartesianas-esfericas")[
  Converter $(1,1,sqrt(2))$ para coordenadas esféricas.

  $ rho = sqrt(1^2+1^2+(sqrt(2))^2) = sqrt(1+1+2) = sqrt(4) = 2 $
  $ phi.alt = arccos(z/rho) = arccos(sqrt(2)/2) = 45° = pi/4 $
  $ theta = arctan(y/x) = arctan(1/1) = 45° = pi/4 $

  Verificação: $x = 2 sin(45°)cos(45°) = 2(sqrt(2)/2)(sqrt(2)/2) = 1$ ✓; $z = 2cos(45°) = 2(sqrt(2)/2)=sqrt(2)$ ✓.
]

== Atenção -- pegadinhas comuns

#remark(name: "Não confundir o ângulo polar φ (esféricas) com o ângulo azimutal θ (polares/cilíndricas)")[
  $phi.alt$ (esféricas) é medido a partir do eixo $z$ (varia de $0$ a $pi$); $theta$ (tanto em polares/cilíndricas quanto em esféricas) é medido no plano $x y$ a partir do eixo $x$ (varia de $0$ a $2pi$) -- são ângulos com referências diferentes, e a convenção de qual letra denota qual ângulo varia entre livros (física costuma inverter $theta$ e $phi.alt$ em relação à convenção matemática) -- sempre confira a convenção adotada no enunciado da questão.
]

#remark(name: "Coordenadas cilíndricas mantêm z; esféricas substituem z por dois ângulos")[
  Cilíndricas modificam apenas a parte $(x,y) -> (r,theta)$, preservando $z$ -- uma extensão direta das polares. Esféricas são mais radicais: nenhuma das três coordenadas cartesianas é preservada diretamente, todas as três (r, dois ângulos) descrevem a posição de forma conjunta.
]

== Questões estilo POSCOMP

*Questão 1.* Em coordenadas cilíndricas, a coordenada $z$:
- a) É sempre igual a zero.
- b) Permanece igual à coordenada $z$ cartesiana, sem alteração.
- c) É substituída por um ângulo.
- d) É igual a $rho$.
- e) Não é definida em coordenadas cilíndricas.

*Questão 2.* No exemplo desta seção, o valor de $rho$ para o ponto $(1,1,sqrt(2))$ é:
- a) $1$.
- b) $sqrt(2)$.
- c) $2$.
- d) $4$.
- e) $sqrt(3)$.

*Questão 3.* O ângulo polar $phi.alt$, em coordenadas esféricas, é medido a partir de:
- a) O eixo $x$.
- b) O eixo $y$.
- c) O eixo $z$.
- d) A origem, sem referência a nenhum eixo específico.
- e) O plano $x y$, exclusivamente.

== Gabarito comentado

1. *(b)* -- coordenadas cilíndricas preservam $z$ inalterado, conforme a definição desta seção.
2. *(c)* -- $rho = sqrt(1+1+2) = sqrt(4) = 2$, calculado no exemplo desta seção.
3. *(c)* -- $phi.alt$ é medido a partir do eixo $z$ positivo, conforme a definição de coordenadas esféricas.

== Referências

- WINTERLE, P. *Vetores e Geometria Analítica*. Cap. 10 (Coordenadas polares e no espaço).
- LEDESMA, D. S. *Apostila de Geometria Analítica*. UNICAMP.
- Série Conhecimento (UFV). *Geometria Analítica*.
