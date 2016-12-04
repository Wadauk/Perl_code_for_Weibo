#! /usr/bin/perl
use strict;
use warnings;

if(@ARGV){
	open IN,  "<$ARGV[0]";
	open OUT, ">$ARGV[1]";
	while (<IN>){
		tr/a-mA-Mn-zN-Z/n-zN-Za-mA-M/;
		print OUT;
	}
	close IN;
	close OUT;
}else{
	print "No input file, Please enter a string end with the Enter key\n";
	chomp ( $_ = <STDIN> );
	tr/a-mA-Mn-zN-Z/n-zN-Za-mA-M/;
	print;
}
