# AI-Assisted Workflow

Artificial intelligence is used as an **academic assistant, not as the author**.

## Allowed responsibilities

- Drafting LaTeX code and skeletons.
- Improving explanations and typography.
- Generating additional examples and counter-examples.
- Checking proofs and looking for gaps.
- Creating TikZ / PGFPlots figures.
- Formatting mathematical content.
- Reviewing consistency of notation across chapters.
- Detecting errors.

## Not allowed

- Publishing unreviewed mathematics.
- Inventing references, theorem attributions or exam sources.
- Producing a whole book in one pass without human review.

## Pipeline

```
Notion (vision, planning, chapter briefs)
        ↓
AI drafting (LaTeX, examples, figures, proof checks)
        ↓
GitHub repository  ← single source of truth
        ↓
VS Code (human editing and review)
        ↓
git pull / commit
        ↓
latexmk → PDF
        ↓
Published on Doc Math DZ
```

## Prompt template for a new chapter

> You are drafting Chapter N of *Doc Math DZ — <Subject>*, Volume V.
> Follow `docs/EDITORIAL_GUIDE.md` exactly: mandatory section order, intuition before
> formalism, complete proofs, no forbidden phrases, macros from `docmath-macros.sty`,
> environments from `docmath-theorems.sty`, TikZ for all figures.
> Output only the LaTeX body of `chapters/NN_name.tex`. Do not redefine environments
> or load packages.

## Review rule

A chapter is merged only when a human has read every proof and recomputed every
numerical example. Mark reviewed chapters in the pull request description.
