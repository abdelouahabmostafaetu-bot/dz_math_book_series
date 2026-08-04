# Doc Math DZ Book Series

**Doc Math DZ Book Series** is an open-source collection of professionally written
mathematics books for self-study and PhD entrance examination preparation.
Each volume focuses on a **single mathematical subject**, combining rigorous theory,
intuitive explanations, worked examples, and fully solved doctoral entrance problems
from Algerian universities.

> One book = one subject. No volume mixes unrelated subjects.

---

## Repository layout

```
dz_math_book_series/
├── books/                  # one directory per volume
│   ├── 01-linear-algebra/
│   ├── 02-real-analysis/
│   └── ...
├── template/               # the shared LaTeX design system (all books use it)
│   ├── class/              # docmathdz.cls
│   ├── style/              # colors, typography, theorem boxes, math macros
│   ├── cover/              # cover generator
│   ├── fonts/
│   └── examples/           # minimal compilable example
├── assets/                 # logos, shared images
├── scripts/                # build helpers, new-book generator
├── docs/                   # editorial guide, design spec, AI workflow
└── README.md
```

Each book has the same internal structure:

```
books/01-linear-algebra/
├── book.tex
├── chapters/
│   ├── 01_introduction.tex
│   ├── 02_definitions.tex
│   ├── 03_theorems.tex
│   ├── 04_examples.tex
│   ├── 05_summary.tex
│   ├── 06_doctoral_problems.tex
│   └── 07_solutions.tex
├── figures/
├── references.bib
└── .latexmkrc
```

---

## Planned volumes

| Vol | Subject | Status |
|-----|---------------------|-------------|
| 1 | Linear Algebra | in progress |
| 2 | Real Analysis | planned |
| 3 | Topology | planned |
| 4 | Measure Theory | planned |
| 5 | Functional Analysis | planned |
| 6 | Probability Theory | planned |
| 7 | Group Theory | planned |
| 8 | Ring Theory | planned |
| 9 | Field Theory | planned |
| 10 | Complex Analysis | planned |
| 11 | Differential Equations | planned |
| 12 | Dynamical Systems | planned |
| 13 | Numerical Analysis | planned |
| 14 | Optimization | planned |
| 15 | Graph Theory | planned |

---

## Build a book

Requirements: a full TeX Live (2021 or newer), `latexmk`, `biber`.

```bash
cd books/01-linear-algebra
latexmk -pdf book.tex        # .latexmkrc already points TEXINPUTS to ../../template
```

Or from the repository root:

```bash
scripts/build.sh 01-linear-algebra   # build one volume
scripts/build.sh --all               # build every volume
```

Start a new volume:

```bash
scripts/new-book.sh 07-group-theory "Group Theory" 7 dmzplum
```

---

## Standard structure of every book

1. Cover page  2. Preface  3. Learning objectives  4. Roadmap of the subject
5. Prerequisites  6. Core definitions  7. Important theorems  8. Proofs
9. Intuitive explanations  10. Illustrative examples  11. Common mistakes
12. Summary  13. Practice exercises  14. Doctoral entrance problems
15. Fully worked solutions  16. References

---

## Workflow

```
Notion (planning)  →  AI drafting  →  GitHub (source of truth)  →  VS Code
   →  git pull  →  compile PDF  →  publish on Doc Math DZ
```

The GitHub repository is the single source of truth. AI is used as an academic
assistant, never as the author: every mathematical statement, proof and solution is
reviewed by a human before publication. See [`docs/AI_WORKFLOW.md`](docs/AI_WORKFLOW.md).

---

## Documentation

- [`docs/DESIGN_SPEC.md`](docs/DESIGN_SPEC.md) — professional book design specification
- [`docs/EDITORIAL_GUIDE.md`](docs/EDITORIAL_GUIDE.md) — strict editorial rules and LaTeX conventions
- [`docs/AI_WORKFLOW.md`](docs/AI_WORKFLOW.md) — how AI is used and reviewed

---

## Design identity

The series has its own visual identity: ivory paper, one accent colour per subject,
a vertical spine band, modern typography, and elegant theorem boxes. The academic
*style* of premium mathematics publishing is a source of inspiration; no publisher's
trade dress, logo or cover is copied.

## License

Code and LaTeX templates: MIT. Book text and figures: CC BY-NC-SA 4.0.

---

### ملاحظة

هذا المستودع هو المشروع الرئيسي للسلسلة كاملة. لا تبدأ بكتابة كتاب قبل تثبيت القالب
في مجلد `template/`، لأن جميع الكتب تعتمد عليه: أي تحسين في التصميم ينتقل تلقائيًا
إلى كل المجلدات.
