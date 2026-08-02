#import "@preview/mousse-notes:1.1.0": *

= 21.12 --- Reuso

== Introdução

Reuso é reaproveitar artefatos de software já existentes (código, componentes, projetos) em vez de desenvolvê-los do zero, buscando reduzir custo e prazo -- mas introduzindo novos desafios de gestão de dependência e compatibilidade.

== Definições formais

#definition(name: "Níveis de reuso de software", id: "def-niveis-reuso")[
  - *Reuso de código*: reaproveitar trechos, funções ou bibliotecas de código já escritas.
  - *Reuso de componentes*: reaproveitar unidades de software maiores, com interface bem definida e independentes de implementação interna (ex.: um componente de autenticação plugável).
  - *Reuso de frameworks*: reaproveitar uma estrutura semi-completa de aplicação, que define o fluxo geral e espera que o desenvolvedor implemente pontos de extensão específicos (*inversão de controle*: o framework chama o código do desenvolvedor, não o contrário).
  - *Reuso de projeto (padrões)*: reaproveitar soluções estruturais (padrões de projeto, 21.11), sem reaproveitar código diretamente.
]

#definition(name: "Linha de Produtos de Software (Software Product Line)", id: "def-linha-produto-software")[
  Conjunto de sistemas de software que compartilham um núcleo comum de funcionalidades e artefatos (arquitetura, componentes, requisitos), gerenciado de forma sistemática para permitir configurar/derivar produtos específicos para diferentes clientes ou mercados a partir desse núcleo -- reuso em escala organizacional, não apenas pontual entre dois projetos.
]

== Exemplo resolvido

#example(name: "Framework vs. biblioteca", id: "ex-framework-biblioteca")[
  Uma *biblioteca* de manipulação de datas é chamada explicitamente pelo código do desenvolvedor sempre que necessário (o desenvolvedor está no controle do fluxo). Um *framework* web (ex.: que define rotas, ciclo de vida de requisição/resposta) chama o código do desenvolvedor nos pontos apropriados do fluxo (o framework está no controle) -- essa inversão de controle é a diferença central entre reusar uma biblioteca e reusar um framework.
]

== Atenção -- pegadinhas comuns

#remark(name: "Reuso reduz custo de desenvolvimento, mas não elimina risco")[
  Reaproveitar uma biblioteca/componente de terceiros introduz uma *dependência externa*: vulnerabilidades de segurança, descontinuação do projeto, ou mudanças incompatíveis em versões futuras tornam-se um risco a gerenciar -- reuso não é uma decisão sem custo, é uma troca (menos esforço de desenvolvimento por mais risco de dependência).
]

#remark(name: "Linha de produtos não é apenas \"copiar e colar\" entre projetos")[
  Uma linha de produtos de software é gerenciada *sistematicamente* (com um núcleo comum explicitamente projetado para variação controlada), diferente da prática ad-hoc de copiar código de um projeto anterior para um novo -- esta última não oferece as mesmas garantias de manutenibilidade e consistência.
]

== Questões estilo POSCOMP

*Questão 1.* A principal diferença entre reusar uma biblioteca e reusar um framework é que:
- a) Bibliotecas sempre são pagas; frameworks são sempre gratuitos.
- b) No framework, há inversão de controle: ele chama o código do desenvolvedor, e não o contrário, como ocorre tipicamente com bibliotecas.
- c) Frameworks não podem ser reutilizados em múltiplos projetos.
- d) Bibliotecas sempre incluem interface gráfica; frameworks nunca incluem.
- e) Não há diferença conceitual relevante.

*Questão 2.* Um conjunto de sistemas que compartilham sistematicamente um núcleo comum de arquitetura e componentes, permitindo derivar produtos específicos para diferentes clientes, é chamado de:
- a) Framework.
- b) Linha de Produtos de Software.
- c) Padrão de projeto criacional.
- d) Ambiente de desenvolvimento integrado.
- e) Sistema legado.

*Questão 3.* Sobre os riscos do reuso de software, é correto afirmar que:
- a) Reuso elimina completamente qualquer risco de manutenção futura.
- b) Reuso introduz dependência de artefatos externos, que pode gerar riscos como vulnerabilidades ou descontinuação.
- c) Reuso é sempre desaconselhável em projetos de software.
- d) Reuso só é possível dentro da mesma organização.
- e) Reuso elimina a necessidade de testes.

== Gabarito comentado

1. *(b)* -- inversão de controle é a diferença conceitual central entre framework e biblioteca, conforme o exemplo desta seção.
2. *(b)* -- definição direta de Linha de Produtos de Software.
3. *(b)* -- reuso troca esforço de desenvolvimento por risco de dependência externa, não elimina risco completamente.

== Referências

- SOMMERVILLE, I. *Engenharia de Software*. Cap. 16 (Engenharia de software baseada em reuso) e Cap. 20 (Engenharia de linha de produtos).
- PRESSMAN, R. S.; MAXIM, B. R. *Engenharia de Software: Uma Abordagem Profissional*. Cap. 15 (Reutilização de software baseada em componentes).
