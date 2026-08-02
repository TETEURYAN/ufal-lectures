#import "@preview/mousse-notes:1.1.0": *

= Famílias Lógicas
#text(size: 9pt, style: "italic")[Edital POSCOMP: 11.13]

== Introdução

Até aqui, portas lógicas foram tratadas em nível puramente funcional (AND, OR, NOT). Esta subseção introduz, em nível introdutório, *como* essas portas são fisicamente implementadas em tecnologia de semicondutores -- e por que a tecnologia escolhida afeta velocidade, consumo e custo do circuito final.

== Definições formais

#definition(name: "TTL (Transistor-Transistor Logic)", id: "def-familia-ttl")[
  Família lógica mais antiga, construída com transistores bipolares (BJT). Historicamente dominante em circuitos integrados digitais de média escala, com níveis de tensão padronizados (0V--0.8V para nível baixo, 2V--5V para nível alto, tipicamente). Maior consumo de energia e menor densidade de integração que CMOS.
]

#definition(name: "CMOS (Complementary Metal-Oxide-Semiconductor)", id: "def-familia-cmos")[
  Família lógica dominante em circuitos digitais modernos, construída com pares complementares de transistores MOSFET (um canal-N, um canal-P) por porta -- consome energia significativa apenas *durante* transições de estado (não em repouso estático), permitindo densidade de integração e eficiência energética muito superiores à TTL, essencial para chips modernos com bilhões de transistores.
]

== Comparação entre famílias lógicas

#table(
  columns: 4,
  [*Característica*], [*TTL*], [*CMOS*], [*Vencedor típico*],
  [Consumo de energia estático], [Alto], [Muito baixo], [CMOS],
  [Densidade de integração], [Baixa/média], [Muito alta], [CMOS],
  [Velocidade de chaveamento (histórico)], [Rápida (na época)], [Historicamente mais lenta, hoje competitiva/superior], [Depende da geração tecnológica],
  [Imunidade a ruído], [Moderada], [Geralmente maior], [CMOS],
  [Uso predominante hoje], [Legado, aplicações específicas], [Praticamente todos os chips modernos], [CMOS],
)

== Atenção -- pegadinhas comuns

#remark(name: "CMOS não consome zero energia -- consome pouco em repouso")[
  Um erro comum é achar que CMOS não consome energia alguma estaticamente. Na prática, há um pequeno consumo estático (corrente de fuga, mais relevante em tecnologias modernas de transistor muito pequeno), mas é ordens de magnitude menor que o consumo estático típico de TTL -- a caracterização correta é "consumo estático muito baixo", não "nulo".
]

#remark(name: "A escolha de família lógica é uma decisão de engenharia, não puramente teórica")[
  A predominância de CMOS hoje não significa que TTL seja "obsoleta e inútil" -- ainda aparece em aplicações legadas e em contextos específicos de interface. A POSCOMP tende a cobrar o reconhecimento das características comparativas (tabela desta seção), não uma afirmação absoluta de superioridade.
]

== Questões estilo POSCOMP

*Questão 1.* A principal razão da predominância da tecnologia CMOS em circuitos integrados digitais modernos é:
- a) Maior consumo de energia estático.
- b) Baixo consumo de energia estático e alta densidade de integração.
- c) Uso exclusivo de transistores bipolares.
- d) Incompatibilidade com portas lógicas básicas.
- e) Menor imunidade a ruído que TTL.

*Questão 2.* A família lógica TTL é construída com base em:
- a) Transistores MOSFET complementares.
- b) Transistores bipolares (BJT).
- c) Exclusivamente capacitores.
- d) Memórias ROM.
- e) Fibra óptica.

== Gabarito comentado

1. *(b)* -- baixo consumo estático e alta densidade são as vantagens centrais que tornaram CMOS dominante, conforme a tabela desta seção.
2. *(b)* -- TTL é definida pelo uso de transistores bipolares, em contraste com os MOSFETs da CMOS.

== Referências

- MANO, M. M.; CILETTI, M. D. *Digital Design*. Cap. 10 (Famílias lógicas: TTL e CMOS).
- TOCCI, R.; WIDMER, N.; MOSS, G. *Sistemas Digitais: Princípios e Aplicações*. Cap. 12 (Interface e famílias lógicas).
