#import "@preview/mousse-notes:1.1.0": *

= Algoritmos para "Garbage Collection"

== Introdução

Gerenciamento automático de memória (*garbage collection*, GC) libera o programador de desalocar
manualmente objetos que não são mais usados, evitando duas classes clássicas de bugs: vazamento de
memória (memory leak) e desreferência de ponteiro pendente (dangling pointer / use-after-free). O
edital cobra quatro famílias de algoritmos de GC, todas construídas sobre a noção de
*alcançabilidade*.

== Definições formais

#definition(id: "def-gc-alcancabilidade")[
  Um objeto é *alcançável (reachable)* se existe um caminho de referências a partir do *conjunto
  raiz* (root set — variáveis globais, pilha de execução, registradores) até ele. Um objeto
  *inalcançável* é *lixo (garbage)*: nenhuma parte do programa pode mais acessá-lo, logo sua
  memória pode ser recuperada com segurança.
]

#definition(id: "def-mark-and-sweep")[
  *Mark-and-sweep* (base conceitual dos algoritmos abaixo) opera em duas fases:
  + *Mark*: partindo do conjunto raiz, percorre (DFS/BFS) todas as referências, marcando cada
    objeto alcançável.
  + *Sweep*: percorre toda a heap; todo objeto não marcado é lixo e sua memória é liberada; os
    marcados são desmarcados para o próximo ciclo.
  Custo $O(text("objetos vivos") + text("tamanho da heap"))$ — o *sweep* percorre toda a heap
  independentemente de quanto lixo existe, o que motiva as otimizações abaixo.
]

== Semi-space (cópia)

#definition(id: "def-gc-semispace")[
  O coletor *semi-space* (cópia) divide a heap em dois espaços iguais, apenas um *ativo* por vez.
  Ao coletar, todo objeto alcançável no espaço ativo é *copiado* para o espaço inativo (que passa a
  ser o novo ativo); o espaço antigo inteiro é então considerado livre de uma só vez, sem precisar
  varrer objeto por objeto.
]

#remark[
  Vantagens: sem fragmentação (a cópia compacta os objetos vivos contiguamente) e custo
  proporcional apenas aos objetos *vivos*, não ao tamanho da heap (diferente de mark-and-sweep).
  Desvantagem: usa apenas metade da memória disponível a qualquer momento — o outro espaço fica
  ocioso, reservado para a próxima cópia.
]

== Generational GC

#definition(id: "def-gc-generational")[
  O *GC geracional* particiona a heap por idade dos objetos — tipicamente em *geração jovem*
  (young/nursery) e *geração antiga* (old/tenured). Objetos que sobrevivem a coletas sucessivas na
  geração jovem são *promovidos* para a geração antiga.
]

#theorem(name: "Hipótese geracional (weak generational hypothesis)", id: "thm-hipotese-geracional")[
  Empiricamente, a maioria dos objetos morre jovem — a probabilidade de um objeto sobreviver
  decresce rapidamente com sua idade. Coletar a geração jovem com muito mais frequência que a
  antiga captura a maior parte do lixo a um custo baixo, pois a geração jovem é pequena.
]

#remark[
  Coletar apenas a geração jovem é $O(text("tamanho da geração jovem"))$, muito menor que coletar
  a heap inteira — na prática reduz drasticamente o tempo total gasto em GC, à custa de precisar de
  um *write barrier* (instrumentação que registra referências da geração antiga para a jovem, para
  não perdê-las ao coletar só a jovem).
]

== Compacting GC

#definition(id: "def-gc-compacting")[
  Um GC *compactador* move os objetos vivos para ficarem contíguos na memória após a fase de
  marcação (*mark-sweep-compact*), eliminando *fragmentação externa* (memória livre espalhada em
  fragmentos pequenos demais para satisfazer alocações futuras, mesmo havendo espaço livre total
  suficiente).
]

#remark[
  Diferente do semi-space (que também compacta, mas via cópia entre dois espaços, gastando metade
  da memória), um compactador *in-place* reorganiza os objetos dentro da mesma heap, exigindo mais
  passos (geralmente três: marcar, calcular novos endereços, mover e atualizar referências) mas sem
  desperdiçar metade do espaço.
]

== Incremental GC

#definition(id: "def-gc-incremental")[
  Um GC *incremental* intercala pequenos passos de coleta com a execução normal do programa
  (*mutator*), em vez de pausar o programa inteiro até o fim de um ciclo completo de coleta
  (*stop-the-world*). Reduz a *latência* de pausas individuais, ao custo de maior complexidade
  (é preciso um *write barrier* para detectar mutações feitas pelo programa durante a coleta
  parcial, evitando coletar por engano um objeto que passou a ser referenciado no meio do processo).
]

#remark[
  *Incremental* não é o mesmo que *concorrente*: incremental ainda pausa o mutator, mas em
  intervalos curtos e intercalados; um GC *concorrente* roda simultaneamente com o mutator em
  paralelo (em outra thread), sem pausá-lo — os dois objetivam reduzir latência, por mecanismos
  distintos.
]

== Comparação

#figure(
  table(
    columns: 3,
    stroke: 0.5pt,
    align: left,
    [*Algoritmo*], [*Vantagem principal*], [*Custo/limitação*],
    [Semi-space], [Sem fragmentação; custo $prop$ objetos vivos], [Usa só metade da heap por vez],
    [Generational], [Explora hipótese geracional; coletas jovens rápidas], [Precisa de write
      barrier; objetos "velhos" ainda podem gerar lixo tardio],
    [Compacting], [Elimina fragmentação externa sem duplicar heap], [Mais passos que
      mark-and-sweep simples; move ponteiros],
    [Incremental], [Reduz pausas longas (latência)], [Overhead de write barrier; maior
      complexidade de implementação],
  ),
  caption: [As quatro famílias de GC do edital não são mutuamente exclusivas — coletores
    modernos (ex.: JVM G1, .NET) combinam geracional + incremental/concorrente + compactação.],
)

== Armadilhas comuns

#remark[
  - *Contagem de referências não está na lista do edital*, mas é frequentemente confundida com
    mark-and-sweep em provas: contagem de referências libera um objeto assim que seu contador de
    referências chega a zero (sem esperar um ciclo de coleta), mas não detecta *ciclos de
    referência* (dois objetos que se referenciam mutuamente, mas são inalcançáveis do root set) —
    mark-and-sweep e suas variantes detectam ciclos corretamente, pois partem da alcançabilidade a
    partir da raiz, não de contadores locais.
  - *"Stop-the-world" não é exclusivo de mark-and-sweep simples*: mesmo semi-space e compacting GC
    tradicionais pausam o mutator inteiro durante a coleta — é o incremental/concorrente que ataca
    especificamente esse problema.
  - *Geração antiga também precisa ser coletada*: a hipótese geracional (@thm-hipotese-geracional)
    justifica coletar a jovem com mais frequência, não *nunca* coletar a antiga — coletas completas
    (full GC) da geração antiga ainda ocorrem, só que mais raramente.
]

== Questões

#example(id: "q-gc-1")[
  *(Múltipla escolha)* Qual técnica de coleta de lixo se baseia na observação empírica de que a
  maioria dos objetos morre logo após ser criada?

  (a) Semi-space #h(1em) (b) Compacting GC #h(1em) (c) Generational GC #h(1em)
  (d) Incremental GC #h(1em) (e) Mark-and-sweep simples
]

#example(id: "q-gc-2")[
  *(Dissertativa curta)* Explique por que um coletor semi-space não sofre de fragmentação externa,
  e qual é o seu principal custo em relação ao uso de memória.
]

#solution[
  *Q1*: (c) — ver @thm-hipotese-geracional.

  *Q2*: Ao coletar, o semi-space copia todos os objetos vivos para o espaço inativo, colocando-os
  *contiguamente* — não há "buracos" entre eles, eliminando fragmentação externa por construção
  (@def-gc-semispace). O custo principal é que apenas metade da heap disponível está em uso a
  qualquer momento (a outra metade fica reservada, vazia, para a próxima cópia), reduzindo pela
  metade a memória efetivamente utilizável pelo programa.
]

== Referências

- Jones, R.; Hosking, A.; Moss, E. *The Garbage Collection Handbook: The Art of Automatic Memory
  Management*.
- Cormen, T. H. et al. *Introduction to Algorithms* (alcançabilidade como busca em grafos, cap.
  22).
