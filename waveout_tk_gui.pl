######################################################
#本次程序通过三个选项，产生不同的波形，并在三个波形混合#
#之后播放3秒钟。其中3秒钟的控制采用play的循环播放标志。#
#导致每一秒之间有个时间空隙，还未找到更好的解决办法.   #
######################################################

#!/usr/bin/perl -w
use strict;

use Win32;
use Win32::Sound;
use Tk;
use List::Util qw(max);

#-----------------绘制GUI界面-----------------#
my($top,$bottom_u,$top_1,$top_2,$top_3);
my $main = new MainWindow;
$main -> title('Sound');

$top = $main -> Frame() -> pack(-side => 'top',-pady =>5);
$top_1 = $top -> Frame(-relief => 'ridge',
		       -borderwidth => 3
		       )->pack(-side => 'left',-padx => 5);
my $value_1;
my $scale_1 = $top_1 -> Scale(-orient => 'vertical',
				-from => 2000,
				-to => 200,
				-length => 400,
				-variable => \$value_1,
				)->pack(-side => 'top',-pady => 5);
my $wave_1;
$top_1 -> Radiobutton(-text => 'sin',
			-value => 'sin_u',
			-variable => \$wave_1
			)->pack();
$top_1 -> Radiobutton(-text => 'sqr',
			-value => 'sqr_u',
			-variable => \$wave_1
			)->pack();
$top_1 -> Radiobutton(-text => 'tri',
			-value => 'tri_u',
			-variable => \$wave_1
			)->pack();
$top_1 -> Radiobutton(-text => 'saw',
			-value => 'saw_u',
			-variable => \$wave_1
			)->pack();
my $enable_1 = 0;
$top_1 -> Checkbutton(-text => 'Enable',
			-onvalue => 1,
			-offvalue => 0,
			-variable => \$enable_1
			)->pack();
#----------------------------------------------#		
$top_2 = $top -> Frame(-relief => 'ridge',
			-borderwidth => 3
			)->pack(-side => 'left',-padx => 5);
my $value_2;
my $scale_2 = $top_2 -> Scale(-orient => 'vertical',
						   -from => 2000,
						   -to => 200,
						   -length => 400,
						   -variable => \$value_2,
						   )->pack(-side => 'top',-pady => 5);
my $wave_2;
$top_2 -> Radiobutton(-text => 'sin',
			-value => 'sin_u',
			-variable => \$wave_2
			)->pack();
$top_2 -> Radiobutton(-text => 'sqr',
			-value => 'sqr_u',
			-variable => \$wave_2
			)->pack();
$top_2 -> Radiobutton(-text => 'tri',
			-value => 'tri_u',
			-variable => \$wave_2
			)->pack();
$top_2 -> Radiobutton(-text => 'saw',
			-value => 'saw_u',
			-variable => \$wave_2
			)->pack();
my $enable_2 = 0;
$top_2 -> Checkbutton(-text => 'Enable',
			-onvalue => 1,
			-offvalue => 0,
			-variable => \$enable_2
			)->pack();					
#--------------------------------------------#					
$top_3 = $top -> Frame(-relief => 'ridge',
		       -borderwidth => 3
		       )->pack(-side => 'left',-padx => 5);
my $value_3;
my $scale_3 = $top_3 -> Scale(-orient => 'vertical',
			      -from => 2000,
			      -to => 200,
			      -length => 400,
			      -variable => \$value_3,
			      )->pack(-side => 'top',-pady => 5);					
my $wave_3;
$top_3 -> Radiobutton(-text => 'sin',
		      -value => 'sin_u',
		      -variable => \$wave_3
		      )->pack();
$top_3 -> Radiobutton(-text => 'sqr',
		      -value => 'sqr_u',
		      -variable => \$wave_3
		      )->pack();
$top_3 -> Radiobutton(-text => 'tri',
		      -value => 'tri_u',
		      -variable => \$wave_3
		      )->pack();
$top_3 -> Radiobutton(-text => 'saw',
		      -value => 'saw_u',
		      -variable => \$wave_3
		      )->pack();
my $enable_3 = 0;
$top_3 -> Checkbutton(-text => 'Enable',
		      -onvalue => 1,
		      -offvalue => 0,
		      -variable => \$enable_3
		      )->pack();					
#-------------------------------------------------#	
$bottom_u = $main -> Frame() -> pack(-side => 'bottom',-pady => 5);
$bottom_u -> Button(-text => 'Play',
		    -command => \&play
		    )->pack(-side => 'left');	
$bottom_u -> Button(-text => 'Quit',
		    -command => sub{exit}
		    )->pack(-side => 'right');	
$main -> MainLoop;


1;

#----------------子函数------------------#
#统一设置时间为3s
#sin_u->产生正弦波
#sqr_u->方波
#tri_u->三角波
#saw_u->锯齿波
#get_wave->to get the generated wave
#play 播放函数
sub sin_u{
	my $freq = shift;
	my @v;
	my $counter = 0;
	my $inc = $freq / 44100;
	for my $i (1..44100) {
	    push @v, sin($counter*2*3.14) * 127 + 128;
	    $counter += $inc;
	}
	return @v ;
}

sub sqr_u{
	my $freq = shift;
	my @v;
	my $t = 44100 / $freq;
	$t = int $t;
	for my $i (1..44100) {
		if (($i % $t) < ($t / 2)) {
			push @v, 255;
		} else {
			push @v, 0;
		}
	}
	return @v;
}

sub tri_u{
	my $freq = shift;
	my @v;
	my $counter = 0;
	my $t = 44100 / $freq;
	my $flag = 1;
	$t = int $t;
	for my $i (1..44100) {
		$counter += $flag;
		push @v, $counter;
		if ($counter >= ($t / 2) or $counter <= 0) {
			$flag = -$flag;
		}
	}
	my $amp = max(@v);
	@v = map {$v[$_] / $amp * 255} 0..44099;
	return @v;
}

sub saw_u{
	my $freq = shift;
	my @v;
	my $counter = 0;
	my $t = 44100 / $freq;
	$t = int $t;
	for my $i (1..44100) {
		if ($counter < $t) {
			push @v, $counter;
			$counter++;
		} else {
			push @v, $counter;
			$counter = 0;
		}
	}
	my $amp = max(@v);
	@v = map {$v[$_] / $amp * 255} 0..44099;
	return @v;
}

sub get_wav {
	my($a, $b, $c) = @_;
	my(@wave1, @wave2, @wave3);
	if ($a) {
		@wave1 = eval("$wave_1($value_1)");
	} else {
		@wave1 = (0) x 44100;
	}
	if ($b) {
		@wave2 = eval("$wave_2($value_2)");
	} else {
		@wave2 = (0) x 44100;
	}
	if ($c) {
		@wave3 = eval("$wave_3($value_3)");
	} else {
		@wave3 = (0) x 44100;
	}
	my @wave = map { ($wave1[$_] + $wave2[$_] + $wave3[$_])} 0..44099;
	my $amp = max(@wave);
	@wave = map {$wave[$_] / $amp * 255} 0..44099 unless $amp == 0;
	return @wave;
}

sub play{
	Win32::Sound::Volume('100%','100%');	               #双声道播放
	my $WAV = new Win32::Sound::WaveOut(44100, 8, 2);
	my @wave = get_wav($enable_1, $enable_2, $enable_3);
	my $data = "";
	foreach my $v (@wave) {
		$data .= pack("CC", int $v, int $v);
	}
	$WAV->Load($data);
	$WAV->Save('test.wav');             #将波形保存
	Win32::Sound::Play("test.WAV", SND_ASYNC|SND_LOOP);        #使用标志进行循环播放
	Win32::Sleep(3000);                                        #控制时间为3s中
	Win32::Sound::Stop();
	$WAV->Unload();
}

