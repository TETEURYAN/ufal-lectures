#import "@preview/mousse-notes:1.1.0": *

= Memória Auxiliar
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.7]

== Introdução

Abaixo da memória principal na hierarquia (07) está a memória auxiliar (ou secundária): não volátil, de capacidade muito maior e custo por byte muito menor, ao preço de latência ordens de magnitude maior. Esta subseção cobre a organização física de discos magnéticos, o cálculo do tempo de acesso e os arranjos RAID, item de cálculo recorrente na POSCOMP.

== Definições formais

#definition(name: "Memória auxiliar (secundária)", id: "def-memoria-auxiliar")[
  Dispositivo de armazenamento *não volátil* (retém dados sem energia), usado para armazenamento persistente de longo prazo -- discos magnéticos (HDD), unidades de estado sólido (SSD), mídias óticas e fitas magnéticas. Em contraste com a memória principal (07), é acessada por meio do subsistema de E/S (06), não diretamente endereçável pela CPU.
]

#definition(name: "Organização física de um disco magnético (HDD)", id: "def-organizacao-disco")[
  Um HDD armazena dados em *pratos (platters)* circulares giratórios, cada face dividida em *trilhas (tracks)* concêntricas, cada trilha dividida em *setores*. O conjunto de trilhas de mesmo raio em todos os pratos forma um *cilindro*. Um *braço com cabeças de leitura/escrita* se move radialmente para posicionar-se sobre a trilha desejada.
]

#definition(name: "Componentes do tempo de acesso a disco", id: "def-tempo-acesso-disco")[
  O tempo para ler/escrever um bloco em um HDD se decompõe em três parcelas:
  - *Tempo de busca (seek time)*: tempo para mover o braço até a trilha correta.
  - *Latência rotacional*: tempo de espera até que o setor desejado gire até a posição da cabeça de leitura -- em média, meia volta: $"latência média" = (1\/2) times (60 \/ "RPM")$.
  - *Tempo de transferência*: tempo para efetivamente ler/escrever os bits do setor, uma vez posicionado.
]

#definition(name: "SSD (Solid-State Drive)", id: "def-ssd")[
  Armazenamento não volátil baseado em memória flash, sem partes mecânicas móveis -- elimina tempo de busca e latência rotacional, resultando em acesso aleatório muito mais rápido que HDD. Exige *wear leveling* (distribuição uniforme de escritas entre células) para compensar o número limitado de ciclos de escrita que cada célula de memória flash suporta antes de se degradar.
]

#definition(name: "RAID (Redundant Array of Independent Disks)", id: "def-raid")[
  Técnica que combina múltiplos discos físicos em uma unidade lógica, buscando desempenho, redundância (tolerância a falha), ou ambos:
  - *RAID 0 (striping)*: dados divididos (stripe) entre discos sem redundância -- máximo desempenho e capacidade, mas *nenhuma* tolerância a falha (perda de um disco perde todos os dados).
  - *RAID 1 (mirroring)*: cada disco é espelhado integralmente em outro -- tolera a falha de um disco, mas usa apenas metade da capacidade bruta total.
  - *RAID 5 (paridade distribuída)*: dados divididos em stripes entre $n$ discos, com informação de paridade distribuída entre todos eles (não concentrada em um único disco) -- tolera a falha de *um* disco, com capacidade útil de $n-1$ discos.
  - *RAID 6*: como RAID 5, mas com *dois* blocos de paridade distribuídos -- tolera a falha de *até dois* discos simultaneamente, com capacidade útil de $n-2$ discos.
  - *RAID 10 (1+0)*: combina espelhamento (RAID 1) com striping (RAID 0) -- alto desempenho e tolerância a falha, ao custo de usar apenas metade da capacidade bruta, como no RAID 1.
]

== Exemplo resolvido

#example(name: "Calculando o tempo médio de acesso a um HDD", id: "ex-tempo-acesso-hdd")[
  Um disco gira a $7200$ RPM, com tempo médio de busca de $8 "ms"$ e tempo de transferência de $0.1 "ms"$ por setor. Qual o tempo médio total de acesso?

  Tempo por revolução: $60000 \/ 7200 approx 8.33 "ms"$. Latência rotacional média (meia volta): $8.33 \/ 2 approx 4.17 "ms"$.

  $ "Tempo total" = "busca" + "latência rotacional" + "transferência" = 8 + 4.17 + 0.1 = 12.27 "ms" $

  Note que a latência rotacional, sozinha, já se aproxima da metade do tempo de busca -- ambas as parcelas mecânicas dominam amplamente o tempo de transferência em si, motivo pelo qual SSDs (sem partes móveis) reduzem drasticamente o tempo de acesso aleatório.
]

#example(name: "Capacidade útil em RAID 5", id: "ex-capacidade-raid5")[
  Um arranjo RAID 5 usa $5$ discos de $2 "TB"$ cada. Qual a capacidade útil (de dados) disponível?

  $ "Capacidade útil" = (n-1) times S = (5-1) times 2 = 8 "TB" $

  Um dos "discos equivalentes" de capacidade é consumido pela paridade distribuída (embora, na prática, essa paridade esteja espalhada entre todos os discos físicos, não isolada em um único disco dedicado).

  #figure(
    image("figures/raid5.svg", width: 55%),
    caption: [RAID 5: dados e paridade (P) distribuídos entre todos os discos do arranjo -- nenhum disco é dedicado exclusivamente à paridade. Fonte: Wikimedia Commons, CC BY-SA 3.0/GFDL (Cburnett).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "RAID 0 não oferece nenhuma redundância -- é o oposto de tolerância a falha")[
  Um erro comum é assumir que "RAID" implica automaticamente proteção contra falha de disco. RAID 0 busca exclusivamente desempenho e capacidade (via striping); a falha de *qualquer* disco do arranjo compromete a integridade de *todos* os dados, sem possibilidade de recuperação pelo próprio arranjo.
]

#remark(name: "RAID 5 tolera exatamente uma falha simultânea, não mais")[
  Se um segundo disco falhar *antes* que o primeiro seja substituído e reconstruído (processo que pode levar horas em discos grandes), o RAID 5 perde a capacidade de reconstrução dos dados -- é justamente essa janela de vulnerabilidade que motiva o RAID 6 (paridade dupla) para arranjos com discos muito grandes.
]

#remark(name: "SSD elimina tempo de busca e latência rotacional, mas não o tempo de transferência")[
  A vantagem do SSD vem de não ter partes mecânicas móveis -- por isso os componentes de busca/latência rotacional (dominantes no HDD, como no exemplo desta seção) desaparecem. O tempo de transferência de dados em si ainda existe em um SSD, apenas é tipicamente muito menor e mais previsível que no HDD.
]

== Questões estilo POSCOMP

*Questão 1.* Em um HDD, a latência rotacional corresponde a:
- a) O tempo para mover o braço até a trilha correta.
- b) O tempo de espera até que o setor desejado gire até a posição da cabeça de leitura.
- c) O tempo total de vida útil do disco.
- d) O tempo de transferência de dados após o posicionamento.
- e) O tempo de inicialização do sistema operacional.

*Questão 2.* Um arranjo RAID 1 com dois discos de $4 "TB"$ cada oferece capacidade útil de:
- a) $8 "TB"$.
- b) $4 "TB"$.
- c) $2 "TB"$.
- d) $6 "TB"$.
- e) $1 "TB"$.

*Questão 3.* A principal diferença entre RAID 5 e RAID 6 é que o RAID 6:
- a) Não utiliza paridade.
- b) Tolera a falha simultânea de até dois discos, usando dois blocos de paridade distribuídos.
- c) É idêntico ao RAID 0 em termos de redundância.
- d) Exige exatamente dois discos no arranjo.
- e) Elimina completamente a necessidade de paridade.

== Gabarito comentado

1. *(b)* -- definição direta de latência rotacional desta seção.
2. *(b)* -- RAID 1 espelha integralmente os dados; a capacidade útil é igual à capacidade de um único disco do par, $4 "TB"$.
3. *(b)* -- RAID 6 acrescenta um segundo bloco de paridade distribuída, tolerando falha dupla, conforme definido nesta seção.

== Referências

- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre memória externa e RAID.
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. sobre armazenamento e confiabilidade.
- PATTERSON, D.; GIBSON, G.; KATZ, R. *A Case for Redundant Arrays of Inexpensive Disks (RAID)* (1988) -- artigo original dos níveis RAID.
