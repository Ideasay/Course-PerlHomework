#!/usr/bin/perl -w
use strict;
use Tk;

sub updateVars;

my $file = 'star25.txt';
open F, "$file" or die "Can't open $file for read.\n";
my @lines = <F>;
my %star = ();
my ($cn, $sn, $dis, $mag, $absmag, $spec);
my @order = ();
chomp @lines;
foreach (@lines) {
	next if /^$/;
	next if /^#/;
	($cn, $sn, $dis, $mag, $absmag, $spec) = split /:/, $_;
	$star{$sn} = {
		cn	=> $cn,
		dis	=> $dis,
		mag	=> $mag,
		absmag	=> $absmag,
		spec	=> $spec,
	};
	push @order, $sn;
}

my $idx = 0;
my $idx1 = 1;
my $total = scalar @order;
my $banner;
updateVars();

my $main = new MainWindow;
my $ft = $main->Frame()->pack(-side => 'top');
my $fb = $main->Frame()->pack(-side => 'bottom');

my $fl = $ft->Frame()->pack(-side => 'left');
my $fm = $ft->Frame()->pack(-side => 'left');
my $fr = $ft->Frame()->pack(-side => 'left');

$fl->Button(-text => '<<', -command => sub{
	$idx = --$idx % $total;
	$idx1 = $idx + 1;
	updateVars()
	})->pack();
$fr->Button(-text => '>>', -command => sub{
	$idx = ++$idx % $total;
	$idx1 = $idx + 1;
	updateVars()
	})->pack();

$fb->Label(-textvariable => \$banner)->pack();
$fb->Button(-text => 'Quit', -command => sub{exit;})->pack();

$fm->Label(-text => 'Command Name : ')->grid(-row=>0,-column=>0);
$fm->Label(-textvariable => \$cn)->grid(-row=>0,-column=>1);

$fm->Label(-text => 'Scitific Name : ')->grid(-row=>1,-column=>0);
$fm->Label(-textvariable => \$sn)->grid(-row=>1,-column=>1);

$fm->Label(-text => 'Distance : ')->grid(-row=>2,-column=>0);
$fm->Label(-textvariable => \$dis)->grid(-row=>2,-column=>1);

$fm->Label(-text => 'Magnitude : ')->grid(-row=>3,-column=>0);
$fm->Label(-textvariable => \$mag)->grid(-row=>3,-column=>1);

$fm->Label(-text => 'Abs Mag : ')->grid(-row=>4,-column=>0);
$fm->Label(-textvariable => \$absmag)->grid(-row=>4,-column=>1);

$fm->Label(-text => 'Spectrum : ')->grid(-row=>5,-column=>0);
$fm->Label(-textvariable => \$spec)->grid(-row=>5,-column=>1);

$fm->Scale(-orient => 'horizontal',
	-from => 1, -to => $total, -tickinterval => 5,
	-length => 200, -variable => \$idx1,
	-command => sub {
		$idx = $idx1 - 1;
		updateVars();
	})->grid(-row=>6,-column=>0,-rowspan=>1,-columnspan=>2,-sticky=>'nwse');;
$main->MainLoop;

1;

sub updateVars {
	$idx %= $total;
	$banner	= "No. " . ($idx + 1) . " of $total";
	$sn	= $order[$idx];
	$cn	= $star{$sn}{cn};
	$dis	= $star{$sn}{dis};
	$mag	= $star{$sn}{mag};
	$absmag	= $star{$sn}{absmag};
	$spec	= $star{$sn}{spec};
#	print "$banner\t$cn\n";
}
