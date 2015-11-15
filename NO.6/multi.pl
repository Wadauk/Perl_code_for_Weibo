#! /usr/bin/perl -w
use LWP::Simple;
use strict;
open (IN,"<GIlist.txt")||die "open error!\n";
while (<IN>){
	chomp;
	open (OUT,">$_.fasta")||die "open error!\n";
	my $page = get "http://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?tool=portal&sendto=on&log\$=seqview&db=nuccore&dopt=fasta&sort=&val=$_&from=begin&to=end&maxplex=1";
	print OUT $page;
	close OUT;
}
close IN;
