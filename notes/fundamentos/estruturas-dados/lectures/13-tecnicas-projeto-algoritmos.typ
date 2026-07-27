#import "@preview/mousse-notes:1.1.0": *

= Técnicas de Projeto de Algoritmos

== Introdução

Encerramos o resumo com as principais *estratégias* usadas para projetar algoritmos — o "projeto"
mencionado na fase de metodologia do tópico 9.1. Cada técnica corresponde a uma família ampla de
algoritmos, e reconhecer qual técnica um problema pede (e por que outra falharia) é um dos tipos de
questão mais comuns em provas de fundamentos de algoritmos.

== Força bruta e pesquisa exaustiva

#definition(id: "def-forca-bruta")[
  *Força bruta* resolve um problema testando *todas* as soluções candidatas possíveis (ou uma
  fração ingênua delas), sem usar nenhuma estrutura do problema para podar o espaço de busca.
  *Pesquisa exaustiva* é o caso extremo: enumera *literalmente todo* o espaço de soluções possíveis
  (ex.: testar todos os $2^n$ subconjuntos de um conjunto de tamanho $n$), garantindo a solução
  ótima ao custo de complexidade tipicamente exponencial.
]

#remark[
  Força bruta e pesquisa exaustiva são a "linha de base" contra a qual outras técnicas são
  comparadas: sempre corretas (dado tempo suficiente), quase sempre impraticáveis para $n$ grande —
  o objetivo das técnicas seguintes é obter a mesma garantia de corretude (ou uma aproximação
  aceitável) com complexidade muito menor.
]

== Algoritmos gulosos (greedy)

#definition(id: "def-guloso")[
  Um *algoritmo guloso* constrói a solução incrementalmente, fazendo a cada passo a escolha
  *localmente ótima* (a que parece melhor naquele momento), sem reconsiderar escolhas anteriores e
  sem olhar para o problema global.
]

#theorem(name: "Propriedade da escolha gulosa", id: "thm-escolha-gulosa")[
  Um algoritmo guloso produz a solução *globalmente ótima* apenas quando o problema exibe a
  *propriedade da escolha gulosa* (uma solução ótima global pode ser construída a partir de
  escolhas ótimas locais) e *subestrutura ótima* (a solução ótima contém, dentro de si, soluções
  ótimas para subproblemas). A demonstração típica usa um *argumento de troca* (exchange argument):
  mostra que qualquer solução ótima pode ser transformada na solução gulosa sem piorá-la.
]

#example(id: "ex-guloso-troco")[
  *Problema do troco* com moedas $\{25, 10, 5, 1\}$ centavos: para dar troco de 41 centavos, a
  estratégia gulosa escolhe sempre a maior moeda que ainda cabe: $25 + 10 + 5 + 1 = 41$ (4 moedas) —
  ótimo para este sistema monetário. Mas com moedas $\{1, 3, 4\}$ e troco de 6: o guloso escolhe
  $4 + 1 + 1 = 6$ (3 moedas), enquanto $3 + 3 = 6$ usa só 2 — aqui o guloso *falha* em ser ótimo,
  pois esse sistema de moedas não satisfaz o @thm-escolha-gulosa.
]

== Dividir para conquistar

#remark[
  Já formalizado no tópico 9.4 (@def-dividir-conquistar): divide o problema em subproblemas
  independentes, resolve cada um recursivamente, e combina as soluções. Difere do guloso por
  *sempre* considerar (recursivamente) o problema completo de cada subproblema, não apenas uma
  escolha local — e do backtracking por não precisar "desfazer" decisões, já que os subproblemas
  são independentes por construção (ex.: Merge Sort, tópico 9.11).
]

== Backtracking

#definition(id: "def-backtracking")[
  *Backtracking* (retrocesso) explora o espaço de soluções incrementalmente, como uma árvore de
  decisões: a cada passo, tenta estender uma solução parcial; se a extensão viola alguma restrição
  (*poda*), retrocede (*backtrack*) e tenta a próxima alternativa. Diferente da pesquisa exaustiva
  ingênua, poda ramos inteiros da árvore de busca assim que uma violação é detectada, evitando
  explorá-los completamente.
]

#example(id: "ex-backtracking-nrainhas")[
  *Problema das $n$ rainhas*: posicionar $n$ rainhas em um tabuleiro $n times n$ sem que duas se
  ataquem (mesma linha, coluna ou diagonal).

  ```
  função resolve(tabuleiro, linha)
      se linha = n então
          retorne verdadeiro   // solução completa encontrada
      para coluna de 0 até n-1 faça
          se posição_segura(tabuleiro, linha, coluna) então
              colocar_rainha(tabuleiro, linha, coluna)
              se resolve(tabuleiro, linha + 1) então
                  retorne verdadeiro
              remover_rainha(tabuleiro, linha, coluna)   // backtrack
      retorne falso   // nenhuma coluna funcionou nesta linha
  fim-função
  ```

  Ao colocar uma rainha em uma posição que ataca outra já colocada, o algoritmo *nem tenta*
  continuar a partir dali — descarta o ramo imediatamente (poda), em vez de completar o tabuleiro e
  verificar no final, como faria a pesquisa exaustiva pura.
]

== Heurísticas

#definition(id: "def-heuristica")[
  Uma *heurística* é uma regra prática que guia a busca por uma solução *boa* (não necessariamente
  ótima) em tempo viável, quando encontrar a solução ótima exata é computacionalmente
  inviável (tipicamente para problemas NP-difíceis). Diferente de força bruta/backtracking, uma
  heurística tipicamente *não garante* encontrar a melhor solução, nem sempre garante um limite de
  qualidade sobre o quão longe do ótimo ela pode ficar.
]

#example(id: "ex-heuristica-vizinho-mais-proximo")[
  *Problema do caixeiro-viajante (TSP)*, heurística do vizinho mais próximo: partindo de uma
  cidade, sempre visite a cidade não visitada mais próxima, até visitar todas. Simples e rápida
  ($O(n^2)$), mas pode ficar arbitrariamente longe do ótimo — decisões gulosas locais (visitar o
  vizinho mais próximo agora) podem "encurralar" o caminho, forçando um salto longo no final.
]

== Comparação das técnicas

#figure(
  table(
    columns: 3,
    stroke: 0.5pt,
    align: left,
    [*Técnica*], [*Garante ótimo?*], [*Ideia central*],
    [Força bruta / exaustiva], [Sim], [Testa (todo) o espaço de soluções],
    [Guloso], [Só se a propriedade da escolha gulosa vale], [Escolha local ótima, sem retroceder],
    [Dividir e conquistar], [Sim (para o problema resolvido)], [Subproblemas independentes,
      combinados],
    [Backtracking], [Sim (explora todo o espaço válido, com poda)], [Constrói e desfaz
      incrementalmente, podando ramos inválidos],
    [Heurística], [Não, em geral], [Regra prática rápida, sem garantia de otimalidade],
  ),
  caption: [Visão consolidada das técnicas de projeto de algoritmos do edital.],
)

== Armadilhas comuns

#remark[
  - *Backtracking $eq.not$ força bruta*: ambos podem, no pior caso, explorar um espaço exponencial,
    mas backtracking *poda* ramos inválidos assim que detectados, tipicamente muito mais rápido na
    prática, mesmo com a mesma complexidade de pior caso teórica.
  - *Guloso "parece" sempre correto*: é tentador aplicar a estratégia gulosa a qualquer problema de
    otimização — o erro clássico é não verificar a propriedade da escolha gulosa
    (@thm-escolha-gulosa) antes de assumir otimalidade, como no contraexemplo do troco.
  - *Heurística $eq.not$ aproximação com garantia*: um *algoritmo de aproximação* (tópico avançado
    de NP-completude) garante formalmente estar dentro de um fator do ótimo (ex.: no máximo 2x
    pior); uma heurística pura, como o vizinho mais próximo, não oferece essa garantia — pode, em
    princípio, ficar arbitrariamente longe do ótimo em instâncias adversariais.
  - *Dividir e conquistar exige subproblemas independentes*: quando os subproblemas se sobrepõem
    (como no Fibonacci ingênuo do tópico 9.4), dividir e conquistar "puro" recomputa trabalho
    redundante — o padrão correto nesse caso é programação dinâmica (memoização), não coberta em
    detalhe neste resumo, mas mencionada no tópico 9.4.
]

== Questões

#example(id: "q-tecnicas-1")[
  *(Múltipla escolha)* Qual técnica de projeto de algoritmos garante encontrar uma solução válida
  (se existir), explorando o espaço de soluções por tentativa e retrocesso, podando ramos que
  violam restrições assim que detectados?

  (a) Heurística #h(1em) (b) Guloso #h(1em) (c) Backtracking #h(1em) (d) Dividir e conquistar
  #h(1em) (e) Programação matemática
]

#example(id: "q-tecnicas-2")[
  *(Dissertativa curta)* Dê um exemplo de problema em que a estratégia gulosa produz a solução
  ótima, e outro em que ela falha, explicando a diferença estrutural entre os dois casos.
]

#solution[
  *Q1*: (c).

  *Q2*: Ver @ex-guloso-troco — o problema do troco com moedas $\{25, 10, 5, 1\}$ satisfaz a
  propriedade da escolha gulosa (a escolha da maior moeda válida sempre faz parte de alguma
  solução ótima), mas o sistema $\{1, 3, 4\}$ não satisfaz essa propriedade para o valor 6
  (a escolha gulosa de "4" descarta a solução ótima "3+3"). A diferença estrutural é justamente a
  validade (ou não) da propriedade da escolha gulosa e da subestrutura ótima do
  @thm-escolha-gulosa para aquela instância específica do problema.
]

== Referências

- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 15–16 (guloso), cap. 4 (dividir e
  conquistar).
- Ziviani, N. *Projeto de Algoritmos*, cap. 9–10.
- Sedgewick, R.; Wayne, K. *Algorithms*, cap. 4 (introdução a técnicas de projeto aplicadas a
  grafos).
