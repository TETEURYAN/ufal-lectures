# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal repository of Typst-based lecture notes and study material for computer science
topics, prepared for POSCOMP (a Brazilian graduate-level CS admission exam) and coursework at UFAL.
Content is written in Portuguese. There is no build pipeline, package manifest, or test suite — the
only "build" is compiling `.typ` files to PDF with Typst.

## Commands

- Compile a subject's notes to PDF:
  ```bash
  typst compile notes/<area>/<subject>/main.typ
  ```
  (e.g. `typst compile notes/fundamentos/sistemas-operacionais/main.typ`)
- Live preview while editing:
  ```bash
  typst watch notes/<area>/<subject>/main.typ
  ```
- Compiled PDFs (`main.pdf`) are left alongside the `.typ` source and are untracked/gitignored-by-convention
  build output, not something to hand-edit or commit deliberately.

There is no linter or test runner in this repo.

## Repository structure

- `notes/<area>/<subject>/` — one directory per subject, under top-level areas:
  `fundamentos/` (algoritmos, arquitetura, arquivos-dados, automatos, circuitos-digitais,
  estruturas-dados, linguagens-programacao, sistemas-operacionais, tecnicas-programacao,
  teoria-grafos), `tecnologia/` (banco-dados, compiladores, computacao-grafica,
  engenharia-software, inteligencia-artificial, processamento-imagens, redes,
  sistemas-distribuidos), and `matematica/` (algebra-linear, analise-combinatoria,
  calculo, geometria-analitica, logica-matematica, matematica-discreta,
  probabilidade-estatistica — POSCOMP's math subjects). Slugs drop connector words
  (`banco-dados`, not `banco-de-dados`; `probabilidade-estatistica`, not
  `probabilidade-e-estatistica`). Every subject directory follows the same scaffold:
  - `main.typ` — entry point; imports `@preview/mousse-notes` and sets up the book (title,
    subtitle, author, epigraph), then `#include`s files from `lectures/`.
  - `info.toml` — subject metadata (`title`, `short`). Most subjects still carry the
    placeholder values (`title = "Curso"`, `short = "CUR"`) until the subject is actually
    written up — update these when starting real content for a subject.
  - `lectures/` — one file per lecture, numbered `NN-nome.typ` (e.g. `01-introducao.typ`,
    `02-processos.typ`).
  - `bibliography.bib`, `exercises/`, `figures/`, `flashcards/`, `implementations/`, `proofs/`,
    `references/`, `summaries/` — auxiliary content, empty until material for that subject is
    added.
- `shared/` — Typst files meant to be imported across subjects (`base.typ` sets page/text
  defaults and defines a `lecture(n, date, title)` heading helper; `theorem.typ`, `code.typ`,
  `math.typ`, `algorithms.typ` are present but currently empty stubs). Import via a relative
  path, e.g. `#import "../../../shared/base.typ": *`.
- `templates/` — reference templates (`main.typ`, `theory.typ`, `exercise.typ`, `revision.typ`)
  showing the mousse-notes book setup and content patterns; `exercise.typ`/`revision.typ` are
  currently empty.
- `current-course` — a symlink meant to point at whichever subject is actively being worked on.
  Repoint it with `ln -sfn <path/to/subject> current-course` when switching focus (see README).
- `exams/`, `references/`, `figures/`, `scripts/`, `build/` — top-level scaffold directories,
  currently empty.

## Content conventions

- New lecture content actually written so far (e.g. `notes/fundamentos/sistemas-operacionais/`)
  imports `@preview/mousse-notes` directly in each lecture file and writes headings/prose with
  Typst markup (`= Título`, `== Seção`, `#definition[...]`), rather than routing through
  `shared/base.typ`'s `lecture()` helper. Most not-yet-written subjects still have the
  scaffolded placeholder (`#lecture(1, "date", "Introdução")` + "Texto da aula.") left over from
  initial setup — follow the sistemas-operacionais style (plain mousse-notes headings) when
  filling these in rather than the placeholder's `lecture()` call, unless you also wire up the
  `shared/base.typ` import.
- Each subject's `main.typ` uses `#show: book.with(...)` from mousse-notes with
  `title`/`subtitle`/`subsubtitle`/`subsubsubtitle`/`author`/`epigraph`/`font-style` — follow the
  existing subjects' main.typ as the pattern for a new one, not `templates/main.typ` (which is
  the upstream WUNK 101 example and uses placeholder/example values).

## Branch workflow

Each subject tends to be developed on its own branch named after the subject slug (e.g.
`sistemas-operacionais`, `banco-dados`, `automato`), branched from `main`, then merged back
once the notes are in reasonable shape. When asked to work on a specific subject's content,
check whether a matching branch already exists and has unmerged progress before starting
fresh from `main`.

## Permissions and generation workflow

Before generating/editing POSCOMP subject content, read **`.claude/rules.md`** — it documents
the exact mousse-notes API (confirmed by reading the package source, not assumed from LaTeX
habits), the pedagogical structure used per subtopic, and a permissions policy derived from
this repo's approval history (what's safe to run without asking — `typst compile`, read-only
git, the standalone `typst` binary setup, `WebFetch`/`WebSearch` for source material — vs. what
always needs confirmation — `git add`/`commit`/`push`, system package installs). A matching
`.claude/settings.json` encodes the safe subset directly as pre-approved permissions.
