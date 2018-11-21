#实现不带括号，无优先级运算的计算器
#!/usr/bin/perl -w
use strict;
use Tk;

my $main = new MainWindow;
$main->title('calculation');
my $flag = 0;
my $expression = '0';

my $Screen = $main->Entry(-width=>40,-state=>'disabled',-textvariabl=>\$expression,-justify=>'center') -> grid(-row=>0,-column=>0,-columnspan=>4,-sticky=>'nwse');
my $Delete = $main->Button(-text=>'<-',-command=>sub{$expression = substr($expression,0,length($expression)-1);
						     if($expression eq ''){
							     $flag = 0;$expression = '0';
						     }
					     	     }) -> grid(-row=>1,-column=>0,-sticky=>'nwse');
my $Clear = $main->Button(-text=>'C',-command=>sub{$expression = '0';$flag = 0}) -> grid(-row=>1,-column=>1,-columnspan=>2,-sticky=>'nwse');
my $Answer = $main->Button(-text=>'=',-command=>sub{$expression = calc()}) -> grid(-row=>1,-column=>3,-sticky=>'nwse');
my $seven = $main->Button(-text=>'7',-command=>sub{input_number('7')}) -> grid(-row=>2,-column=>0,-sticky=>'nwse');
my $eight = $main->Button(-text=>'8',-command=>sub{input_number('8')}) -> grid(-row=>2,-column=>1,-sticky=>'nwse');
my $nine = $main->Button(-text=>'9',-command=>sub{input_number('9')}) -> grid(-row=>2,-column=>2,-sticky=>'nwse');
my $Divide = $main->Button(-text=>'/',-command=>sub{input_operation('/')}) -> grid(-row=>2,-column=>3,-sticky=>'nwse');
my $four = $main->Button(-text=>'4',-command=>sub{input_number('4')}) -> grid(-row=>3,-column=>0,-sticky=>'nwse');
my $five = $main->Button(-text=>'5',-command=>sub{input_number('5')}) -> grid(-row=>3,-column=>1,-sticky=>'nwse');
my $six= $main->Button(-text=>'6',-command=>sub{input_number('6')}) -> grid(-row=>3,-column=>2,-sticky=>'nwse');
my $Mult= $main->Button(-text=>'*',-command=>sub{input_operation('*')}) -> grid(-row=>3,-column=>3,-sticky=>'nwse');
my $one = $main->Button(-text=>'1',-command=>sub{input_number('1')}) -> grid(-row=>4,-column=>0,-sticky=>'nwse');
my $two = $main->Button(-text=>'2',-command=>sub{input_number('2')}) -> grid(-row=>4,-column=>1,-sticky=>'nwse');
my $three = $main->Button(-text=>'3',-command=>sub{input_number('3')}) -> grid(-row=>4,-column=>2,-sticky=>'nwse');
my $Sub = $main->Button(-text=>'-',-command=>sub{input_operation('-')}) -> grid(-row=>4,-column=>3,-sticky=>'nwse');
my $zero = $main->Button(-text=>'0',-command=>sub{input_number('0')}) -> grid(-row=>5,-column=>0,-sticky=>'nwse');
my $neg = $main->Button(-text=>'+/-',-command=>sub{if($flag == 0){
							$expression = '-';
							$flag = 1;
						   }else{
						   	if($expression =~ /^\d*\.?\d*$/){
								$expression = '-'.$expression;
							}elsif($expression =~ /^\-(\d*\.?\d*)$/){
								$expression = substr($expression,1,length($expression)-1);
							}elsif($expression =~ /^\-?\d*\.?\d*[\+\-\*\/]$/){
								$expression .= '-'; 
							}elsif($expression =~ /^\-?\d*\.?\d*[\+\-\*\/]+\-?\d*\.?\d*$/){
								$expression = 0 - calc();
							}
						   }
						   }) -> grid(-row=>5,-column=>1,-sticky=>'nwse');
my $dot = $main->Button(-text=>'.',-command=>sub{if($flag == 0){
							$expression = '0.';
							$flag = 1;
						}else{
							if($expression =~  /^\-?\d+\.?\d*[\+\-\*\/]$/){
								$expression .= '0.';
							}elsif($expression =~ /^\-?\d+\.\d*$/ or $expression =~ /[\+\-\*\-]\-?\d+\.\d*$/){
							}else{
								$expression .= '.';
							}					
						}
						}) -> grid(-row=>5,-column=>2,-sticky=>'nwse');
my $add = $main->Button(-text=>'+',-command=>sub{input_operation('+')}) -> grid(-row=>5,-column=>3,-sticky=>'nwse');

$main->MainLoop;
1;

sub input_number{
	my $elemt = shift;
	if($flag == 0){
		$expression = $elemt;
		$flag = 1;
	}else{
		if($expression =~ /^0$/){
			$expression = $elemt;
		}else{
			$expression .= $elemt;
		}
	}
}


sub input_operation{
	my $elemt = shift;
	if($flag == 0){
		if($elemt eq '-'){
			$expression = '-';
			$flag = 1;
		}
	}else{
		if($expression =~ /[\+\-\*\/\.]$/){
			$expression = substr($expression,0,length($expression - 1)).$elemt;
		}elsif($expression =~ /^\-?\d+\.?\d*[\+\-\*\/]\-?\d+\.?\d*$/){
			$expression = calc().$elemt;
		}else{
			$expression .= $elemt; 
		}
	}
}

sub calc{
	if($expression =~ /^(\-?\d*\.?\d*)[\+\-\*\/]\-?$/){
		return $1;
	}elsif($expression =~ /\-{2}/g){
		my $expression_c = $expression;
	        $expression_c =~ s/\-{2}/\+/;
		return eval($expression_c);
	}
	return eval($expression); 
}
