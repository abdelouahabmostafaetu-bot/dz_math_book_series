# Books

One directory per volume, named `NN-subject`. Volume numbers are fixed once and
never reused.

| Directory | Volume | Subject | Accent colour | Status |
|---|---|---|---|---|
| `01-linear-algebra` | 1 | Linear Algebra | `dmzblue` | in progress |
| `02-real-analysis` | 2 | Real Analysis | `dmzteal` | planned |
| `03-topology` | 3 | Topology | `dmzgreen` | planned |
| `04-measure-theory` | 4 | Measure Theory | `dmzwine` | planned |
| `05-functional-analysis` | 5 | Functional Analysis | `dmzslate` | planned |

To start a new volume, never copy an existing one by hand:

```bash
scripts/new-book.sh 03-topology "Topology" 3 dmzgreen
```

The generator creates `book.tex`, the seven chapter files, `figures/`,
`references.bib` and `.latexmkrc`, all wired to the shared template.
