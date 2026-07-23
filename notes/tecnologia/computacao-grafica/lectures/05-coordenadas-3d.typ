#import "@preview/mousse-notes:1.1.0": *
= 20.5 -- Transformação entre Sistemas de Coordenadas 3D

== Introdução

Cenas 3D raramente são descritas em um único referencial: cada objeto tem seu
próprio sistema de coordenadas *local* (ou de modelagem), que é posicionado
dentro do sistema de coordenadas do *mundo*, muitas vezes através de uma
hierarquia de transformações (como as juntas de um braço articulado). Este
subtópico generaliza 20.1 e 20.4: qualquer mudança de referencial em 3D é uma
matriz homogênea de rotação + translação.

== Mudança de sistema de coordenadas

#definition(id: "def-mudanca-coord-3d")[
  Um sistema de coordenadas local é definido por uma origem $O$ e uma base
  ortonormal $(u,v,n)$ expressa em relação ao sistema de coordenadas de
  referência. A matriz que converte coordenadas *locais* em coordenadas do
  sistema de *referência* (mundo) é
  $ M_"local->mundo" = T(O) mat(
      u_x, v_x, n_x, 0;
      u_y, v_y, n_y, 0;
      u_z, v_z, n_z, 0;
      0,0,0,1
    ), $
  isto é, translação até $O$ composta com a rotação cujas *colunas* são os
  vetores da base local (compare com 20.4: lá, a rotação levava mundo para
  câmera e usava esses vetores como *linhas* -- a diferença de convenção entre
  "linhas" e "colunas" é exatamente a diferença entre transformação direta e
  inversa, vista a seguir).
]

#theorem(id: "thm-inversa-transformacao-rigida")[
  Para uma transformação rígida (rotação + translação, sem escala), a inversa
  é obtida por:
  $ M^(-1) = (T(t) R)^(-1) = R^(-1) T(-t) = R^T T(-t), $
  usando que a inversa de uma matriz de rotação é sua *transposta*
  ($R^(-1) = R^T$, pois $R$ é ortogonal), e que
  $(A B)^(-1) = B^(-1) A^(-1)$ -- a ordem das inversas se inverte.
]

#remark[
  Um erro comum em prova é tentar "inverter" uma matriz composta transpondo
  ou negando os elementos individualmente sem trocar a ordem dos fatores.
  Vale sempre $(A B)^(-1) = B^(-1) A^(-1)$, nunca $A^(-1) B^(-1)$, exceto no
  caso especial em que $A$ e $B$ comutam.
]

== Hierarquias de transformação

#definition(id: "def-hierarquia-transf")[
  Em uma cena com objetos organizados hierarquicamente (ex.: antebraço preso
  ao braço, preso ao ombro), a transformação de um objeto filho para o sistema
  do mundo é o produto encadeado das transformações *locais* de cada nível,
  da folha até a raiz:
  $ M_"objeto->mundo" = M_"pai->mundo" space M_"objeto->pai". $
  Mover a transformação de um nó pai afeta automaticamente todos os seus
  descendentes -- é a base de esqueletos de animação e cenas com múltiplos
  níveis de aninhamento.
]

#example(id: "q-hierarquia-braco")[
  Um "antebraço" está a $3$ unidades de distância da junta do "braço" ao longo
  do eixo local $x$ (ou seja, sofre $T(3,0,0)$ em relação ao braço). O braço,
  por sua vez, sofre uma rotação de $90°$ em torno de $z$ em relação ao mundo,
  $R_z (90°)$, sem translação. Onde fica a origem do sistema do antebraço, em
  coordenadas do mundo?
]

#solution[
  A cadeia de transformações é
  $ M_"antebraço->mundo" = R_z (90°) space T(3,0,0). $
  Aplicando ao ponto local $(0,0,0,1)^T$ (origem do antebraço):
  $ T(3,0,0) mat(0;0;0;1) = mat(3;0;0;1). $
  $ R_z (90°) mat(3;0;0;1) = mat(0,-1,0,0;1,0,0,0;0,0,1,0;0,0,0,1)
      mat(3;0;0;1) = mat(0;3;0;1). $
  A origem do antebraço está em $(0,3,0)$ no sistema do mundo -- a translação
  local é aplicada primeiro (mais à direita), e só depois "arrastada" pela
  rotação do braço, como esperado de uma hierarquia pai-filho.
]

#example(id: "q-inversa-rigida")[
  (Múltipla escolha) Seja $M = T(t) R$ uma transformação rígida com $R$
  ortogonal. Qual expressão representa corretamente $M^(-1)$?
  + $R T(-t)$
  + $R^T T(-t)$
  + $T(-t) R^T$
  + $T(t) R^(-1)$
]

#solution[
  Resposta: alternativa *(2)*. Usa-se $(T(t)R)^(-1) = R^(-1) T(t)^(-1) =
  R^T T(-t)$: a ordem se inverte e cada fator é individualmente invertido
  ($R^(-1) = R^T$ por ortogonalidade, $T(t)^(-1) = T(-t)$).
]

== Referências

- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Cap. sobre
  transformações 3D e hierarquias de objetos.
- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Cap. sobre
  sistemas de coordenadas e modelagem hierárquica.
- cienciadacomputacao.wiki.br -- Tópico 20.5.
