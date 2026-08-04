# Building the books

## Requirements

- TeX Live 2021 or newer (`texlive-full` recommended; the template uses
  `tcolorbox`, `newpx`, `titlesec`, `titletoc`, `imakeidx`, `biblatex`, `tikz`,
  `pgfplots`, `cleveref`, `microtype`, `emptypage`, `beramono`)
- `latexmk`
- `biber`

On Debian/Ubuntu:

```bash
sudo apt install texlive-full latexmk biber
```

## Why `.latexmkrc` matters

The design system is shared: it lives in `template/` and is **not** copied into
each volume. LaTeX finds it through `TEXINPUTS`, which the `.latexmkrc` of each
volume sets to `.:../../template//:`.

Consequence: always build with `latexmk` from inside the volume directory.
If you compile from VS Code (LaTeX Workshop), either keep `latexmk` as the recipe
(recommended, it reads `.latexmkrc`), or set the environment variable yourself:

```bash
export TEXINPUTS=.:$PWD/../../template//:
```

## Commands

```bash
cd books/01-linear-algebra && latexmk -pdf book.tex   # one volume
scripts/build.sh --all                                # every volume
scripts/build.sh --template                           # template test document
scripts/build.sh --clean                              # remove artefacts
```

Before committing a change to `template/`, always run
`scripts/build.sh --template`: `template/examples/minimal-example.tex` exercises
every environment of the series and is the fastest way to catch a regression.

## Screen vs print

`\documentclass[print]{docmathdz}` gives a binding offset and asymmetric margins.
`\documentclass[screen]{docmathdz}` gives symmetric margins for on-screen reading.
The published PDF of a volume should be produced twice, once with each option.

## Continuous integration

`.github/workflows/build.yml` compiles every `books/*/book.tex` on each push and
uploads the PDFs as build artefacts, so a broken template is caught immediately.
