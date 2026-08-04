# Fonts

The series uses only fonts shipped with TeX Live, so that any machine and the CI
workflow produce byte-comparable PDFs:

- **Text and mathematics**: `newpx` (Palatino-style, with matching maths).
  Fallback: Latin Modern, selected automatically if `newpx` is missing.
- **Display headings, cover, boxes titles**: the sans-serif companion of `newpx`.
- **Code and verbatim**: Bera Mono, scaled to 0.85.

Put a font here only if a volume genuinely needs a face that TeX Live does not
provide, and add a note explaining the licence.
