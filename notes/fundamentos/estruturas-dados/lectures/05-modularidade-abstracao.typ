#import "@preview/mousse-notes:1.1.0": *

= Modularidade e Abstração

== Introdução

Programas grandes só permanecem gerenciáveis quando decompostos em partes menores e independentes.
Modularidade é a prática de dividir um algoritmo em unidades (funções, procedimentos, módulos) com
responsabilidades bem definidas; abstração é o princípio complementar de esconder detalhes de
implementação atrás de uma interface simples. Esses dois conceitos aparecem tanto em questões
teóricas quanto embutidos em questões de leitura de código com múltiplas funções.

== Definições formais

#definition(id: "def-modularidade")[
  *Modularidade* é a decomposição de um sistema em *módulos* — funções, procedimentos ou unidades
  maiores (arquivos, pacotes) — cada um resolvendo uma subtarefa específica, comunicando-se por
  interfaces bem definidas (assinaturas de função, parâmetros, valores de retorno).
]

#definition(id: "def-abstracao")[
  *Abstração* é o princípio de expor apenas o *o quê* (comportamento/interface) de um componente,
  ocultando o *como* (implementação). Distinguem-se dois tipos principais:
  - *Abstração procedural*: uma função é usada por seu contrato (entrada $arrow.r$ saída), sem que o
    chamador precise conhecer seu corpo.
  - *Abstração de dados*: um TAD (ver @def-tipo-estruturado no tópico 9.2) expõe operações válidas
    sem revelar a representação interna da estrutura.
]

#definition(id: "def-passagem-parametros")[
  *Passagem de parâmetros* é o mecanismo de comunicação entre uma chamada de função e seu corpo:
  - *Por valor*: uma cópia do argumento é passada; alterações dentro da função não afetam a
    variável original do chamador.
  - *Por referência*: um "apontador" para a variável original é passado; alterações dentro da
    função *são* visíveis para o chamador.
]

#definition(id: "def-escopo")[
  *Escopo* é a região do programa em que um identificador (variável, função) é visível. *Escopo
  local* restringe a visibilidade ao bloco/função em que a variável foi declarada; *escopo global*
  torna a variável visível em todo o programa.
]

== Acoplamento e coesão

#definition(id: "def-acoplamento-coesao")[
  - *Acoplamento* mede o grau de dependência entre módulos — quanto menor (mais "fraco"), mais
    fácil modificar um módulo sem impactar os demais.
  - *Coesão* mede o quanto as responsabilidades dentro de um único módulo estão relacionadas —
    quanto maior (mais "forte"), mais o módulo faz *uma* coisa bem definida.
]

#remark[
  A boa prática de modularização busca *baixo acoplamento* e *alta coesão*: módulos que fazem uma
  coisa bem (alta coesão) e dependem minimamente uns dos outros (baixo acoplamento). Um módulo com
  muitas variáveis globais compartilhadas tende a ter acoplamento alto — mudar uma variável global
  pode ter efeitos difíceis de rastrear em módulos distantes.
]

== Exemplo resolvido

#example(id: "ex-modularidade-troca")[
  Considere uma função `trocar` que deveria trocar os valores de duas variáveis. Compare passagem
  por valor e por referência:

  ```c
  // por valor: NÃO troca as variáveis do chamador
  void trocar_valor(int a, int b) {
      int t = a; a = b; b = t;
  }

  // por referência (ponteiros): troca de fato
  void trocar_ref(int *a, int *b) {
      int t = *a; *a = *b; *b = t;
  }

  int x = 1, y = 2;
  trocar_valor(x, y);      // x=1, y=2 (inalterados)
  trocar_ref(&x, &y);      // x=2, y=1 (trocados)
  ```

  Esse é um exemplo canônico de prova: perguntar o valor final de `x` e `y` após uma chamada por
  valor versus por referência.
]

== Armadilhas comuns

#remark[
  - *Efeitos colaterais silenciosos*: parâmetros passados por referência (ou objetos mutáveis
    passados "por valor de referência", como em Java/Python) podem ser alterados dentro da função
    sem que o código do chamador deixe isso óbvio — fonte comum de bugs difíceis de rastrear.
  - *Abuso de variáveis globais*: aumenta o acoplamento entre módulos, dificulta testes isolados e
    quebra a previsibilidade de uma função (duas chamadas com os mesmos argumentos podem produzir
    resultados diferentes se dependerem de estado global mutável).
  - *Confundir abstração de dados com ocultação de informação (information hiding)*: são
    relacionadas, mas não idênticas — abstração de dados é sobre *o que* a interface expõe;
    ocultação de informação é sobre *impedir acesso* direto aos detalhes internos (ex.: campos
    `private`). Um TAD bem projetado normalmente usa ambos.
]

== Questões

#example(id: "q-modularidade-1")[
  *(Múltipla escolha)* Em relação à passagem de parâmetros, é correto afirmar que:

  (a) Passagem por valor sempre permite que a função altere a variável original do chamador.
  (b) Passagem por referência nunca permite efeitos colaterais visíveis ao chamador.
  (c) Passagem por referência permite que a função altere diretamente a variável original.
  (d) Escopo global e passagem por referência são a mesma coisa.
  (e) Passagem por valor é logicamente equivalente à passagem por referência para tipos primitivos.
]

#example(id: "q-modularidade-2")[
  *(Dissertativa curta)* Defina acoplamento e coesão, e explique por que um módulo com muitas
  variáveis globais compartilhadas tende a ter alto acoplamento.
]

#solution[
  *Q1*: (c).

  *Q2*: Ver @def-acoplamento-coesao. Variáveis globais compartilhadas criam dependências implícitas
  entre módulos que as leem/escrevem — qualquer módulo pode afetar o comportamento de outro sem
  passar por uma interface explícita (parâmetros/retorno), o que é a própria definição de
  acoplamento alto.
]

== Referências

- Ziviani, N. *Projeto de Algoritmos*, cap. 2.
- Cormen, T. H. et al. *Introduction to Algorithms*, cap. 2 (procedimentos e abstração).
- Sommerville, I. *Software Engineering*, cap. sobre design modular (acoplamento/coesão).
