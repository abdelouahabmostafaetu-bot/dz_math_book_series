# Editorial Guide — Doc Math DZ Book Series

This guide is **binding**. AI assistance and human authors must follow it strictly.
The goal is a series where every volume feels written by the same careful editor.

## 1. Scope rule

One book = one subject. A volume on Topology contains no measure theory chapter.
If a prerequisite is needed, state it in the *Prerequisites* section and cite the
volume where it is developed.

## 2. Chapter skeleton (mandatory order)

```latex
\chapter{Title}
\section{Motivation}          % why the subject exists, a concrete question
\section{Historical background} % 1 short paragraph, dated, accurate
\section{Intuition}            % informal picture, no formalism
\section{Definitions}          % formal, numbered
\section{Fundamental properties}
\section{Theorems and proofs}   % complete proofs, no "it is easy to see"
\section{Worked examples}
\section{Visual explanations}   % TikZ / PGFPlots
\section{Common mistakes}
\section{Summary}
\section{Practice exercises}
\section{Doctoral entrance problems}
\section{Further reading}
```

Solutions live in `07_solutions.tex`, never next to the problem.

## 3. Writing rules

- Intuition **before** formalism, always.
- Every theorem has a complete proof, or an explicit reference plus the reason for
  omission.
- Forbidden phrases: *obviously*, *clearly*, *it is easy to see*, *left to the reader*
  (unless it is an exercise with a solution).
- Every non-trivial definition is followed by at least one example and one
  non-example.
- Quantifiers are explicit. Hypotheses of every statement are complete.
- Doctoral problems must record their origin: university, speciality, year.

## 4. LaTeX conventions

- Environments: `\begin{theorem}{Name}{label}` (tcolorbox theorem syntax:
  title, then label key). Reference with `\cref{thm:label}`.
- Use the macros of `docmath-macros.sty` (`\R`, `\C`, `\Span`, `\rank`, `\norm{}`,
  `\abs{}`, `\inner{}{}`) instead of ad hoc definitions.
- Display maths uses `\[ \]`, `equation`, `align`; never `$$`.
- One sentence per source line where possible: it makes Git diffs readable.
- No manual spacing (`\vspace`, `\\` for layout) in the text body.
- Labels are namespaced: `thm:`, `def:`, `lem:`, `prop:`, `cor:`, `ex:`, `exo:`,
  `prob:`, `fig:`, `tab:`, `eq:`, `ch:`, `sec:`.
- Figures are TikZ/PGFPlots in `figures/`, one file per figure, `\input` from the
  chapter.

## 5. Review checklist before publishing

- [ ] Compiles with zero errors; warnings reviewed.
- [ ] Every statement's hypotheses verified.
- [ ] Every proof read line by line by a human.
- [ ] Every numerical example recomputed independently.
- [ ] All cross-references and citations resolve.
- [ ] Index entries added for every new term.
- [ ] Consistent notation with the rest of the series.
- [ ] Cover metadata (volume, subject, accent colour) correct.
