#! /usr/bin/perl -ws
use POSIX;

open (IN,"<timecount.txt");
my ($project,$timecount,$other,%hashother);
while (<IN>){
	chomp;
	/(.*)@(.*?)(#.*$)/;
	$project = $1;
	$timecount = $2;
	$other =$3;
	$hash{$project}=$timecount;
	$hashother{$project}=$other;
}
close IN;
if (%hash){
	print "There are some project, will you continue?\n";
	print $_,"	" foreach keys %hash;
}
print "\nPlease input the project you will do:\n";
$project = <STDIN>;
chomp $project;
if ($hash{$project}){
	print "Until now, project \"$project\" has been doing for $hash{$project} seconds.\n";
}else{
	print "This is a new project.\n";
}
print "Are you ready?(y/n)\n";
my $yorn = <STDIN>;
chomp $yorn;
if ($yorn eq "y"){
	my $start_time=strftime("%Y-%m-%d %H:%M:%S",localtime);
	print "start at: ",$start_time;
	print "\nPlease input \"0\" to end OR \"1\" to pause!\n";
	my $pause_or_end=<STDIN>;
	$pause_or_end=~s/\n//;
	#print $pause_or_end;
	#my $continue_or_end;
	my $i=0;
	my $pause_time_seconds=0;
	my $pause_time;
	my $continue_time_seconds;
	my $pause_time_again_seconds;
	my $continue_time;
	my $pause_time_again;
	my $pause_time_seconds_sums;
	while($pause_or_end eq "1"){
		print "Please input \"0\" to end or \"1\" to continue\n";
		$pause_or_end=<STDIN>;
		$pause_or_end=~s/\n//;
		$pause_time=strftime("%Y-%m-%d %H:%M:%S",localtime);
		if($pause_time=~/(\d{2}):(\d{2}):(\d{2})/){
			my $s=$3;
			my $m=$2;
			my $h=$1;
			$pause_time_seconds=$h*3600+$m*60+$s;
		}
		while($pause_or_end eq "1"){
			$i++;
	#		print $i;
			if ($i%2==0){
				print "Please input \"0\" to end or \"1\" to continue\n";		
				$pause_or_end=<STDIN>;
				$pause_or_end=~s/\n//;
				$continue_time=strftime("%Y-%m-%d %H:%M:%S",localtime);
				if($continue_time=~/(\d{2}):(\d{2}):(\d{2})/){
					my $s=$3;
					my $m=$2;
					my $h=$1;
					$continue_time_seconds=$h*3600+$m*60+$s;
					$pause_time_seconds_sums += $continue_time_seconds-$pause_time_seconds;
	#				print $pause_time_seconds_sums;
				}
			}elsif($i%2==1){
				print "Please input \"0\" to end or \"1\" to pause\n";
				$pause_or_end=<STDIN>;
				$pause_or_end=~s/\n//;
				$pause_time_again=strftime("%Y-%m-%d %H:%M:%S",localtime);
				if($pause_time_again=~/(\d{2}):(\d{2}):(\d{2})/){
					my $s=$3;
					my $m=$2;
					my $h=$1;
					$pause_time_again_seconds=$h*3600+$m*60+$s;
					$pause_time_seconds = $pause_time_again_seconds;
				}
			}
		}
	}
	print "\nFINISH_TIME:\n";
	my $finish_time=strftime("%Y-%m-%d %H:%M:%S",localtime);
	print $finish_time;
	my $start_time_seconds;
	if($start_time=~/(\d{2}):(\d{2}):(\d{2})/){
		my $s=$3;
		my $m=$2;
		my $h=$1;
		$start_time_seconds=$h*3600+$m*60+$s;
	}
	my $finish_time_seconds;
	if($finish_time=~/(\d{2}):(\d{2}):(\d{2})/){
		my $s=$3;
		my $m=$2;
		my $h=$1;
		$finish_time_seconds=$h*3600+$m*60+$s;
	}
	my $s=$finish_time_seconds-$start_time_seconds-$pause_time_seconds_sums;
	print "\nUSED_TIME:\n",int($s/3600)," h : ",int(($s%3600)/60)," m : ",(($s%3600)%60)," s";
	$hash{$project} = $s + $hash{$project};
	print "\nUSED_TOTAL_TIME:\n",int($hash{$project}/3600)," h : ",int(($hash{$project}%3600)/60)," m : ",(($hash{$project}%3600)%60)," s";
	open (OUT, ">timecount.txt");
	my @keys = sort { $hash{$b} <=> $hash{$a} } keys %hash;
	for (@keys){
		if ($_ eq $project){
			print OUT "$_\@$hash{$_}$hashother{$_}\#$start_time\&",int($s/3600),":",int(($s%3600)/60),":",(($s%3600)%60),"\n";
		}else{
			print OUT "$_\@$hash{$_}$hashother{$_}\n";
		}
	}
	close OUT;
}else{
	exit;
}
