package LvSenie::Utils::StatsCollector;
use strict;
use utf8;
use warnings;
use IO::Dir;
use IO::File;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(count);

our $STATS = {
	'Centuries' => {},
};

#TODO: wordforms can be counted correctly only by reading and consolidating index

sub count
{
	autoflush STDOUT 1;
	if (@_ < 2)
	{
		print <<END;
Script for collecting word count statistics from .*_indexed.txt and
.*_indexed_lower.txt Century is guessed by finding last 4 digit number in
the file path.

Params:
   encoding for input files: UTF-8 or cp1257
   input dir

AILab, LUMII, 2021, provided under GPL
END
		exit 1;
	}

	my $encoding = shift @_;
	my $inputDir = shift @_;
	my @inputDirs = ($inputDir);

	while (my $inDirName = shift @inputDirs)
	{
		my $dir = IO::Dir->new($inDirName) or (warn "Folder $inDirName is not available: $!" and next);
		while (defined(my $inFile = $dir->read))
		{
			if ((-f "$inDirName/$inFile") and $inFile =~ /^(.*?)(_indexed)((_lower)?)\.txt$/)
			{
				my $lc = $3 ? '_lower' : '_all';
				eval
				{
					local $SIG{__DIE__} = sub { warn $_[0] }; # This magic makes eval warn on die.
					&processFreqFile( $encoding, "$inDirName/$inFile", $lc);
				};
			}
			elsif ((-d "$inDirName/$inFile") and ($inFile !~ /^\.+$/))
			{
				push @inputDirs, "$inDirName/$inFile";
			}
		}
	}

	&printResult('SENIE-stats.txt')
}

sub processFreqFile
{
	my $encoding = shift @_;
	my $filePath = shift @_;
	my $caps = shift @_;

	$filePath =~ /(\d\d)\d\d(?:.(?!\d{4}))*$/;
	my $century = $1;

	my $in = IO::File->new($filePath, "< :encoding($encoding)")
		or die "Could not open file $filePath: $!";

	my $firstLine = <$in>;
	#$firstLine =~/(\d+)/; # Wordforms;
	#$STATS->{"Forms${caps}"} =  $STATS->{"Forms${caps}"} ? $STATS->{"Forms${caps}"} + $1 : $1;
	#$STATS->{"Forms${caps}_$century"} = $STATS->{"Forms${caps}_$century"} ? $STATS->{"Forms${caps}_$century"} + $1 : $1;

	my $secondLine = <$in>;
	$secondLine =~/(\d+)/; # Word uses;
	$STATS->{"Uses${caps}"} = $STATS->{"Uses${caps}"} ? $STATS->{"Uses${caps}"} + $1 : $1;
	$STATS->{"Uses${caps}_$century"} = $STATS->{"Uses${caps}_$century"} ? $STATS->{"Uses${caps}_$century"} + $1 : $1;

	$STATS->{'Centuries'} = {%{$STATS->{'Centuries'}}, $century => 1};

	$in -> close();
}

sub printResult
{
	my $resultFile = shift @_;

	my $out = IO::File->new($resultFile, "> :encoding(UTF-8)")
		or die "Could not open file $resultFile: $!";

	print $out "KOPĀ\n";
	#print $out "Vārdformas reģistrnejūtīgi:\t" . $STATS->{"Forms_lower"} . "\n";
	#print $out "Vārdformas reģistrjūtīgi:\t" . $STATS->{"Forms_all"} . "\n";
	if ( $STATS->{"Uses_lower"} == $STATS->{"Uses_all"})
	{
		print $out "Vārdlietojumi:\t" . $STATS->{"Uses_lower"} . "\n\n";
	}
	else
	{

		print $out "Vārdlietojumi reģistrnejūtīgi:\t" . $STATS->{"Uses_lower"} . "\n";
		print $out "Vārdlietojumi reģistrjūtīgi:\t" . $STATS->{"Uses_all"} . "\n\n";
	}

	for my $century (sort keys %{$STATS->{"Centuries"}})
	{
		my $human_cent = $century + 1;
		print $out "$human_cent. GADSIMTS\n";
		#print $out "Vārdformas reģistrnejūtīgi:\t" . $STATS->{"Forms_lower_$century"} . "\n";
		#print $out "Vārdformas reģistrjūtīgi:\t" . $STATS->{"Forms_all_$century"} . "\n";
		if ($STATS->{"Uses_lower_$century"} == $STATS->{"Uses_all_$century"})
		{
			print $out "Vārdlietojumi:\t".$STATS->{"Uses_lower_$century"}."\n\n";
		}
		else
		{
			print $out "Vārdlietojumi reģistrnejūtīgi:\t" . $STATS->{"Uses_lower_$century"} . "\n";
			print $out "Vārdlietojumi reģistrjūtīgi:\t" . $STATS->{"Uses_all_$century"} . "\n\n";
		}
	}

	$out->close;
}

1;