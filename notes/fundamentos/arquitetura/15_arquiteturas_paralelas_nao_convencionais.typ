#import "@preview/mousse-notes:1.1.0": *

= Arquiteturas Paralelas e Não Convencionais
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.14]

== Introdução

Fechando a disciplina: multiprocessadores (13) e multicomputadores (14) ainda partem, em cada nó, de um núcleo de execução essencialmente Von Neumann (01) -- busca sequencial guiada por um contador de programa. Esta subseção reúne arquiteturas que rompem com essa premissa de formas mais radicais: dataflow, sistólicas, e uma menção aos paradigmas emergentes de GPU/SIMT e computação quântica.

== Definições formais

#definition(name: "Arquitetura dataflow (fluxo de dados)", id: "def-arquitetura-dataflow")[
  Modelo de execução em que uma instrução é disparada (fire) assim que *todos os seus operandos estão disponíveis*, independentemente de qualquer contador de programa ou ordem sequencial predefinida -- o programa é representado como um *grafo de fluxo de dados*, cujos nós são operações e cujas arestas representam a dependência de dados entre elas. Não existe a noção de "próxima instrução"; a ordem de execução emerge diretamente da disponibilidade de dados, expondo naturalmente todo o paralelismo em nível de instrução (11) presente no grafo.
]

#definition(name: "Arquitetura sistólica (systolic array)", id: "def-arquitetura-sistolica")[
  Rede regular de *elementos de processamento (PEs)* simples e idênticos, dispostos em grade, cada um realizando uma operação fixa e repetitiva sobre os dados que recebe de seus vizinhos, encaminhando o resultado adiante em um ritmo sincronizado por clock -- analogia com o bombeamento rítmico do coração ("sistólico"). Especialmente eficiente para operações regulares e repetitivas sobre grandes volumes de dados estruturados, como multiplicação de matrizes e convolução, tornando o modelo diretamente relevante para aceleradores de aprendizado profundo modernos (unidades de multiplicação matricial).
]

#definition(name: "SIMT (Single Instruction, Multiple Threads)", id: "def-simt")[
  Modelo de execução usado por GPUs modernas, uma variante refinada de SIMD (13): um grande número de *threads leves* executa a *mesma* instrução simultaneamente sobre dados distintos, organizadas em grupos (warps/wavefronts) que avançam em lockstep -- mas, diferente do SIMD clássico, cada thread mantém seu próprio estado (registradores, contador de programa lógico), permitindo alguma divergência controlada de fluxo de controle entre threads do mesmo grupo, ao custo de serialização quando essa divergência ocorre.
]

== Exemplo resolvido

#example(name: "Execução de (a+b)×(c-d) em um modelo dataflow", id: "ex-dataflow-execucao")[
  Considere o grafo de fluxo de dados para calcular $(a+b) times (c-d)$: um nó `+` com entradas $a, b$; um nó `-` com entradas $c, d$; um nó `×` com entradas os resultados de `+` e `-`.

  Em uma máquina Von Neumann convencional, essas operações seriam ordenadas *sequencialmente* pelo compilador em instruções de máquina (ex.: calcular `+` primeiro, depois `-`, depois `×`), mesmo que `+` e `-` sejam, na verdade, completamente independentes entre si.

  Em uma máquina dataflow, assim que $a$ e $b$ estão disponíveis, o nó `+` *dispara* -- e, *simultaneamente*, assim que $c$ e $d$ estão disponíveis (independentemente de `+` já ter disparado ou não), o nó `-` também dispara. Apenas o nó `×` precisa aguardar explicitamente os dois resultados anteriores. O paralelismo entre `+` e `-` é explorado *automaticamente* pela própria estrutura do grafo, sem nenhuma análise de dependências feita a priori por um compilador sequencial.
]

== Atenção -- pegadinhas comuns

#remark(name: "Dataflow não tem contador de programa -- a ordem emerge dos dados, não de um PC")[
  É um erro comum tentar aplicar a intuição de "próxima instrução" (central ao modelo Von Neumann, 01) a uma máquina dataflow -- não existe essa noção. A execução é inteiramente orientada pela disponibilidade de operandos, o que é precisamente o que torna esse modelo capaz de expor paralelismo sem exigir análise explícita de hazards de dados (10) em uma sequência linear de instruções.
]

#remark(name: "Sistólica não é sinônimo de \"processamento paralelo genérico\"")[
  A arquitetura sistólica é *especializada*: eficiente para o padrão regular de fluxo de dados de operações como convolução e multiplicação de matrizes, em que cada elemento de processamento repete a mesma operação simples sobre um fluxo constante de dados vizinhos -- não é um substituto de propósito geral para multiprocessadores (13) ou multicomputadores (14), que lidam bem com cargas de trabalho irregulares.
]

#remark(name: "SIMT não elimina a penalidade de divergência de fluxo de controle")[
  Se threads de um mesmo grupo SIMT tomam caminhos diferentes em um desvio condicional (ex.: metade satisfaz um `if`, metade não), o hardware tipicamente executa *ambos* os caminhos em sequência, desativando as threads não aplicáveis a cada trecho -- a divergência não gera paralelismo extra, apenas serializa parcialmente a execução daquele grupo, reduzindo a eficiência esperada de SIMD/SIMT nesses trechos.
]

== Questões estilo POSCOMP

*Questão 1.* Em uma arquitetura dataflow, uma instrução é executada (disparada) quando:
- a) O contador de programa aponta explicitamente para ela.
- b) Todos os seus operandos de entrada estão disponíveis, independentemente de ordem sequencial predefinida.
- c) Um temporizador de hardware expira.
- d) Nenhuma outra instrução do programa já foi executada.
- e) Um usuário aciona manualmente sua execução.

*Questão 2.* Arquiteturas sistólicas são especialmente adequadas para:
- a) Cargas de trabalho totalmente irregulares e imprevisíveis.
- b) Operações regulares e repetitivas sobre grandes volumes de dados estruturados, como multiplicação de matrizes.
- c) Substituir integralmente multiprocessadores de propósito geral.
- d) Executar exclusivamente código sequencial Von Neumann.
- e) Armazenamento de longo prazo de dados, como um HD.

*Questão 3.* No modelo SIMT usado por GPUs modernas, a divergência de fluxo de controle entre threads de um mesmo grupo (warp) tipicamente resulta em:
- a) Paralelismo adicional, sem custo algum.
- b) Execução sequencial parcial dos diferentes caminhos, com desativação seletiva de threads em cada trecho.
- c) Interrupção definitiva de todas as threads do grupo.
- d) Nenhum efeito sobre o desempenho.
- e) Conversão automática para execução dataflow.

== Gabarito comentado

1. *(b)* -- definição direta do modelo dataflow: disparo por disponibilidade de operandos, sem contador de programa.
2. *(b)* -- é exatamente o nicho de aplicação das arquiteturas sistólicas, conforme definido nesta seção.
3. *(b)* -- divergência em SIMT serializa parcialmente a execução do grupo, desativando threads não aplicáveis a cada caminho, em vez de gerar paralelismo extra.

== Referências

- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Cap. 4 (Paralelismo de dados: vetorial, SIMD e GPU) e apêndices sobre dataflow.
- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre processamento paralelo e arquiteturas alternativas.
- KUNG, H. T. *Why Systolic Architectures?* (1982) -- artigo clássico sobre arquiteturas sistólicas.
- Circuitos Digitais (14, Dispositivos Lógicos Programáveis) -- FPGAs como hardware reconfigurável, outra forma de arquitetura não convencional.
