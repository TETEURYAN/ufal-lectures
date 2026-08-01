#import "@preview/mousse-notes:1.1.0": *

#let evt(x, y, lbl, above: true) = {
  place(dx: x - 2.5pt, dy: y - 2.5pt, circle(radius: 2.5pt, fill: black))
  place(dx: x - 20pt, dy: if above { y - 16pt } else { y + 6pt }, text(size: 8pt)[#lbl])
}

= 25.1 --- Problemas Básicos em Computação Distribuída: Coordenação e Sincronização de Processos, Exclusão Mútua, Difusão de Mensagens

== Introdução

Em um sistema distribuído, processos rodam em máquinas diferentes, sem memória compartilhada e sem um relógio físico comum -- diferente do que se assume em Sistemas Operacionais para sincronização local (semáforos e monitores pressupõem memória compartilhada entre threads/processos de uma mesma máquina). A comunicação só acontece por troca de mensagens, sujeita a latência e atraso variável, o que torna "quem aconteceu antes de quem" e "como coordenar acesso a um recurso" problemas não triviais -- o núcleo desta subseção, muito cobrada na POSCOMP com diagramas de eventos.

== Coordenação e Sincronização de Processos

#definition(name: "Relação happens-before (Lamport)", id: "def-happens-before")[
  A relação de precedência causal $arrow.r$ entre eventos de um sistema distribuído é definida por: (i) se $a$ e $b$ ocorrem no mesmo processo e $a$ vem antes de $b$, então $a arrow.r b$; (ii) se $a$ é o envio de uma mensagem e $b$ é o seu recebimento, então $a arrow.r b$; (iii) transitividade: se $a arrow.r b$ e $b arrow.r c$, então $a arrow.r c$. Dois eventos $a, b$ são *concorrentes* ($a || b$) se nem $a arrow.r b$ nem $b arrow.r a$.
]

#definition(name: "Relógio lógico de Lamport", id: "def-relogio-lamport")[
  Cada processo $P_i$ mantém um contador inteiro $L_i$, atualizado por três regras:
  + Antes de cada evento local (incluindo envio de mensagem), $L_i arrow.l L_i + 1$.
  + Toda mensagem enviada carrega o timestamp $L_i$ do remetente no momento do envio.
  + Ao receber uma mensagem com timestamp $t$, o processo faz $L_i arrow.l max(L_i, t) + 1$ antes de processar o evento de recebimento.
  Essa construção garante que $a arrow.r b arrow.double.r L(a) < L(b)$ -- mas a *recíproca não vale* (ver observação abaixo).
]

#definition(name: "Relógio vetorial (vector clock)", id: "def-relogio-vetorial")[
  Cada processo $P_i$ (em um sistema com $n$ processos) mantém um vetor $V_i[1..n]$. Regras: (1) antes de um evento local, $V_i [i] arrow.l V_i [i] + 1$; (2) toda mensagem carrega o vetor $V_i$ do remetente; (3) ao receber um vetor $V_j$, o processo atualiza $V_i [k] arrow.l max(V_i [k], V_j [k])$ para todo $k$, e então incrementa $V_i [i]$. Diferente do relógio escalar de Lamport, o vetorial permite decidir *exatamente*: $a arrow.r b arrow.double.r.l.r.double V(a) < V(b)$ (comparação componente a componente).
]

== Exemplo resolvido

#example(name: "Atualização de relógios lógicos de Lamport", id: "ex-lamport-clocks")[
  #figure(
    box(width: 320pt, height: 150pt)[
      #place(dx: 40pt, dy: 20pt, text(size: 9pt, weight: "bold")[P1])
      #place(dx: 0pt, dy: 30pt, line(start: (40pt, 0pt), end: (300pt, 0pt), stroke: 1pt))

      #place(dx: 40pt, dy: 70pt, text(size: 9pt, weight: "bold")[P2])
      #place(dx: 0pt, dy: 80pt, line(start: (40pt, 0pt), end: (300pt, 0pt), stroke: 1pt))

      #place(dx: 40pt, dy: 120pt, text(size: 9pt, weight: "bold")[P3])
      #place(dx: 0pt, dy: 130pt, line(start: (40pt, 0pt), end: (300pt, 0pt), stroke: 1pt))

      #evt(90pt, 30pt, "L=1")
      #evt(150pt, 30pt, "L=2 (envia)")
      #evt(90pt, 80pt, "L=1")
      #evt(220pt, 80pt, "L=3 (recebe)", above: false)
      #evt(120pt, 130pt, "L=1")

      #place(dx: 0pt, dy: 0pt, line(start: (150pt, 30pt), end: (220pt, 80pt), stroke: (paint: gray, thickness: 1pt, dash: "dashed")))
    ],
    caption: [Diagrama de espaço-tempo: $P_1$ envia uma mensagem no evento com $L{=}2$; $P_2$ a recebe e atualiza seu relógio para $max(1,2)+1=3$. $P_3$ não participa da troca e mantém sua contagem local independente.],
  )

  Note que o evento de $P_3$ com $L=1$ e o evento de $P_1$ com $L=1$ têm o *mesmo* timestamp, mas são eventos concorrentes (nenhum precede o outro causalmente) -- ilustrando por que timestamps de Lamport iguais (ou mesmo comparáveis) não implicam relação causal real.
]

== Exclusão Mútua Distribuída

#definition(name: "Requisitos de exclusão mútua distribuída", id: "def-exclusao-mutua-distribuida")[
  Um algoritmo de exclusão mútua distribuída deve garantir, sem memória compartilhada:
  - *Segurança (safety)*: no máximo um processo na seção crítica (SC) por vez.
  - *Vivacidade (liveness)*: toda solicitação de entrada na SC é eventualmente atendida (sem deadlock nem starvation).
  - *Ordenação (fairness)*: solicitações são atendidas, idealmente, na ordem de seus timestamps (ordem causal via Lamport/vetorial).
]

#definition(name: "Algoritmo de Ricart-Agrawala", id: "def-ricart-agrawala")[
  Algoritmo baseado em *permissão de todos*: para entrar na SC, um processo $P_i$ envia uma mensagem `REQUEST(timestamp, i)` (via relógio de Lamport) para todos os outros $n-1$ processos, e só entra na SC após receber `REPLY` de todos. Um processo $P_j$ que recebe um `REQUEST`:
  - Responde `REPLY` imediatamente, se não está solicitando a SC nem está nela;
  - Adia a resposta, se está na SC;
  - Compara timestamps se também está solicitando: responde imediatamente se o timestamp recebido é *menor* (regra de desempate: timestamp menor vence; em empate, usa-se o ID do processo) que o seu próprio pedido, senão adia até sair da SC.
  Custo: $2(n-1)$ mensagens por entrada na SC (sem usar um coordenador central).
]

#definition(name: "Algoritmo do token (anel lógico)", id: "def-algoritmo-token")[
  Os processos formam um *anel lógico*; um único token circula continuamente nesse anel. Um processo só pode entrar na SC quando está de posse do token, e o retém até sair da SC, repassando-o em seguida ao próximo do anel. Garante segurança e ausência de starvation por construção (ordem de acesso segue a ordem do anel), com custo entre $1$ (token já no processo) e $n$ mensagens por entrada.
]

== Propriedade relevante

#theorem(name: "Custo de mensagens: Ricart-Agrawala vs. token ring", id: "thm-custo-exclusao-mutua")[
  Para $n$ processos, Ricart-Agrawala usa exatamente $2(n-1)$ mensagens por entrada na SC (independentemente da carga); o algoritmo de token usa entre $0$ e $n$ mensagens, mas pode gastar banda circulando o token *mesmo sem ninguém querendo entrar na SC* (overhead ocioso que Ricart-Agrawala não tem).
]

#proof[
  Em Ricart-Agrawala, cada entrada exige $n-1$ `REQUEST`s de saída mais $n-1$ `REPLY`s de entrada, totalizando $2(n-1)$, independentemente de quantos processos disputam a SC simultaneamente. No algoritmo de token, na ausência de disputa, o token continua circulando (1 mensagem por salto do anel) até chegar a um processo interessado -- overhead que cresce com $n$ mesmo sem contenção, ao contrário de Ricart-Agrawala, que só gera tráfego quando há de fato uma solicitação.
]

== Difusão de Mensagens

#definition(name: "Tipos e ordens de difusão (broadcast)", id: "def-tipos-difusao")[
  - *Unicast*: um remetente, um destinatário. *Multicast*: um remetente, um grupo de destinatários. *Broadcast*: um remetente, todos os processos do sistema.
  - *Difusão confiável*: garante que toda mensagem entregue a um processo correto é entregue a todos os processos corretos.
  - *Ordem FIFO*: mensagens do mesmo remetente são entregues na ordem de envio.
  - *Ordem causal*: se o envio de $m_1$ precede causalmente ($arrow.r$) o envio de $m_2$, então $m_1$ é entregue antes de $m_2$ em todo destinatário comum -- implementável usando relógios vetoriais (@def-relogio-vetorial) para reter mensagens entregues fora de ordem causal até que suas dependências cheguem.
  - *Ordem total*: todos os processos entregam *todas* as mensagens na *mesma* ordem relativa, mesmo que não haja relação causal entre elas.
]

== Atenção -- pegadinhas comuns

#remark(name: "Timestamp de Lamport ordena, mas não captura causalidade com precisão")[
  $a arrow.r b arrow.double.r L(a) < L(b)$ vale sempre, mas $L(a) < L(b)$ *não* implica $a arrow.r b$ -- os eventos podem ser concorrentes (ver exemplo desta seção, com $P_1$ e $P_3$). Só o relógio *vetorial* permite decidir causalidade com certeza a partir dos timestamps.
]

#remark(name: "Exclusão mútua distribuída não pode usar semáforos/monitores do SO local")[
  Semáforos e monitores (Sistemas Operacionais) pressupõem uma região de memória compartilhada acessível por todos os threads/processos concorrentes -- inexistente entre máquinas distintas. Por isso os algoritmos desta seção resolvem o mesmo problema (exclusão mútua) trocando apenas mensagens.
]

#remark(name: "Token perdido é um problema de tolerância a falhas, não do algoritmo em si")[
  O algoritmo de token pressupõe que o token nunca se perde nem é duplicado -- na prática, falhas de processo ou de rede podem violar essa suposição, exigindo um mecanismo de detecção e regeneração do token (tratado em 25.4).
]

== Questões estilo POSCOMP

*Questão 1.* No diagrama de espaço-tempo do exemplo desta seção, o timestamp de Lamport do evento de recebimento em $P_2$ é calculado por:
- a) O valor do relógio local de $P_2$ antes do recebimento, sem alteração.
- b) $max(L_(P_2), t_"mensagem")$.
- c) $max(L_(P_2), t_"mensagem") + 1$.
- d) $L_(P_2) + t_"mensagem"$.
- e) O menor entre $L_(P_2)$ e $t_"mensagem"$.

*Questão 2.* Dois eventos $a$ e $b$ com timestamps de Lamport $L(a) = 3$ e $L(b) = 5$ são observados. Pode-se concluir corretamente que:
- a) $a arrow.r b$ necessariamente.
- b) $b arrow.r a$ necessariamente.
- c) $a$ e $b$ são necessariamente concorrentes.
- d) Nada se pode concluir sobre a relação causal entre $a$ e $b$ apenas com timestamps de Lamport.
- e) $a$ e $b$ ocorreram no mesmo processo.

*Questão 3.* No algoritmo de Ricart-Agrawala, um processo $P_j$ que recebe um `REQUEST` de $P_i$ enquanto está na seção crítica deve:
- a) Responder `REPLY` imediatamente.
- b) Adiar a resposta até sair da seção crítica.
- c) Rejeitar definitivamente o pedido de $P_i$.
- d) Encaminhar o pedido para um coordenador central.
- e) Entrar em deadlock automaticamente.

*Questão 4.* Em relação ao custo de mensagens por entrada na seção crítica, é correto afirmar que:
- a) O algoritmo de token sempre usa exatamente $2(n-1)$ mensagens, como Ricart-Agrawala.
- b) Ricart-Agrawala usa exatamente $2(n-1)$ mensagens por entrada, independentemente da carga do sistema.
- c) O algoritmo de token nunca gera tráfego quando não há disputa pela seção crítica.
- d) Ricart-Agrawala exige um coordenador central para funcionar.
- e) O custo de mensagens é sempre menor no algoritmo de token, em qualquer cenário.

== Gabarito comentado

1. *(c)* -- regra 3 da definição de relógio de Lamport: $max(L_i, t)+1$.
2. *(d)* -- timestamps de Lamport comparáveis não implicam causalidade; os eventos podem ser concorrentes, como no exemplo desta seção.
3. *(b)* -- um processo na SC sempre adia a resposta a `REQUEST`s recebidos, liberando-a apenas ao sair.
4. *(b)* -- é exatamente o enunciado do teorema desta seção sobre custo de mensagens.

== Referências

- TANENBAUM, A. S.; VAN STEEN, M. *Distributed Systems: Principles and Paradigms*. Cap. 6 (Sincronização: relógios lógicos, exclusão mútua).
- COULOURIS, G. et al. *Sistemas Distribuídos: Conceitos e Projeto*. Cap. 14--15.
- cienciadacomputacao.wiki.br -- Tópico 25, subtópico 25.1.
