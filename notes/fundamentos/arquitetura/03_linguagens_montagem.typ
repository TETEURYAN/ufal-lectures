#import "@preview/mousse-notes:1.1.0": *

= Linguagens de Montagem
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.2]

== Introdução

Linguagem de montagem (assembly) é a representação textual, legível por humanos, das instruções de máquina definidas pela ISA (01) -- o elo mais direto entre o código-fonte e o hardware. Entender como um montador (assembler) traduz mnemônicos em código de máquina, e a diferença entre esse processo e a compilação de linguagens de alto nível, é frequentemente cobrado de forma conceitual na POSCOMP.

== Definições formais

#definition(name: "Linguagem de montagem", id: "def-linguagem-montagem")[
  Linguagem de baixo nível em que cada instrução corresponde, em geral, a exatamente uma instrução de máquina da ISA-alvo, representada por *mnemônicos* (ex.: `ADD`, `MOV`, `BEQ`) em vez de códigos numéricos de operação. Uma linha típica de assembly tem a forma:
  $ ["rótulo" :] space "mnemônico" space "operando(s)" space ["; comentário"] $
  O *rótulo* (label) é opcional e nomeia um endereço de memória (destino de desvio ou dado), permitindo referenciá-lo simbolicamente em vez de por endereço numérico absoluto.
]

#definition(name: "Montador (assembler)", id: "def-montador")[
  Programa que traduz código em linguagem de montagem para código de máquina (código-objeto), resolvendo mnemônicos para opcodes e rótulos simbólicos para endereços numéricos. Diferente de um *compilador* (que traduz uma linguagem de alto nível, com uma instrução podendo gerar várias instruções de máquina), o montador opera essencialmente em correspondência *um-para-um* entre linha de assembly e instrução de máquina -- com exceção das diretivas e macros (ver abaixo), que não geram código diretamente.
]

#definition(name: "Diretivas (pseudo-instruções)", id: "def-diretivas")[
  Comandos do assembly que orientam o *processo de montagem* (reservar espaço para dados, definir constantes, marcar seções de código/dados), mas que não correspondem a nenhuma instrução executável da ISA -- não geram opcode. Exemplos comuns: `.data` (inicia seção de dados), `.text` (inicia seção de código), `.word`/`.byte` (reserva e inicializa memória com um valor).
]

#definition(name: "Montagem em duas passagens (two-pass assembly)", id: "def-montagem-duas-passagens")[
  Técnica clássica para resolver *referências futuras* (forward references) -- um rótulo usado antes de ser definido no código-fonte, ex.: um desvio para um rótulo mais adiante:
  + *Primeira passagem*: percorre o código sem gerar código de máquina, apenas construindo a *tabela de símbolos* (associando cada rótulo ao endereço que ocupará).
  + *Segunda passagem*: percorre o código novamente, agora traduzindo cada instrução para código de máquina, substituindo rótulos pelos endereços já conhecidos da tabela de símbolos.
]

== Exemplo resolvido

#example(name: "De assembly a código de máquina", id: "ex-assembly-codigo-maquina")[
  Considere a instrução hipotética de soma de registradores em uma ISA didática, com formato tipo-R de 3 campos (opcode, registrador destino, registrador fonte):
  $ "ADD" space R_1, R_2 $
  Um montador traduz o mnemônico `ADD` para o opcode numérico correspondente (definido pela ISA, ex.: `000101`) e os registradores simbólicos $R_1$, $R_2$ para seus números binários de registrador -- produzindo uma palavra de instrução binária completa, pronta para ser interpretada pela unidade de controle da CPU (04).

  Um trecho maior, somando dois números e armazenando o resultado, ilustra rótulos e diretivas:
  ```
  .data
  valor1: .word 10
  valor2: .word 20
  soma:   .word 0

  .text
  inicio:
      LOAD R1, valor1    ; R1 <- valor1
      LOAD R2, valor2    ; R2 <- valor2
      ADD  R3, R1, R2    ; R3 <- R1 + R2
      STORE R3, soma     ; soma <- R3
  ```
  Note que `valor1`, `valor2`, `soma` e `inicio` são rótulos resolvidos pelo montador para endereços de memória concretos; `.data`/`.text` e `.word` são diretivas, sem correspondência com instruções executáveis.
]

== Atenção -- pegadinhas comuns

#remark(name: "Montador não é compilador")[
  A correspondência aproximadamente um-para-um entre linha de assembly e instrução de máquina é a diferença estrutural central frente a um compilador de linguagem de alto nível (Linguagens de Programação, 12), no qual uma única instrução-fonte tipicamente expande para várias instruções de máquina. Chamar o processo de tradução de assembly de "compilação" é um deslize comum, mas tecnicamente impreciso.
]

#remark(name: "Diretiva não gera código executável")[
  Um erro recorrente é tratar diretivas (`.data`, `.word` etc.) como instruções que a CPU executa em tempo de execução -- elas são processadas *apenas* durante a montagem, orientando como o montador organiza memória e código; não aparecem como instruções no fluxo de execução do programa.
]

#remark(name: "Duas passagens resolvem referências para frente, não para trás")[
  Referências a rótulos já definidos anteriormente no código (backward references) podem, em princípio, ser resolvidas em uma única passagem -- é especificamente a referência a um rótulo ainda não visto (forward reference) que exige a segunda passagem, pois seu endereço só é conhecido depois de percorrer todo o código na primeira.
]

== Questões estilo POSCOMP

*Questão 1.* A principal diferença estrutural entre um montador (assembler) e um compilador é que o montador:
- a) Não pode processar rótulos simbólicos.
- b) Traduz, em geral, cada linha de código-fonte para exatamente uma instrução de máquina, enquanto um compilador tipicamente expande uma instrução-fonte em várias.
- c) Só funciona com linguagens orientadas a objeto.
- d) Gera exclusivamente código-fonte, nunca código de máquina.
- e) Não realiza nenhum tipo de tradução.

*Questão 2.* Em um montador de duas passagens, a finalidade da primeira passagem é:
- a) Executar o programa para verificar erros de lógica.
- b) Construir a tabela de símbolos, associando rótulos aos endereços que ocuparão.
- c) Traduzir diretamente para código de máquina, sem uso de tabela de símbolos.
- d) Remover comentários do código-fonte apenas.
- e) Otimizar o código para reduzir o número de instruções.

*Questão 3.* Em um trecho de assembly, a diretiva `.data` tem a função de:
- a) Executar uma operação aritmética sobre um registrador.
- b) Marcar o início de uma seção de dados, sem gerar instrução executável.
- c) Definir um rótulo de desvio condicional.
- d) Indicar o final do programa.
- e) Solicitar uma interrupção de hardware.

== Gabarito comentado

1. *(b)* -- definição direta da diferença estrutural entre montador e compilador desta seção.
2. *(b)* -- é exatamente o papel da primeira passagem no esquema de montagem em duas passagens.
3. *(b)* -- diretivas orientam o processo de montagem (aqui, demarcando a seção de dados), sem gerar código executável.

== Referências

- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre linguagem de montagem e o processo de montagem.
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. 2 (Instruções: a linguagem do computador).
- TANENBAUM, A. S. *Organização Estruturada de Computadores*. Cap. sobre o nível de linguagem de montagem.
