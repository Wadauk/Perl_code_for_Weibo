#! /usr/bin/perl -ws
use 5.12.0;
use Time::HiRes qw(gettimeofday tv_interval);
 
my $start_time=[gettimeofday];

open (IN,"<NC_017626.gff")||die "open error!\n";
my $keys;
my %hash;
while (<IN>){
	if (!/^#/){
		chomp;
		/.*?	.*?	(.*?)	/;
		$keys=$1;
		$hash{$keys} += 1;
	}
}
close IN;
say "TYPE	=>	COUNT";
print_hash(\%hash);

my $end_time=[gettimeofday];
my $diff_time = tv_interval $start_time,$end_time;
say "\nUsed $diff_time s";
open (OUT,">>data.txt")||die "open error!\n";
print OUT "$diff_time;";
sub print_hash{
	my $hash_ref = shift;
	for my $key ( keys %{$hash_ref} ){
		print("$key	=>	$hash_ref->{$key}\n");
	}
} 
