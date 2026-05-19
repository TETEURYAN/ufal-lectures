<div align="center">
<h1>computer science lectures</h1>
</div>

<div align="center" style="max-width: 850px; margin: 0 auto;">
<table>
  <tr>
    <td valign="top" style="padding-right: 16px; width: 150px;">
      <img src="https://user-images.githubusercontent.com/91018438/204195385-acc6fcd4-05a7-4f25-87d1-cb7d5cc5c852.png" alt="animated" width="140" />
    </td>
    <td valign="top" style="padding-left: 16px;">
      <p>Repositório de estudos e material acadêmico em Typst, preparado para a POSCOMP e outros desafios avançados de computação.</p>
      <p>Inclui notas, exercícios, referências e templates organizados por disciplina e tema.</p>
    </td>
  </tr>
</table>
</div>

## Estrutura do repositório

- `current-course/` - material atual do curso.
- `notes/` - notas e materiais organizados por disciplina.
  - `fundamentos/` - subpastas como `algoritmos`, `automatos`, `sistemas-operacionais`, etc.
- `references/` - referências e bibliografias gerais.
- `scripts/` - scripts auxiliares para gerar ou processar conteúdo.
- `shared/` - arquivos Typst compartilhados e macros comuns.
- `templates/` - modelos de exercício, revisão e teoria.

## Current Course

O arquivo `current-course` é um link para o conteúdo atual que está sendo desenvolvido. Com isso, para trocar para outro conteúdo basta digitar o seguinte comando:

``` 
ln -sfn /novo/diretorio current-course
```

## Templates
Os templates foram inspirados no modelo encontrado em [Mousse Notes](https://github.com/dogeystamp/mousse-notes)

## Tópicos principais

- Algoritmos
- Arquitetura de computadores
- Arquivos e dados
- Autômatos e linguagens formais
- Circuitos digitais
- Estruturas de dados
- Linguagens de programação
- Sistemas operacionais
- Técnicas de programação
- Teoria dos grafos
- Banco de dados
- Compiladores
- Computação gráfica
- Engenharia de software
- Inteligência artificial
- Processamento de imagens
- Redes
- Sistemas distribuídos

## Como ver arquivos Typst

### Requisitos

- Instale o Typst: siga as instruções em https://typst.app/docs/getting-started
- Use um editor com suporte a Typst, como VS Code + extensão `Typst`.

### Visualização no VS Code

1. Abra o repositório no VS Code.
2. Instale a extensão `Typst`.
3. Abra um arquivo `.typ` e use o preview da extensão para ver o PDF renderizado.

### Compilar pela linha de comando

No terminal, execute:

```bash
typst compile caminho/para/arquivo.typ
```

Isso gera um arquivo PDF no mesmo diretório.

### Visualizar um projeto completo

Para compilar um documento principal, execute:

```bash
typst compile notes/fundamentos/algoritmos/main.typ
```

Substitua o caminho pelo `main.typ` desejado.

## Contributing

- Use este repositório para organizar e gerar notas de estudo em Typst.
- Você pode adicionar mais conteúdos por meio de Pull Requests.
