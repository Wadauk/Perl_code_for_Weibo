#如何解读GFF3基因注释文件·之一
#（一）统计注释来源种类及对应序列数目
【说明】
#此例使用两种方法，并使用Time::HiRes模块百万分之一精度计时，使用R进行统计检验得出方法一效率显著高于方法二

【背景知识】
#关于Time::HiRes模块
#使用方法见http://www.dbunix.com/?p=2596

#关于GFF格式文件
#格式说明见http://boyun.sh.cn/bio/?p=1602

#关于基因组注释文件
#数据来源见http://blog.sina.com.cn/s/blog_98b82e370101hebl.html

#关于hash打印
#使用方法见http://bnuzhutao.cn/archives/679

#关于split函数
#@_=split (/	/,$_)表示将字符串$_以制表符为界限切分赋值给数组@_

#关于！
#在if条件语句中，感叹号表示非

#关于+=
#$hash{$keys} += 1 等价于 $hash{$keys} = $hash{$keys} + 1

【目的】
#通过高精度计时评价方法效率高低，结合统计学方法检验

【步骤】
第一步：使用Time::HiRes模块

#! /usr/bin/perl -ws
use 5.12.0;
use Time::HiRes qw(gettimeofday tv_interval);
 
my $start_time=[gettimeofday];
#code here->
my $end_time=[gettimeofday];
my $diff_time = tv_interval $start_time,$end_time;
say "\n$diff_time";


第二步：统计注释来源种类及对应序列数目的第一种方法

#! /usr/bin/perl -ws
use 5.12.0;
use Time::HiRes qw(gettimeofday tv_interval);
 
my $start_time=[gettimeofday];

open (IN,"<NC_017626.gff")||die "open error!\n";
my $keys;
my %hash;
while (<IN>){
	if (!/^#/){
		chomp;
		/.*?	.*?	(.*?)	/;
		$keys = $1;
		$hash{$keys} += 1;
	}
}
close IN;
say "TYPE	=>	COUNT";
print_hash(\%hash);

my $end_time=[gettimeofday];
my $diff_time = tv_interval $start_time,$end_time;
say "\nUsed $diff_time s";
#open (OUT,">>data.txt")||die "open error!\n";
#print OUT "$diff_time,";

sub print_hash{
	my $hash_ref = shift;
	for my $key ( keys %{$hash_ref} ){
		print("$key	=>	$hash_ref->{$key}\n");
	}
} 


第三步：统计注释来源种类及对应序列数目的第二种方法

#! /usr/bin/perl -ws
use 5.12.0;
use Time::HiRes qw(gettimeofday tv_interval);
 
my $start_time=[gettimeofday];

open (IN,"<NC_017626.gff")||die "open error!\n";
my $keys;
my %hash;
while (<IN>){
	if (!/^#/){
		chomp;
		@_=split (/	/,$_);
		$keys=$_[2];
		$hash{$keys} += 1;
	}
}
close IN;
say "TYPE	=>	COUNT";
print_hash(\%hash);

my $end_time=[gettimeofday];
my $diff_time = tv_interval $start_time,$end_time;
say "\nUsed $diff_time s";
#open (OUT,">>data.txt")||die "open error!\n";
#print OUT "$diff_time,";

sub print_hash{
	my $hash_ref = shift;
	for my $key ( keys %{$hash_ref} ){
		print("$key	=>	$hash_ref->{$key}\n");
	}
}
