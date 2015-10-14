#! /usr/bin/perl -ws
my $filename = $ARGV[0];
open (OUT, ">$filename")||die "open error!\n";
$random_sequences = &random_sequences_productor($ARGV[1]);
print OUT "$random_sequences\n";

sub random_sequences_productor{
	my $sequence_length = $_[0];
	my $sequence_random;
	for (my $i = 0;$i < $sequence_length;$i++){
		$sequence_random .= int(rand(4)+1);
	}
	$sequence_random;
}

code by @每天学点Perl语言
