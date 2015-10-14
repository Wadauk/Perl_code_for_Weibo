#! /usr/bin/perl -ws
use POSIX;
my $filename=$ARGV[0];
open (IN,"<$filename")||die "open error!\n";
my $weekday=strftime("%w",localtime);
my $read_class_data_line_start_at = $weekday + 1;
my @class_start_time=(28800,36000,48600,55800);
if ($weekday eq 0 or $weekday eq 6){
	print "Today is weekend!\n";
}
else{
	my $localtime_seconds=strftime("%H",localtime)*3600
		+strftime("%M",localtime)*60+strftime("%S",localtime);
	my $n=1;
	my $the_next_class_number_is=0;
	foreach my $compared_time(@class_start_time){
		if ($localtime_seconds<=$compared_time){
			$the_next_class_number_is = $n;
			last;
		}
		$n++;
	}
	if ($the_next_class_number_is==0){
		print "Classes are over today!\n";
	}
	else{
		print "The next class is NO.$the_next_class_number_is.\n";
	}
	while(<IN>){
		if ($.==$read_class_data_line_start_at){
			print;
		}
	}
}
close (IN);

#code by @每天学点Perl语言
