#! /usr/bin/perl -ws
use Encode;
use utf8;#使用utf8模式编码
use open ":encoding(gbk)", ":std";#使可输出中文
use open ":encoding(utf8)";#使中文文件可读

open (IN,"remember.txt");#打开上一个程序生成的含释义及例句的单词列表
my %hash;#定义hash
while(<IN>){#逐行读取单词列表文件
	chomp;#去除行末换行符
	/(.*)	(.*)/;#以制表符为分隔，捕获制表符前后的内容
	$hash{$1}=$2;#第一个括号捕获的单词作为hash的key，第二个括号捕获的释义及例句作为hash的value
}
my $n;#定义$n，用来计数记忆循环次数
my %count;#定义%count，用来计数每个单词记忆的次数
while (%hash){#当%hash中有东西的时候，执行这个代码块
$n++;#每次循环，$n加1，表示记忆循环次数增加1次
print "&&&&&&ROUND No.$n&&&&&&\n";#打印提示语句，提示当前是第几轮记忆下面这些单词
	foreach my $word (keys %hash){#乱序逐个读取单词
		$count{$word}+=1;#记录该单词记忆的次数加1次
		$hash{$word} =~ /(.*)#(.*)/;#以#为分隔，捕获#前后的内容
		my $trans = $1;#第一个括号捕获的内容存入$trans，作为这个单词的释义
		my $sentence = $2;#第二个括号捕获的内容存入$sentence，作为这个单词的例句
		$sentence =~ s/$word/【$word】/;#将例句中这个单词所在的位置突出显示，在单词前后加一个萌萌的方括号
		print "\n",$word,"\n$sentence";#打印出这个单词及其例句
		print "\n\nDo you remember this word?(Yes=1,No=0)";#问你知不知道这个单词啥意思，知道就输入1，不知道就输入0
		my $yesorno = <STDIN>;#输入你的回复
		chomp $yesorno;#去除行末换行符
		if ($yesorno == 1){#如果你输入了1，则执行这个代码块
			print $trans,"\n";#打印出这个单词的释义让你瞧瞧
			print "Are you right?(yes=1,no=0)\n";#问你答对了吗，答对了就输入1，没答对就输入0
			my $rightornot = <STDIN>;#输入你的回复
			chomp $rightornot;#去除行末换行符
			$rightornot == 1 ? delete($hash{$word}):next;#从hash里踢出这个你已经记住的单词，不再循环记忆
		}elsif ($yesorno == 0){#如果你输入了0，则执行这个代码块
			print $trans,"\n\n";#打印出这个单词的释义让你瞧瞧
			next;#进入下一个单词的学习
		}
	}
}
print "YOU WIN!\n";#打印提示语句，提示你已经完成了所有单词的学习，人生赢家

open (COUNT,">count.txt");#打开一个文本，用来写入记忆了很多次才记住的单词
my @keys = sort { $count{$b} <=> $count{$a} } keys %count;#按记忆次数由高到低排序 见http://zhidao.baidu.com/link?url=sv0LMiG7pnTpiG2RR_gMrTBttd0sxhJ_tdPeOJfD03OjWK67xjZxwpC5FvCDstvTxXyGWVvjq6YHRGuQ2K9Jj_
my $i=1;#定义$1，用来设置输出条目数
for (@keys){#逐个读取单词
	if ($i>10){last}#设置输出条目数，超出条目数就跳出循环
	print COUNT "$_ -> $count{$_}\n";#将结构打印至输出文件
	$i++;#条目数加1
}
close COUNT;#关闭难词文档
