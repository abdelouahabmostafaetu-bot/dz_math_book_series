#!/usr/bin/env bash
# ---------------------------------------------------------------------------
#  new-book.sh -- create a new volume of the Doc Math DZ Book Series
#
#  Usage:
#    scripts/new-book.sh <dir-name> <Subject> <volume-number> [accent-colour]
#
#  Example:
#    scripts/new-book.sh 07-group-theory "Group Theory" 7 dmzplum
#
#  Accent colours available: dmzblue dmzteal dmzgreen dmzplum dmzwine
#                            dmzocre dmzslate dmzcopper
# ---------------------------------------------------------------------------
set -euo pipefail

if [[ $# -lt 3 ]]; then
  echo "usage: $0 <dir-name> <Subject> <volume-number> [accent-colour]" >&2
  exit 1
fi

DIR="$1"
SUBJECT="$2"
VOLUME="$3"
ACCENT="${4:-dmzblue}"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BOOK="$ROOT/books/$DIR"

if [[ -e "$BOOK" ]]; then
  echo "error: $BOOK already exists" >&2
  exit 1
fi

mkdir -p "$BOOK/chapters" "$BOOK/figures"

# ---- build configuration --------------------------------------------------
cat > "$BOOK/.latexmkrc" <<'EOF'
$ENV{'TEXINPUTS'} = '.:' . '../../template//:' . ($ENV{'TEXINPUTS'} || '');
$pdf_mode  = 1;
$pdflatex  = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$bibtex_use = 2;
$clean_ext = 'synctex.gz run.xml bbl idx ind ilg auxlock';
@default_files = ('book.tex');
EOF

# ---- master file ----------------------------------------------------------
cat > "$BOOK/book.tex" <<EOF
%% Doc Math DZ Book Series -- Volume $VOLUME: $SUBJECT
\\documentclass[print]{docmathdz}

\\dmzset{
  title    = $SUBJECT,
  subtitle = Theory, Intuition and Doctoral Entrance Problems,
  subject  = $SUBJECT,
  tagline  = Theory \\textperiodcentered\\ Intuition \\textperiodcentered\\ Proofs
             \\textperiodcentered\\ Examples \\textperiodcentered\\ PhD Problems,
  author   = Abdelouahab Mostafa,
  volume   = $VOLUME,
  accent   = $ACCENT,
  edition  = First Edition,
  year     = \\the\\year,
}

\\addbibresource{references.bib}

\\begin{document}
\\dmzfrontmatter{Volume $VOLUME of the series.}

\\chapter*{Preface}
\\addcontentsline{toc}{chapter}{Preface}
Write the preface here.

\\mainmatter
\\include{chapters/01_introduction}
\\include{chapters/02_definitions}
\\include{chapters/03_theorems}
\\include{chapters/04_examples}
\\include{chapters/05_summary}
\\include{chapters/06_doctoral_problems}
\\include{chapters/07_solutions}

\\backmatter
\\printbibliography[heading=bibintoc,title={References}]
\\printindex
\\end{document}
EOF

# ---- chapter skeletons ----------------------------------------------------
make_chapter () {
  local file="$1" title="$2" label="$3"
  cat > "$BOOK/chapters/$file" <<EOF
\\chapter{$title}
\\label{ch:$label}

\\section{Motivation}

\\section{Historical background}

\\section{Intuition}

\\section{Definitions}

\\section{Fundamental properties}

\\section{Theorems and proofs}

\\section{Worked examples}

\\section{Visual explanations}

\\section{Common mistakes}

\\section{Summary}

\\section{Further reading}
EOF
}

make_chapter 01_introduction.tex      "Introduction and Orientation" introduction
make_chapter 02_definitions.tex       "Core Definitions"             definitions
make_chapter 03_theorems.tex          "Fundamental Theorems and Proofs" theorems
make_chapter 04_examples.tex          "Illustrative Examples"        examples
make_chapter 05_summary.tex           "Common Mistakes, Summary and Practice" summary
make_chapter 06_doctoral_problems.tex "Doctoral Entrance Problems"   problems
make_chapter 07_solutions.tex         "Fully Worked Solutions"       solutions

# ---- bibliography ---------------------------------------------------------
cat > "$BOOK/references.bib" <<EOF
% References for Volume $VOLUME -- $SUBJECT.
% Only books actually consulted may stay in this file.
EOF

echo "Created books/$DIR (Volume $VOLUME, $SUBJECT, accent $ACCENT)."
echo "Next: cd books/$DIR && latexmk -pdf book.tex"
