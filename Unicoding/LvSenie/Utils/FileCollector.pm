package LvSenie::Utils::FileCollector;
use strict;
use utf8;
use warnings;
use IO::Dir;
use IO::File;
use File::Copy;

use Exporter();
use parent qw(Exporter);
our @EXPORT_OK = qw(collectFlat collectNested);

sub collectFlat
{
	#autoflush STDOUT 1;
	if (@_ > 1)
	{
		print <<END;
Script for collecting certain type of files from ../Sources to data, data-VD,
data-JT and data-Apokr. Files named pub_ord.txt, indexing.txt are ignored.

Params:
   source data infix, e.g, Unicode, Unicode_unhyphened or nothing

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}
	my $infix = shift @_;

	mkdir('data');
	mkdir('data-VD1689_94');
	mkdir('data-JT1685');
	mkdir('data-Apokr1689');

	eval
	{
		local $SIG{__DIE__} = sub { warn $_[0] }; # This magic makes eval warn on die.
		&collectSingleLevel('../Sources', 'data', 0, $infix);
		&collectSingleLevel('../Sources/VD1689_94', 'data-VD1689_94', 0, $infix);
		&collectSingleLevel('../Sources/JT1685', 'data-JT1685', 0, $infix);
		&collectSingleLevel('../Sources/Apokr1689', 'data-Apokr1689', 0, $infix);
	};

}

sub collectNested
{
	#autoflush STDOUT 1;
	if (@_ > 1)
	{
		print <<END;
Script for collecting certain type of files from ../Sources to data folder, but
internal folder structure is mimicked. Files named pub_ord.txt, indexing.txt
are ignored.

Params:
   source data infix, e.g, Unicode, Unicode_unhyphened or nothing

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}
	my $infix = shift @_;

	mkdir('data');
	mkdir('data/VD1689_94');
	mkdir('data/JT1685');
	mkdir('data/Apokr1689');

	eval
	{
		local $SIG{__DIE__} = sub { warn $_[0] }; # This magic makes eval warn on die.
		&collectSingleLevel('../Sources', 'data', 1, $infix);
		&collectSingleLevel('../Sources/VD1689_94', 'data/VD1689_94', 1, $infix);
		&collectSingleLevel('../Sources/JT1685', 'data/JT1685', 1, $infix);
		&collectSingleLevel('../Sources/Apokr1689', 'data/Apokr1689', 1, $infix);
	};

}

sub collectSingleLevel
{
	my $inDirName = shift @_;
	my $outDirName = shift @_;
	my $makeSubfolders = shift @_;
	my $infix = shift @_;

	my $sourcesDir = IO::Dir->new($inDirName) or die "Folder $inDirName is not available: $!";

	while (defined(my $subDirName = $sourcesDir->read))
	{
		next if $subDirName =~ /^(\.\.?|Apokr1689|JT1685|VD1689_94|pub_ord.txt|indexing.txt)$/;
		my $subDir = IO::Dir->new("$inDirName/$subDirName") or die "Folder $inDirName/$subDirName is not available: $!";
		mkdir("$outDirName/$subDirName") if ($makeSubfolders);
		my $fileName = "${subDirName}.txt";
		$fileName = "${subDirName}_$infix.txt" if (length $infix);
		my $outpath = $outDirName;
		$outpath = "$outpath/$subDirName" if ($makeSubfolders);
		copy("$inDirName/$subDirName/$fileName", "$outpath/$fileName")
			if (-e "$inDirName/$subDirName/$fileName");
		$subDir->close;
	}
	$sourcesDir->close;
}

1;