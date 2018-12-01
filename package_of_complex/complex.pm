package complex;


use strict;
use overload
	'+' => 'add',
	'-' => 'sub',
	'*' => 'multiple',
	'/' => 'devide',
	'==' => 'judge',
	'=' => 'assign',
	'""' => 'output',
	'abs' => 'absolute';

#-----define new-----#
sub new{
	my $proto = shift;
	my $type = ref($proto)||$proto;
	my($re,$im) = @_;
	$re = 0 if not $re;
	$im = 0 if not $im;
	my $this = {re => $re,
		    im => $im
	};
	bless $this,$type;
}

#-----methods belonging to complex-----#
sub re{
	my $this = shift;
	$this->{re} = shift if (@_);
	return $this->{re};
}

sub im{
	my $this = shift;
	$this->{im} = shift if(@_);
	return $this->{im};
}
sub add{
	my $this = shift;
	my $proto = shift;
	my($re,$im);
        my($type_1,$type_2) = (ref($this),ref($proto));
	if($type_1 eq 'complex' and $type_2 eq 'complex'){
		($re,$im)=($this->re()+$proto->re(),$this->im()+$proto->im());
	}elsif($type_1 eq 'complex' and $type_2 ne 'complex'){
		($re,$im)=($this->re()+$proto,$this->im());
	}
	$this->new($re,$im);
}

sub sub{
	my $this = shift;
	my $proto = shift;
	my($re,$im);
        my($type_1,$type_2) = (ref($this),ref($proto));
	if($type_1 eq 'complex' and $type_2 eq 'complex'){
		($re,$im)=($this->re()-$proto->re(),$this->im()-$proto->im());
	}elsif($type_1 eq 'complex' and $type_2 ne 'complex'){
		($re,$im)=($this->re()-$proto,$this->im());
	}
	$this->new($re,$im);

}

sub multiple{
	my $this = shift;
	my $proto = shift;
	my($re,$im);
	 my($type_1,$type_2) = (ref($this),ref($proto));
	if($type_1 eq 'complex' and $type_2 eq 'complex'){
		($re,$im)=($this->re() * $proto->re() - $this->im() * $proto->im(),$this->re() * $proto->im() + $this->im() * $proto->re());
	}elsif($type_1 eq 'complex' and $type_2 ne 'complex'){
		($re,$im)=($proto * $this->re(),$proto * $this->im());
	}
	$this->new($re,$im);

}

sub devide{
	my $this = shift;
	my $proto = shift;
	my($re,$im);
	 my($type_1,$type_2) = (ref($this),ref($proto));
	if($type_1 eq 'complex' and $type_2 eq 'complex'){
		my $dev_elemt = ($proto->re())**2 + ($proto->im())**2;
		($re,$im)=(($this->re() * $proto->re() + $this->im() * $proto->im())/$dev_elemt,(-$this->re() * $proto->im() + $this->im() * $proto->re())/$dev_elemt);
	}elsif($type_1 eq 'complex' and $type_2 ne 'complex'){
		($re,$im)=($this->re()/$proto,$this->im()/$proto);
	}
	$this->new($re,$im);


}

sub judge{
	my $this = shift;
	my $proto = shift;
	my $type = ref($proto);
	if ($type eq 'complex') {
		return ($this->re() eq $proto->re() and $this->im() eq $proto->im());
	} else {
		return ($this->re() eq $proto and $this->im() eq 0);
	}
}

sub assign{
	my $this = shift;
	my $proto = shift;
	my $type = ref($proto);
	if ($type eq 'complex') {
		$this->re($proto->re());
		$this->im($proto->im());
	} else {
		$this->re($proto);
		$this->im(0);
	}
}

sub output{
	my $str;
	my $this = shift;
	my $re = $this->re();
	my $im = $this->im();
	if($im < 0){
		if($im == -1){
			$str =  "$re-" . "i";
		}else{
			$str =  "$re$im" . "i";
		}
	}elsif($im == 0){
		$str = "$re";
	}else{
		if($im == 1){
			$str = "$re+" . "i";

		}else{
			$str = "$re+$im" . "i";
		}
	}
	if($re == 0){
		if($im > 0){
			$str =~ s/^0\+//;
		}elsif($im < 0){
			$str =~ s/^0//;
		}
	}
	return $str;
}

sub absolute{
	my $this = shift;
	return $this->re()**2 + $this->im()**2;
}

sub conjugate{
	my $this = shift;
	return $this->new($this->re(), 0 - $this->im());
}

1;
