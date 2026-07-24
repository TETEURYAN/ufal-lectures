#import "@preview/mousse-notes:1.1.0": *
= 24.3 -- Terminologia, Topologias, Modelos de Arquitetura e Aplicações

== Introdução

Este subtópico reúne o vocabulário básico de redes, as formas de organizar
fisicamente/logicamente os enlaces entre os nós (topologias) e os dois
modelos de arquitetura em camadas mais cobrados na POSCOMP: *OSI* e
*TCP/IP*. É o subtópico mais visual da disciplina -- entender o desenho da
pilha de camadas e das topologias evita boa parte dos erros de prova.

== Terminologia básica

#definition(id: "def-terminologia-redes")[
  - *Nó (node)*: qualquer dispositivo conectado à rede (host, roteador,
    switch etc.);
  - *Enlace (link)*: conexão física ou lógica direta entre dois nós;
  - *Hospedeiro (host)*: nó que executa aplicações de usuário final (origem
    ou destino final dos dados), em contraste com nós intermediários
    (roteadores, switches) que apenas encaminham tráfego;
  - *Largura de banda (bandwidth)*: capacidade máxima de transmissão de um
    enlace, em bits por segundo -- ver também 24.9.
]

== Topologias de rede

#definition(id: "def-topologias")[
  A *topologia* descreve o padrão de interconexão entre os nós de uma rede:
  - *Totalmente conectada*: todo par de nós tem um enlace direto entre si;
    máxima redundância e desempenho, mas custo de cabeamento cresce com
    $n(n-1)\/2$ enlaces para $n$ nós -- inviável em redes grandes;
  - *Em malha (mesh)*: cada nó se conecta a vários outros (não
    necessariamente todos), oferecendo caminhos redundantes sem o custo total
    da topologia totalmente conectada;
  - *Em anel (ring)*: cada nó se conecta a exatamente dois vizinhos, formando
    um ciclo fechado; dados circulam em uma (ou ambas) direções;
  - *Em barramento (bus)*: todos os nós compartilham um único meio físico
    linear; simples e barata, mas um único ponto de ruptura no barramento
    derruba a rede inteira;
  - *Em estrela (star)*: todos os nós se conectam a um nó central (hub ou
    switch), que intermedeia toda a comunicação;
  - *Em árvore (tree)*: generalização hierárquica da estrela, com vários
    níveis de nós concentradores (ex.: switches em cascata);
  - *Sem fio (wireless)*: os enlaces são feitos por rádio, sem cabeamento
    físico entre os nós;
  - *Híbrida*: combina duas ou mais topologias acima em uma mesma rede (o
    caso mais comum na prática, ex.: várias estrelas interligadas em árvore).
]

#figure(
  image("../figures/network-topologies.svg", width: 85%),
  caption: [
    Comparação visual entre topologias em estrela, anel, barramento, malha e
    totalmente conectada. Fonte: Wikimedia Commons, autor Maksim
    (domínio público).
  ],
)

#remark[
  *Estrela* concentra o risco no nó central (se ele falhar, toda a rede cai),
  mas isola falhas de cabo (um cabo rompido afeta só um nó) -- o oposto do
  *barramento*, onde o meio compartilhado é o ponto único de falha, mas não
  há nó central. Essa troca (nó central x meio compartilhado) é a base da
  maioria das questões comparativas de topologia.
]

== Modelos de arquitetura: OSI e TCP/IP

#definition(id: "def-modelo-osi")[
  O *modelo OSI* (Open Systems Interconnection) organiza a comunicação em
  rede em *7 camadas*, cada uma oferecendo serviço à camada acima e
  consumindo serviço da camada abaixo (24.2): Física, Enlace, Rede,
  Transporte, Sessão, Apresentação e Aplicação.
]

#figure(
  image("../figures/osi-model.svg", width: 75%),
  caption: [
    As 7 camadas do modelo OSI. Fonte: Wikimedia Commons, autor Offnfopt
    (CC0/domínio público).
  ],
)

#definition(id: "def-modelo-tcpip")[
  O *modelo TCP/IP* (também chamado modelo Internet) é mais enxuto, com
  *4 camadas*: Acesso à Rede (ou Enlace), Internet, Transporte e Aplicação.
  É o modelo efetivamente implementado na Internet, enquanto o OSI serve
  principalmente como referência didática e de projeto.
]

#figure(
  tablef(
    columns: 2,
    [*OSI (7 camadas)*], [*TCP/IP (4 camadas)*],
    table.hline(),
    [Aplicação], [Aplicação],
    [Apresentação], [Aplicação],
    [Sessão], [Aplicação],
    [Transporte], [Transporte],
    [Rede], [Internet],
    [Enlace], [Acesso à rede],
    [Física], [Acesso à rede],
  ),
  caption: [Correspondência entre as camadas OSI e TCP/IP.],
)

#remark[
  Erro clássico de prova: achar que a Internet "usa o modelo OSI". A Internet
  foi projetada sobre o modelo TCP/IP; o OSI nunca foi amplamente implantado
  como pilha real, mas continua sendo a referência didática padrão para
  *localizar* um protocolo ou dispositivo por camada (ver 24.6) -- por isso
  os dois modelos são cobrados lado a lado, não um no lugar do outro.
]

== Aplicações

#definition(id: "def-camada-aplicacao")[
  A *camada de aplicação* é onde residem os protocolos usados diretamente
  pelos programas do usuário final, entre eles: HTTP/HTTPS (web), SMTP/IMAP
  (e-mail), FTP (transferência de arquivos) e DNS (resolução de nomes,
  detalhado em 24.5). Cada um roda sobre TCP ou UDP conforme a garantia de
  que precisa (24.2).
]

== Questões estilo POSCOMP

#example(id: "q-243-topologia")[
  (Múltipla escolha) Em uma topologia na qual todos os nós compartilham um
  único meio de transmissão linear, sem nó central concentrador, o rompimento
  de um único ponto do cabo compartilhado:
  + Não afeta a rede, pois cada nó tem um enlace redundante.
  + Isola apenas o nó mais próximo do ponto de rompimento.
  + Pode comprometer a comunicação de toda a rede, pois o meio é compartilhado por todos.
  + Afeta apenas os nós conectados após o nó central.
]

#solution[
  Resposta: alternativa *(3)*. A descrição é de uma topologia em barramento;
  por não haver nó central e o meio ser único e compartilhado, uma ruptura
  pode isolar segmentos inteiros da rede.
]

#example(id: "q-243-osi-tcpip")[
  (Múltipla escolha) A respeito da relação entre os modelos OSI e TCP/IP, é
  correto afirmar que:
  + A Internet é implementada diretamente sobre as 7 camadas do modelo OSI.
  + As camadas de Sessão e Apresentação do OSI não têm correspondente próprio no modelo TCP/IP, sendo absorvidas pela camada de Aplicação.
  + O modelo TCP/IP possui mais camadas que o modelo OSI.
  + A camada Física do OSI corresponde à camada de Transporte do TCP/IP.
]

#solution[
  Resposta: alternativa *(2)*. O TCP/IP tem 4 camadas contra 7 do OSI (logo
  (3) é falsa); a Internet roda sobre TCP/IP, não sobre OSI (logo (1) é
  falsa); Física e Enlace do OSI correspondem a Acesso à Rede do TCP/IP, não
  a Transporte (logo (4) é falsa).
]

== Referências

- TANENBAUM, A. S.; WETHERALL, D. *Redes de Computadores*. Cap. 1 (modelos de
  referência e topologias).
- KUROSE, J. F.; ROSS, K. W. *Redes de Computadores e a Internet*. Cap. 1.
- cienciadacomputacao.wiki.br -- Tópico 24.3.
