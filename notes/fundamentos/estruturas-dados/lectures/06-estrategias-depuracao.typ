#import "@preview/mousse-notes:1.1.0": *

= Estratégias de Depuração

== Introdução

Depuração (*debugging*) é o processo sistemático de localizar e corrigir defeitos em um algoritmo ou
programa. Embora pareça um tema "prático", provas de fundamentos cobram a classificação de tipos de
erro e o raciocínio por trás de técnicas de depuração — habilidades que também sustentam a leitura de
código em questões de múltipla escolha.

== Definições formais

#definition(id: "def-tipos-erro")[
  Um defeito de programa se manifesta como um de três tipos de erro:
  - *Erro de sintaxe*: viola as regras gramaticais da linguagem; detectado em tempo de compilação
    (ou parsing), impede a geração do executável.
  - *Erro de execução (runtime)*: ocorre durante a execução do programa sintaticamente válido (ex.:
    divisão por zero, acesso a índice fora dos limites, desreferência de ponteiro nulo).
  - *Erro de lógica (semântico)*: o programa executa sem falhar, mas produz resultado incorreto —
    o mais difícil de detectar automaticamente, pois não gera nenhum sinal de erro.
]

#definition(id: "def-depuracao")[
  *Depuração* é o processo de (1) reproduzir o defeito de forma consistente, (2) isolar sua causa
  raiz reduzindo o espaço de busca, e (3) corrigi-lo, verificando que a correção não introduz
  regressões.
]

== Estratégias de depuração

#definition(id: "def-estrategias-depuracao")[
  As técnicas mais usadas para isolar defeitos incluem:
  - *Depuração por impressão (print debugging)*: inserir instruções de saída em pontos estratégicos
    para observar valores intermediários de variáveis.
  - *Breakpoints e execução passo a passo*: usar um depurador interativo para pausar a execução em
    um ponto específico e inspecionar o estado do programa.
  - *Depuração por bisseção (bisection debugging)*: aplicar busca binária sobre o espaço do
    problema — por exemplo, comentar/remover metade do código, ou usar `git bisect` sobre o
    histórico de commits, para isolar em qual metade o defeito se manifesta, reduzindo o espaço de
    busca em $O(log n)$ passos.
  - *Rubber duck debugging*: explicar o código linha a linha (a um colega, ou literalmente a um pato
    de borracha) — o ato de verbalizar a lógica frequentemente revela a inconsistência.
  - *Asserções (assertions)*: instruções que verificam uma invariante esperada e interrompem a
    execução imediatamente se ela for violada, aproximando o ponto de falha do ponto de causa.
]

#remark[
  A *bisseção* é conceitualmente idêntica à busca binária (tópico 9.11): dado um espaço ordenável de
  hipóteses (commits, linhas de código, intervalos de entrada), cada teste elimina metade do espaço
  restante — por isso localiza o defeito em $O(log n)$ testes em vez de $O(n)$.
]

== Exemplo resolvido

#example(id: "ex-depuracao-bisseção")[
  Um programa passou a falhar em algum commit entre o commit #100 (funcionando) e o commit #200
  (com defeito). Em vez de testar os 100 commits um a um:

  ```
  baixo ← 100, alto ← 200
  enquanto alto - baixo > 1 faça
      meio ← (baixo + alto) / 2
      se commit(meio) está OK então
          baixo ← meio
      senão
          alto ← meio
      fim-se
  fim-enquanto
  // 'alto' é o primeiro commit com defeito
  ```

  Esse processo (implementado por ferramentas como `git bisect`) localiza o commit culpado em
  $ceil(log_2(200-100)) = 7$ testes, em vez de até 100.
]

== Armadilhas comuns

#remark[
  - *Corrigir o sintoma, não a causa*: "consertar" um valor incorreto forçando-o (ex.: `if (x ==
    -1) x = 0;`) esconde o defeito em vez de corrigi-lo — o erro de lógica original permanece e
    pode se manifestar de outra forma depois.
  - *Confundir erro de execução com erro de lógica*: um programa que lança uma exceção de índice
    fora dos limites tem um erro de execução *observável*; um programa que retorna silenciosamente
    um valor errado tem um erro de lógica, frequentemente mais grave por ser silencioso.
  - *Depender só de "print" em sistemas concorrentes*: em programas com múltiplas threads/processos,
    inserir prints pode alterar o *timing* da execução e mascarar (ou criar) condições de corrida —
    fenômeno conhecido informalmente como "heisenbug".
]

== Questões

#example(id: "q-depuracao-1")[
  *(Múltipla escolha)* Um programa compila e executa sem lançar exceções, mas devolve
  sistematicamente o resultado errado para determinadas entradas. Que tipo de erro é esse?

  (a) Erro de sintaxe #h(1em) (b) Erro de execução #h(1em) (c) Erro de lógica #h(1em)
  (d) Erro de linkagem #h(1em) (e) Não é um erro, é uma limitação de hardware
]

#example(id: "q-depuracao-2")[
  *(Dissertativa curta)* Explique por que a depuração por bisseção tem complexidade $O(log n)$ em
  relação ao número de commits (ou linhas) candidatos, e compare com uma busca sequencial.
]

#solution[
  *Q1*: (c) — comportamento sintaticamente e operacionalmente correto, mas resultado incorreto,
  é a assinatura de um erro de lógica.

  *Q2*: A bisseção descarta metade do espaço de busca a cada teste (assumindo que o defeito, uma
  vez introduzido, persiste em todos os commits/linhas subsequentes) — o mesmo princípio da busca
  binária (@def-estrategias-depuracao). Isso dá $O(log n)$ testes, contra $O(n)$ de uma varredura
  sequencial testando um candidato por vez.
]

== Referências

- Ziviani, N. *Projeto de Algoritmos*, cap. sobre corretude e testes.
- Zeller, A. *Why Programs Fail: A Guide to Systematic Debugging*.
- McConnell, S. *Code Complete*, cap. sobre depuração.
