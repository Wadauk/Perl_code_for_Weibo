
#如何制作一个课程预告器？——只需三步
#必须使用上一篇生成的数据文件或格式作为输入文件

【功能】
#本课程预告器的功能是，提示当天内，下节课程信息。

【背景知识】
#关于获取系统时间
#1. 使用POSIX的模块
#2. 使用localtime函数调用系统时间
#3. 使用不同变量调取所需时间，如%w为调取星期几
#详见（http://blog.chinaunix.net/uid-10697776-id-2935622.html）

#关于=
#1. =为将右边赋值给左边
#2. ==为比较左右两边是否相等

#关于if语句
#1. 判断if后括号内条件是否为真，为真则执行，否则执行else后的内容
#2. 可使用last跳出

#关于while循环
#1. 使用钻石符<>套文件句柄读取文件数据，如while(<IN>)
#2. 当读取文件时，逐行读取，$.表示当前行数

#关于正则表达式
#[abc]表示a或b或c，[^a]表示除a外任何字符（包括符号、数字等）

【目的】
#本篇主要练习了POSIX模块、if条件语句、while循环

【步骤】
#第一步：查看今天是星期几，就打印文件第几行
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

#第二步：判断当前时间之后是否有课
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

#第三步：如果有课，输出课程信息
#! /usr/bin/perl -ws
use POSIX;
my $filename=$ARGV[0];
open (IN,"<$filename")||die "open error!\n";
my $weekday=strftime("%w",localtime);
my $read_class_data_line_start_at = $weekday + 1;
my @class_start_time;
while(<IN>){
	@class_start_time=split(/ /,$_);
	last;
}
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
		while(<IN>){
			if ($.==$read_class_data_line_start_at){
				my $former_number=$n-1;
				/(?:.*?;){$former_number}([^;]*?);/;
				if($1){
					print "The next class is $1\n";
				}
				else{
					print "Classes are over today!\n";
				}
				
			}
		}
	}
}
close (IN);

【延伸】
#如果课程表数据更多，是否可以增强为蹭课神器？

code by @每天学点Perl语言
