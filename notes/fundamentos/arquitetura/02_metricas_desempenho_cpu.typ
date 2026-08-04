#import "@preview/mousse-notes:1.1.0": *

= Métricas de Desempenho de CPU
#text(size: 9pt, style: "italic")[Edital POSCOMP: 10.1]

== Introdução

Comparar processadores exige métricas precisas, não apenas "frequência de clock" -- um erro de avaliação clássico. Esta subseção fecha o bloco introdutório da disciplina (10.1) formalizando a equação fundamental de desempenho, o papel do CPI e da frequência, e os limites teóricos impostos por otimizações parciais (Lei de Amdahl), todos itens de cálculo direto muito cobrados na POSCOMP.

== Definições formais

#definition(name: "Equação fundamental de desempenho de CPU", id: "def-equacao-desempenho-cpu")[
  O tempo de execução de um programa é dado por:
  $ T_"CPU" = "IC" times "CPI" times T_"ciclo" = ("IC" times "CPI") / f $
  onde $"IC"$ (Instruction Count) é o número de instruções executadas, $"CPI"$ (Cycles Per Instruction) é o número médio de ciclos de clock por instrução, $T_"ciclo"$ é a duração de um ciclo de clock, e $f = 1 \/ T_"ciclo"$ é a frequência de clock.
]

#definition(name: "CPI médio e sua composição", id: "def-cpi-medio")[
  Como instruções diferentes (soma, acesso à memória, desvio) tipicamente exigem números diferentes de ciclos, o $"CPI"$ efetivo de um programa é uma média ponderada pela frequência relativa de cada tipo de instrução:
  $ "CPI" = sum_i ("IC"_i / "IC") times "CPI"_i $
  onde $"IC"_i$ é o número de instruções do tipo $i$ executadas e $"CPI"_i$ é o número de ciclos que cada instrução desse tipo consome.
]

#definition(name: "MIPS (Millions of Instructions Per Second)", id: "def-mips")[
  $ "MIPS" = "IC" / (T_"CPU" times 10^6) = f / ("CPI" times 10^6) $
  Mede a taxa de execução de instruções por segundo, em milhões. É uma métrica historicamente popular, mas com limitações importantes (ver observação abaixo).
]

== Propriedade relevante

#theorem(name: "Lei de Amdahl", id: "thm-lei-amdahl")[
  Se uma fração $f$ do tempo de execução original de um programa pode ser acelerada por um fator $s$ (permanecendo o restante $(1-f)$ inalterado), o speedup (aceleração) global obtido é limitado por:
  $ "Speedup" = 1 / ((1-f) + f/s) $
  Quando $s -> infinity$ (a parte otimizada leva tempo zero), o speedup máximo possível tende a $1 \/ (1-f)$ -- limitado pela fração *não* otimizada, não importa quão rápida a parte otimizada se torne.
]

#proof[
  Sejam $T$ o tempo de execução original e $f dot T$ a parcela dele afetada pela melhoria. Após a melhoria, essa parcela passa a levar $(f dot T) \/ s$, enquanto a parcela não afetada continua levando $(1-f) dot T$. O novo tempo total é $T' = (1-f) dot T + (f dot T)/s = T [(1-f) + f/s]$. O speedup é $T \/ T' = 1 \/ [(1-f)+f/s]$, como enunciado.
]

== Exemplo resolvido

#example(name: "Calculando tempo de execução, CPI e MIPS", id: "ex-calculo-desempenho")[
  Duas CPUs implementam a mesma ISA e executam o mesmo programa, com $"IC" = 10^9$ instruções.

  *CPU A*: $f = 3 "GHz"$, $"CPI" = 1.5$. Tempo de execução:
  $ T_A = ("IC" times "CPI")/f = (10^9 times 1.5)/(3 times 10^9) = 0.5 "s" $
  $ "MIPS"_A = f/("CPI" times 10^6) = (3 times 10^9)/(1.5 times 10^6) = 2000 $

  *CPU B*: $f = 4 "GHz"$, $"CPI" = 2.4$. Tempo de execução:
  $ T_B = (10^9 times 2.4)/(4 times 10^9) = 0.6 "s" $
  $ "MIPS"_B = (4 times 10^9)/(2.4 times 10^6) approx 1666.7 $

  Mesmo com clock 33% maior, a CPU B é mais lenta ($T_B > T_A$) porque seu CPI é proporcionalmente ainda maior -- confirmando que frequência de clock isolada não determina desempenho.
]

#example(name: "Aplicando a Lei de Amdahl", id: "ex-lei-amdahl-aplicada")[
  Um programa gasta 40% do seu tempo em uma rotina que pode ser otimizada para rodar 5 vezes mais rápida. Qual o speedup global máximo?

  $ "Speedup" = 1/((1-0.4) + 0.4/5) = 1/(0.6+0.08) = 1/0.68 approx 1.47 $

  Mesmo multiplicando por 5 a velocidade de 40% do programa, o ganho global fica limitado a cerca de $1.47 times$ -- porque os 60% restantes do tempo permanecem inalterados e dominam o resultado.
]

== Atenção -- pegadinhas comuns

#remark(name: "MIPS não permite comparar arquiteturas com ISAs diferentes")[
  MIPS mede instruções por segundo, mas instruções de ISAs diferentes (ex.: RISC vs. CISC, 09) realizam quantidades de trabalho muito diferentes por instrução -- um processador CISC pode executar menos instruções (cada uma mais "poderosa") para o mesmo programa. Comparar MIPS entre arquiteturas distintas pode favorecer injustamente quem tem instruções mais simples e numerosas, mesmo com tempo de execução total pior.
]

#remark(name: "Clock mais alto não implica CPU mais rápida")[
  Como no exemplo desta seção, uma frequência de clock maior pode ser anulada (ou revertida) por um CPI maior -- o que realmente determina o desempenho é o produto $"CPI" times T_"ciclo"$, não cada fator isoladamente. Comparar processadores só pela frequência anunciada é um erro clássico de interpretação.
]

#remark(name: "O speedup de Amdahl é limitado pela fração NÃO otimizada")[
  Um erro recorrente é assumir que otimizar infinitamente uma parte do sistema aproxima o speedup de infinito -- na verdade, o limite superior do speedup é $1\/(1-f)$, determinado inteiramente pela fração que permanece sem otimização. Investir esforço além de certo ponto em uma parte já pequena do problema tem retorno decrescente.
]

== Questões estilo POSCOMP

*Questão 1.* Um programa executa $2 times 10^9$ instruções em uma CPU com CPI médio igual a 2 e frequência de clock de 4 GHz. O tempo de execução é:
- a) $0.5$ s.
- b) $1$ s.
- c) $2$ s.
- d) $4$ s.
- e) $8$ s.

*Questão 2.* Se 25% do tempo de execução de um programa pode ser tornado infinitamente rápido (tempo zero), o speedup máximo possível, segundo a Lei de Amdahl, é:
- a) $1.25$.
- b) $1.33$.
- c) $2$.
- d) $4$.
- e) Infinito.

*Questão 3.* A métrica MIPS é considerada limitada para comparar processadores de ISAs diferentes principalmente porque:
- a) Não pode ser calculada a partir da frequência de clock.
- b) Instruções de ISAs diferentes realizam quantidades de trabalho distintas, tornando a contagem bruta de instruções pouco comparável.
- c) Só se aplica a processadores com pipeline.
- d) É uma medida exclusiva de memória, não de CPU.
- e) Não depende do CPI.

== Gabarito comentado

1. *(b)* -- $T = ("IC" times "CPI")/f = (2 times 10^9 times 2)/(4 times 10^9) = 1$ s.
2. *(b)* -- pela Lei de Amdahl com $s -> infinity$: "Speedup" $= 1/(1-f) = 1/(1-0.25) = 1/0.75 approx 1.33$.
3. *(b)* -- MIPS conta instruções executadas, mas não normaliza pela quantidade de trabalho que cada instrução realiza, variável entre ISAs (ver observação desta seção).

== Referências

- STALLINGS, W. *Arquitetura e Organização de Computadores*. Cap. 2 (Desempenho de computadores).
- PATTERSON, D.; HENNESSY, J. *Computer Organization and Design*. Cap. 1 (Medindo desempenho e Lei de Amdahl).
- HENNESSY, J.; PATTERSON, D. *Computer Architecture: A Quantitative Approach*. Cap. 1.
