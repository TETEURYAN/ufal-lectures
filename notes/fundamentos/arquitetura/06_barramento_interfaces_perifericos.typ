#import "@preview/mousse-notes:1.1.0": *

= Barramento, Comunicações, Interfaces e Periféricos
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.5]

== Introdução

O barramento é a infraestrutura de comunicação que interliga CPU, memória e periféricos (a mesma ideia já introduzida de forma abstrata no modelo de Von Neumann, 01) -- aqui detalhada em seus três subconjuntos funcionais e nas estratégias que a CPU usa para trocar dados com dispositivos de entrada e saída, do polling simples ao DMA.

== Definições formais

#definition(name: "Barramento e seus três subconjuntos", id: "def-barramento-subconjuntos")[
  Um *barramento* é um conjunto de linhas físicas compartilhadas que interligam dois ou mais componentes do sistema. Tradicionalmente subdividido em:
  - *Barramento de dados*: bidirecional, transporta os valores efetivamente lidos/escritos; sua largura (em bits) determina quantos bits podem ser transferidos por ciclo.
  - *Barramento de endereços*: unidirecional (CPU para os demais componentes), transporta o endereço de memória ou dispositivo a ser acessado; sua largura de $n$ bits determina o espaço de endereçamento máximo, $2^n$ posições endereçáveis.
  - *Barramento de controle*: transporta sinais de controle (leitura/escrita, indicação de barramento ocupado, requisições e reconhecimentos de interrupção, sinais de clock) que coordenam o uso dos demais barramentos.
]

#definition(name: "Arbitração de barramento", id: "def-arbitracao-barramento")[
  Quando múltiplos dispositivos podem iniciar uma transferência (múltiplos "mestres" de barramento -- ex.: CPU e um controlador de DMA), um mecanismo de *arbitração* decide, a cada instante, qual dispositivo tem permissão de usar o barramento, evitando que dois mestres transmitam simultaneamente e corrompam o sinal.
]

#definition(name: "Técnicas de entrada e saída", id: "def-tecnicas-e-s")[
  - *E/S programada (polling)*: a CPU consulta ativamente, em laço, o status de um dispositivo até que ele esteja pronto -- simples de implementar, mas desperdiça ciclos de CPU em espera ativa.
  - *E/S orientada a interrupção*: a CPU segue executando outras tarefas; o dispositivo sinaliza sua prontidão via uma interrupção (05), interrompendo a CPU apenas quando há de fato dado a transferir.
  - *DMA (Direct Memory Access)*: um controlador de DMA dedicado transfere blocos de dados diretamente entre um dispositivo de E/S e a memória, *sem* intervenção da CPU a cada palavra transferida -- a CPU apenas configura a transferência (endereço, tamanho) no início e é interrompida apenas ao final do bloco inteiro.
]

== Propriedade relevante

#theorem(name: "Ordem crescente de eficiência de CPU nas técnicas de E/S", id: "thm-eficiencia-e-s")[
  Em termos de tempo de CPU consumido por byte efetivamente transferido, polling $>$ E/S orientada a interrupção $>$ DMA -- polling desperdiça ciclos em espera ativa; interrupção libera a CPU entre eventos, mas ainda a envolve a cada palavra/unidade transferida; DMA remove a CPU do caminho da transferência em si, envolvendo-a apenas na configuração inicial e na notificação final.
]

#proof[
  Sob polling, a CPU executa um laço de consulta continuamente até o dispositivo responder -- tempo de CPU proporcional ao tempo de espera total, não apenas ao tempo de transferência útil. Sob interrupção, a CPU só é desviada quando o dispositivo já está pronto, mas para um dispositivo rápido que gera muitos eventos pequenos (ex.: um disco transferindo muitos setores), o custo acumulado de trocas de contexto por interrupção ainda é significativo. Sob DMA, o controlador dedicado realiza a transferência byte a byte (ou palavra a palavra) usando ciclos de barramento "roubados" (cycle stealing) ou em rajada, sem desviar o fluxo de instruções da CPU -- que só é interrompida uma vez, ao final de todo o bloco.
]

== Exemplo resolvido

#example(name: "Largura do barramento de endereços e espaço endereçável", id: "ex-largura-barramento-enderecos")[
  Um processador possui barramento de endereços de $32$ bits. Qual o espaço máximo de memória diretamente endereçável?

  $ 2^32 = 4294967296 "bytes" = 4 "GiB" $

  Se o barramento de endereços fosse estendido para $36$ bits (mantendo o restante da arquitetura), o espaço endereçável cresceria para $2^36 = 64 "GiB"$ -- ilustrando por que ampliar esse barramento é um passo necessário (ainda que não suficiente sozinho) para suportar mais memória física.
]

== Atenção -- pegadinhas comuns

#remark(name: "DMA não elimina totalmente o uso da CPU, apenas o uso por palavra transferida")[
  Um erro comum é achar que DMA dispensa completamente a CPU durante toda a transferência -- na verdade, a CPU configura a operação (endereço inicial, tamanho, direção) antes de iniciá-la e é notificada (tipicamente por interrupção) ao final; o que o DMA elimina é a necessidade de intervenção da CPU a cada unidade de dado individual transferida.
]

#remark(name: "Barramento de endereços é unidirecional; barramento de dados é bidirecional")[
  O endereço sempre flui da CPU (ou de outro mestre de barramento) em direção ao componente endereçado -- nunca no sentido contrário. Já o barramento de dados precisa transportar valores em ambos os sentidos (leitura: memória para CPU; escrita: CPU para memória). Inverter essa caracterização é um erro recorrente em prova.
]

#remark(name: "Cycle stealing não trava a CPU indefinidamente")[
  Durante uma transferência DMA por roubo de ciclo, o controlador de DMA usa ciclos de barramento *individuais* que a CPU não estaria usando naquele instante (ou os intercala com o uso da CPU), em vez de tomar o barramento por um bloco de tempo contínuo -- diferente do modo rajada (burst), em que o DMA retém o barramento até concluir toda a transferência de uma vez, bloqueando a CPU por mais tempo de uma só vez, porém com menos overhead total.
]

== Questões estilo POSCOMP

*Questão 1.* A largura do barramento de endereços de um processador determina diretamente:
- a) A velocidade do clock do processador.
- b) O espaço máximo de memória diretamente endereçável.
- c) O número de instruções que podem ser executadas por ciclo.
- d) O número de registradores disponíveis.
- e) A largura do barramento de dados, que deve ser sempre igual.

*Questão 2.* Em relação às técnicas de entrada e saída, é correto afirmar que:
- a) Polling é a técnica mais eficiente em uso de CPU, pois evita interrupções.
- b) DMA exige que a CPU transfira cada byte individualmente entre o dispositivo e a memória.
- c) E/S orientada a interrupção libera a CPU para outras tarefas entre a solicitação e a notificação de conclusão.
- d) Polling nunca desperdiça ciclos de CPU, pois é totalmente assíncrono.
- e) DMA é sempre mais lento que polling para qualquer volume de dados.

*Questão 3.* Durante uma transferência por DMA, a CPU é envolvida diretamente:
- a) Em cada byte transferido, sem exceção.
- b) Apenas na configuração inicial da transferência e, tipicamente, na notificação de conclusão.
- c) Apenas durante a metade da transferência.
- d) Somente se o dispositivo for mais lento que a memória.
- e) Nunca, em nenhuma etapa da operação.

== Gabarito comentado

1. *(b)* -- espaço endereçável é $2^n$ para um barramento de $n$ bits, conforme o exemplo desta seção.
2. *(c)* -- é a definição direta de E/S orientada a interrupção; (a), (b), (d) e (e) invertem características das técnicas.
3. *(b)* -- a CPU configura a transferência e é notificada ao final, sem intervir em cada unidade transferida, conforme a definição de DMA desta seção.

== Referências

- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre entrada/saída e estrutura de barramentos.
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. sobre entrada/saída.
- TANENBAUM, A. S. *Organização Estruturada de Computadores*. Cap. sobre barramentos e periféricos.
