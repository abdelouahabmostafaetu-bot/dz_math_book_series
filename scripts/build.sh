#!/usr/bin/env bash
# ---------------------------------------------------------------------------
#  build.sh -- compile one volume or the whole series
#
#  Usage:
#    scripts/build.sh 01-linear-algebra    # one volume
#    scripts/build.sh --all                # every volume
#    scripts/build.sh --template           # the template test document
#    scripts/build.sh --clean              # remove build artefacts
# ---------------------------------------------------------------------------
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

build_one () {
  local dir="$1"
  echo "==> building $dir"
  ( cd "$dir" && latexmk -pdf -interaction=nonstopmode -file-line-error book.tex )
}

case "${1:---all}" in
  --all)
    for d in "$ROOT"/books/*/; do
      [[ -f "$d/book.tex" ]] && build_one "$d"
    done
    ;;
  --template)
    ( cd "$ROOT/template/examples" \
      && TEXINPUTS=".:$ROOT/template//:" latexmk -pdf minimal-example.tex )
    ;;
  --clean)
    for d in "$ROOT"/books/*/ "$ROOT"/template/examples/; do
      ( cd "$d" && latexmk -C >/dev/null 2>&1 || true )
    done
    echo "cleaned"
    ;;
  *)
    build_one "$ROOT/books/$1"
    ;;
esac
