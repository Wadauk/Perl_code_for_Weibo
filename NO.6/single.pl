#! /usr/bin/perl -w
use LWP::Simple;
use strict;
open (OUT,">result.fasta")||die "open error!\n";
my $page = get "http://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?tool=portal&sendto=on&log\$=seqview&db=nuccore&dopt=fasta&sort=&val=34193412&from=begin&to=end&maxplex=1";
print OUT $page;
close OUT;
