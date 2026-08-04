# Troubleshooting

## `File 'docmathdz.cls' not found`

The file exists in `template/class/`. This error always means the compiler was
not told where to look, for one of three reasons.

**1. You compiled from the wrong directory.**

```
PS D:\dz_math_book_series> latexmk -pdf book.tex
Rc files read:
  NONE
Latexmk: Could not find file 'book.tex'.
```

`Rc files read: NONE` is the giveaway: `.latexmkrc` was never read, so
`TEXINPUTS` was never set. Move into the volume directory first:

```powershell
cd D:\dz_math_book_series\books\01-linear-algebra
latexmk -pdf book.tex
```

A correct run starts with:

```
Rc files read (in order):
  ./.latexmkrc
```

**2. Wrong `TEXINPUTS` separator (the Windows trap).**

This one is nasty because `.latexmkrc` *is* read and the build still fails.
The list separator inside `TEXINPUTS` is platform dependent:

| Platform | Separator |
|---|---|
| Windows (MiKTeX, TeX Live for Windows), native PowerShell / cmd | `;` |
| Linux, macOS, WSL, Git Bash, Cygwin | `:` |

With the wrong separator the whole value is read as one nonsensical directory
name, so nothing is found. Every `.latexmkrc` in this repository therefore
detects the platform:

```perl
my $sep = ($^O =~ /^(MSWin|msys|cygwin|dos|os2)/i) ? ';' : ':';
$ENV{'TEXINPUTS'} = join($sep, '.', '../../template//') . $sep . ($ENV{'TEXINPUTS'} || '');
```

If you write a `.latexmkrc` by hand, copy `template/latexmkrc` instead.

To confirm what the compiler actually received:

```powershell
$env:TEXINPUTS = ".;../../template//;"
kpsewhich docmathdz.cls
```

`kpsewhich` should print the path to `template/class/docmathdz.cls`. If it prints
nothing, the variable is still wrong.

**3. A one-off manual build.** Set the variable yourself, with the separator of
your platform:

```powershell
# Windows PowerShell
$env:TEXINPUTS = ".;../../template//;"
pdflatex book.tex
```

```bash
# Linux / macOS / WSL / Git Bash
TEXINPUTS=".:../../template//:" pdflatex book.tex
```

---

## Other frequent errors

| Message | Cause | Fix |
|---|---|---|
| `Undefined control sequence \Ker` | macro used but style not loaded, or renamed | check `template/style/docmath-macros.sty` |
| `Reference ?? on page N undefined` | missing or misspelled `\label` | fix the label, then rebuild; two passes are needed |
| `Empty bibliography` | biber did not run | `latexmk -C`, then rebuild; check keys in `references.bib` |
| `Package tcolorbox Error: unknown option` | TeX distribution too old | update MiKTeX / TeX Live |
| `I can't write on file 'book.pdf'` | the PDF is open in a locking viewer | close the viewer, or use the VS Code internal tab |
| Index empty | no `\term{...}` used | index terms on first occurrence |
| PDF unchanged after an edit | stale auxiliary files | `latexmk -C`, then rebuild |

## MiKTeX specific

- On first build MiKTeX may pause to install packages. Allow it, or pre-install:
  `mpm --install=tcolorbox --install=newpx --install=titlesec --install=titletoc --install=imakeidx --install=biblatex --install=pgfplots --install=cleveref --install=microtype --install=emptypage --install=beramono`
- Set "install missing packages on the fly" to *Yes* in the MiKTeX Console,
  otherwise the build stops at the first missing package.
- Verify the toolchain: `pdflatex --version`, `biber --version`, `latexmk --version`.

## The golden rule

When a log becomes unreadable, delete every generated file and start clean:

```bash
latexmk -C
```

Most mysterious LaTeX failures are stale `.aux`, `.bbl` or `.fls` files, not
real errors in your source.
