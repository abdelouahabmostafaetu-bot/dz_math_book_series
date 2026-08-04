# Build configuration for this volume.
# The shared design system lives in ../../template and is found through TEXINPUTS.
$ENV{'TEXINPUTS'} = '.:' . '../../template//:' . ($ENV{'TEXINPUTS'} || '');
$ENV{'TEXMFOUTPUT'} = '.';

$pdf_mode  = 1;
$pdflatex  = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$bibtex_use = 2;          # biblatex/biber handled automatically
$clean_ext = 'synctex.gz run.xml bbl idx ind ilg glo gls auxlock';
@default_files = ('book.tex');
