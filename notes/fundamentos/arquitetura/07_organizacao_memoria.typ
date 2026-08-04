#import "@preview/mousse-notes:1.1.0": *

= Organização de Memória
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.6]

== Introdução

Memória rápida o bastante para acompanhar a CPU é cara demais para ter grande capacidade, e memória barata o bastante para ter grande capacidade é lenta demais para acompanhar a CPU -- a hierarquia de memória, coroada pela cache, resolve esse dilema explorando um padrão empírico do comportamento dos programas: a localidade de referência. É um dos blocos mais densos em cálculo de toda a disciplina.

== Definições formais

#definition(name: "Hierarquia de memória", id: "def-hierarquia-memoria")[
  Organização em níveis, dos mais próximos da CPU aos mais distantes, com capacidade crescente e velocidade decrescente (e custo por byte decrescente): registradores, cache (frequentemente subdividida em L1, L2, L3), memória principal (RAM) e memória auxiliar (08). Cada nível funciona como uma "janela" mais rápida sobre os dados mais recentemente/frequentemente usados do nível abaixo.
]

#definition(name: "Localidade de referência", id: "def-localidade-referencia")[
  Padrão empírico observado na maioria dos programas, que justifica a eficácia da cache:
  - *Localidade temporal*: um dado recentemente acessado tende a ser acessado novamente em breve (ex.: variável de um laço).
  - *Localidade espacial*: um dado próximo (em endereço) de um dado recentemente acessado tende a ser acessado em breve (ex.: elementos consecutivos de um vetor).
]

#definition(name: "Mapeamento de cache: direto, associativo e associativo por conjuntos", id: "def-mapeamento-cache")[
  Determina em quais linhas da cache um bloco de memória principal pode ser colocado:
  - *Mapeamento direto*: cada bloco de memória só pode ocupar *uma única* linha específica da cache (calculada por $"índice" = ("endereço do bloco") mod ("número de linhas")$) -- simples e rápido, mas sujeito a conflitos entre blocos que mapeiam para a mesma linha, mesmo com cache parcialmente vazia.
  - *Totalmente associativo*: um bloco pode ocupar *qualquer* linha livre da cache -- máxima flexibilidade, mas exige comparar o endereço com *todas* as linhas simultaneamente (hardware mais caro).
  - *Associativo por conjuntos ($n$-way set-associative)*: a cache é dividida em conjuntos de $n$ linhas cada; um bloco mapeia para um conjunto específico (por índice), mas pode ocupar qualquer uma das $n$ linhas daquele conjunto -- meio-termo predominante na prática.
]

#definition(name: "Decomposição do endereço para cache", id: "def-decomposicao-endereco-cache")[
  Um endereço de memória usado para acessar a cache se decompõe em três campos: *tag* (identifica qual bloco específico está armazenado na linha, entre os vários que poderiam mapear ali), *índice* (seleciona a linha ou conjunto, no mapeamento direto/associativo por conjuntos) e *deslocamento (offset)* (seleciona a palavra/byte dentro do bloco).
]

#definition(name: "Políticas de escrita", id: "def-politicas-escrita")[
  - *Write-through*: toda escrita na cache é imediatamente propagada também à memória principal -- mantém consistência simples, mas gera mais tráfego de escrita.
  - *Write-back*: a escrita atualiza apenas a cache, marcando a linha como *suja (dirty)*; a propagação à memória principal só ocorre quando a linha é substituída -- menos tráfego, mas exige rastrear o bit de sujeira e escrever de volta antes de descartar uma linha suja.
]

== Propriedade relevante

#theorem(name: "Tempo médio de acesso à memória (AMAT)", id: "thm-amat")[
  $ "AMAT" = T_"acerto" + "taxa de falta" times "penalidade de falta" $
  onde $T_"acerto"$ (hit time) é o tempo de acesso quando o dado já está na cache, a *taxa de falta* (miss rate) é a fração dos acessos que não encontram o dado na cache, e a *penalidade de falta* (miss penalty) é o tempo adicional necessário para buscar o bloco faltante no nível seguinte da hierarquia.
]

== Exemplo resolvido

#example(name: "Decompondo um endereço em tag, índice e offset", id: "ex-decomposicao-endereco")[
  Uma cache de mapeamento direto tem $8 "KiB"$ de capacidade, com blocos de $32$ bytes, em um sistema com endereços de 32 bits.

  Número de linhas: $8192 \/ 32 = 256$ linhas $=> 8$ bits de índice. Bits de offset (deslocamento dentro do bloco): $log_2 (32) = 5$ bits. Os $32 - 8 - 5 = 19$ bits restantes (mais significativos) formam a tag.

  Para o endereço $"0x123456"$ (binário $"0b100100011010001010110"$):
  - *Offset* (5 bits menos significativos): $10110_2 = 22$.
  - *Índice* (próximos 8 bits): $10100010_2 = 162 = "0xA2"$.
  - *Tag* (19 bits restantes, mais significativos): $10010001_2 = 145 = "0x91"$.

  Ao acessar esse endereço, a CPU consulta a linha de índice $162$: se a tag armazenada ali for $145$, é um *acerto (hit)*; caso contrário, é uma *falta (miss)*, e o bloco correto precisa ser buscado na memória principal.
]

#example(name: "Calculando o AMAT", id: "ex-calculo-amat")[
  Uma cache tem tempo de acerto de $1$ ciclo, taxa de falta de $5%$, e penalidade de falta de $100$ ciclos.

  $ "AMAT" = 1 + 0.05 times 100 = 1 + 5 = 6 "ciclos" $

  Mesmo com uma taxa de falta relativamente baixa, o tempo médio efetivo ($6$ ciclos) é seis vezes maior que o tempo de acerto isolado ($1$ ciclo) -- evidenciando por que a penalidade de falta pesa tanto no desempenho, mesmo sendo rara.

  #figure(
    image("figures/memory-hierarchy.svg", width: 60%),
    caption: [Hierarquia de memória: capacidade cresce e velocidade decresce à medida que se afasta da CPU (registradores, cache, memória principal, armazenamento secundário). Fonte: Wikimedia Commons, domínio público (Danlash; vetorização por Akvitberg).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "Mapeamento direto tem conflitos mesmo com cache vazia em outras linhas")[
  Dois blocos que mapeiam para o mesmo índice competem pela *mesma* linha, mesmo que a cache tenha outras linhas completamente livres -- esse fenômeno (falta por conflito) é a principal desvantagem do mapeamento direto frente ao associativo por conjuntos, que distribui essa competição entre $n$ linhas por conjunto.
]

#remark(name: "Write-back não é \"mais lento\" que write-through de forma absoluta")[
  Write-through gera mais tráfego de escrita (toda escrita vai à memória), mas simplifica a coerência (10.12/13). Write-back reduz tráfego (escreve na memória só ao substituir a linha), mas cada substituição de uma linha suja é mais cara. Qual é "melhor" depende do padrão de acesso -- não existe uma resposta absoluta, e a POSCOMP costuma pedir para identificar qual política se encaixa em um cenário descrito.
]

#remark(name: "Aumentar a associatividade não é sempre melhor sem custo")[
  Cache totalmente associativa minimiza faltas por conflito, mas seu hardware de comparação simultânea de todas as tags é caro e mais lento por acesso -- daí o meio-termo prático das caches associativas por conjuntos ($4$-way, $8$-way etc.), balanceando taxa de falta contra tempo de acerto e custo.
]

== Questões estilo POSCOMP

*Questão 1.* No mapeamento direto de cache, um bloco de memória principal:
- a) Pode ser colocado em qualquer linha livre da cache.
- b) Só pode ser colocado em uma única linha específica, determinada pelo seu índice.
- c) Nunca pode gerar conflito com outro bloco.
- d) É armazenado simultaneamente em todas as linhas da cache.
- e) Ignora completamente o campo de tag.

*Questão 2.* Uma cache tem tempo de acerto de $2$ ciclos, taxa de falta de $10%$ e penalidade de falta de $50$ ciclos. O AMAT (tempo médio de acesso) é:
- a) $2$ ciclos.
- b) $5$ ciclos.
- c) $7$ ciclos.
- d) $50$ ciclos.
- e) $52$ ciclos.

*Questão 3.* Na política de escrita write-back, a memória principal é atualizada:
- a) A cada escrita na cache, imediatamente.
- b) Apenas quando a linha correspondente é substituída e está marcada como suja.
- c) Nunca, em nenhuma circunstância.
- d) Apenas na inicialização do sistema.
- e) A cada leitura, não a cada escrita.

== Gabarito comentado

1. *(b)* -- definição direta de mapeamento direto: uma única linha possível por bloco, calculada pelo índice.
2. *(c)* -- $"AMAT" = 2 + 0.10 times 50 = 2+5=7$ ciclos.
3. *(b)* -- definição direta de write-back: propagação adiada até a substituição de uma linha suja.

== Referências

- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. 5 (Hierarquia de memória).
- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre memória cache.
- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Cap. 2 (Hierarquia de memória).
