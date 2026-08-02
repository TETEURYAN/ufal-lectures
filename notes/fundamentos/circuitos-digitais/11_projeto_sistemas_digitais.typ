#import "@preview/mousse-notes:1.1.0": *

= Projeto de Sistemas Digitais: Hierárquico e Modular
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.11]

== Introdução

Sistemas digitais reais (processadores, controladores) são complexos demais para projetar como um único circuito monolítico. Esta subseção trata dos princípios de organização que tornam esse projeto gerenciável: hierarquia e modularidade.

== Definições formais

#definition(name: "Projeto hierárquico", id: "def-projeto-hierarquico")[
  Estratégia *top-down*: o sistema é decomposto em blocos de alto nível, cada um posteriormente decomposto em subblocos progressivamente mais detalhados, até chegar a componentes primitivos (portas, flip-flops). Cada nível de hierarquia esconde os detalhes internos do nível abaixo -- o projetista de um nível superior não precisa conhecer a implementação interna de cada subbloco, apenas sua interface (entradas/saídas e comportamento).
]

#definition(name: "Projeto modular", id: "def-projeto-modular")[
  Complementa o projeto hierárquico: cada bloco é projetado como um *módulo* com interface bem definida e comportamento independente do contexto em que é usado -- permitindo reuso do mesmo módulo em múltiplos pontos do sistema (ou em projetos futuros), teste isolado de cada módulo antes da integração, e substituição de um módulo por outra implementação equivalente sem afetar o restante do sistema.
]

== Exemplo resolvido

#example(name: "Decompondo uma calculadora digital simples", id: "ex-decomposicao-calculadora")[
  Uma calculadora básica pode ser hierarquicamente decomposta em: *unidade de entrada* (decodifica teclas pressionadas), *unidade de controle* (interpreta a sequência de operações, 12), *ULA -- Unidade Lógica e Aritmética* (executa soma/subtração usando os somadores de 05), *registradores* (armazenam operandos e resultado, 10), e *unidade de saída* (converte o resultado binário para exibição decimal, reaproveitando conversão BCD, 01). Cada bloco é projetado e testado separadamente; a ULA, por exemplo, é um *módulo* que poderia ser reutilizado em outro projeto sem modificação, desde que sua interface (operandos de entrada, código de operação, resultado de saída) seja respeitada.
]

== Atenção -- pegadinhas comuns

#remark(name: "Hierarquia é sobre níveis de abstração; modularidade é sobre reuso e interfaces")[
  Os dois conceitos são complementares, mas distintos: um projeto pode ser hierárquico (decomposto em níveis) sem que os blocos sejam necessariamente reutilizáveis em outros contextos (módulos "descartáveis", específicos daquele projeto); a modularidade acrescenta a exigência extra de interfaces bem definidas que permitam reuso genuíno.
]

#remark(name: "Testar módulos isoladamente reduz drasticamente o espaço de busca de erros")[
  Ao testar cada módulo (ex.: a ULA) isoladamente antes da integração, um defeito é isolado a um bloco específico -- testar apenas o sistema completo integrado dificulta enormemente localizar a origem de um comportamento incorreto, especialmente em sistemas grandes.
]

== Questões estilo POSCOMP

*Questão 1.* No projeto hierárquico de um sistema digital, um projetista trabalhando em um nível superior da hierarquia:
- a) Precisa conhecer todos os detalhes internos de cada subbloco.
- b) Só precisa conhecer a interface (entradas/saídas/comportamento) dos subblocos, não sua implementação interna.
- c) Não pode usar nenhum subbloco já projetado.
- d) Deve reprojetar cada subbloco do zero.
- e) Trabalha exclusivamente com portas lógicas primitivas.

*Questão 2.* A principal vantagem do projeto modular, em relação a um projeto monolítico não modular, é:
- a) Sempre reduzir o número total de portas lógicas usadas.
- b) Permitir reuso, teste isolado e substituição de blocos com interface bem definida.
- c) Eliminar completamente a necessidade de simulação.
- d) Tornar o clock do sistema mais rápido automaticamente.
- e) Substituir a necessidade de hierarquia.

*Questão 3.* No exemplo da calculadora digital desta seção, a ULA (Unidade Lógica e Aritmética) é descrita como um módulo porque:
- a) É o único bloco do sistema.
- b) Tem uma interface bem definida que permitiria reutilizá-la em outro projeto sem modificação.
- c) Não pode ser testada isoladamente.
- d) Depende diretamente da unidade de entrada para funcionar.
- e) É sempre implementada com um único flip-flop.

== Gabarito comentado

1. *(b)* -- ocultamento de detalhes internos entre níveis é a essência do projeto hierárquico.
2. *(b)* -- reuso, teste isolado e substituição via interface são as vantagens centrais da modularidade, conforme esta seção.
3. *(b)* -- interface bem definida permitindo reuso é exatamente o critério de modularidade aplicado à ULA no exemplo.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 1, 9 (Metodologia de projeto hierárquico).
- WAKERLY, J. F. *Digital Design: Principles and Practices*. Cap. sobre metodologia de projeto.
