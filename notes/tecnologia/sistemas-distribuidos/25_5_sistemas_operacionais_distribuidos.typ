#import "@preview/mousse-notes:1.1.0": *

= 25.5 --- Sistemas Operacionais Distribuídos: Sistemas de Arquivos, Servidores de Nomes, Memória Compartilhada, Segurança

== Introdução

Um sistema operacional distribuído estende os serviços clássicos de um SO (arquivos, nomeação de recursos, memória, segurança) para operar de forma transparente sobre múltiplas máquinas. Esta subseção fecha a disciplina revisando quatro serviços clássicos, cada um ilustrado por um sistema real amplamente cobrado em prova: NFS (arquivos) e DNS (nomes).

== Definições formais

#definition(name: "Sistema de arquivos distribuído", id: "def-sistema-arquivos-distribuido")[
  Permite que processos em diferentes máquinas acessem arquivos armazenados remotamente como se fossem locais, por meio de um protocolo cliente-servidor. O *NFS (Network File System)* é o exemplo clássico: um servidor exporta diretórios, e clientes os *montam* em seu próprio espaço de nomes local, tornando o acesso transparente à aplicação. Historicamente, versões clássicas do NFS (v2/v3) usam um protocolo *sem estado (stateless)*: o servidor não mantém informação de sessão entre requisições, o que simplifica a recuperação após falha (o cliente simplesmente reenvia a requisição), mas dificulta operações que exigem estado, como bloqueio de arquivos.
]

#definition(name: "Servidor de nomes", id: "def-servidor-nomes")[
  Serviço que mapeia nomes legíveis por humanos a identificadores usados pelo sistema (endereços, referências de objeto). O *DNS (Domain Name System)* é o exemplo canônico: organiza nomes de domínio em uma hierarquia de árvore (raiz, domínios de topo como `.br`, `.com`, depois subdomínios), *distribuindo* a responsabilidade por cada zona entre servidores autoritativos diferentes, com *cache* (TTL) para reduzir consultas repetidas.
]

#definition(name: "Memória compartilhada distribuída (DSM)", id: "def-memoria-compartilhada-distribuida")[
  Abstração que simula memória compartilhada entre processos em máquinas fisicamente distintas (sem memória física comum), tipicamente replicando ou migrando páginas/objetos conforme o padrão de acesso. Exige um *modelo de consistência* explícito (ex.: consistência sequencial -- todas as operações parecem executar em alguma ordem sequencial comum a todos os processos -- até modelos mais relaxados, como consistência eventual) para definir que garantias o programador pode assumir sobre valores lidos após escritas concorrentes.
]

#definition(name: "Segurança em sistemas distribuídos", id: "def-seguranca-distribuida")[
  Além de autenticação, autorização e confidencialidade (já tratadas localmente em um SO convencional), sistemas distribuídos precisam garantir essas propriedades *através de uma rede não confiável*, sem um único ponto central de controle sempre disponível. O *Kerberos* é um exemplo clássico de protocolo de autenticação distribuída baseado em um servidor de confiança (KDC) que emite tíquetes temporários, evitando que senhas trafeguem repetidamente pela rede.
]

== Exemplo resolvido

#example(name: "Resolução de nomes no DNS", id: "ex-resolucao-dns")[
  Para resolver `www.ufal.br`, um cliente consulta (tipicamente via um servidor DNS recursivo local):
  + O servidor *raiz*, que não conhece `www.ufal.br` diretamente, mas indica o servidor responsável pelo domínio de topo `.br`.
  + O servidor autoritativo de `.br`, que indica o servidor responsável por `ufal.br`.
  + O servidor autoritativo de `ufal.br`, que finalmente responde com o endereço IP de `www.ufal.br`.

  Cada resposta pode ser *cacheada* (por um tempo definido pelo TTL do registro) por servidores intermediários, evitando repetir toda a cadeia em consultas futuras para o mesmo nome.

  #figure(
    image("figures/dns-hierarchy.svg", width: 70%),
    caption: [Hierarquia de nomes do DNS: cada nível da árvore delega autoridade sobre sua subárvore a servidores distintos. Fonte: Wikimedia Commons, domínio público (LionKimbro).],
  )
]

== Atenção -- pegadinhas comuns

#remark(name: "NFS stateless: recuperação simples, mas bloqueio de arquivos é limitado")[
  Um servidor NFS sem estado não sabe quais clientes têm um arquivo aberto -- se o servidor falha e reinicia, não há "sessões perdidas" para recuperar (o cliente só reenvia a última requisição). Em compensação, implementar bloqueio de arquivos (que exige lembrar quem detém o lock) exige mecanismos adicionais fora do núcleo stateless do protocolo original.
]

#remark(name: "Cache de DNS troca consistência por desempenho")[
  Um registro DNS alterado no servidor autoritativo pode continuar sendo servido com o valor *antigo* por outros resolvedores até o TTL expirar -- um exemplo concreto de *consistência eventual* aceita deliberadamente em troca de menos tráfego de rede e menor latência de resolução.
]

== Questões estilo POSCOMP

*Questão 1.* No diagrama de resolução de nomes do DNS desta seção, o papel do servidor autoritativo de `.br` é:
- a) Responder diretamente com o IP de `www.ufal.br`.
- b) Indicar qual servidor é responsável pelo domínio `ufal.br`.
- c) Armazenar permanentemente todos os nomes de domínio do mundo.
- d) Substituir o servidor raiz.
- e) Realizar apenas cache, sem nenhuma responsabilidade de delegação.

*Questão 2.* Um protocolo de sistema de arquivos distribuído é dito "sem estado" (stateless) quando:
- a) O servidor nunca responde às requisições dos clientes.
- b) O servidor não mantém informação de sessão entre requisições, simplificando a recuperação após falha.
- c) Os clientes não podem montar diretórios remotos.
- d) Todas as operações exigem autenticação Kerberos.
- e) O sistema não pode armazenar arquivos permanentemente.

*Questão 3.* O uso de cache com TTL em respostas DNS é um exemplo prático de:
- a) Consistência forte garantida a todo momento.
- b) Consistência eventual, aceita em troca de menor tráfego e latência.
- c) Replicação ativa determinística.
- d) Um protocolo de commit em duas fases.
- e) Falha bizantina intencional.

*Questão 4.* O papel do KDC (Key Distribution Center) no protocolo Kerberos é:
- a) Armazenar arquivos distribuídos.
- b) Resolver nomes de domínio.
- c) Atuar como servidor de confiança que emite tíquetes temporários de autenticação.
- d) Substituir o protocolo NFS.
- e) Implementar memória compartilhada distribuída.

== Gabarito comentado

1. *(b)* -- cada nível da hierarquia DNS delega, não resolve diretamente, o próximo nível (ver exemplo desta seção).
2. *(b)* -- definição direta de protocolo stateless, como no NFS clássico.
3. *(b)* -- cache com TTL aceita servir dados potencialmente desatualizados por um tempo limitado, trocando consistência imediata por desempenho.
4. *(c)* -- o KDC é a autoridade central de confiança do Kerberos, emitindo tíquetes em vez de expor senhas repetidamente na rede.

== Referências

- TANENBAUM, A. S.; VAN STEEN, M. *Distributed Systems: Principles and Paradigms*. Cap. 11 (Sistemas de arquivos distribuídos) e Cap. 9 (Segurança).
- COULOURIS, G. et al. *Sistemas Distribuídos: Conceitos e Projeto*. Cap. 13 (Sistemas de nomes) e Cap. 12 (Sistemas de arquivos distribuídos).
- MULLENDER, S. (Org.). *Distributed Systems*. Cap. sobre DSM e consistência.
