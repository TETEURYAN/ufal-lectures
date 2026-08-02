#import "@preview/mousse-notes:1.1.0": *

= 22.8 --- Esquemas para Representação do Conhecimento: Lógicos, em Rede, Estruturados, Procedurais

== Introdução

Antes de raciocinar automaticamente (22.9 em diante), é preciso *representar* o conhecimento de forma que um programa consiga manipulá-lo. O edital exige diferenciar quatro esquemas clássicos -- item recorrente de associação conceito↔exemplo na POSCOMP.

== Definições formais

#definition(name: "Representação lógica", id: "def-representacao-logica")[
  Conhecimento expresso como fórmulas de lógica proposicional ou de predicados (Lógica Matemática, 5.1--5.4), com semântica formal precisa e mecanismos de inferência bem estabelecidos (dedução, resolução). Vantagem: rigor e generalidade; desvantagem: pode ser ineficiente para consultas específicas sobre estruturas muito regulares (ex.: hierarquias de classes).
]

#definition(name: "Representação em rede (redes semânticas)", id: "def-representacao-em-rede")[
  Grafo cujos nós são conceitos/objetos e cujas arestas rotuladas representam relações entre eles -- tipicamente `é-um` (is-a, relação de subclasse) e `parte-de` (has-a/part-of). Permite *herança*: propriedades de uma classe são automaticamente atribuídas a subclasses e instâncias, sem repetição explícita.
]

#definition(name: "Representação estruturada (frames)", id: "def-representacao-estruturada")[
  Organiza o conhecimento sobre um conceito em uma estrutura com *slots* (atributos nomeados) e *fillers* (valores, que podem ser dados diretos, valores padrão, ou procedimentos para calcular o valor). Frames podem herdar slots de frames "pai", similar a classes em programação orientada a objetos -- de fato, frames são um precursor conceitual direto dessa ideia.
]

#definition(name: "Representação procedural", id: "def-representacao-procedural")[
  Conhecimento codificado como *procedimentos* (código executável) que sabem *como* realizar uma tarefa ou responder a uma consulta, em vez de fatos declarativos que um mecanismo de inferência genérico interpreta. Mais eficiente para tarefas específicas, porém menos flexível: modificar ou reutilizar o conhecimento exige alterar o procedimento em si, não apenas adicionar fatos.
]

== Exemplo resolvido

#example(name: "O mesmo conhecimento em quatro esquemas", id: "ex-quatro-esquemas-mesmo-conhecimento")[
  Conhecimento: "canários são pássaros; pássaros são animais; pássaros voam; canários são amarelos."

  - *Lógico*: $forall x, ("canario"(x) -> "passaro"(x))$, $forall x, ("passaro"(x) -> "animal"(x) and "voa"(x))$, $forall x, ("canario"(x) -> "amarelo"(x))$.
  - *Em rede*: nós `Canário`, `Pássaro`, `Animal`, ligados por arestas `é-um`; um nó de propriedade `Voa` ligado a `Pássaro`; `Amarelo` ligado a `Canário` -- `Canário` herda `Voa` de `Pássaro` via a relação `é-um`.
  - *Estruturado (frame)*: `frame Pássaro [é-um: Animal, voa: sim]`; `frame Canário [é-um: Pássaro, cor: amarelo]` -- `Canário` herda `voa: sim` do frame `Pássaro`.
  - *Procedural*: uma função `pode_voar(x)` que verifica, via código específico, se `x` pertence à categoria pássaro e retorna verdadeiro -- sem uma representação declarativa reutilizável por outros mecanismos de inferência.
]

== Atenção -- pegadinhas comuns

#remark(name: "Herança aparece em rede e em frames, não é exclusiva de um dos dois")[
  Redes semânticas e frames são, na prática, formas alternativas de representar hierarquias com herança -- a diferença é de ênfase: redes semânticas destacam a *estrutura de grafo* e suas relações; frames destacam a *organização em slots* de um conceito individual, mais próxima da metáfora de "ficha" ou registro.
]

#remark(name: "Representação procedural não é \"errada\", apenas menos reutilizável")[
  Sistemas reais frequentemente combinam esquemas -- ex.: uma base de regras declarativas (representação lógica/em rede) com procedimentos específicos anexados para eficiência (procedural) em pontos críticos. Não existe um esquema universalmente superior; a escolha depende do trade-off entre flexibilidade/generalidade e eficiência/especificidade.
]

== Questões estilo POSCOMP

*Questão 1.* A representação do conhecimento que organiza um conceito em atributos nomeados (slots) com valores associados, permitindo herança de um frame "pai", é a representação:
- a) Lógica.
- b) Em rede.
- c) Estruturada (frames).
- d) Procedural.
- e) Nenhuma das anteriores.

*Questão 2.* A principal desvantagem da representação procedural, em comparação com esquemas declarativos, é:
- a) Não pode ser executada por um computador.
- b) É sempre mais lenta em qualquer situação.
- c) É menos flexível e reutilizável, pois o conhecimento está embutido em código específico.
- d) Não permite representar nenhuma relação entre conceitos.
- e) Exige obrigatoriamente lógica de primeira ordem.

*Questão 3.* Associe: (I) Representação lógica, (II) Representação em rede, (III) Representação estruturada, (IV) Representação procedural -- (a) grafo de conceitos ligados por relações rotuladas como "é-um"; (b) fórmulas com semântica formal e mecanismos de inferência dedutivos; (c) código executável que sabe como realizar uma tarefa; (d) slots e fillers organizados por conceito, com herança.
- a) I-b, II-a, III-d, IV-c.
- b) I-a, II-b, III-c, IV-d.
- c) I-c, II-d, III-a, IV-b.
- d) I-b, II-d, III-a, IV-c.
- e) I-d, II-c, III-b, IV-a.

== Gabarito comentado

1. *(c)* -- slots, fillers e herança de frame "pai" definem exatamente a representação estruturada.
2. *(c)* -- é a limitação central discutida na observação desta seção.
3. *(a)* -- mapeamento direto conforme as quatro definições apresentadas.

== Referências

- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 10 (Representação de conhecimento).
- LUGER, G. *Inteligência Artificial*. Cap. 7 (Esquemas de representação).
- MINSKY, M. *A Framework for Representing Knowledge* (1975) -- artigo original sobre frames.
