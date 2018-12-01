#usr/bin/perl -w
use strict;

use complex;
my $aa = complex->new(1,3);
my $bb = complex->new(3,-1);
print "x = $aa\n";
print "y = $bb\n";

#-----add-----#
print "\n#-----add-----#\n";
my $c = $aa + $bb;
my $d = $aa + 1;
my $e = $aa + 0;
print "$aa + $bb = $c\n";
print "$aa + 1 = $d\n";
print "$aa + 0 = $e\n";

#-----sub-----#
print "\n#-----sub-----#\n";
my $c = $aa - $bb;
my $d = $aa - 2;
my $f = $aa - 0;
my $e = $aa + $bb - $c;
print "$aa - $bb = $c\n";
print "$aa - 2 = $d\n";
print "$aa + $bb - $c = $e\n";
print "$aa - 0 = $f\n";

#-----multiple-----#
print "\n#-----multiple-----#\n";
my $c = $aa * $bb;
my $d = $aa * 0;
my $e = ($aa - 2) * $bb;
print "$aa * $bb = $c\n";
print "$aa * 0 = $d\n";
print "($aa - 2) * $bb = $e\n";

#-----devide-----#
print "\n#-----devide-----#\n";
my $c = $aa / $bb;
my $d = $aa / 3;
my $e = ($aa - 2) / $bb;
print "$aa / $bb = $c\n";
print "$aa / 3 = $d\n";
print "($aa - 2) / $bb = $e\n";

#-----judge-----#
print "\n#-----judge-----#\n";
print "$aa is equal to $bb\n " if ($aa == $bb)==1;
print "$aa is not equal to $bb\n" if ($aa == $bb)==0;
print "$aa is equal to 0\n" if ($aa == 0)==1;
print "$aa is not equal to 0\n" if ($aa == 0)==0;
print "$aa is equal to $aa\n " if ($aa == $aa)==1;
print "$aa is not equal to $aa\n" if ($aa == $aa)==0;

#-----abs-----#
print "\n#-----abs-----#\n";
my $c = complex->new(0,0);
my $d = abs($aa);
my $e = abs($c);
print "the abs of $aa is $d\n";
print "the abs of $c is $e\n";

#-----sort-----#
print "\n#-----sort-----#\n";
my $d = complex -> new(5,4);
my $e = complex -> new(-1,2);
my @comp_arr = ($aa,$bb,$c,$d,$e);
print "the arr is @comp_arr\n";
my $sorted = join(' ',sort {abs($a)<=>abs($b)} (@comp_arr));
print "the sorted arr is $sorted\n";

#-----conjugate-----#
print "\n#-----conjugate-----#\n";
print "the initial a is $aa\n";
$aa = $aa->conjugate();
print "the conjugate is $aa\n";
1;
