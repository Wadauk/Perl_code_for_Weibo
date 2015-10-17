#! /usr/bin/perl -ws
use 5.12.0;
use Time::HiRes qw(gettimeofday tv_interval);
 
my $start_time=[gettimeofday];
#code here->
my $end_time=[gettimeofday];
my $diff_time = tv_interval $start_time,$end_time;
say "\n$diff_time";
