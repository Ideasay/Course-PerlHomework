#!/usr/bin/perl -w
use strict;
use Data::Dumper;

my $exp = "12*5+55+(4*3+2)*(2+44*(5+1))";
$exp = new CALC_TREE($exp);
print "The answer = ".($exp->{_answer}).".\n";
print "The tree is as follows.\n".Dumper($exp->{_tree});

1;

package CALC_TREE;

sub new{
    my $class = shift;
    my $exp = shift;
    $exp = exp_split($exp);
    my $self = {
	_tree => buildtree($exp),
	_answer => calc(buildtree($exp))
    };
    bless ($self,$class);
}
	
sub exp_split{                                                                                                                                                                                          
    my $exp = shift;       #输入一个表达式
    my %split;               #新建一个mem的hash表，存入三个数组引用。分别为操作符数组，数组数组，括号表示数组
    my $copy = $exp;
    my %pri = ('+' => 0, 
               '-' => 0,
               '*' => 1,
               '/' => 1);   #(priority)由于优先级不同给加减和乘除赋上不同的值，方便之后还原成一个树
    $split{_op} = [];         #操作符数组,mem是hash,key值前加个_明确一下
    $split{_pri} = [];        #优先级数组
    $split{_data} = [];       #数据数组
    my $pri = 0;
    while (1) {
        if ($copy=~ /^([\+\-\*\/])/g){#匹配开头的操作符
            push @{$split{_op}},  $1;
            push @{$split{_pri}}, $pri + $pri{$1};
            my $position = pos $copy;
            $copy = substr($copy, $position, length($copy) - $position);   #将操作符截取掉，保留剩余的部分在$t中
            next;
        }
        elsif ($copy =~ /^(\(*)(\d+)(\)*)/g){     #匹配开头的数字
            $pri += 5*(length($1)) if $1;
            push @{$split{_data}}, $2;
            $pri -= 5*(length($3)) if $3;
            my $position = pos $copy;
            $copy = substr($copy, $position, length($copy) - $position);
            next;
        }
        last;
    }
    return \%split;           #返回的是一个引用!
}

sub buildtree {             #生成树的函数buildtree 
    my $split = shift;
    my $tree_top_pri =[];
    my @stack_units;      #新建一个栈
    $tree_top_pri->[0] = $split->{_op}[0];
    $tree_top_pri->[1] = $split->{_data}[0];
    TIDE:for my $i(1..$#{$split->{_pri}}){  #循环得到最终树的最后的最小单元保存在$cur，和其他外部部分一层层的剥离放在$stack里面(也是按照优先级的前后进行排列)
    	if ($split->{_pri}[$i] > $split->{_pri}[$i-1]) {  #遇到优先级更高的运算符，说明又有了更小的[]子单元，将之前的结果存入stack，新建一个cur继续存放.最后剩下的必然是一个运算中优先级最高最内部的一个子单元。
            push @stack_units, [$tree_top_pri,$split->{_pri}[$i-1]];    
            $tree_top_pri = [];
            $tree_top_pri->[0] = $split->{_op}[$i];
            $tree_top_pri->[1] = $split->{_data}[$i];
        }
        else {
            push @$tree_top_pri, $split->{_data}[$i];
	    if ($split->{_pri}[$i] == $split->{_pri}[$i-1] && #这个if是判断前后两个操作符一样，并且没有遇到括号，那就可以不停push到$cur，不要管符号。因为这是连加连乘的类似操作。
                $split->{_op}[$i] eq $split->{_op}[$i-1]) {                   
                next;
            }
	    if ($#stack_units >= 0){
                my( $scur, $pri) = @{$stack_units[$#stack_units]};
                if ($split->{_pri}[$i] <= $pri) {                    #处理stack_units中前一个子单元优先级反而较高的情况，处理()*()...等类似情况,例如(12*5+55+(4*3+2))*(2+44*(5+1))
                    push @$scur, $tree_top_pri;
                    $tree_top_pri = $scur;
                    pop @stack_units;
                    if ($split->{_pri}[$i] == $pri && 
                        $split->{_op}[$i] eq $scur->[0]){
                        next TIDE;
                    }
                }
            }
            $tree_top_pri = [$split->{_op}->[$i], $tree_top_pri];       #只要是运算优先级低的，遇到的数字给上一个运算符，把自己包裹在生成的子单元外层           
        }
    }
    push @$tree_top_pri, $split->{_data}[$#{$split->{_data}}];
    my $tree = $tree_top_pri;
    while ($#stack_units >= 0){
        my ($cur,$pri) = @{$stack_units[$#stack_units]};  #此处因为压栈过程使得外层多了一个[]
        pop @stack_units;
        push @$cur, $tree;
        $tree = $cur;
    }
    return $tree;
}

sub calc{
    my $tree = shift;              #得到一个树
    my @m;                         #运算栈，存每一个子数组计算完成的结果
    my $ans;                       #结果保存在ref之中
    for my $i(1..$#{$tree}){
        if (ref $tree->[$i]) {     #说明输入的仍然是一个引用，就是指向一个子数组
            push @m, calc($tree->[$i]);    #递归调用
        }
        else {
            push @m, $tree->[$i];
        }
    }
	$ans = $m[0];                 #对于每一次遍历，操作目标是不同的子数组，因此每个子数组push到m中的数是不一样的要分别存。否则对于加减和乘除得分开处理
    if ($tree->[0] eq '+'){
    	$ans += $_ foreach(@m[1..$#m]);
    }
    elsif ($tree->[0] eq '-'){
        $ans -= $_ foreach(@m[1..$#m]);
    }
    elsif ($tree->[0] eq '*'){
        $ans *= $_ foreach(@m[1..$#m]);
    }
    elsif ($tree->[0] eq '/'){
        $ans /= $_ foreach(@m[1..$#m]);
    }
    return $ans;
}



