#!/usr/bin/perl -w
use strict;

use CGI qw/:standard/;

my($ans,@history,$yes_or_no,$yes);
my $counter = 0;
my @words = ('��','��','��','��','��','��','��','��','δ','��','��','��','î','��','��','��');
my @sentences = (
	'�ӳ���î������δ',
	'�ӳ���î�����纥',
	'�ӳ������ϼ���',
	'������������ױ�'
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
	"�����������ѡ��һ���ּ�ס��<br>" . 
	h2(	
		"�ӳ���î<br>������δ<br>�����纥<br>���ұ���<br>"
	) .
	"��������Ƿ������<br>" .
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
	"��������Ƿ������<br>" . 
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
	h3('�Ҳ�����!') .
	"���ס������$words[$ans]" .
	p(a({-href=>'/cgi-bin/Myguess.pl'}, '����һ��')) .
	end_html;

	
}
