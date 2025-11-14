package LvSenie::Utils::CodeCollector;
use strict;
use utf8;
use warnings;
use IO::Dir;
use IO::File;

use Exporter();
use parent qw(Exporter);
our @EXPORT_OK = qw(collect);

sub collect
{
	#autoflush STDOUT 1;
	if (@_ < 2)
	{
		print <<END;
Script for collecting all \@-prefixed codes in the input files.

Params:
   encoding for input files: UTF-8 or cp1257
   space separated list of input dirs

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}

	my $encoding = shift @_;
	my @inputDirs = @_;
	my $codeCollector = {};

	for my $inDirName (@inputDirs)
	{
		my $dir = IO::Dir->new($inDirName) or (warn "Folder $inDirName is not available: $!" and next);
		while (defined(my $inFile = $dir->read))
		{
			if ((-f "$inDirName/$inFile") and $inFile =~ /^(.*?)(_Unicode)?(_unhyphened)?\.txt$/)
			{
				my $nameStub = $1;
				$nameStub = "VD1689_94::$nameStub" if ($inDirName =~ /VD(1689_94)?$/);
				$nameStub = "JT1685::$nameStub" if ($inDirName =~ /JT(1685)?$/);
				$nameStub = "Apokr1689::$nameStub" if ($inDirName =~ /Apokr(1689)?$/);
				eval
				{
					local $SIG{__DIE__} = sub { warn $_[0] }; # This magic makes eval warn on die.
					$codeCollector = &reviewFile( $encoding, "$inDirName/$inFile", $nameStub, $codeCollector);
				};
			}
		}
	}

	&printResult($codeCollector, 'SENIE-codes.txt');
}

sub reviewFile
{
	my $encoding = shift @_;
	my $filePath = shift @_;
	my $fileCode = shift @_;
	my $codeCollector = shift @_;

	my $in = IO::File->new($filePath, "< :encoding($encoding)")
		or die "Could not open file $fileCode from $filePath: $!";

	while (my $line = <$in>)
	{
		while ($line =~ /\@ ?([\w\d]+) ?\{/g)
		{
			$codeCollector->{$1}->{$fileCode} = 1;
		}
	}

	$in -> close();
	return $codeCollector;
}

sub printResult
{
	my $codeCollector = shift @_;
	my $resultFile = shift @_;

	my $out = IO::File->new($resultFile, "> :encoding(UTF-8)")
		or die "Could not open file $resultFile: $!";

	foreach my $code (sort keys %$codeCollector)
	{
		print $out "$code\t";
		print $out (join ', ', sort keys %{$codeCollector->{$code}});
		print $out "\n";
	}

	$out->close;
}

1;