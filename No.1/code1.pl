#! /usr/bin/perl -ws
my $filename=$ARGV[0];
open (OUT,">$filename")||die "open error!\n";
print OUT "ATGC\n";

code by @每天学点Perl语言
