#! /usr/bin/perl -ws
use Encode;
use utf8;
use open ":encoding(gbk)", ":std";
use open ":encoding(utf8)";
open (OUT,">chinese.txt");
print OUT "中国棒棒哒~";
close OUT;
open (IN,"<chinese.txt");
while (<IN>){
	print;
}
close IN;
