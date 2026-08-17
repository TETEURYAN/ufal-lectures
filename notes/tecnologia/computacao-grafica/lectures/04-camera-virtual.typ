#import "@preview/mousse-notes:1.1.0": *
= 20.4 -- Câmera Virtual

== Introdução

A câmera virtual modela como um observador vê a cena 3D, definindo o sistema de
coordenadas que será usado para projetar o mundo na tela. Este subtópico é a
ponte entre 20.3 (tipos de projeção) e 20.5 (mudança de sistemas de
coordenadas 3D): a câmera é, na prática, mais um sistema de coordenadas, com
sua própria matriz de transformação.

== Parâmetros da câmera

#definition(id: "def-camera-virtual")[
  Uma câmera virtual é definida por:
  - *VRP* (View Reference Point) ou posição do olho ($"eye"$): ponto de onde a
    cena é observada;
  - *VPN* (View Plane Normal) ou direção de visada: para onde a câmera aponta;
  - *VUP* (View Up Vector): vetor que define a orientação "para cima" da
    câmera, usado para eliminar a ambiguidade de rotação em torno da direção
    de visada;
  - o *volume de visualização* ("view volume"), que delimita o que é visível
    entre um plano *near* (próximo) e um plano *far* (distante).
]

#remark[
  O volume de visualização de uma câmera com projeção *perspectiva* é um
  tronco de pirâmide (*frustum*): uma pirâmide com o ápice no olho, cortada
  pelos planos near e far. Para projeção *paralela*, o volume é um paralelepípedo
  (caixa), já que os projetores não convergem. Confundir os dois formatos é
  um erro comum em prova.
]

== Sistema de coordenadas da câmera (base uvn)

#definition(id: "def-base-uvn")[
  A partir de $"eye"$, de um ponto observado $"at"$ (ou diretamente da direção
  de visada) e do vetor $"up"$, constrói-se uma base ortonormal
  $(u, v, n)$ centrada em $"eye"$:
  $ n = "normalize"("eye" - "at"), $
  $ u = "normalize"("up" times n), $
  $ v = n times u. $
  Aqui $n$ aponta *para trás* da câmera (convenção destra), $u$ é o eixo
  "direita" e $v$ é o eixo "cima" recalculado (ortogonal a $n$ e $u$, mesmo que
  $"up"$ original não fosse perfeitamente ortogonal a $n$).
]

#theorem(id: "thm-matriz-view")[
  A *matriz de visualização* (view matrix), que transforma coordenadas do
  mundo para coordenadas da câmera, é a composição de uma translação (leva
  $"eye"$ à origem) com uma rotação (alinha $u,v,n$ aos eixos $x,y,z$):
  $ M_"view" = mat(
      u_x, u_y, u_z, 0;
      v_x, v_y, v_z, 0;
      n_x, n_y, n_z, 0;
      0,0,0,1
    )
    T(-"eye"_x, -"eye"_y, -"eye"_z). $
  As linhas da parte rotacional são os próprios vetores da base $u,v,n$,
  porque a matriz de mudança de base para uma base ortonormal é a transposta
  (aqui, equivalentemente, a inversa) da matriz cujas *colunas* seriam
  $u,v,n$.
]

#remark[
  Essa construção é o motivo pelo qual "câmera virtual" e "transformação entre
  sistemas de coordenadas 3D" (20.5) são, matematicamente, o mesmo problema: a
  câmera nada mais é do que outro referencial, e a view matrix é uma
  transformação de mudança de base como qualquer outra.
]

#example(id: "q-camera-uvn")[
  Uma câmera está em $"eye" = (0,0,5)$, observando a origem
  $"at" = (0,0,0)$, com $"up" = (0,1,0)$. Determine o vetor $n$ da base da
  câmera.
]

#solution[
  $ n = "normalize"("eye" - "at") = "normalize"((0,0,5) - (0,0,0))
      = "normalize"((0,0,5)) = (0,0,1). $
  Como $"up" = (0,1,0)$ já é ortogonal a $n$, segue
  $ u = "normalize"("up" times n) = (1,0,0) times (0,0,1) "seguindo a fórmula"
      = (1,0,0), quad v = n times u = (0,1,0). $
  Ou seja, aqui a base da câmera coincide com a base canônica -- resultado
  esperado, já que a câmera olha diretamente ao longo do eixo $z$.
]

#example(id: "q-camera-frustum")[
  (Múltipla escolha) Sobre o volume de visualização de uma câmera com projeção
  perspectiva, assinale a alternativa correta.
  + É delimitado por seis planos e tem formato de tronco de pirâmide (frustum).
  + É sempre um paralelepípedo, independentemente do tipo de projeção.
  + O plano near serve apenas para efeitos estéticos e pode ser omitido sem
    consequência.
  + O vetor VUP determina a posição do centro de projeção.
]

#solution[
  Resposta: alternativa *(1)*. O plano near é necessário para evitar o ponto
  singular no próprio olho (divisão por zero na projeção) e para a precisão
  numérica do teste de profundidade; VUP apenas resolve a ambiguidade de
  rotação em torno do eixo de visada, não a posição da câmera.
]

== Referências

- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Cap. sobre
  visualização 3D e parâmetros de câmera.
- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Cap. sobre
  a pipeline de visualização (viewing pipeline).
- cienciadacomputacao.wiki.br -- Tópico 20.4.
