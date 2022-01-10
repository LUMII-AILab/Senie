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

our $doWarnAts = 1;
our $doWarnEmptyBraces = 0;
our $doWarnOtherBraces = 1;

# TODO manis vienotie dehyp faili ir citādāki kā Normunda??
# TODO ko darīt, ja transliterācijas tabula maina tokenizāciju

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

	mkdir "$dirName/res/";
	my $outForTotal = IO::File->new("$dirName/res/all.vert", "> :encoding(UTF-8)")
		or die "Could not open file $dirName/res/all.vert: $!";
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
				verticalizeFile($dirName, $inFile, $encoding, $outForTotal);
			};
			$baddies = $baddies + $isBad;
			$all++;
		}
	}
	$outForTotal->close();
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
	if (not @_ or @_ < 3 or @_ > 4)
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
   filehandle for dumping copy of the processed contents [optional]

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}

	my $dirName = shift @_;
	my $fileName = shift @_;
	my $encoding = shift @_;
	my $outTotal = shift @_;
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
	my $outSingle = IO::File->new("$dirName/res/$lowerSourceId/${fileNameStub}.vert", "> :encoding(UTF-8)")
		or die "Could not open file $dirName/res/$lowerSourceId/${fileNameStub}.vert: $!";

	# Doc header
	&printInVerts("<doc id=\"$fullSourceStub\" author=\"${\$properties->{'a'}}\"", $outSingle, $outTotal);
	&printInVerts(" year=\"${\$properties->{'year'}}\"", $outSingle, $outTotal) if ($properties->{'year'});
	&printInVerts(" century=\"${\$properties->{'cent'}}\"", $outSingle, $outTotal) if ($properties->{'cent'});
	#print $out " commentary=\"${\$properties->{'k'}}\"" if (($indexType eq 'GNP' or $indexType eq 'GLR') and $properties->{'k'});
	&printInVerts(">\n", $outSingle, $outTotal);

	# Counters for adreses
	my ($inPara, $inPage, $inVerse, $inChapter) = (0, 0, 0, 0);
	my ($currentPage, $currentLine, $currentChapter, $currentVerse, $currentWord) = (0, 0, 0, 0, 0);

	# Line by line processing
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
				&printInVerts("</para>\n", $outSingle, $outTotal);
				$inVerse = 0;
				$inPara = 0;
			}
			if ($inPage)
			{
				&printInVerts("</page>\n", $outSingle, $outTotal);
				$inPage = 0;
			}
			&printInVerts("<page sourceNo=\"$bookPageNo\" correctedNo=\"$corrPageNo\">\n", $outSingle, $outTotal);
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
				&printInVerts("</para>\n", $outSingle, $outTotal);
				$inVerse = 0;
				$inPara = 0;
			}
			&printInVerts("</chapter>\n", $outSingle, $outTotal) if ($inChapter);
			$currentChapter = $1;
			&printInVerts("<chapter no=\"$currentChapter\">\n", $outSingle, $outTotal) if ($inChapter);
			#TODO chapter commentary
			$currentVerse = 0;
		}
		elsif ($line =~ /^\s*\@b\{(.*)\}\s*$/)	# repeated first word from next book;
		{
			# Omit it.
			$currentLine++;
		}
		elsif ($line =~ /^\s*$/)	# empty line - paragraph border
		{
			if ($inVerse or $inPara)
			{
				&printInVerts("</para>\n", $outSingle, $outTotal);
				$inVerse = 0;
				$inPara = 0;
			}
		}
		else
		{
			unless ($inPara or $indexType eq 'GNP' or $indexType eq 'P')
			{
				&printInVerts("<para type=\"Paragraph\">\n", $outSingle, $outTotal);
				$inPara = 1;
			}
			# @@ ir tikai Normunda savienoto domuzīmju failos, manos tāda nav.
			if($line =~ /^\s*\@\@((?:\d+\.)+)(\p{Z}+)(.*$)/ or
				($indexType eq 'GNP' or $indexType eq 'P') and $line =~ /^  +((?:\d+\.)+)(\p{Z}+)(.*$)/) # verse in bible or in law
			{
				$currentVerse = $1;
				$line = "$3";

				&printInVerts("</para>\n", $outSingle, $outTotal) if ($inVerse);
				my $paraType = "Section";
				$paraType = "Verse"if ($indexType eq 'GNP');
				&printInVerts("<para no=\"$currentVerse\" type=\"$paraType\">\n", $outSingle, $outTotal);
				$inVerse = 1;
				$currentWord = 0;
			}
			&printInVerts("<line>\n", $outSingle, $outTotal);
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
				my $sketchElemType = ($isLang ? 'language' : 'block');
				my $sketchAttrType = ($isLang ? 'langName' : 'type');

				$codeLetter ?
					&printInVerts("<$sketchElemType $sketchAttrType=\"$decoded\">\n", $outSingle, $outTotal) :
					&printInVerts("<language langName=\"Latvian\">\n", $outSingle, $outTotal);


				for my $token (@{&tokenize($linePart)})
				{
					$currentWord++;
					&printInVerts("<g/>\n", $outSingle, $outTotal) unless ($token =~ /^\s+(.*)$/ or $firstWord);
					$token =~ s/^\p{Z}*(.*)$/$1/;
					my $address = "${fullSourceStub}_";
					$address = "$address${currentChapter}:" if($indexType eq 'GNP');
					$address = "$address${currentVerse}" if($indexType eq 'GNP' or $indexType eq 'P');
					$address = "$address${currentPage}_${currentLine}" if ($indexType eq 'LR' or $indexType eq 'GLR');
					#$address = "$address_$currentWord"; #Everita pašlaik negrib vārda numuru
					&printInVerts(join("\t", @{&splitCorrection($token, $address)}), $outSingle, $outTotal);
					&printInVerts("\t$address\n", $outSingle, $outTotal);
					$firstWord = 0;
				}
				$codeLetter ?
					&printInVerts("</$sketchElemType>\n", $outSingle, $outTotal) :
					&printInVerts("</language>\n", $outSingle, $outTotal);

			}
			&printInVerts("</line>\n", $outSingle, $outTotal);
		}
	}

	&printInVerts("</para>\n", $outSingle, $outTotal) if ($inPara or $inVerse);
	&printInVerts("</page>\n", $outSingle, $outTotal) if ($inPage);
	&printInVerts("</doc>\n", $outSingle, $outTotal);
	$outSingle->close;
}

sub printInVerts
{
	my $text = shift @_;
	my @outs = @_;
	for my $out (@outs)
	{
		print $out $text if ($out);
	}
}

# Split line so that each fragment in different language becomes a new segment.
sub splitByLang
{
	my $line = shift @_;
	my @result = split /\s*(?=\@[\w\d]+{)/, $line;
	@result = map {/^\s*(\@[\w\d]+\{(?:[^\{\}]*\{[^{}]*\})*[^\{\}]*\})?\s*(.*?)\s*$/; ($1, $2)} @result;
	@result = grep {$_} @result;
	return \@result;
}

# Split a line in tokens, taking into account specifics like "=" usage.
sub tokenize
{
	my $line = shift @_;
	$line =~ s/^\s*(.*?)\s*$/$1/;	# Remove leading and trailing whitespaces
	$line =~ tr/\t/ /;	# Remove tabs
	$line =~ s/(\p{Z})\p{Z}+(?!\p{Z})/$1/g;	# Remove double whitespaces
	my @tooMuchTokens = split /(?=\p{Z})|(?=\{\})|(?=[\\\/](\p{Z}|$))|(?=[^=\{\}\[\]\p{L}\p{M}\p{N}^~`'´\\\/ß§\$#"])|(?<=[,.?!\(])(?=[\p{L}\p{N}])/, $line;
	@tooMuchTokens = grep {$_} @tooMuchTokens;
	my @result = ();
	while (@tooMuchTokens)
	{
		my $token = shift @tooMuchTokens;
		$token = $token . shift(@tooMuchTokens) while ($token =~ /^\p{Z}*$/ or ($token =~ /\{[^}]*$/ and @tooMuchTokens));
		push @result, $token;
	}
	return \@result;
}

# Split token{correction} into two strings and remove {}.
sub splitCorrection
{
	my $token = shift @_;
	my $address = shift @_;
	my ($form, $corr) = ($token, $token);
	($form, $corr) = ($1, $2) if ($token =~ /^([^{]+){([^}]+)}$/ );
	warn "Suspicious token $form at $address\n" if ($form =~/[@]/ and $doWarnAts);
	warn "Suspicious token $form at $address\n" if ($form =~/\{\}/ and $doWarnEmptyBraces);
	warn "Suspicious token $form at $address\n" if ($form =~/[\{\}]/ and $form !~ /\{\}/ and $doWarnOtherBraces);
	warn "Suspicious correction $corr at $address\n" if ($corr =~/[@]/ and $doWarnAts);
	warn "Suspicious correction $corr at $address\n" if ($corr =~/\{\}/ and $doWarnEmptyBraces);
	warn "Suspicious correction $corr at $address\n" if ($corr =~/[\{\}]/ and $corr !~ /\{\}/ and $doWarnOtherBraces);

	#TODO kā pareizi apstrādāt tos tukšos? Jo tas nenozīmē, ka iepriekšējo vārdu nevajag.
	#$corr = '_' unless $corr;
	return [$form, $corr];
}

1;