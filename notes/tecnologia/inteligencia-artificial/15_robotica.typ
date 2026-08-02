#import "@preview/mousse-notes:1.1.0": *

= 22.20 --- Robótica

== Introdução

Robótica fecha a disciplina aplicando os conceitos anteriores (agentes, 22.19; busca, 22.3--22.5; incerteza, 22.11) a agentes com um *corpo físico*, que precisam lidar com sensores ruidosos, atuadores imprecisos e um mundo contínuo -- diferente do mundo discreto e limpo de muitos problemas de busca clássicos.

== Definições formais

#definition(name: "Ciclo perceber-planejar-agir", id: "def-ciclo-perceber-planejar-agir")[
  Arquitetura básica de um robô: *perceber* o ambiente via sensores (câmeras, lidar, sensores de contato), *planejar* uma ação ou sequência de ações (frequentemente usando busca, 22.3--22.5, ou técnicas de planejamento) e *agir* via atuadores (motores, garras) -- ciclo repetido continuamente, análogo ao laço perceber-agir de um agente inteligente (22.19), mas com a complexidade adicional do mundo físico.
]

#definition(name: "Graus de liberdade (DOF) e cinemática", id: "def-graus-liberdade-cinematica")[
  Os *graus de liberdade* (degrees of freedom) de um robô são o número de parâmetros independentes necessários para especificar completamente sua configuração (ex.: um corpo rígido livre no espaço 3D tem 6 DOF: 3 de translação, 3 de rotação). A *cinemática direta* calcula a posição/orientação do efetuador final a partir dos ângulos das juntas; a *cinemática inversa* faz o caminho oposto -- dada uma posição desejada do efetuador, calcula os ângulos de junta necessários -- geralmente mais difícil computacionalmente (pode ter múltiplas soluções ou nenhuma).
]

== Estrutura visual: graus de liberdade

#figure(
  image("figures/robot-6dof.svg", width: 45%),
  caption: [Os 6 graus de liberdade de um corpo rígido no espaço: 3 de translação (X, Y, Z) e 3 de rotação (roll, pitch, yaw). Fonte: Wikimedia Commons, CC BY-SA 4.0 (GregorDS).],
)

== Exemplo resolvido

#example(name: "Planejamento de movimento como busca", id: "ex-planejamento-movimento-busca")[
  Um braço robótico precisa mover seu efetuador de uma posição inicial a uma posição alvo, desviando de obstáculos. O *espaço de configurações* do robô (todas as combinações possíveis dos ângulos de suas juntas) pode ser tratado como um espaço de estados -- e algoritmos de busca como A\* (22.5) são aplicados para encontrar uma sequência de configurações (um caminho no espaço de configurações) que leve do início ao alvo sem colisão, generalizando diretamente as técnicas de busca já vistas para um domínio contínuo (tipicamente discretizado ou amostrado para tornar a busca tratável).
]

== Atenção -- pegadinhas comuns

#remark(name: "Cinemática inversa é geralmente mais difícil que a direta")[
  Calcular onde o efetuador *está*, dados os ângulos de junta (cinemática direta), é um cálculo geométrico direto e determinístico. Calcular quais ângulos de junta *produzem* uma posição desejada (cinemática inversa) pode ter zero, uma, ou infinitas soluções (redundância), exigindo métodos numéricos ou heurísticos -- confundir a direção fácil com a difícil é um erro comum.
]

#remark(name: "Robótica soma a incerteza da IA clássica à imprecisão física")[
  Além da incerteza já tratada em raciocínio probabilístico (22.11/22.12), robôs físicos lidam com ruído de sensor, erro de atuação (um motor não move exatamente o ângulo comandado) e um ambiente dinâmico -- exigindo replanejamento contínuo, não apenas um plano único calculado uma vez no início.
]

== Questões estilo POSCOMP

*Questão 1.* O número de parâmetros independentes necessários para especificar completamente a configuração de um robô é chamado de:
- a) Fator de ramificação.
- b) Graus de liberdade.
- c) Fator de certeza.
- d) Profundidade de busca.
- e) Taxa de aprendizado.

*Questão 2.* Calcular os ângulos de junta necessários para que o efetuador de um braço robótico alcance uma posição específica desejada é o problema de:
- a) Cinemática direta.
- b) Cinemática inversa.
- c) Busca cega.
- d) Aprendizado por reforço exclusivamente.
- e) Representação em rede.

*Questão 3.* O planejamento de movimento de um robô, evitando obstáculos, pode ser formalizado como um problema de:
- a) Classificação supervisionada apenas.
- b) Busca no espaço de configurações do robô.
- c) Lógica não-monotônica exclusivamente.
- d) Representação procedural sem busca.
- e) Sistemas de produção sem encadeamento.

== Gabarito comentado

1. *(b)* -- definição direta de graus de liberdade (DOF).
2. *(b)* -- encontrar ângulos de junta a partir de uma posição-alvo desejada é a definição de cinemática inversa.
3. *(b)* -- é exatamente a formalização apresentada no exemplo desta seção, generalizando busca (22.3--22.5) para o espaço de configurações do robô.

== Referências

- RUSSELL, S.; NORVIG, P. *Inteligência Artificial: Uma Abordagem Moderna*. Cap. 25--26 (Robótica).
- SICILIANO, B.; KHATIB, O. (Orgs.). *Springer Handbook of Robotics*. Cap. sobre cinemática.
- LAVALLE, S. *Planning Algorithms*. Cap. sobre planejamento de movimento e espaço de configurações.
