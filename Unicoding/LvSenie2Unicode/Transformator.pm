package LvSenie2Unicode::Transformator;
use strict;
use utf8;
use warnings;
use IO::Dir;
use IO::File;
use LvSenie2Unicode::Tables qw(substTable);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(transformFile transformDir);

sub transformFile
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 2)
	{
		print <<END;
Script for transforming a single SENIE source to Unicode. Source file name must
correspond name used in transformation tables. Output file name is formed as
filename stub + _Unicode.txt.

Params:
   data directory
   source filename stub without extension, e.g. Baum1699_LVV

AILab, LUMII, 2018, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $fileName = shift @_;
	my %table = %{substTable($fileName)};
	die "No table found for file $fileName!" unless (%table);
	#my $in = IO::File->new("$dirName/$fileName.txt", "< :encoding(UTF-8)")
	my $in = IO::File->new("$dirName/$fileName.txt", "< :encoding(cp1257)")
		or die "Could not open file $dirName/$fileName.txt: $!";
	mkdir "$dirName/res/";
	my $out = IO::File->new("$dirName/res/${fileName}_Unicode.txt", "> :encoding(UTF-8)")
		or die "Could not open file $dirName/res/${fileName}_Unicode.txt: $!";

	while (my $line = <$in>)
	{
		for my $target (keys %table)
		{
			$line =~ s/\Q$target\E/$table{$target}/g;
		}
		print $out $line;
	}

	$in->close();
	$out->close();
}

sub transformDir
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 1)
	{
		print <<END;
Script for transforming SENIE sources to Unicode. Source must be provided in
input folder with canonical names, e.g., Baum1699_LVV.txt.

Params:
   data directory

AILab, LUMII, 2018, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $dir = IO::Dir->new($dirName) or die "Folder $dirName is not available: $!";

	my $baddies = 0;
	my $all = 0;
	while (defined(my $inFile = $dir->read))
	{
		if ((-f "$dirName/$inFile") and $inFile =~ /^(.*?)\.txt$/)
		{
			my $nameStub = $1;
			my $isBad = 0;
			eval
			{
				local $SIG{__WARN__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval count warnings.
				transformFile($dirName, $nameStub);
			};
			$baddies = $baddies + $isBad;
			$all++;
		}
	}
	if ($baddies)
	{
		print "Processing $dirName finished, $baddies of $all files failed!";
	}
	else
	{
		print "Processing $dirName ($all files) finished successfully!";
	}
	return $baddies;
}


1;