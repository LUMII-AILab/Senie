package LvSenie2Unicode::FileCollector;
use strict;
use utf8;
use warnings;
use IO::Dir;
use IO::File;
use File::Copy;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(collect);

sub collect
{
	autoflush STDOUT 1;
	if (@_ > 1)
	{
		print <<END;
Script for collecting certain type of files from ../Sources to data, data-VD and
data-JT

Params:
   source data infix, e.g, Unicode, Unicode_unhyphened or nothing

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}
	my $infix = shift @_;

	mkdir('data');
	mkdir('data-VD');
	mkdir('data-JT');

	eval
	{
		local $SIG{__DIE__} = sub { warn $_[0] }; # This magic makes eval warn on die.
		&collectSingleLevel('../Sources', 'data', $infix);
		&collectSingleLevel('../Sources/VD1689_94', 'data-VD', $infix);
		&collectSingleLevel('../Sources/JT1685', 'data-JT', $infix);
	};

}

sub collectSingleLevel
{
	my $inDirName = shift @_;
	my $outDirName = shift @_;
	my $infix = shift @_;

	my $sourcesDir = IO::Dir->new($inDirName) or die "Folder $inDirName is not available: $!";

	while (defined(my $subDirName = $sourcesDir->read))
	{
		next if $subDirName =~ /^\.\.?|JT1685|VD1689_94$/;
		my $subDir = IO::Dir->new("$inDirName/$subDirName") or die "Folder $inDirName/$subDirName is not available: $!";
		my $fileName = "${subDirName}.txt";
		$fileName = "${subDirName}_$infix.txt" if (length $infix);
		copy("$inDirName/$subDirName/$fileName", "$outDirName/$fileName") if (-e "$inDirName/$subDirName/$fileName");
		$subDir->close;
	}
	$sourcesDir->close;
}

1;