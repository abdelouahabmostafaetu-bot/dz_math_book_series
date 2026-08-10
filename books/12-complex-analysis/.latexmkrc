my $sep = ($^O =~ /^(MSWin|msys|cygwin|dos|os2)/i) ? ';' : ':';
my @texinputs = ('.', '../../template//');
$ENV{'TEXINPUTS'} = join($sep, @texinputs) . $sep . ($ENV{'TEXINPUTS'} || '');
$ENV{'BIBINPUTS'} = '.' . $sep . ($ENV{'BIBINPUTS'} || '');
$pdf_mode=1;
$pdflatex='pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$bibtex_use=2; $max_repeat=6; @default_files=('book.tex');
$clean_ext='bbl idx ilg ind run.xml synctex.gz xdv';
