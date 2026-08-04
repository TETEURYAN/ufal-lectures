#import "@preview/mousse-notes:1.1.0": *

= Arquiteturas RISC e CISC
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.8]

== Introdução

RISC e CISC são duas filosofias opostas de projeto de conjunto de instruções (04), cada uma otimizando um compromisso diferente entre simplicidade de hardware, densidade de código e facilidade de pipelining (10). É um dos temas mais comparativos da disciplina -- a POSCOMP frequentemente pede para classificar características específicas como pertencentes a um ou outro paradigma.

== Definições formais

#definition(name: "CISC (Complex Instruction Set Computer)", id: "def-cisc")[
  Filosofia de projeto que favorece um conjunto de instruções *rico e complexo*: instruções de comprimento variável, muitos modos de endereçamento (04), e instruções que podem operar diretamente sobre operandos em memória (não apenas em registradores), executando em múltiplos ciclos de clock cada. O objetivo histórico era reduzir o número de instruções por programa e a distância semântica entre linguagens de alto nível e linguagem de máquina, num contexto em que memória era cara e compiladores, pouco sofisticados. Exemplo canônico: a família x86.
]

#definition(name: "RISC (Reduced Instruction Set Computer)", id: "def-risc")[
  Filosofia de projeto que favorece um conjunto de instruções *pequeno e simples*: instruções de comprimento fixo, poucos modos de endereçamento, e arquitetura *load-store* (apenas instruções `LOAD`/`STORE` acessam memória; instruções aritméticas operam exclusivamente sobre registradores). Um grande banco de registradores reduz a necessidade de acessos à memória. O objetivo é simplificar o hardware e viabilizar pipelines eficientes (10), delegando ao compilador mais responsabilidade por gerar sequências eficientes de instruções simples. Exemplos: ARM, MIPS, RISC-V.
]

== Propriedade relevante

#theorem(name: "Trade-off central entre RISC e CISC", id: "thm-trade-off-risc-cisc")[
  Para um mesmo programa-fonte, uma implementação CISC tende a gerar *menos instruções*, cada uma mais "poderosa" e ocupando (em geral) mais ciclos e espaço de codificação variável; uma implementação RISC tende a gerar *mais instruções*, cada uma simples e uniforme, adequada a um pipeline profundo e regular. Nenhuma das duas é estritamente superior em desempenho bruto -- a equação fundamental (02), $T = "IC" times "CPI" times T_"ciclo"$, mostra que CISC busca reduzir $"IC"$ à custa de $"CPI"$ maior por instrução, enquanto RISC busca o oposto.
]

== Exemplo resolvido

#example(name: "Somar um valor da memória a um registrador: CISC vs. RISC", id: "ex-cisc-risc-soma-memoria")[
  Operação: somar o conteúdo da posição de memória `endereco` ao registrador `R1`.

  *Estilo CISC* (instrução única, com operando em memória):
  ```
  ADD R1, [endereco]
  ```
  Uma única instrução, mas que internamente realiza um acesso à memória *e* uma soma -- tipicamente consumindo mais de um ciclo de clock.

  *Estilo RISC* (load-store, dois passos explícitos):
  ```
  LOAD R2, endereco   ; R2 <- memória[endereco]
  ADD  R1, R1, R2     ; R1 <- R1 + R2
  ```
  Duas instruções simples, cada uma tipicamente concluída em um ciclo (ou etapa de pipeline) -- nenhuma instrução aritmética acessa memória diretamente, coerente com a arquitetura load-store.
]

== Atenção -- pegadinhas comuns

#remark(name: "Processadores x86 modernos são CISC na ISA, mas RISC na microarquitetura interna")[
  Um erro comum é achar que a distinção RISC/CISC é absoluta e imutável: processadores x86 atuais expõem uma ISA CISC (compatibilidade histórica), mas internamente *traduzem* cada instrução CISC complexa em uma ou mais micro-operações simples, do estilo RISC, antes de executá-las em um pipeline interno -- ilustrando novamente a separação entre ISA e microarquitetura (01).
]

#remark(name: "\"Poucas instruções\" não é a definição central de RISC -- \"instruções simples e uniformes\" é")[
  O nome "Reduced" se refere à *complexidade* de cada instrução e à uniformidade do formato, não necessariamente ao tamanho total do conjunto de instruções em número absoluto -- ISAs RISC modernas (ex.: ARM com extensões) podem ter um número considerável de instruções, desde que mantenham simplicidade e regularidade de formato/execução.
]

#remark(name: "RISC não elimina modos de endereçamento -- apenas os restringe")[
  RISC não abole os modos de endereçamento vistos em 04, mas os restringe a poucos e simples (tipicamente registrador, imediato e base+deslocamento), reservando modos mais complexos (indexado com múltiplos níveis de indireção, por exemplo) para arquiteturas CISC.
]

== Questões estilo POSCOMP

*Questão 1.* Uma característica típica de arquiteturas RISC é:
- a) Instruções de comprimento variável e muitos modos de endereçamento complexos.
- b) Arquitetura load-store, em que apenas instruções específicas acessam a memória.
- c) Instruções aritméticas que sempre operam diretamente sobre operandos em memória.
- d) Ausência total de registradores de propósito geral.
- e) Dependência exclusiva de microcódigo para toda e qualquer instrução.

*Questão 2.* Em relação a processadores x86 modernos, é correto afirmar que:
- a) São puramente RISC tanto na ISA quanto na microarquitetura.
- b) Expõem uma ISA CISC, mas internamente traduzem instruções complexas em micro-operações simples, de estilo RISC.
- c) Não possuem pipeline, por serem CISC.
- d) Não podem executar mais de uma instrução por ciclo, sob nenhuma circunstância.
- e) Abandonaram completamente a compatibilidade com instruções CISC antigas.

*Questão 3.* Segundo o trade-off central entre RISC e CISC, uma implementação CISC tende a:
- a) Gerar mais instruções por programa, cada uma mais simples.
- b) Gerar menos instruções por programa, cada uma potencialmente mais custosa em ciclos.
- c) Eliminar completamente a necessidade de um compilador.
- d) Ser sempre mais rápida que qualquer implementação RISC equivalente.
- e) Não ter relação alguma com o CPI médio do programa.

== Gabarito comentado

1. *(b)* -- arquitetura load-store é a característica definidora de RISC apresentada nesta seção.
2. *(b)* -- exatamente a observação desta seção sobre a tradução interna de instruções CISC em micro-operações RISC.
3. *(b)* -- CISC busca reduzir o número de instruções (IC), tipicamente às custas de um CPI médio maior por instrução, conforme o teorema desta seção.

== Referências

- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. sobre computadores com conjunto de instruções reduzido.
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. 2, 4.
- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Cap. 1.
