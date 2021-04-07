package LvSenie::Vert::Verticalizer;
use strict;
use utf8;
use warnings;

use IO::Dir;
use IO::File;
#use Data::Dumper;
use LvSenie::Utils::CodeCatalog qw(isLanguage canDecode decode);
use LvSenie::Utils::SourceProperties qw(getSourceProperties);
use LvSenie::Vert::IndexTypeCatalog qw(getIndexType);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(verticalizeFile verticalizeDir);

# TODO manis vienotie dehyp faili ir citādāki kā Normunda, laikam jāpāriet visur uz maniem???
sub verticalizeDir
{
	autoflush STDOUT 1;
	if (not @_ or @_ != 2)
	{
		print <<END;
Script for transforming SENIE sources to Sketch-appropriate vertical format.

Params:
   data directory
   endoding, expected cp1257 or UTF-8

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $encoding = shift @_;
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
				verticalizeFile($dirName, $inFile, $encoding);
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
	if (not @_ or @_ != 3)
	{
		print <<END;
Script for transforming a single SENIE source to Sketch-appropriate vertical
format. Source file name must end with .txt. Output file name is formed as
filename stub + _vertical.txt. It is expected that file starts with lines
\@a{author name} and \@z{source code}/

Params:
   data directory
   source filename, e.g. Baum1699_LVV_Unicode.txt
   endoding, expected cp1257 or UTF-8

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}

	my $dirName = shift @_;
	my $fileName = shift @_;
	my $encoding = shift @_;
	$fileName =~ /^(.*?)\.txt$/;
	my $fileNameStub = $1;

	print "Processing $fileNameStub.\n";

	# Get general file info and indexing type
	my $properties = getSourceProperties("$dirName/$fileName", $encoding);
	my $indexType = getIndexType ($properties->{'z'}, $properties->{'g'});
	my $fullSourceStub = $properties->{'z'};
	$fullSourceStub = $fullSourceStub . "/" . $properties->{'g'} if (exists $properties->{'g'});
	my $lowerSourceId = ($properties->{'g'} or $properties->{'z'});

	# Prepare input
	my $in = IO::File->new("$dirName/$fileName", "< :encoding($encoding)")
		or die "Could not open file $dirName/$fileName: $!";

	# First two lines should always be file properties, not actual text.
	my $line = <$in>;
	warn "Author is not in the first line!" unless $line =~ /^\N{BOM}?\s*\@a\{(.*?)\}\s*$/;
	$line = <$in>;
	warn "Source ID is not in the second line!" unless $line =~ /^\s*\@z\{(.*?)\}\s*$/;
	#if ($indexType eq 'GNP' or $indexType eq 'GLR')
	#{
	#	$line = <$in>;
	#	$line = <$in> while ($line =~ /^\p{Z}*$/);
	#	$line = <$in> if ($line =~ /^\s*\@k\{(.*?)\}\s*$/);
	#	warn "Bible book is not in the third/fourth nonempty line!" unless $line =~ /^\s*\@g\{(.*?)\}\s*$/;
	#}

	# Prepare output
	mkdir "$dirName/res/";
	mkdir "$dirName/res/$lowerSourceId/";
	my $out = IO::File->new("$dirName/res/$lowerSourceId/${fileNameStub}_vertical.txt", "> :encoding(UTF-8)")
		or die "Could not open file $dirName/res/$lowerSourceId/${fileNameStub}_vertical.txt: $!";

	# Doc header
	print $out "<doc id=\"$fullSourceStub\" author=\"${\$properties->{'a'}}\"";
	#print $out " commentary=\"${\$properties->{'k'}}\"" if (($indexType eq 'GNP' or $indexType eq 'GLR') and $properties->{'k'});
	print $out ">\n";

	my ($inPara, $inPage, $inVerse, $inChapter) = (0, 0, 0, 0);
	my ($currentPage, $currentLine, $currentChapter, $currentVerse, $currentWord) = (0, 0, 0, 0, 0);
	my $seenBookCode = 0;
	while (my $line = <$in>)
	{
		if ($line =~ /^\s*\[(.*?)(\{(.*?)\})?\.lpp\.\]\s*$/)	# start of a new page
		{

			# Retrieve written and corrected page numbers
			my $corrPageNo = $1;
			my $fullBookPageNo = $2;
			my $bookPageNo = $3;
			$bookPageNo = $corrPageNo unless($fullBookPageNo);
			#print "$line $corrPageNo, $fullBookPageNo, $bookPageNo @ $sourceId\n" if ($line =~ /[{}]/);

			# Print paragraph and page borders.
			if ($inVerse or $inPara)
			{
				print $out "</para>\n";
				$inVerse = 0;
				$inPara = 0;
			}
			if ($inPage)
			{
				print $out "</page>\n";
				$inPage = 0;
			}
			print $out "<page correctedNo=\"$corrPageNo\" sourceNo=\"$bookPageNo\">\n";
			$inPage = 1;
			# Update indexing data.
			$currentPage = $corrPageNo;
			$currentLine = 0;
		}
		elsif ($line =~ /^\s*\@g\{(.*)\}\s*$/)	# bible book
		{
			warn "Repeated Bible book code g (\@g{$1}!" if ($seenBookCode);
			$seenBookCode = 1;
		}
		elsif ($line =~ /^\s*\@n\{(.*)\}\s*$/)	# bible chapter
		{
			if ($inVerse or $inPara)
			{
				print $out "</para>\n";
				$inVerse = 0;
				$inPara = 0;
			}
			print $out "</chapter>\n" if ($inChapter);
			$currentChapter = $1;
			print $out "<chapter no=\"$currentChapter\">\n" if ($inChapter);
			#TODO chapter commentary
			$currentVerse = 0;
		}
		elsif ($line =~ /^\s*$/)	# empty line - paragraph border
		{
			if ($inVerse or $inPara)
			{
				print $out "</para>\n";
				$inVerse = 0;
				$inPara = 0;
			}
		}
		else
		{
			unless ($inPara or $indexType eq 'GNP' or $indexType eq 'P')
			{
				print $out "<para type=\"paragraph\">\n";
				$inPara = 1;
			}
			# @@ ir tikai Normunda savienoto domuzīmju failos, manos tāda nav.
			if($line =~ /^\s*\@\@((?:\d+\.)+)(\p{Z}+)(.*$)/ or
				($indexType eq 'GNP' or $indexType eq 'P') and $line =~ /^  +((?:\d+\.)+)(\p{Z}+)(.*$)/) # verse in bible or in law
			{
				$currentVerse = $1;
				$line = "$3";

				print $out "</para>\n" if ($inVerse);
				my $paraType = "section";
				$paraType = "verse"if ($indexType eq 'GNP');
				print $out "<para no=\"$currentVerse\" type=\"$paraType\">\n";
				$inVerse = 1;
				$currentWord = 0;
			}
			print $out "<line>\n";
			my $firstWord = 1;
			$currentLine++;
			$currentWord = 0 if ($indexType eq 'GLR' or $indexType eq 'LR');
			my $lineParts = &splitByLang($line);
			for my $linePart (@$lineParts)
			{
				my $codeLetter = 0;
				if ($linePart =~ /^\s*@([\w\d]+){(.*?)}(\s*)$/)
				{
					$codeLetter = $1;
					$linePart = $2;
				}
				my $isLang = isLanguage($codeLetter);
				my $decoded = $codeLetter;
				$decoded = decode($codeLetter) if (canDecode($codeLetter));
				my $sketchElemType = ($isLang ? 'foreign' : 'block');
				my $sketchAttrType = ($isLang ? 'lang' : 'type');

				print $out "<$sketchElemType $sketchAttrType=\"$decoded\">\n" if ($codeLetter);

				for my $token (@{&tokenize($linePart)})
				{
					$currentWord++;
					print $out "<g/>\n" unless ($token =~ /^\s+(.*)$/ or $firstWord);
					$token =~ s/^\p{Z}*(.*)$/$1/;
					print $out join "\t", @{&splitCorrection($token)};
					print $out "\t${fullSourceStub}_";
					print $out "${currentChapter}:" if($indexType eq 'GNP');
					print $out "${currentVerse}_" if($indexType eq 'GNP' or $indexType eq 'P');
					print $out "${currentPage}_${currentLine}_" if ($indexType eq 'LR' or $indexType eq 'GLR');
					print $out $currentWord;
					print $out "\n";
					$firstWord = 0;
				}

				print $out "</$sketchElemType>\n" if ($codeLetter);
			}
			print $out "</line>\n";
		}
	}

	print $out "</para>\n" if ($inPara or $inVerse);
	print $out "</page>\n" if ($inPage);
	print $out "</doc>";
	$out->close;
}

# Split line so that each fragment in different language becomes a new segment.
sub splitByLang
{
	my $line = shift @_;
	my @result = split /\s*(?=\@[\w\d]+{)/, $line;
	@result = map {/^\s*(\@[\w\d]+\{[^\{\}]*(?:\{[^[]]*\})*[^\{\}]*\})?\s*(.*?)\s*$/; ($1, $2)} @result;
	@result = grep {$_} @result;
	return \@result;
}

# Split a line in tokens, taking into account specifics like "=" usage.
sub tokenize
{
	my $line = shift @_;
	$line =~ s/^\s*(.*?)\s*$/$1/;
	my @result = split /(?=\p{Z}+)|(?=[^=\{\}\[\]\p{L}\p{M}\p{N},^~`'´\\\/ß§\$#"])|(?<=[.?!\(])(?=[\p{L}\p{N}])/, $line;
	return \@result;
}

# Split token{correction} into two strings and remove {}.
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