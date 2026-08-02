#import "@preview/mousse-notes:1.1.0": *

= Introdução à Programação Linear
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.6]

== Introdução

Programação linear aplica álgebra linear (sistemas de inequações) à otimização: encontrar o melhor valor de uma função linear sujeita a restrições lineares. Não é o foco central desta disciplina na POSCOMP, mas aparece em nível introdutório -- formulação e ideia geral de solução.

== Definições formais

#definition(name: "Problema de programação linear", id: "def-problema-programacao-linear")[
  Um problema de programação linear consiste em maximizar (ou minimizar) uma *função objetivo* linear $c^T x$, sujeita a *restrições* lineares na forma $A x <= b$ (ou $>=$, $=$) e, tipicamente, $x >= 0$ (não-negatividade das variáveis).
]

#definition(name: "Região viável e solução ótima", id: "def-regiao-viavel")[
  A *região viável* é o conjunto de todos os pontos $x$ que satisfazem todas as restrições -- geometricamente, a interseção de semiplanos (em 2D) ou semiespaços (em dimensões maiores), formando um poliedro convexo. Um resultado fundamental garante que, se existe solução ótima finita, ela ocorre em pelo menos um *vértice* (ponto extremo) desse poliedro -- base do *método simplex*, que percorre vértices adjacentes melhorando a função objetivo a cada passo.
]

== Exemplo resolvido

#example(name: "Solução gráfica de um problema de PL em 2D", id: "ex-pl-solucao-grafica")[
  Maximizar $z = 3x + 2y$ sujeito a $x + y <= 4$, $x <= 3$, $x,y >= 0$.

  A região viável é um polígono com vértices $(0,0)$, $(3,0)$, $(3,1)$ e $(0,4)$ (interseções das retas de restrição). Avaliando $z$ em cada vértice: $z(0,0)=0$; $z(3,0)=9$; $z(3,1)=11$; $z(0,4)=8$. O máximo ocorre em $(3,1)$, com $z=11$ -- confirmando que a solução ótima está em um vértice da região viável, não em um ponto interior.
]

== Atenção -- pegadinhas comuns

#remark(name: "A solução ótima está em um vértice, não em qualquer ponto da região viável")[
  Mesmo que a região viável tenha infinitos pontos, o valor ótimo de uma função linear sobre um poliedro convexo é sempre atingido em (pelo menos) um vértice -- é isso que torna o método simplex eficiente: em vez de testar todos os pontos, ele percorre apenas os vértices.
]

#remark(name: "Nem todo problema de PL tem solução ótima finita")[
  A região viável pode ser vazia (restrições incompatíveis, problema *inviável*) ou ilimitada na direção de otimização (problema *ilimitado*, sem máximo/mínimo finito) -- casos que a prova costuma explorar conceitualmente, sem exigir cálculo completo.
]

== Questões estilo POSCOMP

*Questão 1.* Em um problema de programação linear com região viável limitada e não vazia, a solução ótima é encontrada:
- a) Em qualquer ponto interior da região viável.
- b) Sempre no centro geométrico da região viável.
- c) Em (pelo menos) um vértice da região viável.
- d) Fora da região viável.
- e) Apenas quando a função objetivo é quadrática.

*Questão 2.* No exemplo desta seção, o valor ótimo de $z=3x+2y$ na região viável dada é:
- a) $8$, em $(0,4)$.
- b) $9$, em $(3,0)$.
- c) $11$, em $(3,1)$.
- d) $0$, em $(0,0)$.
- e) $12$, em um ponto fora dos vértices calculados.

*Questão 3.* Um problema de programação linear é dito "ilimitado" quando:
- a) A região viável é vazia.
- b) A função objetivo pode crescer (ou decrescer) indefinidamente dentro da região viável, sem ótimo finito.
- c) Tem exatamente uma solução ótima.
- d) A região viável tem apenas um vértice.
- e) Não possui nenhuma restrição.

== Gabarito comentado

1. *(c)* -- resultado fundamental de PL: ótimo em um vértice do poliedro viável.
2. *(c)* -- calculado explicitamente no exemplo desta seção: $z(3,1)=11$ é o maior entre os vértices.
3. *(b)* -- definição direta de problema ilimitado (unbounded).

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 8 (Otimização linear).
- BOLDRINI, J. L. et al. *Álgebra Linear*. Cap. sobre aplicações.
- BAZARAA, M.; JARVIS, J.; SHERALI, H. *Linear Programming and Network Flows*. Cap. 1--2.
