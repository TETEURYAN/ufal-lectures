#import "@preview/mousse-notes:1.1.0": *

= Multicomputadores
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.13]

== Introdução

Enquanto o multiprocessador (13) compartilha um único espaço de memória entre CPUs fortemente acopladas, o multicomputador leva o paralelismo a uma escala maior, conectando computadores *completos e independentes* -- cada um com sua própria memória privada -- por uma rede de interconexão. Aqui o foco é a organização física da rede e o modelo de troca de mensagens; os algoritmos e problemas de mais alto nível dessa mesma ideia (consenso, tolerância a falhas distribuída) são aprofundados na disciplina de Sistemas Distribuídos.

== Definições formais

#definition(name: "Multicomputador (fracamente acoplado)", id: "def-multicomputador")[
  Sistema paralelo composto por múltiplos *nós de processamento independentes* -- cada um com sua própria CPU e memória privada, sem espaço de endereçamento compartilhado -- interligados por uma rede de interconexão dedicada. Toda comunicação entre nós ocorre *explicitamente*, por troca de mensagens, em contraste com a comunicação implícita via memória compartilhada dos multiprocessadores (13).
]

#definition(name: "Modelo de troca de mensagens", id: "def-troca-mensagens")[
  Paradigma de programação paralela em que processos, cada um confinado à memória de seu próprio nó, cooperam exclusivamente por meio de primitivas explícitas de *envio* (`send`) e *recebimento* (`receive`) de mensagens através da rede de interconexão -- não há leitura/escrita direta na memória de outro nó. MPI (Message Passing Interface) é o padrão de fato para programação de multicomputadores/clusters.
]

#definition(name: "Topologias de rede de interconexão", id: "def-topologias-interconexao")[
  A organização física dos enlaces entre nós de um multicomputador afeta diretamente a latência de comunicação e a escalabilidade:
  - *Malha (mesh)*: nós dispostos em grade, cada um conectado aos vizinhos ortogonais -- escala bem, mas a distância entre nós opostos cresce com o tamanho da malha.
  - *Toro (torus)*: malha com as extremidades "emendadas" (o último nó de cada linha/coluna se conecta ao primeiro) -- reduz a distância máxima entre nós em relação à malha simples.
  - *Hipercubo*: $N = 2^d$ nós, cada um conectado a exatamente $d$ vizinhos que diferem dele em um único bit de seu identificador binário -- oferece baixa distância máxima entre quaisquer dois nós, à custa de um número de conexões por nó que cresce com $log_2 N$.
  - *Árvore/árvore gorda (fat tree)*: nós-folha conectados por uma hierarquia de switches, com maior largura de banda nos níveis mais altos (na variante "gorda") para evitar gargalo -- topologia comum em clusters comerciais.
]

#definition(name: "Métricas de uma rede de interconexão", id: "def-metricas-interconexao")[
  - *Diâmetro*: a maior distância (em número de saltos/enlaces) entre quaisquer dois nós da rede -- limita o pior caso de latência de comunicação.
  - *Grau*: número de enlaces diretos que cada nó possui -- afeta o custo de hardware por nó.
  - *Largura de bissecção (bisection bandwidth)*: a menor largura de banda total obtida ao dividir a rede em duas metades iguais -- indica a capacidade da rede sob comunicação intensa e distribuída entre todos os nós.
]

== Exemplo resolvido

#example(name: "Diâmetro de um hipercubo", id: "ex-diametro-hipercubo")[
  Um hipercubo de dimensão $d = 3$ tem $N = 2^3 = 8$ nós, cada um identificado por um número binário de 3 bits ($000$ a $111$), conectado a todos os nós cujo identificador difere do seu em exatamente 1 bit.

  O diâmetro de um hipercubo de dimensão $d$ é exatamente $d$: para ir do nó $000$ ao nó $111$ (que difere em todos os 3 bits), são necessários no mínimo 3 saltos, corrigindo um bit por vez (ex.: $000 -> 100 -> 110 -> 111$). Nenhum par de nós está a mais de $d$ saltos de distância.

  Comparando com uma malha 2D de $8$ nós ($2 times 4$, por exemplo): a distância máxima entre cantos opostos seria maior que $3$ saltos -- ilustrando por que o hipercubo oferece diâmetro menor à custa de mais conexões por nó ($d = 3$ conexões por nó no hipercubo, contra tipicamente $2$ a $4$ na malha, mas com diâmetro maior).
]

== Atenção -- pegadinhas comuns

#remark(name: "Multicomputador não compartilha memória -- multiprocessador compartilha")[
  A pegadinha mais recorrente desta subseção é a mesma da anterior, invertida: se o enunciado descreve nós com memória *privada* se comunicando por *mensagens explícitas*, é um multicomputador; se descreve processadores acessando um único espaço de memória *comum*, é um multiprocessador (13). O critério é sempre a presença (ou ausência) de memória compartilhada.
]

#remark(name: "Maior conectividade (grau) não é gratuita")[
  Topologias com diâmetro menor (como o hipercubo) tipicamente exigem grau maior (mais enlaces por nó), aumentando o custo e a complexidade física de cada nó -- a escolha de topologia é sempre um compromisso entre latência de pior caso (diâmetro), custo por nó (grau) e capacidade agregada (largura de bissecção), não uma escolha estritamente superior em todos os aspectos.
]

#remark(name: "Cluster e multicomputador não são conceitos totalmente distintos")[
  Um cluster de computadores comuns interligados por uma rede local (ex.: Ethernet) e programados via troca de mensagens (ex.: MPI) é, em essência, um multicomputador -- a distinção histórica entre "multicomputador" (rede de interconexão dedicada, proprietária) e "cluster" (rede genérica, hardware comum) tem se tornado cada vez mais tênue com o barateamento de redes de alto desempenho.
]

== Questões estilo POSCOMP

*Questão 1.* A principal diferença entre um multiprocessador e um multicomputador é que, no multicomputador:
- a) Existe um único espaço de memória compartilhado entre todos os nós.
- b) Cada nó possui memória privada, e a comunicação ocorre exclusivamente por troca explícita de mensagens.
- c) Não é possível haver mais de dois nós.
- d) Os nós compartilham obrigatoriamente a mesma cache.
- e) Não existe rede de interconexão entre os nós.

*Questão 2.* O diâmetro de uma rede de interconexão de multicomputadores representa:
- a) O número total de nós da rede.
- b) A maior distância, em saltos, entre quaisquer dois nós da rede.
- c) A quantidade de memória de cada nó.
- d) O número de processadores por nó.
- e) A velocidade de clock de cada nó.

*Questão 3.* Em um hipercubo de dimensão $d = 4$ (com $2^4 = 16$ nós), o diâmetro da rede é:
- a) $2$.
- b) $4$.
- c) $8$.
- d) $16$.
- e) $32$.

== Gabarito comentado

1. *(b)* -- ausência de memória compartilhada e comunicação por mensagens explícitas é a característica definidora do multicomputador.
2. *(b)* -- definição direta de diâmetro de uma rede de interconexão desta seção.
3. *(b)* -- o diâmetro de um hipercubo de dimensão $d$ é sempre igual a $d$, conforme demonstrado no exemplo desta seção.

== Referências

- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Cap. 6 (Arquiteturas de memória distribuída e redes de interconexão).
- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre processamento paralelo.
- TANENBAUM, A. S.; VAN STEEN, M. *Distributed Systems: Principles and Paradigms* -- aprofundamento dos algoritmos e modelos de programação, tratado em Sistemas Distribuídos.
