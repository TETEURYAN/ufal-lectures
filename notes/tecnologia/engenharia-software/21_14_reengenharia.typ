#import "@preview/mousse-notes:1.1.0": *

= 21.14 --- Reengenharia

== Introdução

Reengenharia fecha a cadeia conceitual iniciada pela manutenção e engenharia reversa (21.9, 21.13): depois de entender um sistema legado, reconstruí-lo em uma forma melhorada, preservando (ou aprimorando) sua funcionalidade. É onde a POSCOMP costuma testar se o candidato realmente distingue os três conceitos da cadeia.

== Definições formais

#definition(name: "Reengenharia", id: "def-reengenharia")[
  Exame e alteração de um sistema existente para reconstituí-lo em uma nova forma, tipicamente combinando *engenharia reversa* (entender o sistema atual, 21.13), *reestruturação* e *engenharia direta* (reimplementar/redesenhar a partir do entendimento recuperado) -- ao contrário da engenharia reversa, a reengenharia *efetivamente modifica* o sistema, buscando melhorar manutenibilidade, desempenho ou adequação à plataforma atual, preservando a funcionalidade essencial já existente.
]

#definition(name: "Reengenharia vs. reescrita do zero", id: "def-reengenharia-vs-reescrita")[
  Reengenharia parte do sistema *existente* como base de conhecimento (via engenharia reversa) e reconstrói de forma incremental/informada; uma reescrita completa do zero descarta o sistema legado como fonte de entendimento e recomeça a especificação/projeto -- reengenharia é geralmente mais barata e menos arriscada, por preservar conhecimento de negócio já embutido (ainda que implicitamente) no sistema legado.
]

== Exemplo resolvido

#example(name: "Do legado ao sistema modernizado", id: "ex-cadeia-reengenharia")[
  Retomando o sistema de faturamento legado do exemplo de 21.13:
  + *Manutenção* (histórico): ao longo de 15 anos, o sistema recebeu inúmeras correções e pequenos ajustes, acumulando complexidade.
  + *Engenharia reversa*: a equipe atual reconstrói o modelo de dados e o diagrama de classes reais do sistema, já que a documentação original se perdeu.
  + *Reengenharia*: com esse entendimento recuperado, a equipe reconstrói o sistema em uma arquitetura moderna (ex.: migrando de um monolito desktop para uma aplicação web em camadas), preservando as regras de negócio de faturamento identificadas na etapa anterior.
]

== Atenção -- pegadinhas comuns

#remark(name: "A cadeia manutenção → engenharia reversa → reengenharia, na ordem certa")[
  A prova gosta de embaralhar a ordem ou trocar as definições: *manutenção* mantém o sistema funcionando ao longo do tempo (21.9); *engenharia reversa* só *entende* o sistema existente, sem alterá-lo (21.13); *reengenharia* usa esse entendimento para efetivamente *reconstruir* o sistema (21.14). Confundir "entender" com "reconstruir" é o erro mais comum entre os três.
]

#remark(name: "Reengenharia não é o mesmo que manutenção perfectiva")[
  Manutenção perfectiva (21.9) adiciona funcionalidades incrementalmente ao sistema existente, sem necessariamente alterar sua estrutura interna. Reengenharia é mais ampla e profunda: reconstrói a estrutura/arquitetura do sistema, tipicamente motivada por dificuldade crescente de manutenção do sistema em sua forma atual.
]

== Questões estilo POSCOMP

*Questão 1.* A atividade que reconstrói um sistema existente em uma nova forma, combinando entendimento recuperado (engenharia reversa) com reimplementação, é:
- a) Manutenção corretiva.
- b) Engenharia reversa.
- c) Reengenharia.
- d) Garantia de qualidade.
- e) Prototipação.

*Questão 2.* Associe corretamente: (I) Manutenção, (II) Engenharia reversa, (III) Reengenharia -- (a) reconstrói o sistema em nova forma, a partir do entendimento recuperado; (b) mantém o sistema em operação ao longo do tempo, com correções e ajustes; (c) analisa o sistema existente para recuperar entendimento, sem alterá-lo.
- a) I-b, II-c, III-a.
- b) I-a, II-b, III-c.
- c) I-c, II-a, III-b.
- d) I-b, II-a, III-c.
- e) I-a, II-c, III-b.

*Questão 3.* Uma vantagem da reengenharia em relação a uma reescrita completa do zero é:
- a) A reengenharia sempre é mais cara.
- b) A reengenharia preserva conhecimento de negócio já embutido no sistema legado, reduzindo risco.
- c) A reengenharia dispensa qualquer forma de engenharia reversa.
- d) A reescrita do zero é sempre mais rápida e barata.
- e) Não há diferença prática entre as duas abordagens.

== Gabarito comentado

1. *(c)* -- reconstrução efetiva do sistema, combinando compreensão e reimplementação, é a definição de reengenharia.
2. *(a)* -- mapeamento direto conforme a cadeia manutenção → engenharia reversa → reengenharia descrita nesta seção.
3. *(b)* -- partir do sistema legado como base de conhecimento reduz o risco de perder regras de negócio implícitas, ao contrário de uma reescrita do zero.

== Referências

- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 27 (Reengenharia).
- SOMMERVILLE, I. *Engenharia de Software*. Cap. 9 (Reengenharia de sistemas legados).
- CHIKOFSKY, E.; CROSS, J. *Reverse Engineering and Design Recovery: A Taxonomy* (1990) -- referência clássica que formaliza os termos desta e da seção 21.13.
