$ENV{'TEXINPUTS'} = '.:' . '../..//:' . ($ENV{'TEXINPUTS'} || '');
$pdf_mode  = 1;
$pdflatex  = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$bibtex_use = 2;
@default_files = ('minimal-example.tex');
