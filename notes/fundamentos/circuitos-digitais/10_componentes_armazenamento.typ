#import "@preview/mousse-notes:1.1.0": *

= Componentes de Armazenamento
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.10]

== Introdução

De flip-flops individuais (06) a memórias inteiras: esta subseção reúne, em nível conceitual, os principais componentes usados para armazenar informação em um sistema digital -- da menor unidade (1 bit) até blocos de memória endereçáveis.

== Definições formais

#definition(name: "Latch vs. flip-flop", id: "def-latch-vs-flip-flop")[
  - *Latch*: elemento de memória *sensível a nível* -- enquanto um sinal de habilitação (enable) está ativo, a saída acompanha a entrada continuamente.
  - *Flip-flop*: elemento de memória *sensível a borda* -- só atualiza a saída no instante exato de uma transição (subida ou descida) do clock, permanecendo estável no restante do ciclo.
  Flip-flops são compostos internamente por latches (tipicamente dois, em configuração mestre-escravo), mas o comportamento externo -- borda vs. nível -- é a distinção que mais importa para o projetista.
]

#definition(name: "Registrador", id: "def-registrador")[
  Conjunto de flip-flops (tipicamente D) operando em paralelo, compartilhando o mesmo clock, para armazenar uma palavra de múltiplos bits como uma unidade -- bloco básico de armazenamento temporário em processadores (registradores de propósito geral, PC, etc.).
]

#definition(name: "Memórias RAM e ROM", id: "def-memorias-ram-rom")[
  - *RAM (Random Access Memory)*: memória de leitura *e* escrita, volátil (perde o conteúdo sem energia). *SRAM* (baseada em flip-flops/latches, rápida, cara) vs. *DRAM* (baseada em capacitores, precisa de refresh periódico, mais densa e barata).
  - *ROM (Read-Only Memory)*: memória primariamente de leitura, não volátil (retém conteúdo sem energia) -- variantes como PROM, EPROM, EEPROM permitem gravação/regravação com procedimentos especiais, mas a leitura em operação normal é o uso típico.
]

== Exemplo resolvido

#example(name: "Endereçamento de uma memória RAM", id: "ex-enderecamento-ram")[
  Uma RAM com $2^10 = 1024$ posições endereçáveis, cada uma armazenando 8 bits, precisa de $10$ linhas de endereço (para selecionar 1 entre 1024 posições, via um decodificador, 05) e $8$ linhas de dados (para ler/escrever o byte armazenado naquela posição). Esse é o padrão geral: uma memória de $2^n$ posições de $m$ bits cada exige $n$ bits de endereço e um barramento de dados de $m$ bits.
]

== Atenção -- pegadinhas comuns

#remark(name: "Latch não é \"um flip-flop mais simples\" de forma inofensiva")[
  Usar um latch onde um flip-flop era esperado pode causar instabilidade real: como o latch é transparente durante todo o nível ativo do enable, uma mudança na entrada durante esse intervalo se propaga imediatamente à saída -- comportamento frequentemente indesejado em lógica síncrona, onde se espera atualização só em um instante discreto (borda).
]

#remark(name: "RAM volátil vs. ROM não-volátil -- não confundir com read/write")[
  A distinção volátil/não-volátil é sobre *reter dados sem energia*; a distinção leitura/escrita é sobre *quais operações são suportadas em operação normal*. RAM moderna suporta leitura e escrita, mas é volátil; ROM tradicionalmente só suporta leitura em operação normal, mas é não volátil -- são dois eixos diferentes, não sinônimos.
]

== Questões estilo POSCOMP

*Questão 1.* A diferença fundamental entre um latch e um flip-flop é que o flip-flop:
- a) Nunca armazena informação.
- b) É sensível a borda de clock, enquanto o latch é sensível a nível.
- c) Não pode ser usado em registradores.
- d) É sempre mais lento que um latch.
- e) É equivalente a uma memória ROM.

*Questão 2.* Uma memória RAM de $2^12$ posições endereçáveis, com 16 bits por posição, exige:
- a) 12 bits de endereço e 16 bits de dados.
- b) 16 bits de endereço e 12 bits de dados.
- c) 12 bits de endereço e 12 bits de dados.
- d) 4096 bits de endereço.
- e) 28 bits de endereço.

*Questão 3.* Sobre RAM e ROM, é correto afirmar que:
- a) RAM é não volátil; ROM é volátil.
- b) RAM é volátil; ROM é tradicionalmente não volátil.
- c) Ambas são sempre voláteis.
- d) Ambas são sempre não voláteis.
- e) A distinção volátil/não-volátil é irrelevante para memórias digitais.

== Gabarito comentado

1. *(b)* -- sensibilidade a borda (flip-flop) vs. a nível (latch) é a diferença definidora, conforme esta seção.
2. *(a)* -- $2^12$ posições exigem 12 bits de endereço; cada posição armazena 16 bits de dados.
3. *(b)* -- RAM perde dados sem energia (volátil); ROM tradicionalmente retém dados sem energia (não volátil).

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 5, 7 (Latches, flip-flops, memórias).
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 10--11 (Memórias).
