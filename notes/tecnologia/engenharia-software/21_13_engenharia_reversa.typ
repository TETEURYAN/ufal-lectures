#import "@preview/mousse-notes:1.1.0": *

= 21.13 --- Engenharia Reversa

== Introdução

Sistemas legados frequentemente sobrevivem sem documentação atualizada ou com a equipe original já dispersa. Engenharia reversa é o primeiro elo da cadeia manutenção → engenharia reversa → reengenharia (21.9, 21.14): entender o que já existe, antes de decidir o que fazer com isso.

== Definições formais

#definition(name: "Engenharia reversa", id: "def-engenharia-reversa")[
  Processo de *analisar* um sistema existente para identificar seus componentes, suas relações e criar representações do sistema em outra forma ou em um nível de abstração mais alto (ex.: extrair um diagrama de classes a partir do código-fonte de um sistema sem documentação) -- *sem alterar* o sistema original. É uma atividade de *compreensão*, não de modificação.
]

#definition(name: "Reestruturação (Restructuring)", id: "def-reestruturacao")[
  Transformação de uma forma de representação do sistema para outra, no *mesmo* nível relativo de abstração, preservando a funcionalidade externa (ex.: converter código não estruturado em código estruturado equivalente) -- frequentemente usada como uma etapa dentro de um esforço maior de reengenharia (21.14).
]

== Exemplo resolvido

#example(name: "Recuperando o projeto de um sistema legado", id: "ex-engenharia-reversa-legado")[
  Uma empresa herda um sistema de faturamento escrito 15 anos atrás, sem nenhuma documentação de projeto disponível, e cuja equipe original não está mais na empresa. Antes de decidir se vale a pena modernizar (reengenharia) ou substituir o sistema, a equipe atual faz *engenharia reversa*: analisa o código-fonte e o comportamento em execução para reconstruir um diagrama de classes e um modelo de dados que descrevam *como o sistema realmente funciona hoje* -- essa representação recuperada é o insumo para qualquer decisão posterior.
]

== Atenção -- pegadinhas comuns

#remark(name: "Engenharia reversa não implica alterar o sistema")[
  Um erro comum é confundir engenharia reversa com modificação do sistema -- engenharia reversa produz apenas uma representação/entendimento *derivado*, o sistema original permanece intacto. Só a reengenharia (21.14), que vem depois, efetivamente altera o sistema.
]

#remark(name: "Engenharia reversa não é sinônimo de atividade ilegal")[
  Embora o termo às vezes seja associado (na cultura popular) a quebra de proteção de software, no contexto de Engenharia de Software a engenharia reversa é uma prática legítima e comum para entender sistemas legados próprios de uma organização, sem nenhuma conotação de violação de propriedade intelectual por si só.
]

== Questões estilo POSCOMP

*Questão 1.* O processo de analisar um sistema existente para reconstruir uma representação em nível de abstração mais alto, sem alterar o sistema original, é chamado de:
- a) Reengenharia.
- b) Manutenção corretiva.
- c) Engenharia reversa.
- d) Garantia de qualidade.
- e) Prototipação evolutiva.

*Questão 2.* Sobre engenharia reversa, é correto afirmar que:
- a) Sempre resulta em modificação do código-fonte original.
- b) É, por definição, uma atividade de compreensão, não de modificação do sistema.
- c) É sinônimo de atividade ilegal em qualquer contexto.
- d) Só pode ser aplicada a sistemas com código-fonte disponível e documentado.
- e) É a última etapa da cadeia manutenção-reengenharia.

*Questão 3.* No exemplo do sistema legado de faturamento desta seção, o motivo para realizar engenharia reversa antes de qualquer modernização é:
- a) É exigido por lei em todos os países.
- b) Permite reconstruir o entendimento de como o sistema realmente funciona, servindo de base para decisões posteriores.
- c) Substitui completamente a necessidade de testes futuros.
- d) É uma etapa opcional sem nenhum impacto nas decisões seguintes.
- e) Torna o sistema automaticamente mais rápido.

== Gabarito comentado

1. *(c)* -- definição direta de engenharia reversa: compreensão/representação, sem alteração do sistema.
2. *(b)* -- engenharia reversa é, por definição, uma atividade de análise/compreensão, não de modificação.
3. *(b)* -- recuperar o entendimento real do sistema é exatamente o propósito ilustrado no exemplo.

== Referências

- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 27 (Engenharia reversa e reengenharia).
- SOMMERVILLE, I. *Engenharia de Software*. Cap. 9 (Evolução e engenharia reversa de sistemas legados).
