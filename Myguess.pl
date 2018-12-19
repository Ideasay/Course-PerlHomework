#!/usr/bin/perl -w
use strict;

use CGI qw/:standard/;

my($ans,@history,$yes_or_no,$yes);
my $counter = 0;
my @words = ('丁','丙','乙','甲','亥','戌','酉','申','未','午','巳','辰','卯','寅','丑','子');
my @sentences = (
	'子丑寅卯辰巳午未',
	'子丑寅卯申酉戌亥',
	'子丑辰巳申酉甲乙',
	'子寅辰午申戌甲丙'
);
my @keys = param( );

print @keys ? continue_question():first_question();
1;

sub form{
	start_form('GET','Myguess.pl') . 
	radio_group(
		-name => 'judge',
		-value => ['Yes','No'],
	) . 
	"<br>" .
	hidden(
		-name => 'history',
		-default => [join('_', @history)],
	) .
	hidden(
		-name => 'counter',
		-default => [$counter],
	) .
	p() .
	submit(
		-name => 'submit',
		-value => 'OK'
	) .
	end_form();
}


sub first_question{
	header(-charset => 'GB2312') .
	start_html(
		-title	=>	'first question',
		-text	=>	'darkgreen',
		-bgcolor=>	'lightgreen',
	) . 
	"下面句子里面选择一个字记住：<br>" . 
	h2(	
		"子丑寅卯<br>辰巳午未<br>申酉戌亥<br>甲乙丙丁<br>"
	) .
	"你想的字是否在这里：<br>" .
	h2($sentences[0]) .
	form() .
	end_html 
}

sub continue_question{
	$counter =  param('counter');
	@history = split /_/,join '_',param('history');
	$yes_or_no = param('judge');
	Delete_all();
	if($yes_or_no eq 'Yes'){
		$yes = 1;
	}elsif($yes_or_no eq 'No'){
		$yes = 0;
	}
	push @history,$yes;
	$counter = $counter + 1;
	
	return ($counter == 4)?answer():next_question();
}

sub next_question{
	header(-charset => 'GB2312') .
	start_html(
		-title	=>	'next question',
		-text	=>	'darkgreen',
		-bgcolor=>	'lightgreen',
	) . 
	"你想的字是否在这里：<br>" . 
	h2($sentences[$counter]) .
	form() .
	end_html;
}
	
sub answer{
	$ans = 8*$history[0] + 4*$history[1] + 2*$history[2] + $history[3];
	header(-charset => 'GB2312') .
	start_html(
		-title	=>	'answer',
		-text	=>	'darkgreen',
		-bgcolor=>	'lightgreen',
		) .
	h3('我猜中啦!') .
	"你记住的字是$words[$ans]" .
	p(a({-href=>'/cgi-bin/Myguess.pl'}, '再玩一次')) .
	end_html;

	
}
