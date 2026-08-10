# Problem Routing Specification

How problems from the DocMath DZ exam database are dispatched into the volumes of
this series. The database is **read-only** for this process: only its list/read
endpoints are ever called, and nothing is written back to it.

## Core principle: route the problem, never the exam

An exam carries a single `specialty` field, but Algerian doctoral papers are
frequently mixed. Routing by `specialty` therefore misfiles a large fraction of
the corpus. Measured on the 35 exams filed under `Algèbre`:

| Exam | Filed as | Actually contains |
|---|---|---|
| Oran 1, 2017, both épreuves | Algèbre | ODEs, Fourier transforms, residues, Sobolev distributions, heat equation, Hilbert operators — **no algebra at all** |
| Sétif 1, 2022 | Algèbre | kernels/images, eigenvalues, matrices of polynomial maps — **pure linear algebra** |
| Mila, 2023, épreuve 22 | Algèbre | a power-series ODE and a matrix problem — **no algebra at all** |
| USTHB, 2014, épreuve 02 | Algèbre | cohomology rings, symplectic forms, fundamental groups, Hopf fibration — **topology** |
| USTHB, 2013 / 2012 | Algèbre | graph colouring, perfect graphs, Pascal identities — **discrete mathematics** |
| Oran 1, 2023, épreuve 03 | Algèbre | one field-theory exercise, one functional equation, one $\ell_2$ operator problem |

Every problem is therefore classified **individually**, from its own `tags` plus a
keyword scan of its own statement. The parent exam's `specialty` is used only as a
tie-breaker when a problem is genuinely ambiguous.

## The router

First match wins; the table is ordered from most specific to least specific.

| Signals in `tags` or statement | Destination volume |
|---|---|
| holomorphe, méromorphe, résidu, Cauchy, conforme, pôle | `12-complex-analysis` |
| Banach, Hilbert, opérateur, spectre, semi-groupe, distribution, Sobolev, $H^s$, $\ell_2$, $L^p$, graphe fermé, convergence faible, Fourier | `05-functional-analysis` |
| mesure, tribu, Lebesgue, presque partout, intégrabilité | `04-measure-theory` |
| compact, connexe, ouvert, fermé, topologie, cohomologie, homotopie, revêtement, variété, symplectique, fibration | `03-topology` |
| EDP, dérivées partielles, laplacien, chaleur, ondes, problème de Cauchy, variationnel | `07-pde` |
| EDO, équation différentielle, système dynamique, stabilité, point fixe, flot, bifurcation | `10-dynamical-systems` |
| probabilité, loi, variable aléatoire, espérance, martingale, estimateur, statistique | `08-probability-statistics` |
| schéma numérique, éléments finis, différences finies, interpolation, quadrature, convergence d'algorithme numérique | `09-numerical-analysis` |
| programmation linéaire, simplexe, dualité, graphe pondéré, flot maximal, contrôle optimal, ordonnancement | `11-operations-research` |
| graphe, coloration, chromatique, clique, stable, biparti, planaire, complexité, NP, algorithme, dénombrement asymptotique | `13-discrete-mathematics` |
| groupe, anneau, idéal, corps, Galois, module, polynôme minimal, extension, Sylow, nilpotent (groupe/anneau), treillis, relation d'ordre, fonction arithmétique, code, cryptographie | `06-algebra` |
| matrice, endomorphisme, diagonalisable, valeur propre, vecteur propre, déterminant, trace, rang, forme quadratique, nilpotente (matrice), semblable | `01-linear-algebra` |
| suite, série, série entière, dérivabilité, continuité, intégrale, équation fonctionnelle, dénombrabilité, récurrence | `02-real-analysis` |

### Statement fallback

Several records carry an empty `tags` array (for example Mila 2023 épreuve 22 and
both Ouargla 2022 papers). Tag-only routing silently drops these, so the keyword
scan runs against the French statement text as well.

### Disambiguation rules

- **Nilpotent** splits by object: a nilpotent *matrix* goes to `01`, a nilpotent
  *group* or a nil *ideal* goes to `06`.
- **Order theory** (lattices, Hasse diagrams, relation dimension, distributivity)
  goes to `06`, matching the Algerian *Algèbre et Mathématiques Discrètes*
  syllabus.
- **Generating functions and formal power series** go to `06`; the analytic
  convergence questions built on them go to `02`.
- **Ordinary differential equations** go to `10`, matching the database
  convention where EDO papers are filed under *Systèmes Dynamiques*.

## Deduplication

Matching on `university + year + examNumber` is **not sufficient**. Real cases in
the corpus:

- Sétif 1, 2025, épreuve 02 and épreuve 11 are the same three exercises (maximal
  simple subgroup, Frattini, groups of order $p^3q$) under two different exam
  numbers, one copy with solutions and one without.
- USTHB, 2014, épreuve 09 repeats all four exercises of épreuve 04 verbatim.
- The exercise "$x^4+x+1$ irreducible over $\mathbb{F}_2$, construct
  $\mathbb{F}_{16}$" appears **five times** across the M'Sila 2015–2016 papers.
- The exercise "$E=\{a,b,c,d,e\}$: count reflexive/irreflexive/symmetric
  relations, Hasse diagrams" appears **four times**.
- Ouargla 2022 general and Ouargla 2022 specialty share exercises 1 and 2
  verbatim and differ only in exercise 3 (the field is $\mathbb{Q}(\sqrt2,i)$ in
  one and $\mathbb{Q}(\sqrt2,\sqrt3)$ in the other).

The key is therefore a **normalised fingerprint of the statement text**
(whitespace collapsed, markdown emphasis and barème markers stripped, case
folded). When two problems collide, the copy that carries a solution is kept.
Genuine variants of a common template, such as the two Ouargla exercise 3
variants, are kept separately and flagged as variants.

## Exclusions

- Problems with an empty or placeholder statement are skipped.
- Problems whose transcription is explicitly flagged as illegible in the source
  `remark` are kept only when the mathematical content is still recoverable, and
  the warning is carried into the `\source` line.

## Ordering inside a volume

1. `\section` per university.
2. Within a university, ascending year (oldest first).
3. Within a year, ascending épreuve number, then problem number.

University sections are ordered alphabetically. The university name is taken from
the record's `university` field, which is authoritative even when the title
disagrees: the 2015 paper slugged `...m-sila-2015-specialty-35` carries
`Université Kasdi Merbah - Ouargla` and is filed under Ouargla.

## Source line

Every imported problem ends with:

```latex
\source{\emph{\small <University>, <year>, Épreuve~n\textsuperscript{o}~<nn>.}}
```

## Scope guarantees

The import never touches `template/`, never edits `book.tex` or any chapter other
than `06_doctoral_problems.tex`, and never alters a problem already present in a
book.

## Run log

### Run 1 — specialty `Algèbre`, 35 exams, 106 problems

| Destination | Problems |
|---|---|
| `06-algebra` | 50 |
| `01-linear-algebra` | 9 |
| `13-discrete-mathematics` | 9 |
| `02-real-analysis` | 4 |
| `03-topology` | 4 |
| `05-functional-analysis` | 4 |
| `07-pde` | 1 |
| `10-dynamical-systems` | 1 |
| `12-complex-analysis` | 1 |
| dropped as duplicates | 23 |

Committed in run 1: `06-algebra` (50) and `01-linear-algebra` (9). The remaining
33 routed problems are queued for the volumes that do not yet exist as books.
