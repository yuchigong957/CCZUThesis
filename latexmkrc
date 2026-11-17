$pdf_mode = 5;
$xelatex = 'xelatex -no-shell-escape -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

# Clean only this document's intermediate files after a successful build.
# Keep PDF, BBL, TOC and SyncTeX (PDF/source navigation).
# Failed builds retain their diagnostics.
$success_cmd = 'internal thesis_cleanup %R %V %W';
sub thesis_cleanup {
    require File::Basename;
    require File::Spec;
    my ($root, $aux, $out) = @_;
    my $name = File::Basename::basename($root);
    for my $dir ($aux, $out) {
        for my $ext (qw(aux log blg out fls fdb_latexmk xdv)) {
            my $file = File::Spec->catfile($dir, "$name.$ext");
            if (-f $file) {
                unlink($file) or warn "Cannot remove $file: $!\n";
            }
        }
    }
    return 0;
}
