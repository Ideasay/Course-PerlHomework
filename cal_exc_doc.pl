#create a calculation exercise doc for children.(formart -> .doc)
#!usr/bin/perl -w
use strict;

use Win32;
use Win32::OLE;

#create 40 calculation exercise in the $content
my $content;
my @stack;       # to storage the 40 expressions.
my($first_n,$second_n,$op);

my %oprt = (0 => "+",
			 1 => "-");
			 
for(my $i = 0;$i < 40;$i += 1){
	#the sum is no more than 100
	#the difference cannot be negative
	my $op_rand = int rand(2);
	$op = $oprt{$op_rand};
	$first_n = int rand(99) + 1;
	$second_n = int rand(100 - $first_n) if($op_rand == 0);
	$second_n = int rand($first_n) if($op_rand == 1);
	
	$first_n = $first_n . " " if($first_n < 10);
	$second_n = $second_n . " " if($second_n < 10);
	
	my $expression = $first_n . $op . $second_n . "=" . "\t\t\t";
	$expression = $expression . "\n" if(($i + 1) % 4 == 0);
	push @stack,$expression;
}

$content = join("",@stack);

#create the doc file
my $wd = Win32::OLE->new('Word.Application') ||
	die "CreateObject: " . Win32::OLE->LastError;
$wd->{Visible} = 1;
my $doc = $wd->Documents->Add();
$wd->Selection->Font->{Size} = 18;
$wd->Selection->TypeText($content);
$doc->SaveAs(Win32::GetCwd . '\Exercise.doc',undef,1);  #unlock the doc
1;



	

	
