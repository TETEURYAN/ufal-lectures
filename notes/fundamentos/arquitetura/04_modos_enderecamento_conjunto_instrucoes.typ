#import "@preview/mousse-notes:1.1.0": *

= Modos de Endereçamento e Conjunto de Instruções
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.3]

== Introdução

O conjunto de instruções (parte central da ISA, 01) define não só *quais* operações a CPU realiza, mas *como* cada instrução localiza seus operandos na memória ou nos registradores -- os modos de endereçamento. É um dos blocos de cálculo mais diretos da disciplina: dado um modo e valores de registradores/memória, calcular o endereço efetivo do operando.

== Definições formais

#definition(name: "Modo de endereçamento", id: "def-modo-enderecamento")[
  Regra que determina como o *endereço efetivo* de um operando é calculado a partir dos campos de uma instrução. Diferentes modos equilibram flexibilidade (acessar estruturas de dados complexas) contra tamanho de instrução e velocidade de decodificação.
]

#definition(name: "Modos de endereçamento clássicos", id: "def-modos-classicos")[
  - *Imediato*: o próprio valor do operando está codificado na instrução (não há acesso à memória para buscá-lo).
  - *Direto (absoluto)*: o campo de endereço da instrução é o próprio endereço de memória do operando.
  - *Indireto*: o campo de endereço aponta para uma posição de memória que, por sua vez, contém o endereço do operando (um nível extra de indireção).
  - *Registrador*: o operando está em um registrador da CPU, identificado pelo campo da instrução -- mais rápido que qualquer modo que acesse memória.
  - *Registrador indireto*: um registrador contém o endereço de memória do operando (o registrador funciona como um ponteiro).
  - *Indexado (base + índice)*: o endereço efetivo é a soma do conteúdo de um registrador-base com um registrador-índice (frequentemente combinado com um deslocamento constante) -- útil para percorrer vetores.
  - *Base + deslocamento (displacement)*: o endereço efetivo é a soma do conteúdo de um registrador-base com uma constante presente na instrução -- usado para acessar campos de registros/estruturas e variáveis locais na pilha.
  - *Relativo ao PC*: o endereço efetivo é o valor atual do contador de programa somado a um deslocamento -- usado tipicamente em instruções de desvio (05), permitindo código *posição-independente*.
]

#definition(name: "Classificação de conjuntos de instruções pelo número de operandos", id: "def-classificacao-operandos")[
  Máquinas são classificadas pelo número máximo de operandos endereçáveis explicitamente em uma instrução aritmética típica:
  - *Máquina de pilha (0 endereços)*: operações consomem operandos implicitamente do topo de uma pilha (ex.: `ADD` soma os dois valores no topo, empilhando o resultado).
  - *1 endereço (acumulador)*: um operando implícito é sempre um registrador acumulador; a instrução especifica o outro operando.
  - *2 endereços*: a instrução especifica dois operandos; um deles é normalmente sobrescrito pelo resultado (ex.: `ADD R1, R2` calcula $R_1 arrow.l R_1 + R_2$).
  - *3 endereços*: a instrução especifica dois operandos-fonte e um destino distinto (ex.: `ADD R1, R2, R3` calcula $R_1 arrow.l R_2 + R_3$), típico de arquiteturas RISC (09) load-store.
]

== Exemplo resolvido

#example(name: "Calculando o endereço efetivo em diferentes modos", id: "ex-endereco-efetivo")[
  Considere o estado: registrador base $R_1 = 1000$, registrador índice $R_2 = 4$, e a memória na posição $1000$ contém o valor $2000$. A instrução tem campo de endereço/deslocamento $D = 20$.

  - *Direto*, campo $= 1000$: endereço efetivo $= 1000$ (acessa diretamente a posição 1000).
  - *Indireto*, campo $= 1000$: endereço efetivo $=$ conteúdo da posição $1000 = 2000$ (um nível extra de indireção).
  - *Registrador indireto*, campo $= R_1$: endereço efetivo $= R_1 = 1000$ (conteúdo do registrador é o endereço).
  - *Indexado*, base $R_1$ + índice $R_2$: endereço efetivo $= R_1 + R_2 = 1000 + 4 = 1004$.
  - *Base + deslocamento*, base $R_1$ + $D$: endereço efetivo $= R_1 + D = 1000 + 20 = 1020$.
]

== Atenção -- pegadinhas comuns

#remark(name: "Indireto não é o mesmo que indexado")[
  No modo indireto, o campo da instrução aponta para uma posição de memória que contém o endereço final -- uma indireção *via memória*. No modo indexado, o endereço final é calculado por *aritmética* entre registradores (soma de base e índice), sem esse acesso extra à memória para obter o próprio endereço. Confundir os dois é o erro mais comum desta seção.
]

#remark(name: "Modo imediato nunca acessa memória para buscar o operando")[
  No modo imediato, o valor já está na instrução -- não há leitura adicional de memória nem de registrador para obter o operando (apenas para buscar a própria instrução). É o modo mais rápido, mas limitado a constantes pequenas, pelo tamanho fixo do campo da instrução.
]

#remark(name: "Endereçamento relativo ao PC viabiliza código posição-independente")[
  Como o deslocamento é somado ao valor *atual* do PC (não a um endereço absoluto fixo), o mesmo código pode ser carregado em diferentes posições de memória sem precisar recalcular endereços de desvio -- propriedade explorada por bibliotecas compartilhadas e por código realocável.
]

== Questões estilo POSCOMP

*Questão 1.* No modo de endereçamento indireto, o campo de endereço da instrução:
- a) Contém diretamente o valor do operando.
- b) Contém o endereço de uma posição de memória que, por sua vez, contém o endereço do operando.
- c) É sempre ignorado pela unidade de controle.
- d) Referencia exclusivamente um registrador de propósito geral.
- e) É somado ao contador de programa.

*Questão 2.* Uma arquitetura RISC do tipo load-store, com instruções aritméticas de 3 endereços como `ADD R1, R2, R3`, calcula o resultado da seguinte forma:
- a) $R_2 arrow.l R_1 + R_3$.
- b) $R_1 arrow.l R_2 + R_3$, sem sobrescrever nenhum dos operandos-fonte.
- c) $R_3 arrow.l R_1 + R_2$, sobrescrevendo $R_1$.
- d) Os três registradores são somados entre si e o resultado é descartado.
- e) Apenas $R_1$ é lido; $R_2$ e $R_3$ são ignorados.

*Questão 3.* O modo de endereçamento indexado (base + índice) é especialmente adequado para:
- a) Acessar uma constante fixa embutida na instrução.
- b) Percorrer elementos de um vetor, variando o registrador de índice a cada acesso.
- c) Realizar desvios incondicionais.
- d) Acessar exclusivamente registradores, sem tocar a memória.
- e) Executar instruções de ponto flutuante.

== Gabarito comentado

1. *(b)* -- definição direta de endereçamento indireto: um nível extra de indireção via memória.
2. *(b)* -- formato de 3 endereços especifica dois operandos-fonte distintos e um destino, sem sobrescrever nenhuma fonte, conforme a definição desta seção.
3. *(b)* -- somar um índice variável a uma base fixa é exatamente o mecanismo usado para percorrer vetores, incrementando o índice a cada iteração.

== Referências

- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre conjuntos de instruções e modos de endereçamento.
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. 2.
- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Apêndice sobre conjuntos de instruções.
