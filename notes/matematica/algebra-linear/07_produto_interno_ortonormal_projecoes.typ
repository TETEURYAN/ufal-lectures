#import "@preview/mousse-notes:1.1.0": *

= Espaços com Produto Interno
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.10]

== Introdução

Produto interno generaliza o produto escalar de $RR^n$ para qualquer espaço vetorial, introduzindo noções geométricas -- ângulo, ortogonalidade, projeção -- em espaços que podem não ter uma interpretação geométrica óbvia (ex.: espaços de funções, base de séries de Fourier).

== Definições formais

#definition(name: "Produto interno", id: "def-produto-interno")[
  Um produto interno em um espaço vetorial real $V$ é uma função $angle.l dot, dot angle.r: V times V -> RR$ satisfazendo, para todos $u,v,w in V$ e escalar $a$:
  + *Simetria*: $angle.l u,v angle.r = angle.l v,u angle.r$.
  + *Bilinearidade*: $angle.l u+v,w angle.r = angle.l u,w angle.r + angle.l v,w angle.r$; $angle.l a u,v angle.r = a angle.l u,v angle.r$.
  + *Positividade*: $angle.l v,v angle.r >= 0$, com igualdade se, e somente se, $v=0$.
  O *produto escalar comum* $u dot v = sum_i u_i v_i$ em $RR^n$ é um *caso particular* de produto interno -- mas a definição axiomática admite muitos outros (ex.: produto interno entre funções via integral, usado em séries de Fourier), todos compartilhando as mesmas propriedades estruturais.
]

= Bases Ortonormais
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.11]

== Definições formais

#definition(name: "Ortogonalidade e base ortonormal", id: "def-ortogonalidade-base-ortonormal")[
  Dois vetores $u,v$ são *ortogonais* se $angle.l u,v angle.r = 0$. Uma *base ortonormal* é uma base cujos vetores são dois a dois ortogonais e cada um tem norma 1 ($norm(v) = sqrt((angle.l v,v angle.r)) = 1$). Bases ortonormais simplificam drasticamente cálculos: coordenadas de um vetor na base são obtidas diretamente por produtos internos, sem resolver sistemas lineares.
]

#definition(name: "Processo de Gram-Schmidt", id: "def-gram-schmidt")[
  Converte uma base qualquer $\{u_1,dots,u_n\}$ em uma base ortogonal $\{v_1,dots,v_n\}$ (depois normalizada para ortonormal), subtraindo de cada vetor suas projeções sobre os anteriores já ortogonalizados:
  $ v_1 = u_1, quad quad v_k = u_k - sum_(i=1)^(k-1) ("proj"_(v_i)(u_k)) $
]

= Projeções Ortogonais
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.12]

== Definições formais

#definition(name: "Projeção ortogonal sobre um vetor", id: "def-projecao-ortogonal")[
  A projeção ortogonal de $v$ sobre $u$ (não nulo) é:
  $ "proj"_u (v) = (angle.l v,u angle.r)/(angle.l u,u angle.r) u $
  o "pedaço" de $v$ que aponta na direção de $u$; $v - "proj"_u(v)$ é ortogonal a $u$ -- exatamente o vetor subtraído a cada passo do processo de Gram-Schmidt.
]

== Exemplo resolvido

#example(name: "Ortogonalização de Gram-Schmidt", id: "ex-gram-schmidt-completo")[
  Ortogonalizar a base $u_1=(1,1,0)$, $u_2=(2,0,1)$ de um subespaço de $RR^3$ (produto interno = produto escalar usual):

  $ v_1 = u_1 = (1,1,0) $
  $ "proj"_(v_1)(u_2) = (angle.l u_2,v_1 angle.r)/(angle.l v_1,v_1 angle.r) v_1 = (2)/(2) (1,1,0) = (1,1,0) $
  $ v_2 = u_2 - "proj"_(v_1)(u_2) = (2,0,1) - (1,1,0) = (1,-1,1) $

  Verificação: $angle.l v_1,v_2 angle.r = 1(1)+1(-1)+0(1) = 0$ ✓ (ortogonais). Normalizando: $norm(v_1)=sqrt(2)$, $norm(v_2)=sqrt(3)$, dando a base ortonormal $e_1 = (1,1,0)\/sqrt(2)$, $e_2=(1,-1,1)\/sqrt(3)$.

  #figure(
    image("figures/gram-schmidt.svg", width: 45%),
    caption: [Processo de Gram-Schmidt: o segundo vetor é obtido subtraindo sua projeção sobre o primeiro, já ortogonalizado. Fonte: Wikimedia Commons, domínio público (Gustavb).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "Produto interno não é sempre o produto escalar \"ponto a ponto\"")[
  Embora o produto escalar comum de $RR^n$ seja o exemplo mais familiar, a POSCOMP pode definir um produto interno *diferente* (ex.: com pesos, $angle.l u,v angle.r = sum_i w_i u_i v_i$) -- é preciso sempre verificar os três axiomas para a definição dada, não presumir que "produto interno" significa automaticamente o produto escalar padrão.
]

#remark(name: "Gram-Schmidt depende da ordem dos vetores de entrada")[
  Trocar a ordem dos vetores $u_1, u_2, dots$ antes de aplicar Gram-Schmidt produz, em geral, uma base ortonormal *diferente* (embora gerando o mesmo subespaço) -- o processo não é simétrico em relação à ordem de entrada.
]

== Questões estilo POSCOMP

*Questão 1.* Uma base ortonormal é aquela em que os vetores são:
- a) Apenas linearmente independentes.
- b) Dois a dois ortogonais e cada um com norma 1.
- c) Todos paralelos entre si.
- d) Necessariamente vetores da base canônica.
- e) Apenas ortogonais, sem restrição de norma.

*Questão 2.* No exemplo de Gram-Schmidt desta seção, o vetor $v_2$ é ortogonal a $v_1$ porque:
- a) Foi escolhido arbitrariamente.
- b) É o resultado de subtrair de $u_2$ exatamente sua projeção sobre $v_1$.
- c) Tem a mesma norma que $v_1$.
- d) É paralelo a $v_1$.
- e) $u_2$ já era ortogonal a $u_1$ originalmente.

*Questão 3.* A projeção ortogonal de $v$ sobre $u$ é dada por $"proj"_u(v) = (angle.l v,u angle.r)/(angle.l u,u angle.r) u$. Essa fórmula representa:
- a) Um vetor ortogonal a $u$.
- b) A componente de $v$ na direção de $u$.
- c) A norma de $v$.
- d) Sempre o próprio vetor $v$.
- e) Um escalar, não um vetor.

== Gabarito comentado

1. *(b)* -- definição direta de base ortonormal.
2. *(b)* -- é exatamente o mecanismo do processo de Gram-Schmidt, que subtrai a projeção para garantir ortogonalidade.
3. *(b)* -- definição direta de projeção ortogonal: a "sombra" de $v$ sobre a direção de $u$.

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 4 (Ortogonalidade e Gram-Schmidt).
- BOLDRINI, J. L. et al. *Álgebra Linear*. Cap. 10 (Espaços com produto interno).
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 6.
