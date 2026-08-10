# ---------------------------------------------------------------------------
#  Volume 6 -- Algebra. Build with:  latexmk -pdf book.tex
#  Keep in sync with template/latexmkrc.
#
#  The TEXINPUTS separator differs between Windows (;) and Unix (:), so it is
#  detected below. A hard-coded ':' breaks MiKTeX with the misleading error
#  "File `docmathdz.cls' not found".
# ---------------------------------------------------------------------------

my $sep = ($^O =~ /^(MSWin|msys|cygwin|dos|os2)/i) ? ';' : ':';

my @texinputs = ('.', '../../template//');
$ENV{'TEXINPUTS'} = join($sep, @texinputs) . $sep . ($ENV{'TEXINPUTS'} || '');
$ENV{'BIBINPUTS'} = '.' . $sep . ($ENV{'BIBINPUTS'} || '');

$pdf_mode   = 1;
$pdflatex   = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$bibtex_use = 2;
$max_repeat = 6;

@default_files = ('book.tex');

$clean_ext = 'bbl idx ilg ind run.xml synctex.gz xdv';
