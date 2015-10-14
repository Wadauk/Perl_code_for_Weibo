#! /usr/bin/perl -ws
my $filename = $ARGV[0];
open (OUT,">$filename")||die "open error!\n";

print "Please input the beginning time of each class,
and seperated with semicolon.For example:
08:00;09:50;13:30;15:20\n";
my $input_classtime_string = <STDIN>;
$input_classtime_string =~ s/\n//;
my @input_classtime_array = split(/;/, $input_classtime_string);
my $the_order_of_input_classtime = 0;
foreach my $each_input_classtime(@input_classtime_array){
	$each_input_classtime =~ /(\d{2}):(\d{2})/;
	$classtime_seconds[$the_order_of_input_classtime] = $1*3600+$2*60;
	$the_order_of_input_classtime ++;
}
print OUT "@classtime_seconds\n";

my @weekday_names = (Monday, Tuesday, Wednesday, Thursday, Friday);
foreach my $each_weekday_name(@weekday_names){
	print "Please input the classes and rooms in $each_weekday_name.For example:
	\@\@Math(101);English(101);;Perl(101);\n";
	my $input_classnames_string = <STDIN>;
	$input_classnames_string =~ s/\n//;
	foreach my $each_input_classtime(@input_classtime_array){
		$input_classnames_string =~ s/@(.*?)?;/$1$each_input_classtime@@@/;
	}
	$input_classnames_string =~ s/(@@@|@)/;/g;
	$input_classnames_string =~ s/^\d{2}:\d{2};/;/;
	$input_classnames_string =~ s/(?<=;)\d{2}:\d{2}(?=;)//g;
	print OUT "$input_classnames_string\n";
}
close(OUT);

{
my $example_data='
08:00;09:50;13:30;15:20
@@Math(101);English(101);;Perl(101);
@@Python(101);Biology(101);R(101);Math(101);
@@Java(101);C++(101);;;
@@;;Perl(101);;
@@;;;;
'
}

#code by @每天学点Perl语言
