#import "@preview/mousse-notes:1.1.0": *
= 24.1 -- Tipos de Enlace, Códigos, Modos e Meios de Transmissão

== Introdução

Este subtópico cobre a base física e de enlace das redes de computadores:
como as redes são classificadas por escala, que meios físicos carregam o
sinal, como as estações disputam o acesso a esse meio e em que direção os
dados podem fluir. A POSCOMP costuma cobrar principalmente a classificação
correta de siglas (PAN, LAN, WAN etc.) e a diferença entre os modos de
transmissão -- são perguntas de definição direta, de resposta rápida quando
os conceitos estão bem fixados.

== Classificação de redes por escala

#definition(id: "def-escala-redes")[
  Redes de computadores são classificadas pela sua *abrangência geográfica*:
  - *PAN* (Personal Area Network): alcance de poucos metros, em torno de um
    único usuário (ex.: Bluetooth entre celular e fone de ouvido);
  - *LAN* (Local Area Network): um único prédio ou campus pequeno, sob
    administração de uma única organização;
  - *WLAN* (Wireless LAN): uma LAN cujo meio de acesso é sem fio (ex.: Wi-Fi);
  - *CAN* (Campus Area Network): interliga várias LANs dentro de um campus
    ou conjunto de prédios próximos;
  - *MAN* (Metropolitan Area Network): abrange uma cidade;
  - *WAN* (Wide Area Network): abrange uma grande área geográfica (país,
    continente), tipicamente interligando várias LANs/MANs via
    operadoras de telecomunicações;
  - *VLAN* (Virtual LAN): não é uma classificação por *distância física*, mas
    por *segmentação lógica* -- um grupo de estações que se comporta como uma
    LAN independente, mesmo estando fisicamente espalhado por vários switches.
]

#remark[
  *VLAN* é a pegadinha clássica dessa lista: todas as outras siglas (PAN,
  LAN, ..., WAN) crescem em uma progressão de escala física, mas VLAN é uma
  divisão *lógica* dentro de uma infraestrutura física já existente (ver
  24.3/24.6), configurada em switches gerenciáveis, não uma nova categoria de
  distância.
]

== Meios de transmissão guiados

#definition(id: "def-meios-guiados")[
  *Meios guiados* conduzem o sinal por um caminho físico definido:
  - *Cabo coaxial*: condutor central envolto por isolante, malha metálica e
    capa externa; boa blindagem contra ruído, hoje usado sobretudo em TV a
    cabo e enlaces de banda larga (24.7);
  - *Par trançado*: dois fios de cobre entrelaçados, que reduzem a
    interferência eletromagnética (EMI) por cancelamento mútuo; é o meio
    dominante em LANs Ethernet.
]

#definition(id: "def-utp-variantes")[
  O par trançado se subdivide pelo tipo de *blindagem*, na notação
  `X/YTP` (`X` = blindagem do cabo inteiro, `Y` = blindagem de cada par):
]

#figure(
  tablef(
    columns: 2,
    [*Sigla*], [*Blindagem*],
    table.hline(),
    [U/UTP], [Nenhuma blindagem (Unshielded/Unshielded) -- o par trançado "puro"],
    [F/UTP], [Blindagem geral por folha metálica (Foiled), sem blindagem por par],
    [S/UTP], [Blindagem geral por malha trançada (Shielded), sem blindagem por par],
    [SF/UTP], [Blindagem dupla geral: folha *e* malha (Screened Foiled), sem blindagem por par],
  ),
  caption: [Variantes de blindagem do par trançado.],
)

#remark[
  Quanto mais blindagem, maior a proteção contra EMI e maior o custo/rigidez
  do cabo. Não confundir com a *categoria* do cabo (Cat5e, Cat6 etc.), que
  descreve a largura de banda suportada -- são duas classificações
  independentes e ambas podem ser cobradas juntas em prova.
]

== Métodos de controle de acesso ao meio

#definition(id: "def-controle-acesso")[
  Quando várias estações compartilham o mesmo meio físico, é preciso um
  método para decidir quem transmite em cada instante:
  - *Contenção*: as estações competem livremente pelo meio e podem colidir
    (ex.: CSMA/CD em Ethernet clássica, CSMA/CA em Wi-Fi); simples, mas
    degrada sob alta carga;
  - *Passagem de ficha (token passing)*: um "token" circula pela rede e só
    quem o possui pode transmitir (ex.: Token Ring); elimina colisões, mas
    adiciona latência de espera pelo token;
  - *Sondagem (polling)*: um nó mestre pergunta a cada estação, em sequência,
    se ela tem dados a enviar; centraliza o controle e evita colisões, ao
    custo de depender do mestre (ponto único de falha).
]

#remark[
  Colisão só é *possível* em métodos de contenção. Token passing e polling
  são determinísticos (livres de colisão) por construção -- se uma questão
  afirma que "token ring pode sofrer colisões", está errada.
]

== Modos de transmissão

#definition(id: "def-modos-transmissao")[
  Quanto à direção do fluxo de dados em um enlace:
  - *Simplex*: fluxo em um único sentido, sempre (ex.: transmissão de TV);
  - *Half-duplex*: os dois sentidos são possíveis, mas não simultaneamente
    (ex.: walkie-talkie, Ethernet clássica com hub);
  - *Full-duplex*: os dois sentidos ocorrem simultaneamente (ex.: telefone,
    Ethernet moderna com switch, em enlace ponto a ponto dedicado).
]

== Questões estilo POSCOMP

#example(id: "q-241-classificacao")[
  (Múltipla escolha) Uma empresa interliga, via switches gerenciáveis, os
  computadores do setor financeiro espalhados em três andares diferentes de
  um mesmo prédio, de modo que eles se comportem como uma única rede local
  isolada dos demais setores, mesmo compartilhando a mesma infraestrutura
  física de cabeamento. Essa segmentação é um exemplo de:
  + LAN
  + MAN
  + CAN
  + VLAN
]

#solution[
  Resposta: alternativa *(4)*. A segmentação é lógica, não uma nova
  infraestrutura física por andar/prédio -- exatamente a definição de VLAN.
]

#example(id: "q-241-acesso-meio")[
  (Múltipla escolha) Em uma rede que utiliza passagem de ficha (token
  passing) como método de controle de acesso ao meio, é correto afirmar que:
  + Colisões são frequentes sob alta carga, assim como em CSMA/CD.
  + Apenas a estação que possui o token pode transmitir dados naquele instante.
  + O controle de acesso depende de um nó mestre central que sonda cada estação.
  + É um método de contenção, assim como o CSMA/CA usado em Wi-Fi.
]

#solution[
  Resposta: alternativa *(2)*. (1) e (4) descrevem contenção, não token
  passing; (3) descreve polling, um método distinto (sem token circulante).
]

#example(id: "q-241-subrede")[
  (Cálculo de sub-rede) A rede $200.17.34.0\/24$ deve ser dividida em $8$
  sub-redes de igual tamanho. Determine: (a) a nova máscara de sub-rede; (b)
  o número de hosts válidos por sub-rede; (c) o endereço de broadcast da
  quarta sub-rede (a que começa em $200.17.34.96$).
]

#solution[
  *(a)* Dividir em $8 = 2^3$ sub-redes exige *tomar emprestados* $3$ bits do
  campo de host: a máscara passa de $\/24$ para $\/27$, ou seja
  $255.255.255.224$.

  *(b)* Com $\/27$ restam $32-27=5$ bits de host, logo $2^5 = 32$ endereços
  por sub-rede, dos quais $2$ são reservados (rede e broadcast):
  $32 - 2 = 30$ hosts válidos por sub-rede.

  *(c)* Cada sub-rede tem $32$ endereços. A quarta sub-rede começa em
  $200.17.34.96$ ($96 = 3 times 32$, quarto bloco contando do zero) e vai até
  $200.17.34.127$ ($96 + 32 - 1$); esse último endereço é o *broadcast* da
  sub-rede: $200.17.34.127$.
]

#remark[
  Esse tipo de cálculo -- descobrir quantos bits emprestar, o tamanho do
  bloco ($2^"bits de host"$) e os endereços de rede/broadcast de cada
  sub-rede -- reaparece com endereçamento IP completo (classes, CIDR,
  sub-redes de tamanho variável) em 24.5.
]

== Referências

- TANENBAUM, A. S.; WETHERALL, D. *Redes de Computadores*. Cap. 2 (camada
  física) e Cap. 4 (subcamada de acesso ao meio).
- KUROSE, J. F.; ROSS, K. W. *Redes de Computadores e a Internet*. Cap. 1 e 5.
- cienciadacomputacao.wiki.br -- Tópico 24.1.
