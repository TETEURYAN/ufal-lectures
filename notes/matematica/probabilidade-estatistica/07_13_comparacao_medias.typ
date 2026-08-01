#import "@preview/mousse-notes:1.1.0": *

= 7.13 --- Testes de Comparações de Médias

== Introdução

O teste Z/t de 7.12 compara uma média a um valor fixo. Aqui a comparação é entre *duas ou mais* médias -- de dois grupos independentes, de medidas pareadas (antes/depois), ou de vários grupos simultaneamente (ANOVA). Reconhecer qual desenho experimental está descrito no enunciado é o que a POSCOMP mais testa neste tópico.

== Definições formais

#definition(name: "Teste t para duas amostras independentes", id: "def-teste-t-independentes")[
  Compara as médias de dois grupos *independentes* (ex.: tratamento vs. controle, sujeitos diferentes em cada grupo). Assumindo variâncias populacionais desconhecidas mas iguais, a estatística de teste (com $n_1+n_2-2$ graus de liberdade) é:
  $ t = (macron(X)_1 - macron(X)_2)/(s_p sqrt(1/n_1 + 1/n_2)) $
  onde $s_p$ é o desvio-padrão *combinado (pooled)* das duas amostras.
]

#definition(name: "Teste t pareado", id: "def-teste-t-pareado")[
  Compara duas medidas tomadas *no mesmo sujeito/unidade* (ex.: antes e depois de um tratamento). Reduz-se a um teste t de *uma* amostra sobre as diferenças $D_i = X_(1i) - X_(2i)$:
  $ t = macron(D)/(s_D\/sqrt(n)) $
  com $n-1$ graus de liberdade, onde $macron(D)$ e $s_D$ são a média e o desvio-padrão amostral das diferenças.
]

#definition(name: "ANOVA (Análise de Variância) de um fator", id: "def-anova")[
  Generaliza a comparação para $k >= 3$ grupos, testando $H_0: mu_1 = mu_2 = dots = mu_k$ de uma vez (em vez de múltiplos testes t par a par, o que infla o erro tipo I). A estatística $F$ compara a variância *entre* grupos com a variância *dentro* dos grupos:
  $ F = ("variabilidade entre grupos")/("variabilidade dentro dos grupos") $
  Um $F$ grande sugere que ao menos uma média difere das demais -- mas a ANOVA sozinha não indica *qual* par difere (exige testes post-hoc, ex.: Tukey).
]

== Exemplo resolvido

#example(name: "Escolhendo entre teste pareado e independente", id: "ex-pareado-vs-independente")[
  - *Cenário A*: comparar o desempenho médio dos mesmos 30 alunos em uma prova antes e depois de um curso preparatório. São *as mesmas pessoas* medidas duas vezes $arrow.r$ *teste t pareado* sobre as diferenças (nota depois -- nota antes).
  - *Cenário B*: comparar a nota média de uma turma de 30 alunos que fez o curso com a nota média de outra turma de 30 alunos que não fez. São *grupos diferentes* de sujeitos $arrow.r$ *teste t para duas amostras independentes*.

  O erro mais comum é tratar o Cenário A como se fosse independente, ignorando que as medidas estão correlacionadas (mesmo sujeito) -- isso costuma superestimar a variabilidade e reduzir indevidamente o poder do teste.
]

== Atenção -- pegadinhas comuns

#remark(name: "Por que não fazer vários testes t em vez de uma ANOVA?")[
  Comparar $k=5$ grupos com testes t par a par exigiria $binom(5,2)=10$ testes; cada um com 5% de chance de erro tipo I, a chance de pelo menos um falso positivo entre os 10 testes é bem maior que 5%. A ANOVA testa a igualdade de todas as médias em um único teste, controlando o erro tipo I global.
]

#remark(name: "ANOVA significativa não diz qual grupo difere")[
  Rejeitar $H_0$ na ANOVA ($F$ grande, valor-p $< alpha$) indica que *pelo menos um* par de médias difere -- não especifica qual. Para identificar os pares, são necessários testes post-hoc (ex.: Tukey HSD), fora do escopo detalhado desta subseção mas frequentemente citados em prova como o próximo passo correto.
]

== Questões estilo POSCOMP

*Questão 1.* Para comparar a pressão arterial dos mesmos pacientes antes e depois da administração de um medicamento, o teste estatístico apropriado é:
- a) Teste t para duas amostras independentes.
- b) Teste t pareado.
- c) ANOVA de um fator.
- d) Teste Qui-Quadrado de independência.
- e) Teste Z para uma proporção.

*Questão 2.* A principal vantagem de usar ANOVA em vez de múltiplos testes t par a par para comparar $k>2$ grupos é:
- a) A ANOVA elimina a necessidade de qualquer nível de significância.
- b) A ANOVA controla o erro tipo I global, em vez de inflá-lo com múltiplas comparações.
- c) A ANOVA sempre identifica exatamente qual par de médias difere.
- d) A ANOVA dispensa a suposição de independência entre grupos.
- e) A ANOVA só pode ser usada quando $k=2$.

*Questão 3.* Ao rejeitar $H_0$ em uma ANOVA de um fator com 4 grupos, é correto concluir que:
- a) Todas as médias são diferentes entre si.
- b) Nenhuma das médias é igual à média geral.
- c) Pelo menos uma média difere das demais, mas ainda não se sabe qual.
- d) O teste é inconclusivo.
- e) É necessário refazer a coleta de dados.

== Gabarito comentado

1. *(b)* -- mesmos pacientes medidos duas vezes é o cenário clássico de teste t pareado.
2. *(b)* -- a ANOVA evita a inflação do erro tipo I que ocorreria com múltiplos testes t par a par.
3. *(c)* -- ANOVA significativa indica heterogeneidade entre as médias, sem apontar qual par difere.

== Referências

- BUSSAB, W. O.; MORETTIN, P. A. *Estatística Básica*. Cap. 13 (Comparação de médias e ANOVA).
- TRIOLA, M. F. *Introdução à Estatística*. Cap. 9--10.
- MONTGOMERY, D. C.; RUNGER, G. C. *Estatística Aplicada e Probabilidade para Engenheiros*. Cap. 10--13.
