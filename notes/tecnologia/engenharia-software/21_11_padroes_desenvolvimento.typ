#import "@preview/mousse-notes:1.1.0": *

= 21.11 --- Padrões de Desenvolvimento

== Introdução

Padrões capturam soluções recorrentes e comprovadas para problemas de projeto que aparecem repetidamente em diferentes sistemas -- reduzindo a necessidade de "reinventar a roda" e melhorando a comunicação entre desenvolvedores por meio de um vocabulário comum.

== Definições formais

#definition(name: "Padrão de projeto (Design Pattern)", id: "def-padrao-projeto")[
  Descrição reutilizável de uma solução comprovada para um problema recorrente de projeto orientado a objetos, em um contexto específico. O catálogo mais influente, conhecido como *GoF* (Gang of Four -- Gamma, Helm, Johnson, Vlissides, 1994), organiza 23 padrões clássicos em três categorias:
  - *Criacionais*: tratam da criação de objetos (ex.: *Singleton* -- garante uma única instância de uma classe; *Factory Method* -- delega a criação de objetos a subclasses).
  - *Estruturais*: tratam de como classes/objetos são compostos (ex.: *Adapter* -- adapta uma interface incompatível; *Decorator* -- adiciona responsabilidades a um objeto dinamicamente).
  - *Comportamentais*: tratam de como objetos interagem e distribuem responsabilidades (ex.: *Observer* -- notifica múltiplos objetos dependentes automaticamente quando o estado de um objeto muda; *Strategy* -- encapsula algoritmos intercambiáveis).
]

#definition(name: "Padrões de codificação (coding standards)", id: "def-padroes-codificacao")[
  Convenções acordadas pela equipe (ou organização) sobre estilo de código -- nomenclatura, formatação, organização de arquivos, tratamento de erros -- distintas de padrões de *projeto*: padrões de codificação tratam de *como o código é escrito*, não de *como o problema de projeto é resolvido estruturalmente*.
]

== Exemplo resolvido

#example(name: "Padrão Observer em um sistema de notificações", id: "ex-observer-pattern")[
  Um sistema de e-commerce precisa notificar múltiplos módulos (e-mail, SMS, log de auditoria) sempre que um pedido muda de status, sem acoplar o módulo de pedidos diretamente a cada um deles. O padrão *Observer* resolve isso: o objeto `Pedido` (o *sujeito*) mantém uma lista de *observadores* registrados; ao mudar de status, notifica todos, cada um reagindo à sua maneira (enviar e-mail, SMS, registrar log) -- sem que `Pedido` precise conhecer os detalhes de cada observador.
]

== Atenção -- pegadinhas comuns

#remark(name: "Padrão de projeto não é código pronto para copiar e colar")[
  Um padrão descreve uma *estrutura de solução* reutilizável em nível conceitual (papéis, relações entre classes), não uma implementação literal a ser copiada -- a implementação concreta varia conforme a linguagem e o contexto específico do sistema.
]

#remark(name: "Nem todo problema precisa de um padrão")[
  Aplicar um padrão de projeto onde não é necessário (over-engineering) adiciona complexidade acidental sem benefício real -- padrões existem para resolver um problema recorrente *específico*, não para serem aplicados por padrão em qualquer situação.
]

== Questões estilo POSCOMP

*Questão 1.* Um padrão que garante que uma classe tenha apenas uma única instância, acessível globalmente, pertence à categoria:
- a) Estrutural.
- b) Comportamental.
- c) Criacional.
- d) Arquitetural.
- e) De codificação.

*Questão 2.* O padrão que permite que múltiplos objetos sejam notificados automaticamente quando o estado de outro objeto muda, sem acoplamento direto entre eles, é o:
- a) Singleton.
- b) Adapter.
- c) Observer.
- d) Factory Method.
- e) Decorator.

*Questão 3.* Associe: (I) Padrão criacional, (II) Padrão estrutural, (III) Padrão comportamental -- (a) trata de como objetos interagem e distribuem responsabilidades; (b) trata da criação de objetos; (c) trata de como classes/objetos são compostos.
- a) I-b, II-c, III-a.
- b) I-a, II-b, III-c.
- c) I-c, II-a, III-b.
- d) I-b, II-a, III-c.
- e) I-a, II-c, III-b.

== Gabarito comentado

1. *(c)* -- controlar a criação (garantindo instância única) é a característica de um padrão criacional -- o padrão Singleton especificamente.
2. *(c)* -- notificação automática de dependentes sem acoplamento direto é a definição do padrão Observer.
3. *(a)* -- mapeamento direto conforme as três categorias GoF descritas nesta seção.

== Referências

- GAMMA, E.; HELM, R.; JOHNSON, R.; VLISSIDES, J. *Design Patterns: Elements of Reusable Object-Oriented Software* (1994) -- catálogo original GoF.
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 12 (Padrões de projeto).
- SOMMERVILLE, I. *Engenharia de Software*. Cap. 7 (Padrões de projeto e reuso).
