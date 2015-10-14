
#如何制作一个随机序列生成器？——只需要三步

【背景知识】
#本篇你需要知道的相关背景知识：

#关于@ARGV
#	1. 请想象一个管道，可以从命令行传输信息到你的程序，这个管道就是数组@ARGV。
#	2. 数组$ARGV[0]，是数组@ARGV的第一个元素，以此类推。
#	3. 当在命令行界面输入完perl filename.pl后，空一格再输入的信息就存入$ARGV[0],
#	   空一格再输入的信息就存入$ARGV[1]……

#关于rand()函数
#	随机产生32768（0x7FFF）个0至1的不同数字
#	（参考http://bbs.chinaunix.net/thread-4102148-1-1.html）

#关于正则表达式
#	1. =~是正则匹配运算符，当左操作数符合右操作数的正则
#	   表达式时返回非false值（参考http://bbs.csdn.net/topics/380218185）
#	   用我的话来说，看到这个符号就知道下面要进行匹配或者替换了。
#	2. tr/1234/ATGC/的意思是用A替换1，用T替换2，用G替换3，用C替换4。

【目的】
#本篇主要练习了文件输出、rand函数、正则表达式tr替换。

【步骤】
#第一步：创建一个新文档，以便可以向其中写入信息。
#! /usr/bin/perl -ws
my $filename=$ARGV[0];
open (OUT,">$filename")||die "open error!\n";
print OUT "ATGC\n";

#第二步：产生1-4的随机数，写入第一步创建的文档。
#! /usr/bin/perl -ws
my $filename = $ARGV[0];
open (OUT, ">$filename")||die "open error!\n";
$random_sequences = &random_sequences_productor($ARGV[1]);	#较上一步增加了此行
print OUT "$random_sequences\n";

sub random_sequences_productor{								#较上一步增加了此子程序
	my $sequence_length = $_[0];
	my $sequence_random;
	for (my $i = 0;$i < $sequence_length;$i++){
		$sequence_random .= int(rand(4)+1);
	}
	$sequence_random;
}

#第三步：将数字1-4替换为ATGC四种碱基。
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
	$sequence_random=~tr/1234/ATGC/;						#较上一步增加了此行
	$sequence_random;
}

【延伸思考】
#写一个程序，设定GC含量比例，产生该GC含量比例的随机序列。

code by @每天学点Perl语言
