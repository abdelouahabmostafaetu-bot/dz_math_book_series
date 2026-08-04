# Template test document. Build with:  latexmk -pdf minimal-example.tex
# Platform-dependent TEXINPUTS separator; see template/latexmkrc.

my $sep = ($^O =~ /^(MSWin|msys|cygwin|dos|os2)/i) ? ';' : ':';

my @texinputs = ('.', '../..//');
$ENV{'TEXINPUTS'} = join($sep, @texinputs) . $sep . ($ENV{'TEXINPUTS'} || '');

$pdf_mode   = 1;
$pdflatex   = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$bibtex_use = 2;

@default_files = ('minimal-example.tex');

$clean_ext = 'bbl idx ilg ind run.xml synctex.gz xdv';
