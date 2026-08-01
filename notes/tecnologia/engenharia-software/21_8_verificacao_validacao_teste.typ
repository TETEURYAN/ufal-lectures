#import "@preview/mousse-notes:1.1.0": *

= 21.8 --- Verificação, Validação e Teste

== Introdução

Verificação e Validação (V&V) são os dois lados da pergunta "o software está correto?", e teste é a principal técnica *dinâmica* para responder a essa pergunta. É a subseção com as pegadinhas conceituais mais cobradas de toda a disciplina na POSCOMP.

== Definições formais

#definition(name: "Verificação vs. Validação", id: "def-verificacao-validacao")[
  - *Verificação*: "Estamos construindo o produto *corretamente*?" -- checa se o software está em conformidade com sua *especificação* (ex.: o código implementa exatamente o que o documento de projeto descreve).
  - *Validação*: "Estamos construindo o produto *certo*?" -- checa se o software atende às *necessidades reais* do cliente/usuário, que podem divergir da especificação (uma especificação pode estar mal formulada, mas o sistema pode estar 100% em conformidade com ela).
]

#definition(name: "Níveis de teste", id: "def-niveis-teste")[
  - *Teste unitário*: verifica a menor unidade testável isoladamente (função, método, classe).
  - *Teste de integração*: verifica a interação correta entre unidades/módulos já testados individualmente.
  - *Teste de sistema*: verifica o sistema completo integrado, contra os requisitos funcionais e não-funcionais.
  - *Teste de aceitação*: realizado (ou validado) pelo cliente/usuário final, para confirmar que o sistema atende à necessidade real -- ligado diretamente ao conceito de *validação*.
]

#definition(name: "Técnicas de teste: caixa branca, caixa preta e caixa cinza", id: "def-tecnicas-teste")[
  - *Caixa branca (estrutural)*: os casos de teste são derivados observando a *estrutura interna* do código (ex.: cobertura de caminhos, ramos, condições).
  - *Caixa preta (funcional)*: os casos de teste são derivados apenas da *especificação externa* (entradas/saídas esperadas), sem olhar a implementação interna.
  - *Caixa cinza*: combina elementos de ambas -- conhecimento parcial da estrutura interna é usado para orientar testes primariamente funcionais.
]

== Estrutura visual: pirâmide de testes

#figure(
  image("figures/testing-pyramid.svg", width: 55%),
  caption: [Pirâmide de testes: muitos testes unitários (rápidos, baratos) na base, poucos testes de ponta a ponta (lentos, caros) no topo. Fonte: Wikimedia Commons, CC BY-SA 4.0 (Abbe98).],
)

== Exemplo resolvido

#example(name: "Verificação vs. validação em um cenário real", id: "ex-verificacao-validacao-cenario")[
  Um sistema de cálculo de impostos foi especificado para arredondar valores para baixo (truncamento). O código implementa exatamente esse truncamento, conforme especificado -- passa em todos os testes de *verificação* (está de acordo com a especificação). Porém, ao apresentar o sistema, o cliente informa que a regra fiscal real exige arredondamento matemático padrão, não truncamento -- a especificação original estava errada. O sistema falha na *validação*: não atende à necessidade real, mesmo estando perfeitamente verificado contra uma especificação incorreta.
]

== Atenção -- pegadinhas comuns

#remark(name: "\"Correto conforme a especificação\" não é o mesmo que \"correto para o usuário\"")[
  O exemplo desta seção ilustra a pegadinha mais clássica: um sistema pode passar em 100% dos testes de verificação e ainda assim não ser o que o cliente precisa -- daí a necessidade de validação como uma atividade distinta e complementar.
]

#remark(name: "Teste não prova ausência de defeitos")[
  Segundo Dijkstra, "testes podem mostrar a presença de defeitos, mas nunca sua ausência" -- passar em todos os casos de teste executados não garante que não existam defeitos em cenários não cobertos pelos testes.
]

#remark(name: "Caixa branca não é sinônimo de teste unitário")[
  Um erro comum é tratar "caixa branca" e "teste unitário" como a mesma coisa. São dimensões independentes: pode-se aplicar técnica de caixa branca em teste de integração (analisando a estrutura da interação entre módulos), assim como técnica de caixa preta em teste unitário (testando uma função apenas por sua interface, sem olhar sua implementação).
]

== Questões estilo POSCOMP

*Questão 1.* A pergunta "Estamos construindo o produto certo?" está associada ao conceito de:
- a) Verificação.
- b) Validação.
- c) Teste de integração.
- d) Gerenciamento de configuração.
- e) Manutenção corretiva.

*Questão 2.* Um teste que verifica a interação correta entre módulos que já passaram individualmente por seus próprios testes é classificado como teste de:
- a) Unidade.
- b) Integração.
- c) Sistema.
- d) Aceitação.
- e) Regressão exclusivamente.

*Questão 3.* Derivar casos de teste exclusivamente a partir da especificação de entradas e saídas esperadas, sem examinar o código-fonte internamente, caracteriza a técnica de:
- a) Caixa branca.
- b) Caixa cinza.
- c) Caixa preta.
- d) Teste estrutural.
- e) Cobertura de caminhos.

*Questão 4.* Um sistema passa em todos os testes de verificação (está de acordo com sua especificação), mas o cliente rejeita o sistema por não atender à sua necessidade real. Esse cenário ilustra que:
- a) Verificação e validação são sempre equivalentes.
- b) A especificação em si pode estar incorreta, e verificação não garante validação.
- c) O sistema necessariamente tem defeitos de implementação.
- d) O problema só pode ser resolvido com mais testes de unidade.
- e) Validação é um subconjunto de verificação.

== Gabarito comentado

1. *(b)* -- "produto certo" é exatamente a pergunta de validação; "produto correto" (conforme especificação) é verificação.
2. *(b)* -- por definição, teste de integração foca na interação entre módulos já testados individualmente.
3. *(c)* -- basear-se apenas na especificação externa, sem examinar a estrutura interna, é a definição de caixa preta.
4. *(b)* -- é exatamente o ponto do exemplo desta seção: verificação correta contra uma especificação errada não garante validação.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 8--9 (Teste de software e V&V).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 19--20 (Estratégias e técnicas de teste).
- DIJKSTRA, E. W. *Notes on Structured Programming* (1970) -- origem da citação sobre testes e ausência de defeitos.
