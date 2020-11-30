package LvSenieTranslit::Verticalizer;
use strict;
use utf8;
use warnings;
use IO::Dir;
use IO::File;
#use Data::Dumper;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(verticalizeFile verticalizeDir);

sub verticalizeDir
{
	autoflush STDOUT 1;
	if (not @_ or @_ != 1)
	{
		print <<END;
Script for transforming SENIE sources to Sketch-appropriate vertical format.

Params:
   data directory

AILab, LUMII, 2020, provided under GPL
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
			my $isBad = 0;
			eval
			{
				local $SIG{__WARN__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval count warnings.
				local $SIG{__DIE__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval warn on die and count it as problem.
				verticalizeFile($dirName, $inFile);
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


sub verticalizeFile
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 2)
	{
		print <<END;
Script for transforming a single SENIE source to Sketch-appropriate vertical
format. Source file name must end with .txt. Output file name is formed as
filename stub + _vertical.txt. It is expected that file starts with lines
\@a{author name} and \@z{source code}/

Params:
   data directory
   source filename, e.g. Baum1699_LVV_Unicode.txt

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}

	my $dirName = shift @_;
	my $fileName = shift @_;
	$fileName =~ /^(.*?)\.txt$/;
	my $fileNameStub = $1;

	my $in = IO::File->new("$dirName/$fileName", "< :encoding(UTF-8)")
		or die "Could not open file $dirName/$fileName: $!";

	my $author = <$in>;
	my $sourceId = <$in>;
	$author =~ s/^\N{BOM}?\s*\@a\{(.*?)\}\s*$/$1/;
	$sourceId =~ s/^\s*\@z\{(.*?)\}\s*$/$1/;

	mkdir "$dirName/res/";
	mkdir "$dirName/res/${sourceId}/";
	my $out = IO::File->new("$dirName/res/${sourceId}/${fileNameStub}_vertical.txt", "> :encoding(UTF-8)")
		or die "Could not open file $dirName/res/${sourceId}/${fileNameStub}_vertical.txt: $!";

	print $out "<doc id=\"$sourceId\" author=\"$author\">\n";
	my ($inPara, $inPage) = (0, 0);
	while (my $line = <$in>)
	{
		if ($line =~ /^\s*\[(.*?)\.lpp\.\]\s*$/)	# start of a new page
		{
			my $pageNo = $1;
			if ($inPara)
			{
				print $out "</para>\n";
				$inPara = 0;
			}
			if ($inPage)
			{
				print $out "</page>\n";
				$inPage = 0;
			}
			print $out "<page no=\"$pageNo\">\n";
			$inPage = 1;
		}
		elsif ($line =~ /^\s*$/)	# empty line - paragraph border
		{
			if ($inPara)
			{
				print $out "</para>\n";
				$inPara = 0;
			}
		}
		else
		{
			unless ($inPara)
			{
				print $out "<para>\n";
				$inPara = 1;
			}
			print $out "<line>\n";
			my $lineParts = &splitByLang($line);
			for my $linePart (@$lineParts)
			{
				my $language = 0;
				if ($linePart =~ /^\s*@([\w\d]+){(.*?)}(\s*)$/)
				{
					$language = $1;
					$linePart = $2;
				}

				print $out "<foreign lang=\"$language\">\n" if ($language);

				for my $token (@{&tokenize($linePart)})
				{
					print $out join "\t", @{&splitCorrection($token)};
					print $out "\n";
				}

				print $out "</foreign>\n" if ($language);
			}
			print $out "</line>\n";
		}
	}

	print $out "</para>\n" if ($inPara);
	print $out "</page>\n" if ($inPage);
	print $out "</doc>";
	$out->close;
}

sub splitByLang
{
	my $line = shift @_;
	my @result = split /\s*(?=\@[\w\d]+{)/, $line;
	@result = map {/^\s*(\@[\w\d]+\{[^\{\}]*(?:\{[^[]]*\})*[^\{\}]*\})?\s*(.*?)\s*$/; ($1, $2)} @result;
	@result = grep {$_} @result;
	return \@result;
}

sub tokenize
{
	my $line = shift @_;
	$line =~ s/^\s*(.*?)\s*$/$1/;
	my @result = split /\p{Z}|(?=[^=\{\}\[\]\p{L}\p{M}\p{N}])|(?<=[.,?!\(])(?=[\p{L}\p{N}])/, $line;
	return \@result;
}

sub splitCorrection
{
	my $token = shift @_;
	if ($token =~ /^([^{]+){([^}]+)}$/ )
	{
		return [$1, $2];
	}
	else
	{
		return [$token, $token];
	}
}

1;