#import "@preview/mousse-notes:1.1.0": *

= Recursividade: Conceito e Implementação

== Introdução

Recursão é uma técnica em que uma função resolve um problema chamando a si mesma sobre uma instância
menor do mesmo problema, até atingir um caso trivial. É uma das ideias mais cobradas em provas de
algoritmos, tanto pela sua elegância matemática (indução) quanto pelas armadilhas práticas que
introduz (estouro de pilha, recomputação, custo de espaço) — tópicos que o edital cobra
explicitamente.

== Definições formais

#definition(id: "def-recursao")[
  Uma função (ou procedimento) é *recursiva* quando, em sua própria definição, invoca a si mesma —
  diretamente (*recursão direta*) ou por meio de uma cadeia de outras funções (*recursão indireta* /
  mútua).
]

#definition(id: "def-propriedades-recursao")[
  Toda função recursiva bem-formada precisa de duas partes:
  - *Caso base*: uma ou mais instâncias do problema resolvidas diretamente, sem chamada recursiva —
    garante que a recursão eventualmente termina.
  - *Passo recursivo*: a regra que reduz o problema original a uma instância *estritamente menor* do
    mesmo problema, aproximando-o do caso base a cada chamada.
]

#definition(id: "def-dividir-conquistar")[
  *Dividir para conquistar* é a estratégia recursiva em que um problema de tamanho $n$ é (1)
  *dividido* em $a$ subproblemas independentes de tamanho $n/b$, (2) cada subproblema é *conquistado*
  recursivamente, e (3) as soluções parciais são *combinadas* em uma solução do problema original.
]

== Exemplo resolvido: Torres de Hanói

#example(id: "ex-hanoi")[
  Mover $n$ discos da torre A para a torre C, usando B como auxiliar, sem nunca colocar um disco
  maior sobre um menor.

  - *Caso base*: $n = 1$ — mova o disco diretamente de A para C.
  - *Passo recursivo*: para mover $n$ discos de A para C usando B, (i) mova os $n-1$ discos
    superiores de A para B (usando C como auxiliar), (ii) mova o disco restante de A para C, (iii)
    mova os $n-1$ discos de B para C (usando A como auxiliar).

  ```
  função hanoi(n, origem, destino, auxiliar)
      se n = 1 então
          mover(origem, destino)
          retorne
      fim-se
      hanoi(n-1, origem, auxiliar, destino)
      mover(origem, destino)
      hanoi(n-1, auxiliar, destino, origem)
  fim-função
  ```

  #figure(
    image("../figures/tower-of-hanoi.png", width: 55%),
    caption: [Torres de Hanói com 4 discos — problema clássico de recursão direta. Fonte:
      Wikimedia Commons (CC0).],
  )

  Seja $T(n)$ o número de movimentos. A recorrência é $T(n) = 2T(n-1) + 1$, $T(1) = 1$, cuja
  solução fechada é $T(n) = 2^n - 1$ (facilmente provada por indução).
]

== Problemas com algoritmos recursivos

=== Stack overflow

#definition(id: "def-stack-overflow")[
  Cada chamada recursiva empilha um novo *quadro de ativação* (variáveis locais, endereço de
  retorno) na pilha de execução. Se a profundidade de recursão exceder o espaço de pilha disponível,
  ocorre *stack overflow* — um erro de esgotamento de memória específico da pilha de chamadas.
]

#remark[
  Recursões sem um caso base alcançável (ou com passo recursivo que não reduz o problema)
  causam recursão infinita e, na prática, sempre terminam em stack overflow — é o análogo, em
  recursão, de um laço infinito em iteração.
]

=== Cálculos duplicados (recomputação)

#example(id: "ex-fibonacci-duplicado")[
  A definição recursiva ingênua de Fibonacci, $F(n) = F(n-1) + F(n-2)$, $F(0)=0$, $F(1)=1$,
  recalcula os mesmos subproblemas exponencialmente muitas vezes:

  ```
  fib(5)
  ├─ fib(4)
  │  ├─ fib(3)
  │  │  ├─ fib(2) ├─ fib(1)  fib(0)
  │  │  └─ fib(1)
  │  └─ fib(2)
  │     ├─ fib(1)  fib(0)
  └─ fib(3)
     ├─ fib(2) ├─ fib(1)  fib(0)
     └─ fib(1)
  ```

  `fib(2)` é recalculado 3 vezes, `fib(1)` é recalculado 5 vezes — o número total de chamadas cresce
  como $O(phi^n)$, com $phi approx 1.618$ (razão áurea). A técnica de *memoização* (armazenar
  resultados já computados) resolve isso reduzindo o custo para $O(n)$, ponte direta para o tópico
  de programação dinâmica (9.13).
]

=== Considerações de complexidade

#definition(id: "def-complexidade-recursiva")[
  Para uma função recursiva, distinguem-se dois custos:
  - *Complexidade de tempo*: número total de operações executadas, tipicamente modelado por uma
    *relação de recorrência* $T(n)$ que descreve o custo em função do tamanho da entrada.
  - *Complexidade espacial*: memória adicional usada, dominada pela *profundidade máxima da pilha
    de chamadas* (para recursão não-cauda) somada a qualquer estrutura auxiliar alocada.
]

#theorem(name: "Recorrência mestre (caso simplificado)", id: "thm-mestre")[
  Para uma recorrência da forma $T(n) = a T(n/b) + O(n^d)$, com $a >= 1$, $b > 1$, $d >= 0$:
  $ T(n) = cases(
    O(n^d) & "se" d > log_b a,
    O(n^d log n) & "se" d = log_b a,
    O(n^(log_b a)) & "se" d < log_b a,
  ) $
]

#remark[
  O Teorema Mestre resolve diretamente a recorrência de algoritmos de dividir-para-conquistar. Por
  exemplo, Merge Sort tem $a=2, b=2, d=1$, logo $d = log_b a = 1$, caindo no segundo caso:
  $T(n) = O(n log n)$ (ver tópico 9.11).
]

== Armadilhas comuns

#remark[
  - *Recursão em cauda $eq.not$ recursão qualquer*: uma recursão é de *cauda* (tail recursion)
    quando a chamada recursiva é a última operação da função, sem trabalho pendente após o
    retorno. Compiladores/interpretadores que fazem *tail call optimization* podem executá-la com
    espaço $O(1)$ — mas nem toda linguagem faz essa otimização (Python, por exemplo, não faz).
  - *Confundir "recursivo" com "ineficiente"*: a ineficiência de `fib` ingênuo vem da *recomputação*
    de subproblemas sobrepostos, não da recursão em si — Merge Sort é recursivo e ótimo
    ($O(n log n)$) porque seus subproblemas não se sobrepõem.
  - *Esquecer o caso base ou defini-lo de forma inalcançável*: por exemplo, decrementar $n$ por 2 mas
    checar apenas `n == 0` — se $n$ for ímpar, o caso base nunca é atingido.
]

== Questões

#example(id: "q-recursao-1")[
  *(Múltipla escolha)* Quantos movimentos de disco são necessários para resolver a Torre de
  Hanói com 5 discos?

  (a) 10 #h(1em) (b) 15 #h(1em) (c) 31 #h(1em) (d) 32 #h(1em) (e) 63
]

#example(id: "q-recursao-2")[
  *(Múltipla escolha)* Considere $T(n) = 4T(n/2) + O(n)$. Pelo Teorema Mestre (@thm-mestre), qual é
  a complexidade assintótica de $T(n)$?

  (a) $O(n)$ #h(1em) (b) $O(n log n)$ #h(1em) (c) $O(n^2)$ #h(1em) (d) $O(n^2 log n)$ #h(1em)
  (e) $O(2^n)$
]

#example(id: "q-recursao-3")[
  *(Dissertativa curta)* Explique por que o `fib` recursivo ingênuo é exponencial e como a
  memoização resolve esse problema, sem eliminar a recursão.
]

#solution[
  *Q1*: (c) — $T(5) = 2^5 - 1 = 31$.

  *Q2*: (c) — $a=4, b=2, d=1$; $log_2 4 = 2 > d = 1$, logo caímos no terceiro caso do
  @thm-mestre: $T(n) = O(n^(log_2 4)) = O(n^2)$.

  *Q3*: `fib(n)` ingênuo refaz, para cada chamada, duas subchamadas que se sobrepõem amplamente
  (ex.: `fib(2)` é recalculado repetidas vezes dentro da árvore de chamadas), gerando
  $O(phi^n)$ chamadas. Memoização guarda o resultado de cada `fib(k)` já calculado (ex.: em um
  array ou tabela hash) e o reutiliza nas chamadas seguintes, reduzindo o número de subproblemas
  distintos resolvidos para $O(n)$ — a estrutura recursiva permanece, apenas deixa de recalcular.
]

== Referências

- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 4 (Divide-and-Conquer, Teorema Mestre).
- Ziviani, N. *Projeto de Algoritmos*, cap. 5.
- Sedgewick, R.; Wayne, K. *Algorithms*, cap. 2.3, 5.1.
