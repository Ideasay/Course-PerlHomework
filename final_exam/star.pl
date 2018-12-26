#!/usr/bin/perl -w
use strict;

###################
# part 1

open F, "star25.txt" or die "Can't open file";
my @lines = <F>;
close F;

chomp @lines;
s/#.*// foreach @lines;

my (%sname, %spectrum, @fields);
foreach (grep !/^$/, @lines) {
	@fields = split /:/, $_;
	next if @fields < 6;
	$sname{$fields[0]} = $fields[1];
	$spectrum{$fields[0]} = $fields[5];
}

print exists $sname{$_} ?
	"$_: Scientific name is $sname{$_}, Spectrum is $spectrum{$_}\n" :
	"$_: Not find!\n"
	foreach ('Pole star', 'Castor', 'Altair', 'Hadar');

###################
# part 2
my $c;
foreach $c ('Ori', 'Cen', 'Cru') {
	print "Number of starts in $c is ",
	      scalar(grep {$_ eq $c} map ((split / /, $_)[1], values %sname)),
	      "\n";
}

###################
# part 3
my %Nspec;
$Nspec{substr $_, 0, 1}++ foreach values %spectrum;

open F, ">OBAFGKM.txt" or die "Can't open file for write.";
print F "$_:$Nspec{$_}\n" foreach keys %Nspec;
close F;

1;
