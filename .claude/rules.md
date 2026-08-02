# Regras para criação/edição de disciplinas — ufal-lectures

Este documento existe para reduzir o número de confirmações que o Claude Code
pede durante o trabalho neste repositório. Foi derivado observando os
prompts e as permissões efetivamente aprovadas em sessões anteriores
(`.claude/settings.local.json`, 83 entradas acumuladas). A ideia é: o que já
foi aprovado repetidamente, sem nunca ter causado problema, deveria deixar de
gerar pergunta.

Referenciado a partir de `CLAUDE.md` (raiz), que é carregado automaticamente
em toda sessão. Se algo aqui conflitar com uma instrução explícita do usuário
na conversa, a instrução da conversa vale.

## 1. Padrão de disciplina (não é preciso redescobrir isso toda vez)

Toda disciplina em `notes/<area>/<disciplina>/` já nasce com a mesma
estrutura de pastas (confirmado em `find notes -maxdepth 3 -type d`):

```
notes/<area>/<disciplina>/
  main.typ          # book.with(title:, subtitle:, ..., author:) do mousse-notes
  lectures/          # padrão principal: #lecture(n, data, titulo) por aula, cronológico
  summaries/         # resumos por tópico (ex.: trilha POSCOMP por subtópico do edital)
  exercises/
  flashcards/
  implementations/
  proofs/
  references/
  figures/
```

`<area>` é `fundamentos/` ou `tecnologia/`, seguindo a lista de tópicos do
`README.md` da raiz.

- Único pacote externo do projeto: `@preview/mousse-notes:1.1.0`. Não há
  `typst.toml` na raiz nem outras dependências — não presuma pacotes (ex.
  `fletcher`, `cetz`) sem confirmar que já estão em uso em algum `.typ`
  existente.
- Caixas de teorema/definição/exemplo vêm todas de `mousse-notes` (`thm-env`):
  `definition`, `theorem`, `proposition`, `lemma`, `corollary`, `example`,
  `solution`, `proof`, `remark`. Todas aceitam `name:` e `id:` — `id:` já
  chama `label(id)` internamente, é assim que se referencia entre arquivos
  (`@meu-id`), não use `#label()`/`<>` à parte.
  Os arquivos em `shared/` (exceto `shared/base.typ`, que define
  `#let lecture(n, date, title)`) estão vazios — não existem caixas
  customizadas além das do mousse-notes.
- `current-course` (link simbólico na raiz) aponta para a disciplina ativa.
  Trocar de disciplina em desenvolvimento é rotina, não uma ação destrutiva:
  `ln -sfn notes/<area>/<disciplina> current-course`.
- Nomenclatura: pastas e arquivos em `kebab-case`/`snake_case`, sem acentos.
  Arquivos numerados por subtópico de edital usam prefixo `NN_M_` (ex.
  `18_2_modelagem_projeto.typ`) para manter ordem alfabética = ordem do
  edital.
- Antes de usar qualquer função/macro não listada acima, leia o arquivo
  fonte real (`~/.cache/typst/packages/preview/mousse-notes/*/src/lib.typ`
  ou o `.typ` do repo) — nunca por analogia com LaTeX ou outro template
  Typst conhecido de memória.

## 2. Fluxo de trabalho padrão

1. Confirmar estrutura/macros lendo os arquivos reais (não assumir).
2. Gerar/editar o conteúdo `.typ`, um arquivo por vez se o volume for grande.
3. Validar com `typst compile <arquivo ou main.typ>` antes de seguir para o
   próximo — corrigir warnings também (ex.: sintaxe depreciada como
   `sect` → `inter`), não só erros fatais.
4. Se não houver `typst` instalado localmente, resolver via binário estático
   pré-compilado (GitHub releases, `typst-*-unknown-linux-musl.tar.xz`) baixado
   para `/tmp` ou `~/.local/bin` — **nunca** `apt`/`apt-get`/`sudo` sem
   perguntar antes (ver seção 3).
5. Ao final, listar arquivos criados/alterados e propor mensagem de commit —
   **sem rodar `git commit` automaticamente**. Commit/push são sempre ação do
   usuário, mesmo que o resto do fluxo esteja pré-autorizado.

## 3. Política de permissões

### 3.1 Pré-autorizado (pode fazer sem perguntar)

Baseado no que já foi aprovado repetidamente nas últimas sessões:

**Typst (18 aprovações — a categoria mais frequente):**
- `typst compile ...` em qualquer arquivo do repo, para validação.
- `typst --version`, `command -v typst`.
- Localizar/baixar/instalar um binário `typst` standalone em `/tmp` ou
  `~/.local/bin` a partir de `github.com/typst/typst/releases` (curl + tar +
  chmod) quando não houver `typst` no PATH. Isso não é instalação de pacote
  de sistema — não mexe em nada fora do `$HOME`/`/tmp`.

**Git — apenas leitura (8 aprovações):**
- `git status`, `git diff`, `git log`, `git branch *`, `git ls-tree *`,
  `git ls-remote *`, `git show *`.
- `git add`, `git commit`, `git push`, `git rm` **ficam de fora** desta lista
  de propósito — ver seção 3.2.

**Busca/inspeção (11 aprovações):**
- `find`, `grep`, `sort`, `xargs`, `command -v` dentro do repositório ou de
  diretórios do próprio usuário (`~/.cache/typst`, `~/.local/bin`).
- Leitura (`Read`) em `~/.cache/typst/**` (código-fonte de pacotes Typst
  instalados) e em `/tmp/**` (scratchpad) sem perguntar — é necessário para
  não inventar API.

**current-course (3 aprovações):**
- `ln -sfn notes/<area>/<disciplina> current-course` — trocar a disciplina
  ativa é uma ação de desenvolvimento rotineira, reversível com o mesmo
  comando.

**Web (9 WebFetch + WebSearch aprovados):**
- `WebSearch` de forma geral, para localizar bibliografia/fontes.
- `WebFetch` em domínios acadêmicos/institucionais já usados como fonte de
  conteúdo (ex. `cienciadacomputacao.wiki.br` — fonte oficial do edital
  POSCOMP; sites de universidades como `.edu`, `.usp.br`, `.ufrgs.br`,
  `docente.ifrn.edu.br`, `online.stanford.edu`) para confirmar ementa,
  bibliografia ou definições. Não pré-autoriza domínios comerciais,
  redes sociais ou qualquer fonte fora do escopo de material didático.

**Python para extração de conteúdo de PDF (6 aprovações):**
- `python3` usando `pypdf`/`PyPDF2`/`fitz` para extrair texto/figuras de
  PDFs já presentes no repo ou no scratchpad — não para rodar código
  arbitrário fora desse escopo.

### 3.2 Sempre pede confirmação (nunca pré-autorizado)

- `git add`, `git commit`, `git push`, `git rm`, qualquer rewrite de
  histórico (`rebase`, `reset --hard`, `--force`). Já é instrução explícita
  do usuário: gerar a mensagem e o diff, mas deixar o `git commit` para ele
  rodar/aprovar.
- Instalação de pacotes de sistema: `apt`, `apt-get`, `sudo` em qualquer
  forma. Se faltar uma dependência, preferir sempre um binário
  standalone/user-space (ver 3.1) e só pedir `apt-get install` como último
  recurso, explicitando o motivo.
- `gh pr *`, `gh repo *`, `gh api *` com efeito colateral (abrir PR, comentar,
  etc.) — leitura (`gh pr view`, `gh repo view`) pode ser tratada como
  inofensiva, mas ações que publicam algo continuam pedindo confirmação.
- Qualquer ação fora da árvore do repositório e de `~/.cache/typst`,
  `~/.local/bin`, `/tmp` (ex. editar dotfiles, configurações globais).
- `cargo install`, `pip install` de pacotes — usado no passado só como
  tentativa de obter o `typst` CLI; hoje o binário standalone resolve isso
  sem precisar de toolchain nenhuma.

## 4. Características recorrentes dos prompts (para reconhecer o padrão rápido)

- Pedidos de "gerar/continuar material de [disciplina] para POSCOMP" seguem
  quase sempre o mesmo formato: introdução breve → definições formais em
  caixa → teorema/propriedade quando existir → exemplo resolvido → caixa de
  atenção/pegadinha → 2-4 questões estilo POSCOMP com gabarito comentado →
  referências (livros clássicos da área, citação curta, sem reprodução de
  texto extenso).
- Peça sempre: nada de sintaxe Typst inventada por analogia com LaTeX; toda
  macro usada deve ter sido confirmada lendo o arquivo fonte real.
- Peça sempre: compilar (`typst compile`) antes de considerar um arquivo
  pronto, e tratar warnings de depreciação (não só erros) como pendência.
- Peça sempre: no fim, listar arquivos tocados + mensagem de commit sugerida,
  sem executar o commit.
