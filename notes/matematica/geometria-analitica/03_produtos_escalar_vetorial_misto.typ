#import "@preview/mousse-notes:1.1.0": *

= Produtos: Escalar, Vetorial e Misto
#text(size: 9pt, style: "italic")[Edital POSCOMP: 4.4]

== Introdução

Os três produtos entre vetores respondem perguntas geométricas distintas: o escalar mede *ângulo/projeção*, o vetorial produz um *vetor perpendicular* (e mede área), e o misto mede *volume* -- é o bloco mais denso em fórmulas de toda a disciplina, com forte presença em prova.

== Definições formais

#definition(name: "Produto escalar (produto interno)", id: "def-produto-escalar-ga")[
  $ u dot v = u_1 v_1+u_2 v_2+u_3 v_3 = norm(u) norm(v) cos(theta) $
  onde $theta$ é o ângulo entre $u$ e $v$. Consequência direta: $u dot v = 0 arrow.l.r.double u perp v$ (ortogonais), pois $cos(90°)=0$.
]

#definition(name: "Produto vetorial", id: "def-produto-vetorial-ga")[
  Para $u,v in RR^3$, o produto vetorial $u times v$ é o vetor:
  $ u times v = mat(delim: "|", i,j,k; u_1,u_2,u_3; v_1,v_2,v_3) = (u_2 v_3-u_3 v_2, u_3 v_1-u_1 v_3, u_1 v_2-u_2 v_1) $
  perpendicular tanto a $u$ quanto a $v$ (sentido dado pela regra da mão direita), com $norm(u times v) = norm(u) norm(v) sin(theta)$ -- numericamente igual à *área do paralelogramo* formado por $u$ e $v$.
]

#definition(name: "Produto misto", id: "def-produto-misto")[
  $ (u,v,w) = u dot (v times w) = det mat(delim: "[", u_1,u_2,u_3; v_1,v_2,v_3; w_1,w_2,w_3) $
  O *valor absoluto* do produto misto é o volume do paralelepípedo formado por $u,v,w$. Consequência direta: $(u,v,w)=0 arrow.l.r.double u,v,w$ são *coplanares* (02) -- o paralelepípedo degenera, sem volume.
]

== Exemplo resolvido

#example(name: "Calculando os três produtos", id: "ex-tres-produtos")[
  Sejam $u=(1,0,0)$, $v=(0,1,0)$, $w=(1,1,1)$.

  *Produto escalar*: $u dot v = 1(0)+0(1)+0(0)=0$ -- $u perp v$ (ângulo de $90°$).

  *Produto vetorial*: $u times v = (0(0)-0(1), 0(0)-1(0), 1(1)-0(0)) = (0,0,1)$. Norma $=1$, igual à área do quadrado unitário formado por $u,v$ ✓.

  *Produto misto* $(u,v,w)$: primeiro $v times w = (1(1)-0(1), 0(1)-0(1), 0(1)-1(1)) = (1,0,-1)$; então $u dot (v times w) = 1(1)+0(0)+0(-1)=1$. Como $(u,v,w)=1 eq.not 0$, os três vetores *não* são coplanares -- formam um paralelepípedo de volume $1$.

  #figure(
    image("figures/cross-product.svg", width: 35%),
    caption: [Produto vetorial $u times v$: perpendicular ao plano de $u$ e $v$, com sentido dado pela regra da mão direita. Fonte: Wikimedia Commons, domínio público.],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "Produto vetorial só existe (com essa definição) em RR³")[
  Diferente do produto escalar (definido em qualquer $RR^n$), o produto vetorial na forma usual só é definido em $RR^3$ -- não confundir com generalizações mais abstratas (produto exterior) fora do escopo desta disciplina.
]

#remark(name: "Produto vetorial não é comutativo -- é anticomutativo")[
  $u times v = -(v times u)$ (troca de ordem inverte o sentido do vetor resultante) -- diferente do produto escalar, que é comutativo ($u dot v = v dot u$). Esquecer o sinal ao trocar a ordem dos fatores é um erro recorrente.
]

== Questões estilo POSCOMP

*Questão 1.* Se $u dot v = 0$ para vetores não nulos $u,v$, é correto concluir que:
- a) $u$ e $v$ são paralelos.
- b) $u$ e $v$ são ortogonais.
- c) $u=v$.
- d) $u times v = 0$.
- e) $u$ e $v$ são coplanares com qualquer terceiro vetor apenas.

*Questão 2.* A norma do produto vetorial $norm(u times v)$ é numericamente igual a:
- a) O volume do paralelepípedo formado por $u,v$ e um terceiro vetor.
- b) A área do paralelogramo formado por $u$ e $v$.
- c) O produto escalar $u dot v$.
- d) A soma das normas de $u$ e $v$.
- e) Sempre zero.

*Questão 3.* Três vetores $u,v,w$ são coplanares se, e somente se:
- a) $u dot v = 0$.
- b) $u times v = 0$.
- c) $(u,v,w) = 0$ (produto misto nulo).
- d) $norm(u)=norm(v)=norm(w)$.
- e) $u,v,w$ são todos unitários.

== Gabarito comentado

1. *(b)* -- produto escalar nulo entre vetores não nulos caracteriza ortogonalidade.
2. *(b)* -- definição direta: norma do produto vetorial = área do paralelogramo.
3. *(c)* -- definição direta: produto misto nulo caracteriza coplanaridade.

== Referências

- WINTERLE, P. *Vetores e Geometria Analítica*. Cap. 4--5 (Produtos entre vetores).
- LEDESMA, D. S. *Apostila de Geometria Analítica*. UNICAMP.
- Série Conhecimento (UFV). *Geometria Analítica*. Cap. sobre produtos vetoriais.
