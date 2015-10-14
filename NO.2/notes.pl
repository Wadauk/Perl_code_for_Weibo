
#如何制作一个课程表数据存储器？

【背景知识】
#关于Perl语言编程习惯
#1. 逗号后空一格
#2. 不同功能块间空行分隔
#3. 分号后不空格

#关于标准化输入
#1. 使用STDIN进行标准化输入
#2. 标准化输入就是可以在程序运行过程中暂停，通过命令行向其输入信息
#3. 每行标准化输入信息末尾有一个换行符

#关于作用域
#1. 使用my等限定变量、数组等的作用范围
#2. 被限定对象只在作用范围内有效
#3. 作用范围外，变量、数组等即使名称相同，都不能相互影响

#关于foreach循环
#1. 逐个循环数组内容，并赋值給一个变量
#2. 循环次数等于数组的元素个数

#关于正则表达式s替换
#1. s/@/;/的意思是匹配@，将匹配内容替换为；，该过程匹配至多1次就停止
#2. s/@/;/g的意思是匹配@，将匹配内容替换为；，该过程匹配尽可能多次才停止
#3. s/(@@@|@)/;/g的意思是匹配@@@或@，将匹配内容替换为；，该过程匹配尽可能多次才停止
#4. ?表示匹配0次或1次；?也可以表示尽可能少地匹配内容，意思是，一旦遇到满足条件的内容就停止
#5. {2}表示匹配2次；*表示匹配任意次（包括0次）；.*表示匹配任意长度的任意字符串
#6. \d表示任意数字，\n表示换行符
#7. s/^\d{2}:\d{2};/;/表示将以\d\d:\d\d;开头的内容替换为;，该过程匹配至多1次就停止
#8. s/(?<=;)\d{2}:\d{2}(?=;)//g表示匹配前后都是;的内容，如果格式为\d\d:\d\d，则替换为;，
#9. ()表示优先级；()也可以表示捕获信息；(?:)表示此括号信息不捕获

【目的】
#本篇主要练习了文本输出、foreach循环、正则表达式s替换。

【注意】
#每行后的注释表示，如果此行代码意义不明白可以查阅小骆驼书的页数，
#若小骆驼书没有提到，则会有其他资源链接

#! /usr/bin/perl -ws
my $filename = $ARGV[0];
open (OUT,">$filename")||die "open error!\n";#P102 打开文件句柄 #P107 用die处理致命错误

print "Please input the beginning time of each class,
and seperated with semicolon.For example:
08:00;09:50;13:30;15:20\n";
my $input_classtime_string = <STDIN>;#P90 读取标准输入
chomp($input_classtime_string);#P90 截掉最后的换行符
my @input_classtime_array = split(/;/, $input_classtime_string);#P169 split操作符
my $the_order_of_input_classtime = 0;
foreach my $each_input_classtime(@input_classtime_array){#P63 foreach控制结构
	$each_input_classtime =~ /(\d{2}):(\d{2})/;#P138 字符集的缩写
	$classtime_seconds[$the_order_of_input_classtime] = $1*3600+$2*60;#P153 捕获变量
	$the_order_of_input_classtime ++;#P185 自增与自减
}
print OUT "@classtime_seconds\n";#P110 使用文件句柄

my @weekday_names = (Monday, Tuesday, Wednesday, Thursday, Friday);
foreach my $each_weekday_name(@weekday_names){#P81 关于词法（my）变量
	print "Please input the classes and rooms in $each_weekday_name.For example:
	\@\@Math(101);English(101);;Perl(101);\n";
	my $input_classnames_string = <STDIN>;
	$input_classnames_string =~ s/\n//;#P165 用s///进行替换
	foreach my $each_input_classtime(@input_classtime_array){
		$input_classnames_string =~ s/@(.*?)?;/$1$each_input_classtime@@@/;
		#P133 第一行.* #P152 模式中的内插 #P160 通用量词 #P172 非贪婪量词
	}
	$input_classnames_string =~ s/(@@@|@)/;/g;#P137 择一匹配 #P166 用/g进行全局替换
	$input_classnames_string =~ s/^\d{2}:\d{2};/;/;#P148 锚位
	$input_classnames_string =~ s/(?<=;)\d{2}:\d{2}(?=;)//g;#《正则表达式必知必会》P86
	print OUT "$input_classnames_string\n";
}
close(OUT);#P106 关闭文件句柄

'example_data:
08:00;09:50;13:30;15:20
@@Math(101);English(101);;Perl(101);
@@Python(101);Biology(101);R(101);Math(101);
@@Java(101);C++(101);;;
@@;;Perl(101);;
@@;;;;
'

【延伸】
#本篇第67~72行可否浓缩为一行的正则表达式？

#code by @每天学点Perl语言
