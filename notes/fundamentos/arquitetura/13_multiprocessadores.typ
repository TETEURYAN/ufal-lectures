#import "@preview/mousse-notes:1.1.0": *

= Multiprocessadores
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.12]

== Introdução

Multiprocessadores levam o paralelismo além de uma única CPU (11, 12): múltiplos processadores completos, compartilhando um mesmo espaço de endereçamento de memória. A Taxonomia de Flynn classifica esse e outros arranjos paralelos por número de fluxos de instrução e de dados, enquanto o problema de coerência de cache é a complicação mais cobrada quando múltiplas CPUs compartilham memória através de caches privadas.

== Definições formais

#definition(name: "Taxonomia de Flynn", id: "def-taxonomia-flynn")[
  Classifica arquiteturas de computador pelo número de *fluxos de instrução* e *fluxos de dados* processados simultaneamente:
  - *SISD (Single Instruction, Single Data)*: um processador executa um único fluxo de instruções sobre um único fluxo de dados -- o computador sequencial clássico de Von Neumann (01).
  - *SIMD (Single Instruction, Multiple Data)*: uma única instrução é aplicada simultaneamente a múltiplos dados -- processadores vetoriais e unidades SIMD de CPUs modernas (ex.: extensões AVX), além de GPUs em larga medida.
  - *MISD (Multiple Instruction, Single Data)*: múltiplas instruções operam sobre o mesmo fluxo de dados -- categoria rara na prática, citada principalmente por completude teórica (ex.: sistemas de tolerância a falha com verificação redundante).
  - *MIMD (Multiple Instruction, Multiple Data)*: múltiplos processadores, cada um executando seu próprio fluxo de instruções sobre seus próprios dados -- categoria dos multiprocessadores (este subtópico) e multicomputadores (14).
]

#definition(name: "Multiprocessador (fortemente acoplado)", id: "def-multiprocessador")[
  Sistema com múltiplas CPUs que compartilham um único espaço de endereçamento de memória física, visível e acessível por todas elas -- comunicação entre processadores ocorre implicitamente por leitura/escrita em posições de memória compartilhadas, sem troca explícita de mensagens (diferente dos multicomputadores, 14).
]

#definition(name: "UMA e NUMA", id: "def-uma-numa")[
  - *UMA (Uniform Memory Access)*: todos os processadores acessam qualquer posição da memória compartilhada com a *mesma* latência, independente de qual processador faz o acesso -- típico de multiprocessadores simétricos (SMP) de pequena escala.
  - *NUMA (Non-Uniform Memory Access)*: a memória é fisicamente distribuída entre os processadores (cada um com memória "local"), mas continua logicamente compartilhada -- acessar memória local é mais rápido que acessar a memória "remota" de outro processador, com latência não uniforme. Escala melhor para um número maior de processadores que UMA.
]

#definition(name: "Coerência de cache", id: "def-coerencia-cache")[
  Propriedade que garante que todos os processadores enxerguem um valor *consistente* para uma mesma posição de memória, mesmo quando cada um mantém sua própria cópia em cache privada (07). Sem um protocolo de coerência, um processador pode escrever em sua cópia em cache sem que os demais processadores, com cópias antigas em suas próprias caches, sejam notificados -- produzindo valores diferentes e inconsistentes para o mesmo endereço.
]

== Propriedade relevante

#theorem(name: "Protocolos de coerência: snooping vs. baseado em diretório", id: "thm-protocolos-coerencia")[
  Duas famílias principais de protocolos resolvem a coerência de cache:
  - *Snooping (espionagem de barramento)*: cada controlador de cache "escuta" continuamente o barramento compartilhado, observando as operações de memória dos demais processadores, e invalida ou atualiza sua própria cópia quando detecta uma escrita conflitante em outro processador. Funciona bem para poucos processadores (barramento compartilhado, como em UMA), mas não escala -- o tráfego de espionagem cresce com o número de processadores.
  - *Baseado em diretório*: uma estrutura central (ou distribuída) mantém, para cada bloco de memória, quais caches possuem cópias dele -- ao ocorrer uma escrita, o diretório é consultado para notificar/invalidar *apenas* as caches relevantes, sem exigir que todo processador monitore todo o tráfego. Escala melhor para sistemas NUMA de grande porte.
]

== Exemplo resolvido

#example(name: "O problema da coerência sem protocolo", id: "ex-problema-coerencia")[
  Dois processadores, $P_1$ e $P_2$, compartilham a variável `X`, inicialmente igual a $10$ na memória principal. Ambos leem `X` e mantêm uma cópia em suas respectivas caches privadas.

  + $P_1$ executa `X <- 20`, atualizando *apenas sua própria cache* (por exemplo, sob uma política write-back, 07) -- a memória principal ainda mostra $X = 10$.
  + $P_2$, sem qualquer protocolo de coerência, lê `X` de sua *própria* cache (não atualizada) e obtém o valor obsoleto $10$, quando o valor logicamente correto e mais recente é $20$.

  Um protocolo de coerência (ex.: invalidação por snooping) evitaria esse erro: ao detectar a escrita de $P_1$ no barramento, o controlador de cache de $P_2$ invalidaria sua cópia local de `X`, forçando uma nova busca (agora obtendo o valor atualizado $20$) na próxima leitura.

  #figure(
    image("figures/flynn-taxonomy.svg", width: 70%),
    caption: [As três organizações não triviais da Taxonomia de Flynn: SISD (um fluxo de instrução, um de dados), MIMD (múltiplos fluxos independentes, típico de multiprocessadores) e SIMD (uma instrução, múltiplos dados, típico de processadores vetoriais/GPUs). Fonte: Wikimedia Commons, CC BY-SA 4.0 (Maury Markowitz).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "Multiprocessador não é sinônimo de multicomputador")[
  A distinção central (aprofundada em 14) é a *memória compartilhada*: multiprocessadores comunicam-se implicitamente via memória comum; multicomputadores têm memórias privadas e se comunicam explicitamente por troca de mensagens em rede. Confundir os dois termos é um erro recorrente de prova.
]

#remark(name: "NUMA não é \"memória compartilhada mais rápida\" -- é memória compartilhada com latência desigual")[
  NUMA melhora a *escalabilidade* (mais processadores suportados), não necessariamente a latência de todo acesso -- pelo contrário, acessos a memória remota em NUMA são *mais lentos* que em UMA equivalente; o ganho vem de a maior parte dos acessos, bem projetados, ficarem locais.
]

#remark(name: "SIMD não é o mesmo que MIMD, mesmo ambos envolvendo múltiplos dados")[
  SIMD aplica a *mesma* instrução a múltiplos dados simultaneamente (um único fluxo de controle); MIMD tem múltiplos fluxos de instrução *independentes*, cada um controlando seus próprios dados -- multiprocessadores de propósito geral são MIMD, não SIMD, mesmo processando "muitos dados" em paralelo.
]

== Questões estilo POSCOMP

*Questão 1.* Segundo a Taxonomia de Flynn, um multiprocessador de propósito geral, com processadores independentes executando programas distintos, é classificado como:
- a) SISD.
- b) SIMD.
- c) MISD.
- d) MIMD.
- e) Nenhuma das anteriores.

*Questão 2.* A diferença central entre UMA e NUMA é que, em NUMA:
- a) Não existe memória compartilhada.
- b) A latência de acesso à memória varia conforme a posição física acessada em relação ao processador.
- c) Todos os acessos à memória têm exatamente a mesma latência, independente do processador.
- d) Não há necessidade de protocolo de coerência de cache.
- e) Apenas um processador pode acessar a memória por vez.

*Questão 3.* O problema da coerência de cache em um multiprocessador surge porque:
- a) Cada processador tem sua própria cópia em cache de dados compartilhados, que pode ficar desatualizada após uma escrita de outro processador.
- b) A memória principal não pode ser compartilhada entre processadores.
- c) Processadores em um multiprocessador nunca compartilham dados.
- d) Não existe memória cache em sistemas multiprocessados.
- e) O barramento de endereços é insuficiente para múltiplos processadores.

== Gabarito comentado

1. *(d)* -- múltiplos fluxos de instrução independentes sobre múltiplos fluxos de dados é a definição direta de MIMD.
2. *(b)* -- é exatamente a definição de NUMA: latência não uniforme conforme a localização física do dado.
3. *(a)* -- cópias privadas desatualizadas em cache, após escrita em outro processador, é a causa raiz do problema de coerência, conforme o exemplo desta seção.

== Referências

- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Cap. 5 (Multiprocessadores e coerência de cache).
- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre multiprocessadores e Taxonomia de Flynn.
- FLYNN, M. J. *Some Computer Organizations and Their Effectiveness* (1972) -- artigo original da taxonomia.
