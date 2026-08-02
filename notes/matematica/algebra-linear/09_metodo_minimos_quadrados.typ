#import "@preview/mousse-notes:1.1.0": *

= Método dos Mínimos Quadrados
#text(size: 9pt, style: "italic")[Edital POSCOMP: 1.14]

== Introdução

Quando um sistema linear $A x = b$ não tem solução exata (mais equações que incógnitas, dados com ruído), mínimos quadrados encontra a *melhor aproximação* possível -- a base matemática por trás de ajuste de retas/curvas a dados, incluindo a Regressão Linear tratada em Probabilidade e Estatística, subtópico 7.14.

== Definições formais

#definition(name: "Sistema sobredeterminado e mínimos quadrados", id: "def-minimos-quadrados")[
  Um sistema $A x = b$ com mais equações que incógnitas (mais linhas que colunas em $A$) é *sobredeterminado* e tipicamente não tem solução exata. O método dos mínimos quadrados encontra $hat(x)$ que *minimiza* $norm(A x - b)^2$ (a soma dos quadrados dos resíduos). A solução é obtida resolvendo as *equações normais*:
  $ A^T A hat(x) = A^T b $
  que sempre têm solução (e solução única, se as colunas de $A$ forem linearmente independentes).
]

== Exemplo resolvido

#example(name: "Ajustando uma reta por mínimos quadrados", id: "ex-ajuste-reta-minimos-quadrados")[
  Ajustar uma reta $y = b_0 + b_1 x$ aos pontos $(0,6), (1,0), (2,0)$ (sistema sobredeterminado: 3 equações, 2 incógnitas).

  $ A = mat(delim: "[", 1, 0; 1, 1; 1, 2), quad b = vec(6,0,0) $

  $ A^T A = mat(3,3;3,5), quad quad A^T b = vec(6,0) $

  Resolvendo $mat(3,3;3,5) vec(b_0,b_1) = vec(6,0)$: da primeira equação, $3b_0+3b_1=6 arrow.r.double b_0+b_1=2$. Subtraindo $3 times$ essa equação da segunda: $2b_1 = 0-6=-6 arrow.r.double b_1=-3$; logo $b_0 = 2-(-3)=5$.

  Reta ajustada: $y = 5 - 3x$. Resíduos: em $x{=}0$, previsto $5$ (real $6$, resíduo $1$); em $x{=}1$, previsto $2$ (real $0$, resíduo $-2$); em $x{=}2$, previsto $-1$ (real $0$, resíduo $1$) -- soma dos resíduos $= 1-2+1=0$ (propriedade esperada de mínimos quadrados com intercepto), soma dos quadrados $=1+4+1=6$, o menor valor possível para qualquer reta.

  #figure(
    image("figures/least-squares.svg", width: 50%),
    caption: [Ajuste por mínimos quadrados: a reta escolhida minimiza a soma dos quadrados das distâncias verticais (resíduos) aos pontos observados. Fonte: Wikimedia Commons, domínio público (Oleg Alexandrov).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "Mínimos quadrados minimiza resíduos verticais ao quadrado, não a distância perpendicular")[
  A quantidade minimizada é a soma dos quadrados das diferenças verticais ($y$ observado menos $y$ previsto), não a distância perpendicular à reta -- uma distinção sutil, mas que faz diferença em problemas onde ambos os eixos têm erro (mínimos quadrados totais, fora do escopo padrão desta seção).
]

#remark(name: "Equações normais sempre têm solução, mesmo quando o sistema original não tem")[
  $A x = b$ sobredeterminado tipicamente não tem solução exata -- mas $A^T A hat(x) = A^T b$ (as equações normais) sempre tem, pois $A^T A$ é uma matriz quadrada bem comportada (se as colunas de $A$ são linearmente independentes, $A^T A$ é invertível). É esse "truque" algébrico que transforma um problema sem solução exata em um problema de aproximação ótima bem definido.
]

== Questões estilo POSCOMP

*Questão 1.* O método dos mínimos quadrados busca minimizar:
- a) $norm(A x - b)$ (a norma, não o quadrado).
- b) $norm(A x - b)^2$, a soma dos quadrados dos resíduos.
- c) $det(A)$.
- d) O número de equações do sistema.
- e) A distância entre as colunas de $A$.

*Questão 2.* As equações normais do método dos mínimos quadrados são dadas por:
- a) $A x = b$.
- b) $A^T A hat(x) = A^T b$.
- c) $A hat(x) = A^T b$.
- d) $hat(x) = A^(-1) b$ diretamente.
- e) $A A^T hat(x) = b$.

*Questão 3.* No exemplo desta seção, a soma dos resíduos da reta ajustada aos pontos dados é:
- a) $6$.
- b) $-6$.
- c) $0$.
- d) $3$.
- e) Não pode ser calculada sem mais dados.

== Gabarito comentado

1. *(b)* -- definição direta do critério de mínimos quadrados.
2. *(b)* -- definição direta das equações normais desta seção.
3. *(c)* -- soma dos resíduos $1+(-2)+1=0$, calculada explicitamente no exemplo desta seção (propriedade geral de mínimos quadrados com termo de intercepto).

== Referências

- STRANG, G. *Introduction to Linear Algebra*. Cap. 4 (Mínimos quadrados e projeções).
- LAY, D. C. *Álgebra Linear e suas Aplicações*. Cap. 6.
- Probabilidade e Estatística (7.14, Regressão e Correlação) -- aplicação estatística do mesmo método.
