# Getting started (VS Code + LaTeX)

This page takes you from a bare machine to a compiled PDF, and then through the
normal day-to-day writing loop.

---

## 1. Install what you need

| Tool | Why | Check |
|---|---|---|
| Git | version control | `git --version` |
| TeX Live (full) | the LaTeX engine and packages | `pdflatex --version` |
| `latexmk` | runs pdflatex/biber/makeindex the right number of times | `latexmk --version` |
| `biber` | bibliography backend used by biblatex | `biber --version` |
| VS Code | editor | -- |
| LaTeX Workshop extension | build, preview, SyncTeX | -- |

Install a **full** TeX distribution, not a minimal one. The template uses
`tcolorbox`, `newpx`, `titlesec`, `titletoc`, `imakeidx`, `biblatex`, `tikz`,
`pgfplots`, `cleveref`, `microtype`, `emptypage`, `beramono`.

- Windows: install MiKTeX (enable "install missing packages on the fly") or TeX Live.
- macOS: `brew install --cask mactex`
- Debian/Ubuntu: `sudo apt install texlive-full latexmk biber`

---

## 2. Clone the repository

```bash
git clone https://github.com/abdelouahabmostafaetu-bot/dz_math_book_series.git
cd dz_math_book_series
code .
```

Open the **repository root** in VS Code, not a single volume folder. The root
contains `.vscode/settings.json`, which is what makes the shared template
visible to the compiler.

When VS Code asks about the recommended extensions, accept them.

---

## 3. First build

### From the terminal (the reference method)

```bash
cd books/01-linear-algebra
latexmk -pdf book.tex
```

This produces `book.pdf` in the same folder. Run it once before touching
anything: if it succeeds, your installation is correct, and any later error is
yours, not the environment's.

### From VS Code

1. Open `books/01-linear-algebra/book.tex`.
2. `Ctrl+Alt+B` (or the green arrow in the TeX panel) builds.
3. `Ctrl+Alt+V` opens the PDF beside the source.
4. `Ctrl+Alt+J` jumps from the cursor to the matching place in the PDF;
   `Ctrl+click` in the PDF jumps back to the source.

Building also happens automatically on save.

### Why the build must start in the volume folder

The design system is **not copied** into each book; it lives once in
`template/`. LaTeX finds it through the `TEXINPUTS` variable, set by
`books/<volume>/.latexmkrc` to `.:../../template//:`. So:

- `latexmk` run from inside the volume folder: works.
- `pdflatex book.tex` run from the repository root: **fails**, `docmathdz.cls not found`.

If you ever need raw pdflatex:

```bash
cd books/01-linear-algebra
TEXINPUTS=.:../../template//: pdflatex book.tex
```

---

## 4. Where to write

Never write mathematics in `book.tex`. It is only an assembly file: metadata,
front matter, and `\input` lines.

```
books/01-linear-algebra/
  book.tex                     <- assembly only
  front/                       <- preface, objectives, roadmap, prerequisites
  chapters/
    01_introduction.tex
    02_definitions.tex         <- you write here
    ...
    07_solutions.tex
  figures/                     <- one .tex per TikZ figure
  references.bib
```

Put this magic comment on the first line of every chapter file, so LaTeX
Workshop always compiles the whole book instead of the fragment you are editing:

```latex
% !TEX root = ../book.tex
```

### Rules for chapter files

- Never write `\documentclass`, `\usepackage`, `\begin{document}` in a chapter.
  All packages belong to the class. A chapter starts directly with `\chapter{...}`.
- Never redefine an environment or a colour locally. If something is missing,
  add it to `template/style/` so every volume gets it.
- Always use the series macros: `\Ker u`, `\rank A`, `\norm{x}`, `\R`, `\K`.
  Never `\ker`, `\|x\|`, `\mathbb{R}`.
- Label everything you may cite: `\label{thm:rank-nullity}` with the prefixes
  `ch: def: thm: lem: prop: cor: ex: rem: eq: fig: exo: prob:`.
- Reference with `\cref{thm:rank-nullity}`, never with a hand-typed number.
- Index every new term with `\term{eigenvalue}` on its first occurrence.

### The shape of a piece of writing

```latex
% !TEX root = ../book.tex
\chapter{Core Definitions}\label{ch:definitions}

\section{Vector spaces}

Motivation in plain prose: which problem forces this definition?

\begin{intuition}
The informal picture, before any formalism.
\end{intuition}

\begin{definition}{Vector space}{def:vector-space}
A \term{vector space} over $\K$ is a set $E$ with ...
\end{definition}

\begin{example}{The standard spaces}{ex:standard-spaces}
$\K^n$, $\K[X]$, $\mathcal{C}([0,1],\R)$ ...
\end{example}

\begin{theorem}{Rank--nullity}{thm:rank-nullity}
Let $u\colon E\to F$ be linear with $\dim E<\infty$. Then
\[ \dim E = \dim\Ker u + \rank u. \]
\end{theorem}

\begin{proof}
Complete argument, every step justified.
\end{proof}

\begin{warning}
The hypothesis $\dim E<\infty$ cannot be dropped: ...
\end{warning}
```

Available environments, all defined in `template/style/docmath-theorems.sty`:
`definition theorem lemma proposition corollary example remark` (numbered,
syntax `{Title}{label}`), `exercise problem solution` and the unnumbered boxes
`intuition note warning keypoints mistakes summarybox`.

### Figures

One file per figure in `figures/`, containing only the `tikzpicture`. Include it
with:

```latex
\begin{figure}[htbp]
  \centering
  \input{figures/projection}
  \caption{Orthogonal projection onto a plane.}\label{fig:projection}
\end{figure}
```

Vector graphics only. No screenshots, no JPEG, no PNG of mathematics.

---

## 5. Test before you commit

**A. Does it compile from a clean state?** Incremental builds hide broken
references.

```bash
cd books/01-linear-algebra
latexmk -C            # delete every generated file, including the PDF
latexmk -pdf book.tex
```

**B. Is the log clean?** Search `book.log` for the things that matter:

```bash
grep -nE "^(!|.*:[0-9]+:)" book.log      # real errors
grep -n "undefined" book.log             # undefined references or citations
grep -n "Overfull" book.log              # lines sticking into the margin
```

A volume is releasable only with zero errors, zero undefined references, and no
Overfull box above roughly 10pt.

**C. Did you change the template?** Then compile the test document, which
exercises every environment of the series:

```bash
scripts/build.sh --template
```

**D. Does the whole series still build?**

```bash
scripts/build.sh --all
```

**E. Read the PDF as a reader, not as an author.** Chapter opening pages,
running headers, page breaks inside boxes, the index, the bibliography.

**F. Mathematical review.** The compiler cannot check truth. Every proof read
line by line, every computation redone independently. This is the one step
nothing can automate.

---

## 6. Commit and push

Work on a branch, one branch per chapter or per template change:

```bash
git checkout -b vol1-ch3-theorems

git status
git add books/01-linear-algebra/chapters/03_theorems.tex
git commit -m "vol1: add proof of the diagonalisability criterion"
git push -u origin vol1-ch3-theorems
```

Then open a pull request on GitHub. The checklist in the PR template is the
quality gate; CI compiles every volume and attaches the PDFs, so you can
download and read the result before merging.

When the branch is merged:

```bash
git checkout main
git pull
git branch -d vol1-ch3-theorems
```

Never commit generated files: `.gitignore` already excludes `*.aux`, `*.log`,
`*.pdf` and friends. If `git status` shows them, your `.gitignore` is not in effect.

### Commit message convention

```
vol1: add worked examples on diagonalisation
template: soften the theorem box border
docs: clarify the TEXINPUTS explanation
fix: correct the sign error in Exercise 5.3
```

---

## 7. Start a new volume

```bash
scripts/new-book.sh 02-real-analysis "Real Analysis" 2 dmzteal
cd books/02-real-analysis
latexmk -pdf book.tex
```

You get a complete, already compiling skeleton: cover, front matter, the seven
chapter files, `figures/`, `references.bib`, `.latexmkrc`. Only the mathematics
is missing, which is exactly as it should be.

---

## 8. When something breaks

| Message | Cause | Fix |
|---|---|---|
| `docmathdz.cls not found` | built from the wrong directory, or opened a single volume folder in VS Code | build from inside `books/<volume>/`; open the repo root in VS Code |
| `Undefined control sequence \Ker` | a macro was used before the style file was loaded, or you renamed it | check `template/style/docmath-macros.sty` |
| `Reference ?? on page N undefined` | wrong or missing `\label` | fix the label; a clean rebuild resolves the numbering |
| `Empty bibliography` | biber did not run | `latexmk -C` then rebuild; check `references.bib` keys |
| `Package tcolorbox Error: unknown option` | TeX distribution too old | update TeX Live, or install `tcolorbox` and `pgf` |
| Index empty | `\printindex` present but no `\term{}` used | index the terms |
| PDF unchanged after editing | you edited an included file that latexmk is not watching | save the root file, or `latexmk -C` and rebuild |

When a log is unreadable, delete everything and start clean: `latexmk -C`. Ninety
percent of mysterious LaTeX problems are stale auxiliary files.
