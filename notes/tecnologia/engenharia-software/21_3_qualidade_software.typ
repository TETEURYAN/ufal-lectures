#import "@preview/mousse-notes:1.1.0": *

= 21.3 --- Qualidade de Software

== Introdução

Qualidade de software vai além de "funciona sem bugs": é um conjunto de características mensuráveis, e a forma como a organização produz software (o processo) também tem seu próprio nível de qualidade, avaliado separadamente do produto. A POSCOMP explora ambas as dimensões.

== Definições formais

#definition(name: "Qualidade de produto vs. qualidade de processo", id: "def-qualidade-produto-processo")[
  - *Qualidade de produto*: características do software entregue (confiabilidade, usabilidade, desempenho...).
  - *Qualidade de processo*: o quão bem definido, controlado e repetível é o processo usado para produzir o software -- a premissa (nem sempre garantida, mas fortemente correlacionada) é que um processo de melhor qualidade tende a produzir produtos de melhor qualidade.
]

#definition(name: "Características de qualidade (ISO/IEC 25010)", id: "def-caracteristicas-qualidade")[
  Modelo de qualidade de produto de software, sucessor da norma ISO/IEC 9126, organizado em características como:
  - *Adequação funcional*: o software realiza as funções especificadas.
  - *Confiabilidade*: mantém um nível de desempenho sob condições estabelecidas por um tempo determinado.
  - *Usabilidade*: facilidade de uso e aprendizado pelo usuário.
  - *Eficiência de desempenho*: uso adequado de recursos (tempo, memória) para o nível de desempenho exigido.
  - *Manutenibilidade*: facilidade de modificar o software (corrigir, adaptar, estender).
  - *Portabilidade*: facilidade de transferir o software para outros ambientes.
]

#definition(name: "CMMI (Capability Maturity Model Integration)", id: "def-cmmi")[
  Modelo de avaliação e melhoria da *maturidade do processo* de uma organização, com níveis crescentes (do processo *inicial/ad-hoc*, imprevisível, até o *processo em otimização*, com melhoria contínua baseada em métricas quantitativas). Quanto mais alto o nível, mais definido, medido e controlado é o processo da organização -- não avalia diretamente um produto específico, mas a capacidade organizacional de produzir software com qualidade de forma consistente.
]

== Exemplo resolvido

#example(name: "Classificando um requisito de qualidade", id: "ex-classificar-requisito-qualidade")[
  Um sistema bancário precisa "processar 10.000 transações por segundo sem degradação perceptível de tempo de resposta" -- essa exigência se enquadra em *eficiência de desempenho*. Já a exigência "o sistema deve continuar operando corretamente mesmo após 720 horas contínuas de uso" se enquadra em *confiabilidade*. Perceba que ambas são "não-funcionais" no sentido amplo, mas correspondem a características de qualidade distintas dentro do modelo ISO/IEC 25010.
]

== Atenção -- pegadinhas comuns

#remark(name: "Processo de qualidade não garante produto de qualidade, mas aumenta a chance")[
  Um erro comum é tratar "processo maduro (CMMI alto)" como sinônimo automático de "produto sem defeitos". A correlação é forte, mas não é uma garantia lógica -- um processo bem definido reduz a *variabilidade* e o risco, não elimina totalmente a possibilidade de defeitos.
]

#remark(name: "Eficiência não é a mesma coisa que confiabilidade")[
  Um sistema pode ser extremamente rápido (alta eficiência) e ainda assim falhar com frequência (baixa confiabilidade), ou vice-versa -- são características independentes do modelo de qualidade, frequentemente confundidas em questões de múltipla escolha.
]

== Questões estilo POSCOMP

*Questão 1.* A capacidade de um software manter seu nível de desempenho sob condições estabelecidas por um período determinado corresponde, no modelo ISO/IEC 25010, à característica de:
- a) Usabilidade.
- b) Portabilidade.
- c) Confiabilidade.
- d) Manutenibilidade.
- e) Eficiência de desempenho.

*Questão 2.* Sobre a diferença entre qualidade de produto e qualidade de processo, é correto afirmar que:
- a) São sinônimos e sempre avaliadas da mesma forma.
- b) Qualidade de processo avalia o quão bem definido e controlado é o método de produção; qualidade de produto avalia características do software entregue.
- c) Qualidade de processo só pode ser medida após a entrega do produto.
- d) O CMMI avalia exclusivamente características do produto final.
- e) Não há relação entre as duas.

*Questão 3.* Associe cada característica de qualidade à sua descrição: (I) Usabilidade, (II) Portabilidade, (III) Manutenibilidade -- (a) facilidade de transferir o software para outro ambiente; (b) facilidade de modificar o software; (c) facilidade de uso e aprendizado pelo usuário.
- a) I-c, II-a, III-b.
- b) I-a, II-b, III-c.
- c) I-b, II-c, III-a.
- d) I-c, II-b, III-a.
- e) I-a, II-c, III-b.

== Gabarito comentado

1. *(c)* -- manter desempenho ao longo do tempo sob condições estabelecidas é a definição de confiabilidade.
2. *(b)* -- distinção direta conforme definição desta seção.
3. *(a)* -- mapeamento direto conforme as definições de usabilidade, portabilidade e manutenibilidade.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 11 (Gerência de qualidade).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 8 (Conceitos de qualidade de software).
- ISO/IEC 25010:2011 -- Modelo de qualidade de produto de software.
