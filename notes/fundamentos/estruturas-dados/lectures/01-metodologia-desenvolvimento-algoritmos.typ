#import "@preview/mousse-notes:1.1.0": *

= Metodologia de Desenvolvimento de Algoritmos

== Introdução

Todo problema computacional é resolvido por um processo sistemático de tradução de uma ideia em
uma sequência de passos executável por uma máquina. Essa disciplina de "como chegar de um enunciado
a um programa correto" é a metodologia de desenvolvimento de algoritmos: entender o problema,
projetar uma solução abstrata, representá-la de forma não ambígua e só então implementá-la. Questões
sobre as fases desse processo e sobre as propriedades que definem um algoritmo válido são recorrentes
em provas de fundamentos de computação.

== Definições formais

#definition(id: "def-algoritmo")[
  Um *algoritmo* é uma sequência finita de instruções, não ambíguas e executáveis mecanicamente, que
  transforma um conjunto de entradas em um conjunto de saídas em tempo finito, resolvendo um problema
  bem definido.
]

Donald Knuth caracteriza um algoritmo por cinco propriedades essenciais:

#definition(id: "def-propriedades-algoritmo")[
  + *Finitude*: o algoritmo termina após um número finito de passos.
  + *Definição (determinismo)*: cada passo é precisamente definido, sem ambiguidade.
  + *Entrada*: possui zero ou mais entradas, fornecidas antes ou durante a execução.
  + *Saída*: produz uma ou mais saídas, relacionadas às entradas.
  + *Efetividade*: cada operação é suficientemente básica para, em princípio, ser executada
    exatamente, em tempo finito, por uma pessoa usando papel e lápis.
]

#remark[
  "Efetividade" não é o mesmo que "eficiência". Um algoritmo pode ser efetivo (cada passo é
  realizável) e mesmo assim extremamente lento. Eficiência é uma medida de custo (tempo/espaço),
  enquanto efetividade é uma condição de existência do algoritmo.
]

#definition(id: "def-pseudocodigo")[
  *Pseudocódigo* é uma notação informal, próxima da linguagem natural e de estruturas de
  linguagens de programação, usada para descrever um algoritmo sem se prender à sintaxe de uma
  linguagem específica. *Fluxograma* é a representação gráfica equivalente, usando símbolos
  padronizados (retângulo para processamento, losango para decisão, elipse para início/fim).
]

== Fases do desenvolvimento de um algoritmo

O desenvolvimento de um algoritmo, do ponto de vista didático, segue tipicamente as fases abaixo.
Elas não são estritamente sequenciais: é comum retornar a uma fase anterior ao encontrar um erro.

+ *Análise do problema*: entender os dados de entrada, o resultado esperado e as restrições
  (domínio de validade dos dados, casos especiais, recursos disponíveis).
+ *Projeto da solução (design)*: escolher uma estratégia algorítmica (força bruta, divisão e
  conquista, recursão, programação dinâmica etc.) e as estruturas de dados adequadas.
+ *Representação do algoritmo*: descrever a solução em pseudocódigo ou fluxograma, de forma
  independente de linguagem.
+ *Codificação (implementação)*: traduzir a representação para uma linguagem de programação
  concreta.
+ *Teste e depuração*: verificar se a implementação produz os resultados esperados para um
  conjunto de casos de teste, incluindo casos de borda.
+ *Análise e manutenção*: avaliar complexidade de tempo/espaço e manter o código à medida que
  requisitos mudam.

#figure(
  table(
    columns: 2,
    stroke: 0.5pt,
    align: left,
    [*Fase*], [*Produto*],
    [Análise], [Especificação do problema (entradas, saídas, restrições)],
    [Projeto], [Estratégia algorítmica escolhida],
    [Representação], [Pseudocódigo / fluxograma],
    [Codificação], [Programa em uma linguagem concreta],
    [Teste], [Conjunto de casos de teste executados com sucesso],
    [Manutenção], [Versão revisada / documentada],
  ),
  caption: [Fases do desenvolvimento de algoritmos e seus produtos.],
)

== Exemplo resolvido

#example(id: "ex-metodologia-mdc")[
  Aplique a metodologia acima ao problema "calcular o Máximo Divisor Comum (MDC) de dois inteiros
  positivos $a$ e $b$".

  - *Análise*: entradas $a, b in NN^*$; saída: o maior inteiro que divide $a$ e $b$ simultaneamente.
  - *Projeto*: usar o algoritmo de Euclides, baseado na identidade $"mdc"(a,b) = "mdc"(b, a mod b)$,
    com caso base $"mdc"(a, 0) = a$.
  - *Representação* (pseudocódigo):

  ```
  função mdc(a, b)
      enquanto b ≠ 0 faça
          (a, b) ← (b, a mod b)
      fim-enquanto
      retorne a
  fim-função
  ```

  - *Codificação* (equivalente em C):

  ```c
  int mdc(int a, int b) {
      while (b != 0) {
          int t = b;
          b = a % b;
          a = t;
      }
      return a;
  }
  ```

  - *Teste*: $"mdc"(48, 18) = 6$; $"mdc"(17, 5) = 1$; $"mdc"(9, 0) = 9$ (caso de borda).
]

== Armadilhas comuns

#remark[
  - Confundir *algoritmo* com *programa*: o algoritmo é a ideia abstrata e independente de
    linguagem; o programa é uma de suas possíveis implementações concretas.
  - Um pseudocódigo "quase certo" que não trata casos de borda (entrada vazia, zero, valores
    negativos) não satisfaz a propriedade de *definição* do @def-propriedades-algoritmo — a prova
    costuma cobrar identificar qual propriedade foi violada.
  - Nem todo procedimento é um algoritmo: um processo que pode não terminar (ex.: um servidor que
    fica em loop atendendo requisições) viola *finitude* e é chamado de *método computacional*, não
    algoritmo, na definição clássica de Knuth.
]

== Questões

#example(id: "q-metodologia-1")[
  *(Múltipla escolha)* Das propriedades que Knuth atribui a um algoritmo, qual delas é violada por
  um procedimento que, para determinadas entradas, entra em um laço infinito?

  (a) Entrada #h(1em) (b) Saída #h(1em) (c) Finitude #h(1em) (d) Efetividade #h(1em) (e) Definição
]

#example(id: "q-metodologia-2")[
  *(Dissertativa curta)* Explique a diferença entre a fase de *projeto* e a fase de
  *codificação* no desenvolvimento de um algoritmo, e dê um exemplo de decisão tomada em cada uma
  para o problema de ordenar uma lista de números.
]

#example(id: "q-metodologia-3")[
  *(Múltipla escolha)* Um pseudocódigo é escrito para calcular a média de $n$ notas, mas não
  especifica o que fazer quando $n = 0$. Isso compromete diretamente qual propriedade de um
  algoritmo?

  (a) Finitude #h(1em) (b) Definição #h(1em) (c) Efetividade #h(1em) (d) Saída #h(1em) (e) Entrada
]

#solution[
  *Q1*: (c) — um laço que não termina para certas entradas viola a finitude.

  *Q2*: Projeto é a escolha da *estratégia* (ex.: "vou usar um algoritmo de ordenação por
  comparação, com estratégia dividir-e-conquistar"); codificação é a *tradução* dessa estratégia
  para uma linguagem concreta (ex.: implementar `mergesort` em Python, escolhendo a sintaxe de
  recursão da linguagem). O projeto é independente de linguagem; a codificação não.

  *Q3*: (b) — a definição (ausência de ambiguidade) é violada, pois o comportamento para $n=0$
  (divisão por zero) não está especificado.
]

== Referências

- Knuth, D. E. *The Art of Computer Programming, Vol. 1: Fundamental Algorithms*, cap. 1.
- Ziviani, N. *Projeto de Algoritmos*, cap. 1.
- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 1–2.
