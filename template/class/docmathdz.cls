%% ===================================================================
%%  docmathdz.cls -- Doc Math DZ Book Series master book class
%%  Author : Abdelouahab Mostafa
%%  Licence: MIT (see LICENSE)
%%
%%  One class for the whole series: trim size, fonts, headings, theorem
%%  boxes, cover, front matter, index and bibliography.
%%  Books must NOT redefine any of this locally.
%%
%%  Options:
%%    print   (default) two-sided, binding offset, print-safe colours
%%    screen            symmetric margins, tighter, for on-screen reading
%% ===================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{docmathdz}[2026/08/04 v1.0 Doc Math DZ Book Series]

\newif\ifdmz@screen \dmz@screenfalse
\DeclareOption{screen}{\dmz@screentrue}
\DeclareOption{print}{\dmz@screenfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{print}
\ProcessOptions\relax

\LoadClass[11pt,twoside,openright]{book}

%% ------------------------------------------------------------------
%% 1. Encoding, mathematics and fonts
%% ------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{mathtools}          % loads amsmath
\RequirePackage{amssymb}
\RequirePackage{amsthm}

% Palatino-style text with matching mathematics: the classic look of
% premium graduate textbooks. Falls back to Latin Modern if absent.
\IfFileExists{newpxtext.sty}{%
  \RequirePackage{newpxtext}%
  \IfFileExists{newpxmath.sty}{\RequirePackage{newpxmath}}{}%
}{\RequirePackage{lmodern}}
\IfFileExists{beramono.sty}{\RequirePackage[scaled=0.85]{beramono}}{}
\RequirePackage{bm}
\RequirePackage[final]{microtype}
\linespread{1.06}
\frenchspacing

%% ------------------------------------------------------------------
%% 2. Page geometry -- trim size 170 x 240 mm
%% ------------------------------------------------------------------
\RequirePackage{geometry}
\ifdmz@screen
  \geometry{paperwidth=170mm,paperheight=240mm,
            inner=20mm,outer=20mm,top=22mm,bottom=25mm,
            headsep=7mm,footskip=12mm}
\else
  \geometry{paperwidth=170mm,paperheight=240mm,
            inner=22mm,outer=18mm,top=24mm,bottom=26mm,
            bindingoffset=5mm,headsep=7mm,footskip=12mm}
\fi

%% ------------------------------------------------------------------
%% 3. Graphics, tables, lists, captions
%% ------------------------------------------------------------------
\RequirePackage{xcolor}
\RequirePackage{docmath-colors}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,positioning,calc,patterns,decorations.pathmorphing,
                intersections,matrix,shapes.geometric}
\IfFileExists{pgfplots.sty}{\RequirePackage{pgfplots}\pgfplotsset{compat=1.17}}{}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{enumitem}
\RequirePackage{caption}
\RequirePackage{emptypage}

%% ------------------------------------------------------------------
%% 4. Numbering: everything per chapter
%% ------------------------------------------------------------------
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{1}
\numberwithin{equation}{chapter}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}

%% ------------------------------------------------------------------
%% 5. Index and bibliography
%% ------------------------------------------------------------------
\RequirePackage{imakeidx}
\makeindex[intoc=true,columns=2,title=Index]
\RequirePackage[backend=biber,style=numeric-comp,sorting=nyt,giveninits=true,
                maxbibnames=6,isbn=false,url=false]{biblatex}

%% ------------------------------------------------------------------
%% 6. Links (hyperref, then cleveref -- order matters)
%% ------------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{%
  colorlinks=true,
  linkcolor=dmzlink,
  citecolor=dmzlink,
  urlcolor=dmzlink,
  linktoc=all,
  bookmarksnumbered=true,
  bookmarksopen=true,
  pdfstartview=FitH,
}
\RequirePackage[nameinlink,capitalise]{cleveref}

%% ------------------------------------------------------------------
%% 7. Doc Math DZ design system
%% ------------------------------------------------------------------
\RequirePackage{docmath-typography}
\RequirePackage{docmath-theorems}
\RequirePackage{docmath-macros}
\RequirePackage{docmath-cover}

\AtBeginDocument{%
  \hypersetup{pdftitle={\dmz@title},pdfauthor={\dmz@author},
              pdfsubject={\dmz@subject},
              pdfkeywords={\dmz@series, \dmz@subject, PhD entrance examinations}}%
}

%% ------------------------------------------------------------------
%% 8. Front matter pages
%% ------------------------------------------------------------------

% Half-title page
\newcommand{\dmzhalftitlepage}{%
  \thispagestyle{empty}%
  \vspace*{0.25\textheight}%
  \noindent{\sffamily\bfseries\fontsize{26}{30}\selectfont\color{dmzink}\dmz@title\par}%
  \vspace{5mm}%
  \noindent{\color{dmzaccent}\rule{38mm}{1.4pt}}\par
  \vspace{5mm}%
  \noindent{\sffamily\large\color{dmzsoft}\dmz@series\ \textperiodcentered\ Volume~\dmz@volume\par}%
  \cleardoublepage}

% Series page: the list of volumes of the collection
\newcommand{\dmzseriespage}[1]{%
  \thispagestyle{empty}%
  \noindent{\sffamily\bfseries\Large\color{dmzink}\dmz@series\par}%
  \vspace{2mm}\noindent{\color{dmzaccent}\rule{\textwidth}{0.8pt}}\par
  \vspace{4mm}%
  \noindent\begin{minipage}{\textwidth}\small #1\end{minipage}%
  \cleardoublepage}

% Full title page
\newcommand{\dmztitlepage}{%
  \begin{titlepage}%
  \thispagestyle{empty}%
  \noindent{\color{dmzaccent}\rule{\textwidth}{2.2pt}}\par
  \vspace{3mm}%
  \noindent{\sffamily\bfseries\small\color{dmzaccent}%
    \MakeUppercase{\dmz@series}\hfill VOLUME~\dmz@volume\par}%
  \vspace*{0.16\textheight}%
  \noindent{\sffamily\bfseries\fontsize{34}{40}\selectfont\color{dmzink}\dmz@title\par}%
  \vspace{4mm}%
  \ifx\dmz@subtitle\@empty\else
    \noindent{\sffamily\fontsize{15}{19}\selectfont\color{dmzsoft}\dmz@subtitle\par}%
    \vspace{4mm}%
  \fi
  \noindent{\color{dmzaccent}\rule{45mm}{1pt}}\par
  \vspace{4mm}%
  \ifx\dmz@tagline\@empty\else
    \noindent{\sffamily\small\color{dmzsoft}\dmz@tagline\par}%
  \fi
  \vfill
  \noindent{\sffamily\large\color{dmzink}\dmz@author\par}%
  \vspace{2mm}%
  \noindent{\sffamily\small\color{dmzsoft}\dmz@edition\ \textperiodcentered\ \dmz@year\par}%
  \vspace{6mm}%
  \noindent\raisebox{-1mm}{\dmzlogo[1]}\hspace{3mm}%
  {\sffamily\small\bfseries\color{dmzink}DOC MATH DZ}\par
  \vspace{3mm}%
  \noindent{\color{dmzrule}\rule{\textwidth}{0.6pt}}%
  \end{titlepage}}

% Copyright / imprint page
\newcommand{\dmzcopyrightpage}[1][]{%
  \thispagestyle{empty}%
  \null\vfill
  \noindent\begin{minipage}{\textwidth}\small\setlength{\parskip}{1.6ex}
    \textbf{\dmz@title}\\
    \dmz@series\ \textperiodcentered\ Volume~\dmz@volume\ \textperiodcentered\ \dmz@subject

    \copyright\ \dmz@year\ \dmz@author. All rights reserved.

    Book text, exercises, solutions and figures are released under the Creative
    Commons Attribution\,--\,NonCommercial\,--\,ShareAlike 4.0 International licence.
    The LaTeX class, styles and scripts of the series are released under the MIT licence.

    This volume is an independent, self-published work of the Doc Math DZ project.
    It is not affiliated with, endorsed by, or connected to any commercial academic
    publisher; the design is the original visual identity of the series.

    Typeset by the author with \LaTeX{} using the \texttt{docmathdz} class.

    #1
  \end{minipage}
  \cleardoublepage}

% Convenience wrapper: the whole standard front matter
\newcommand{\dmzfrontmatter}[1]{%
  \frontmatter
  \dmzmakecover
  \dmzhalftitlepage
  \dmzseriespage{#1}%
  \dmztitlepage
  \dmzcopyrightpage
  \tableofcontents
  \cleardoublepage}

\endinput
