#import "@preview/mousse-notes:1.1.0": *
= 20.3 -- Transformações de Projeção Paralela e Perspectiva

== Introdução

Projeção é o processo de reduzir a dimensionalidade de uma cena 3D para uma
imagem 2D. A POSCOMP costuma cobrar a classificação dos tipos de projeção
(paralela vs. perspectiva, e suas subcategorias) e o cálculo direto da divisão
perspectiva -- é o segundo grande bloco de questões de matriz da disciplina.

== Conceitos gerais

#definition(id: "def-projecao")[
  Uma *projeção* mapeia pontos do espaço 3D sobre um plano de projeção,
  seguindo retas chamadas *projetores*, que partem de cada ponto do objeto em
  direção a um *centro de projeção* (COP). Quando o COP está a distância
  finita, a projeção é dita *perspectiva*; quando o COP está no infinito (os
  projetores são paralelos entre si, com uma direção de projeção fixa), a
  projeção é dita *paralela*.
]

#theorem(id: "thm-tipos-projecao")[
  *Projeção paralela* preserva o paralelismo entre retas do objeto e as
  proporções relativas ao longo da direção de projeção, mas não produz efeito
  de profundidade realista. *Projeção perspectiva* produz *escorço em
  perspectiva* (objetos mais distantes do COP aparecem menores) e faz retas
  paralelas -- que não sejam paralelas ao plano de projeção -- convergirem para
  um *ponto de fuga*.
]

== Projeção paralela

#definition(id: "def-projecao-paralela")[
  A projeção paralela se divide em:
  - *Ortográfica*: os projetores são perpendiculares ao plano de projeção.
    Inclui as vistas *multivistas* (frontal, superior, lateral) e as
    *axonométricas* (plano de projeção não alinhado a nenhum eixo principal),
    subdivididas em *isométrica* (os três eixos formam ângulos iguais com o
    plano), *dimétrica* (dois ângulos iguais) e *trimétrica* (três ângulos
    distintos).
  - *Oblíqua*: os projetores fazem um ângulo diferente de $90°$ com o plano de
    projeção. Os dois casos clássicos são *cavalier* (fator de escorço $L=1$:
    arestas perpendiculares ao plano mantêm o comprimento real) e *cabinet*
    (fator de escorço $L=1/2$: essas arestas aparecem com metade do
    comprimento, resultado visualmente mais realista).
]

A projeção ortográfica simples sobre o plano $z=0$ apenas descarta a
coordenada $z$:
$ M_"ort" = mat(1,0,0,0; 0,1,0,0; 0,0,0,0; 0,0,0,1). $

A projeção oblíqua (cavalier/cabinet) cisalha $x$ e $y$ em função de $z$ antes
de descartá-lo, usando um fator de escorço $L$ e ângulo $alpha$ (tipicamente
$45°$):
$ M_"obl" = mat(1,0,-L cos alpha,0; 0,1,-L sin alpha,0; 0,0,0,0; 0,0,0,1). $

== Projeção perspectiva

#definition(id: "def-projecao-perspectiva")[
  Na projeção perspectiva simples, com o centro de projeção na origem, o
  observador olhando ao longo do eixo $z$ e o plano de projeção em $z = d$,
  um ponto $(x,y,z)$ é projetado em
  $ x' = d x/z, quad y' = d y/z. $
  Em coordenadas homogêneas, isso é obtido pela matriz
  $ M_"persp" = mat(1,0,0,0; 0,1,0,0; 0,0,1,0; 0,0,1/d,0), $
  seguida da *divisão perspectiva*: divide-se cada componente do resultado
  pela quarta coordenada homogênea $w$ (que deixa de ser $1$).
]

#remark[
  A divisão perspectiva é o que diferencia a matriz de projeção perspectiva de
  todas as transformações afins vistas em 20.1: ali $w$ sempre permanecia $1$,
  aqui $w$ passa a depender de $z$, e a divisão final por $w$ é uma operação
  *não linear*. Esquecer esse passo é o erro mais comum ao calcular projeção
  perspectiva em prova.
]

#example(id: "q-projecao-perspectiva-1")[
  Um ponto $(x,y,z) = (4, 2, 8)$ é projetado perspectivamente sobre o plano
  $z = d = 4$, com o centro de projeção na origem. Calcule as coordenadas
  projetadas $(x', y')$.
]

#solution[
  Aplicando a matriz $M_"persp"$ ao ponto homogêneo $(4,2,8,1)^T$:
  $ mat(1,0,0,0; 0,1,0,0; 0,0,1,0; 0,0,1/4,0)
    mat(4;2;8;1) = mat(4;2;8;2). $
  Dividindo pela quarta coordenada ($w=2$, divisão perspectiva):
  $ x' = 4/2 = 2, quad y' = 2/2 = 1. $
  Confere com a fórmula direta: $x' = d x/z = 4 dot 4/8 = 2$ e
  $y' = d y /z = 4 dot 2 /8 = 1$.
]

#example(id: "q-projecao-classificacao")[
  (Múltipla escolha) Qual característica é *exclusiva* da projeção
  perspectiva, não ocorrendo na projeção paralela?
  + Preservação do paralelismo entre retas paralelas do objeto.
  + Existência de pontos de fuga para retas não paralelas ao plano de projeção.
  + Uso de coordenadas homogêneas na matriz de transformação.
  + Redução da dimensionalidade de 3D para 2D.
]

#solution[
  Resposta: alternativa *(2)*. As opções (3) e (4) valem para ambas; a opção
  (1) é justamente uma propriedade da projeção *paralela*, não da perspectiva
  (que converge retas para pontos de fuga em vez de preservar paralelismo).
]

== Pontos de fuga

#remark[
  Uma projeção perspectiva é classificada por *quantos eixos principais
  (x, y, z) o plano de projeção intercepta*: perspectiva de *um ponto* (o plano
  é paralelo a dois dos três eixos, só um eixo gera ponto de fuga), *dois
  pontos* (paralelo a um eixo) ou *três pontos* (não paralelo a nenhum eixo
  principal). Quanto mais pontos de fuga, maior a sensação de profundidade --
  e mais cara a distorção geométrica introduzida.
]

== Referências

- FOLEY, J. D. et al. *Computer Graphics: Principles and Practice*. Cap. sobre
  projeções paralela e perspectiva.
- HEARN, D.; BAKER, M. P. *Computer Graphics with OpenGL*. Cap. sobre
  projeções 3D.
- cienciadacomputacao.wiki.br -- Tópico 20.3.
