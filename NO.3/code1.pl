#! /usr/bin/perl -ws
use POSIX;
my $filename=$ARGV[0];
open (IN,"<$filename")||die "open error!\n";
my $weekday=strftime("%w",localtime);
my $read_class_data_line_start_at = $weekday + 1;
if ($weekday eq 0 or $weekday eq 6){
	print "Today is weekend!\n";
}
else{
	while(<IN>){
		if ($.==$read_class_data_line_start_at){
			print;
		}
	}
}
close (IN);

#code by @每天学点Perl语言
