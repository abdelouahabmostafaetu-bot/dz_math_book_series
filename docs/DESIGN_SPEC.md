# Professional Book Design Specification

The book must look like a professionally published mathematics textbook, comparable
in quality to the graduate-level series of major academic publishers.

> **Important.** Do not copy any publisher's cover, trade dress or logo. Only the
> general academic style is a source of inspiration; the visual identity belongs to
> **Doc Math DZ Book Series**.

## General style

- Elegant and minimalist.
- Premium academic appearance.
- High typographic quality.
- Designed for long reading sessions.
- Suitable for digital viewing and high-quality printing.
- Consistent formatting throughout the entire book.

## Cover design

- Clean mathematical aesthetic; ivory or white background with a subtle geometric pattern.
- One vertical accent band whose colour identifies the subject.
- Large title, smaller subtitle, subject line, tagline.
- Author name, `Doc Math DZ Book Series` branding, volume number, small modern logo.
- No flashy colours, no unnecessary illustrations, balanced spacing.

Implemented by `template/cover/docmath-cover.sty` (`\dmzset`, `\dmzmakecover`).

## Interior layout

- Trim size 170 x 240 mm, two-sided, `openright`.
- Half-title, series page, title page, copyright page.
- Table of contents, chapter opening pages, running headers, page numbers.
- Elegant margins with binding offset in print mode.
- Professional equation numbering (per chapter), cross-references, hyperlinks.
- Index and bibliography.

## Mathematical environments

Visually distinct, print-safe boxes for: definition, theorem, lemma, proposition,
corollary, example, remark, note, warning, exercise, doctoral problem, solution,
intuition, key points, common mistakes, summary.

All theorem-like environments share one counter per chapter, so numbering reads
`Theorem 2.4`, `Definition 2.5`, ... in strict document order.

## Figures

- Vector graphics only: TikZ, PGFPlots, commutative diagrams, `booktabs` tables.
- Avoid raster images. If unavoidable, minimum 600 dpi.

## Educational sequence (every chapter)

1. Motivation 2. Historical background 3. Intuition 4. Formal definitions
5. Fundamental properties 6. Theorems 7. Complete proofs 8. Worked examples
9. Visual explanations 10. Common mistakes 11. Summary 12. Practice problems
13. Doctoral entrance problems 14. Fully worked solutions 15. Further reading

## Typography

- Palatino-style text and matching mathematics (`newpx`), monospaced code font.
- Line spread 1.06, generous but balanced leading.
- Consistent heading hierarchy, sans-serif display headings.
- Excellent PDF quality (Type 1 / OpenType outlines, hyperlinked, tagged TOC).

## LaTeX standards

Clean, modular, commented, reusable LaTeX split into multiple files and suitable for
Git version control. No formatting done by hand inside the text: everything goes
through the class and style files.

## Overall goal

The final PDF should be indistinguishable in quality from a commercially published
graduate-level mathematics textbook.
