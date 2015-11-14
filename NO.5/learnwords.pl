#! /usr/bin/perl -ws
use Encode;
use utf8;#使用utf8模式编码
use open ":encoding(gbk)", ":std";#使可输出中文
use open ":encoding(utf8)";#使中文文件可读
my $filename = $ARGV[0];#输入要学习的英文文章，每行放置一句
open (IN,"<$filename");#打开这篇文章
open (LIST,">>list.txt");#打开一个文本，用来写入单词列表
open (DICT,"<dict_edited.txt");#打开词典，用来查找单词释义
open (ANSW,">>answer.txt");#打开一个文本，用来写入单词列表及对应释义
open (REM,">>remember.txt");#打开一个文本，用来写入单词列表、对应释义及例句，作为下一个程序的数据源，记忆单词用
while (<DICT>){#打开词典，将词典的每个单词及释义存入hash，方便快速查找
	chomp;#去除每行末的换行符
	/(.*)@(.*)/;#以@为分隔，捕获@前和@后的内容，分别作为hash的key和value
	$hash{$1}=$2;#将第一个括号捕获的单词作为key，第二个括号捕获的释义作为value
}
close DICT;#读取完毕，关闭词典文件
while (<IN>){#逐行读取要学习的英文文章
	chomp;#去除每行末的换行符
	print "\n################################################################################\n";#打印多个#，用来分隔，使看起来不太乱
	print $_,"\n";#打印读入的这句话
	print "\n################################################################################";#打印多个#，用来分隔，使看起来不太乱
	print "unkown words:";#打印提示语句，提示请输入这句话中不认识的单词，格式要求每个单词后输入半角分号为分隔
	my $string_of_words = <STDIN>;#输入所有不认识的单词，存入字符串$string_of_words
	$string_of_words =~ s/\n//;#去除换行符
	my @array_of_words = split (/;/,$string_of_words);#将字符串$string_of_words以半角分号为分隔，逐个存入数组@array_of_words
	foreach my $word (@array_of_words){#逐个读取数组@array_of_words中的元素，即逐个读取之前输入的不认识的单词
		if ($word=~/^\s+$/){#如果什么都没有就跳过
			next;#跳出一层循环
		}else{#如果有内容
			print LIST "$word\n";#将这个单词写入单词列表文件
			unless (defined($hash{$word})){#在词典里查找这个单词的释义，如果没有，就执行这个代码块
				print "$word is not fund in dictionary!\n";#打印提示语句，提示这个单词在字典中不存在
				print "Please input the meaning of $word!\n";#打印提示语句，提示请输入这个单词的释义
				$hash{$word}=<STDIN>;#将你输入的释义存入%hash中
				chomp $hash{$word};#去除每行末的换行符
				open (ADD,">>dict_edited.txt");#打开词典
				print ADD "\n",$word,'@',$hash{$word};#将你输入的词条补充到词典中
				close ADD;#关闭词典文件
			};
			print ANSW "$word	$hash{$word}\n";#将单词及释义写入到含释义的单词列表文件
			print REM "$word	$hash{$word}#[例句] $_\n";#将单词、释义及例句写入到含释义、例句的列表文件
		}
	}	
}
close IN;#关闭待学习的文章
close LIST;#关闭单词列表
close ANSW;#关闭含释义的单词列表
close REM;#关闭含释义、例句的单词列表
exit;#退出程序
