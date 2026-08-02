#import "@preview/mousse-notes:1.1.0": *

= 21.4 --- Técnicas de Planejamento e Gerenciamento de Software

== Introdução

Planejar um projeto de software exige estimar esforço, prazo e custo *antes* de o sistema existir -- uma das tarefas mais propensas a erro em Engenharia de Software. A POSCOMP cobra o reconhecimento conceitual das principais técnicas de estimativa, sem exigir cálculos elaborados.

== Definições formais

#definition(name: "Análise de Pontos de Função (APF)", id: "def-pontos-funcao")[
  Técnica de estimativa baseada na *funcionalidade* percebida pelo usuário, independente da linguagem de implementação. Conta-se o número de: entradas externas, saídas externas, consultas externas, arquivos lógicos internos e arquivos de interface externa, cada um ponderado por complexidade (simples/média/complexa), somando-se para obter os *Pontos de Função Não Ajustados (PFNA)*; um *fator de ajuste* baseado em características técnicas do sistema (ex.: desempenho, concorrência) refina o valor final.
]

#definition(name: "COCOMO (Constructive Cost Model)", id: "def-cocomo")[
  Modelo *paramétrico* de estimativa de esforço a partir do tamanho estimado do software em milhares de linhas de código (KLOC). Na versão básica:
  $ E = a dot ("KLOC")^b $
  onde $E$ é o esforço em pessoas-mês, e $a, b$ são constantes que dependem do modo do projeto -- *orgânico* (equipe pequena, experiente, requisitos flexíveis; $a=2.4$, $b=1.05$), *semidestacado* (intermediário) ou *embutido* (grande, restrições rígidas; maiores $a,b$).
]

#definition(name: "Estrutura Analítica do Projeto (WBS/EAP)", id: "def-wbs")[
  Decomposição hierárquica do trabalho do projeto em pacotes de trabalho progressivamente menores e mais gerenciáveis, usada como base para estimar esforço, alocar recursos e construir cronogramas (ex.: gráficos de Gantt).
]

== Exemplo resolvido

#example(name: "Estimativa de esforço com COCOMO básico", id: "ex-cocomo-basico")[
  Um projeto orgânico ($a=2.4$, $b=1.05$) tem tamanho estimado de $50$ KLOC. O esforço estimado é:
  $ E = 2.4 times 50^1.05 approx 2.4 times 60.8 approx 146 " pessoas-mês" $
  Se a equipe planejada for de $6$ pessoas trabalhando em paralelo, o prazo estimado seria aproximadamente $146\/6 approx 24$ meses -- um valor grosseiro, que na prática ainda seria ajustado por outros fatores (COCOMO intermediário/detalhado consideram atributos adicionais, como experiência da equipe e confiabilidade exigida).
]

== Atenção -- pegadinhas comuns

#remark(name: "Pontos de Função medem funcionalidade, não linhas de código")[
  Diferente do COCOMO (que parte do tamanho em KLOC, dependente de linguagem), Pontos de Função são estimados a partir de requisitos funcionais, *antes* de decidir a linguagem de implementação -- por isso são úteis para comparar produtividade entre projetos em linguagens diferentes.
]

#remark(name: "Estimativas são feitas cedo, quando a incerteza é maior")[
  Um erro comum de interpretação é achar que uma estimativa inicial deveria ser exata. Na prática, estimativas de esforço/custo são refinadas ao longo do projeto à medida que mais informação fica disponível -- a estimativa inicial serve para planejamento, não como compromisso rígido e definitivo.
]

== Questões estilo POSCOMP

*Questão 1.* A técnica de estimativa que mede o esforço com base na funcionalidade percebida pelo usuário, independentemente da linguagem de programação usada, é:
- a) COCOMO básico.
- b) Análise de Pontos de Função.
- c) Gráfico de Gantt.
- d) Estrutura Analítica do Projeto.
- e) Modelo em Cascata.

*Questão 2.* No modelo COCOMO básico, a fórmula $E = a dot ("KLOC")^b$ estima:
- a) O número de pontos de função do sistema.
- b) O esforço de desenvolvimento em pessoas-mês, a partir do tamanho estimado do código.
- c) O número de defeitos esperados no sistema.
- d) O prazo exato do projeto, sem necessidade de considerar o tamanho da equipe.
- e) A quantidade de testes necessários.

*Questão 3.* Uma Estrutura Analítica do Projeto (WBS/EAP) tem como principal função:
- a) Substituir completamente a necessidade de estimativa de esforço.
- b) Decompor hierarquicamente o trabalho em pacotes gerenciáveis, servindo de base para estimativas e cronogramas.
- c) Medir exclusivamente a qualidade do produto final.
- d) Ser usada apenas em projetos que seguem o modelo em cascata.
- e) Calcular automaticamente o custo total do projeto sem intervenção humana.

== Gabarito comentado

1. *(b)* -- Pontos de Função são independentes de linguagem/tecnologia, baseados em funcionalidade percebida.
2. *(b)* -- é exatamente a definição da fórmula do COCOMO básico desta seção.
3. *(b)* -- WBS/EAP decompõe o trabalho hierarquicamente, servindo de base para estimativas e cronograma.

== Referências

- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 23 (Estimativas de projeto de software).
- SOMMERVILLE, I. *Engenharia de Software*. Cap. 22--23 (Gerência de projetos e estimativas).
- BOEHM, B. *Software Engineering Economics* (1981) -- referência original do COCOMO.
