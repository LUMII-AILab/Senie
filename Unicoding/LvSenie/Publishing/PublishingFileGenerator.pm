package LvSenie::Publishing::PublishingFileGenerator;
use strict;
use utf8;
use warnings;

use IO::Dir;
use IO::File;
use Data::Dumper;
use LvSenie::Translit::Transliterator qw(transliterateString);
use LvSenie::Translit::SimpleTranslitTables qw(substTable);

use LvSenie::Utils::CodeCatalog qw(isLanguage canDecode decode mustIncludeLanguage);
use LvSenie::Utils::SourceProperties qw(getSourceProperties);
use LvSenie::Utils::ExternalPropertyCatalog qw(getIndexType getExternalProperties);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(processFile processDirs);

our $doWarnAts = 1;
our $doWarnEmptyBraces = 0;
our $doWarnOtherBraces = 1;

our $doVert = 1;
our $doHtml = 1;
our $doTranslit = 0;

# TODO manis vienotie dehyp faili ir citādāki kā Normunda??
# TODO ko darīt, ja transliterācijas tabula maina tokenizāciju

sub processDirs
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 6)
	{
		print <<END;
Script for transforming SENIE sources to Sketch-appropriate vertical
format and/or html for senie.korpuss.lv.

Params:
   place for summarized result files
   endoding, expected cp1257 or UTF-8
   do vertical files?
   do html files?
   do transliteration?
   data directories

AILab, LUMII, 2022, provided under GPL
END
		exit 1;
	}
	my $totalResultDirName = shift @_;
	my $encoding = shift @_;
	$doVert = shift @_;
	$doHtml = shift @_;
	$doTranslit = shift @_;
	my @dirNames = @_;

	unless ($doVert or $doHtml)
	{
		print "\tNothing to do.\n";
		return;
	}

	#my $totalResDir = IO::Dir->new($totalResultDirName)
	#	or die "Folder $totalResultDirName is not available: $!";
	my $outForTotal = IO::File->new("$totalResultDirName/all.vert", "> :encoding(UTF-8)")
		or die "Could not open file $totalResultDirName/all.vert: $!";
	my $baddies = 0;
	my $all = 0;

	for my $dirName (@dirNames)
	{
		my $dir = IO::Dir->new($dirName) or die "Folder $dirName is not available: $!";
		mkdir "$dirName/res/";
		#my $outForDir = IO::File->new("$dirName/res/all.vert", "> :encoding(UTF-8)")
		#	or die "Could not open file $dirName/res/all.vert: $!";

		while (defined(my $inFile = $dir->read))
		{
			if ((-f "$dirName/$inFile") and $inFile =~ /^(.*?)\.txt$/)
			{
				my $isBad = 0;
				eval
				{
					local $SIG{__WARN__} = sub {
						$isBad = 1;
						warn $_[0]
					}; # This magic makes eval count warnings.
					local $SIG{__DIE__} = sub {
						$isBad = 1;
						warn $_[0]
					}; # This magic makes eval warn on die and count it as problem.
					processFile($dirName, $inFile, $encoding, $doVert, $doHtml, $outForTotal);
				};
				$baddies = $baddies + $isBad;
				$all++;
			}
		}
		#$outForDir->close();
	}
	$outForTotal->close();
	if ($baddies) {
		print "Processing finished, $baddies of $all files had problems!";
	}
	else {
		print "Processing $all files finished successfully!";
	}
	return $baddies;
}


sub processFile
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 3 or @_ > 6)
	{
		print <<END;

Script for transforming a single SENIE source to Sketch-appropriate vertical
format and/or html for senie.korpuss.lv. Source file name must end with .txt.
Output file name is formed as filename stub + .vert and/or source id + .html.
It is expected that file starts with lines \@a{author name} and
\@z{source code}.

Params:
   data directory
   source filename, e.g. Baum1699_LVV_Unicode.txt
   encoding, expected cp1257 or UTF-8
   do vertical files?
   do html files?
   filehandle for dumping copy of the processed contents [optional]

AILab, LUMII, 2022, provided under GPL
END
		exit 1;
	}

	my $dirName = shift @_;
	my $fileName = shift @_;
	my $encoding = shift @_;
	$doVert = shift @_;
	$doHtml = shift @_;
	my $outTotal = shift @_;
	$fileName =~ /^(.*?)\.txt$/;
	my $fileNameStub = $1;

	print "Processing $fileNameStub.\n";
	unless ($doVert or $doHtml)
	{
		print "\tNothing to do.\n";
		return;
	}

	# Get general file info and indexing type
	my $internalProperties = getSourceProperties("$dirName/$fileName", $encoding);
	my $fullSourceStub = $internalProperties->{'full ID'};
	my $lowerSourceId = $internalProperties->{'short ID'};
	my $indexType = getIndexType($internalProperties->{'full ID'});
	my $externalProperties = getExternalProperties($internalProperties->{'full ID'});
	my $author = $externalProperties->{'author'};

	# Prepare IO
	my ($outSingleVert, $outHtml, $translitTable) = (0,0, 0);
	if ($doTranslit)
	{
		$translitTable = substTable($lowerSourceId, $internalProperties->{'collection'});
		if (not $translitTable)
		{
			print "\t$fullSourceStub has no transliteration table, ommiting.\n";
			return;
		}
	}

	my $in = IO::File->new("$dirName/$fileName", "< :encoding($encoding)")
		or die "Could not open file $dirName/$fileName: $!";
	mkdir "$dirName/res/";
	mkdir "$dirName/res/$lowerSourceId/";

	if ($doVert)
	{
		$outSingleVert = IO::File->new("$dirName/res/$lowerSourceId/${fileNameStub}.vert", "> :encoding(UTF-8)")
			or die "Could not open file $dirName/res/$lowerSourceId/${fileNameStub}.vert: $!";
	}


	# Vert header
	my $urlPart = $internalProperties->{'full ID'};
	$urlPart =~ s/[\/]+/#/;
	&printInVerts("<doc id=\"$fullSourceStub\"", $outSingleVert, $outTotal);
	&printInVerts(" title=\"${\$externalProperties->{'short name'}}\"", $outSingleVert, $outTotal) if ($externalProperties->{'short name'});
	&printInVerts(" year=\"${\$externalProperties->{'year'}}\"", $outSingleVert, $outTotal) if ($externalProperties->{'year'});
	&printInVerts(" century=\"${\$externalProperties->{'century'}}\"", $outSingleVert, $outTotal) if ($externalProperties->{'century'});
	&printInVerts(" genre=\"${\$externalProperties->{'genre'}}\"", $outSingleVert, $outTotal) if ($externalProperties->{'genre'});

	my $subgenre = 0;
	$subgenre = join(',', @{$externalProperties->{'subgenre'}}) if ($externalProperties->{'subgenre'});
	&printInVerts(" subgenre=\"$subgenre\"", $outSingleVert, $outTotal) if ($subgenre);
	my $manuscript = $externalProperties->{'manuscript'} ? 'Jā' : 'Nē';
	&printInVerts(" manuscript=\"$manuscript\"", $outSingleVert, $outTotal);
	&printInVerts(" external=\"http://senie.korpuss.lv/source.jsp?codificator=$urlPart\"", $outSingleVert, $outTotal);
	&printInVerts(">\n", $outSingleVert, $outTotal);

	if ($doHtml)
	{
		my $htmlFileName = $lowerSourceId;
		$htmlFileName =~ s/_Unicode//;
		$outHtml = IO::File->new("$dirName/res/$lowerSourceId/${htmlFileName}.html", "> :encoding(UTF-8)")
			or die "Could not open file $dirName/res/$lowerSourceId/${htmlFileName}.html: $!";
	}
	# Html header
	&printInHtml("<html>\n\t<head>\n\t\t<meta charset=\"UTF-8\"/>\n", $outHtml);
	my $cssPath = $internalProperties->{'full ID'} eq $internalProperties->{'short ID'} ? '..' : '../..';
	&printInHtml("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"$cssPath/source.css\">\n", $outHtml);
	&printInHtml("\t\t<title>$fullSourceStub</title>\n", $outHtml);
	&printInHtml("\t</head>\n", $outHtml);
	&printInHtml("\t<body>\n", $outHtml);
	&printInHtml("\t\t<table>\n", $outHtml);

	# First two lines should always be file properties, not actual text.
	my $line = <$in>;
	warn "Author is not in the first line!" unless $line =~ /^\N{BOM}?\s*\@a\{(.*?)\}\s*$/;
	&printInHtml(&formLineForHtml($line), $outHtml);
	$line = <$in>;
	&printInHtml(&formLineForHtml($line), $outHtml);
	warn "Source ID is not in the second line!" unless $line =~ /^\s*\@z\{(.*?)\}\s*$/;

	# Counters for addresses
	my ($inPara, $inPage, $inVerse, $inChapter, $isLatvian) = (0, 0, 0, 0, 0);
	my ($currentPage, $currentLine, $currentChapter, $currentVerse, $currentWord) = (0, 0, 0, '0.', 0);

	# Line by line processing
	my $seenBookCode = 0;
	my $previousHtmlLineAddress = 0; #for HTML printing
	my $newHtmlLineAddress = 0; #for HTML printing
	while (my $line = <$in>)
	{
		$previousHtmlLineAddress = $newHtmlLineAddress;
		$newHtmlLineAddress = 0;
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
				&printInVerts("</para>\n", $outSingleVert, $outTotal);
				$inVerse = 0;
				$inPara = 0;
			}
			if ($inPage)
			{
				&printInVerts("</page>\n", $outSingleVert, $outTotal);
				$inPage = 0;
			}
			&printInVerts("<page sourceNo=\"$bookPageNo\" correctedNo=\"$corrPageNo\">\n", $outSingleVert, $outTotal);
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
				&printInVerts("</para>\n", $outSingleVert, $outTotal);
				$inVerse = 0;
				$inPara = 0;
			}
			&printInVerts("</chapter>\n", $outSingleVert, $outTotal) if ($inChapter);
			$currentChapter = $1;
			&printInVerts("<chapter no=\"$currentChapter\">\n", $outSingleVert, $outTotal) if ($inChapter);
			#TODO chapter commentary
			$currentVerse = '0.';
		}
		elsif ($line =~ /^\s*\@b\{(.*)\}\s*$/)	# repeated first word from next book;
		{
			# Omit it.
			$currentLine++;
		}
		elsif ($line =~ /^\s*\@a\{(.*)\}\s*$/)	# other author;
		{
			$author = $1;
			$currentLine++;
		}
		elsif ($line =~ /^\s*$/)	# empty line - paragraph border
		{
			if ($inVerse or $inPara)
			{
				&printInVerts("</para>\n", $outSingleVert, $outTotal);
				$inVerse = 0;
				$inPara = 0;
			}
		}
		else
		{
			unless ($inPara or $indexType eq 'GNP' or $indexType eq 'P')
			{
				&printInVerts("<para type=\"Paragraph\">\n", $outSingleVert, $outTotal);
				$inPara = 1;
			}
			# @@ ir tikai Normunda savienoto domuzīmju failos, manos tāda nav.
			if($line =~ /^\s*\@\@((?:\d+\.)+)(\p{Z}+)(.*$)/ or
				($indexType eq 'GNP' or $indexType eq 'P') and $line =~ /^  +((?:\d+\.)+)(\p{Z}+)(.*$)/) # verse in bible or in law
			{
				$currentVerse = $1;
				$line = "$3";

				&printInVerts("</para>\n", $outSingleVert, $outTotal) if ($inVerse);
				my $paraType = "Section";
				$paraType = "Verse" if ($indexType eq 'GNP');
				&printInVerts("<para no=\"$currentVerse\" type=\"$paraType\" address=\"${fullSourceStub}_", $outSingleVert, $outTotal);
				&printInVerts("${currentChapter}:", $outSingleVert, $outTotal) if($indexType eq 'GNP');
				&printInVerts("${currentVerse}\">\n", $outSingleVert, $outTotal);
				$inVerse = 1;
				$currentWord = 0;
			}
			&printInVerts("<line author=\"$author\"", $outSingleVert, $outTotal);
			$currentLine++;
			&printInVerts(" no=\"$currentLine\" address=\"${fullSourceStub}_${currentPage}_${currentLine}\"", $outSingleVert, $outTotal)
				if ($indexType eq 'LR' or $indexType eq 'GLR');
			&printInVerts(">\n", $outSingleVert, $outTotal);
			my $firstWord = 1;
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

				if ($codeLetter)
				{
					&printInVerts("<$sketchElemType $sketchAttrType=\"$decoded\">\n", $outSingleVert, $outTotal);
					if (mustIncludeLanguage($codeLetter))
					{
						&printInVerts("<language langName=\"Latvian\">\n", $outSingleVert, $outTotal);
						$isLatvian = 1;
					}
				}
				else
				{
					&printInVerts("<language langName=\"Latvian\">\n", $outSingleVert, $outTotal);
					$isLatvian = 1;
				}

				my $address = "${fullSourceStub}_";
				$address = "$address${currentChapter}:" if($indexType eq 'GNP');
				$address = "$address${currentVerse}" if($indexType eq 'GNP' or $indexType eq 'P');
				$address = "$address${currentPage}_${currentLine}" if ($indexType eq 'LR' or $indexType eq 'GLR');

				my @origTokens = @{&tokenize($linePart)};
				my $translitLine = 0;
				my @translitTokens = 0;
				if ($doTranslit)
				{
					$translitLine = $isLatvian ? transliterateString($linePart, $translitTable) : $linePart;
					@translitTokens = @{&tokenize($translitLine)};
					if (scalar(@origTokens) ne @translitTokens)
					{
						warn "$address tokenization problem for \"$linePart\"->\"$translitLine\"";
						@translitTokens = @origTokens
					}
				}

				#for my $token (@origTokens)
				for my $tokenNo (0..scalar(@origTokens)-1)
				{
					my $token = $origTokens[$tokenNo];
					my $translitToken = $translitTokens[$tokenNo];
					$currentWord++;
					&printInVerts("<g/>\n", $outSingleVert, $outTotal) unless ($token =~ /^\s+(.*)$/ or $firstWord);
					$token =~ s/^\p{Z}*(.*)$/$1/;

					$newHtmlLineAddress = $address;
					$address = "${address}_$currentWord"; #Everita pašlaik negrib vārda numuru, bet nav loģiski to ignorēt, ja adreses liek arī citur
					my ($splitTok, $splitCorr) = @{&splitCorrection($token, $address)};
					&printInVerts("$splitTok\t$splitCorr", $outSingleVert, $outTotal);
					&printInVerts("\t$translitToken", $outSingleVert, $outTotal) if ($doTranslit);
					&printInVerts("\t$address\n", $outSingleVert, $outTotal);
					$firstWord = 0;
				}
				if ($codeLetter) {
					&printInVerts("</$sketchElemType>\n", $outSingleVert, $outTotal);
					if (mustIncludeLanguage($codeLetter))
					{
						&printInVerts("</language>\n", $outSingleVert, $outTotal);
						$isLatvian = 0;
					}
				}
				else {
					&printInVerts("</language>\n", $outSingleVert, $outTotal);
					$isLatvian = 0;
				}
			}
			&printInVerts("</line>\n", $outSingleVert, $outTotal);
		}

		my $htmlLine = &formLineForHtml($line, $newHtmlLineAddress eq $previousHtmlLineAddress ? "" : $newHtmlLineAddress);
		&printInHtml($htmlLine, $outHtml);
	}

	&printInVerts("</para>\n", $outSingleVert, $outTotal) if ($inPara or $inVerse);
	&printInVerts("</page>\n", $outSingleVert, $outTotal) if ($inPage);
	&printInVerts("</doc>\n", $outSingleVert, $outTotal);
	$outSingleVert->close() if ($doVert);

	&printInHtml("\t\t<\/table>\t</body>\n</html>", $outHtml);
	$outHtml->close() if ($doHtml);

}

sub formLineForHtml
{
	my $line = shift @_;
	my $address = shift @_;

	return "<tr><td class=\"source-address\">&nbsp;</td><td class=\"source-line\">&nbsp;</td></tr>\n"
		if ($line =~ /^\s*$/);
	$address = '&nbsp;' unless ($address);
	$line =~ /^\s*(.*?)\s*$/;
	$line = $1;
	#Mandatory escapes
	$line =~ s/\&/&amp;/g;
	$line =~ s/</&lt;/g;
	#Some formating
	$line =~ s/(\[[^\]]*\])/<span class="source-page">$1<\/span>/g;
	$line =~ s/(\@[^{]{[^}]*({[^}]*}[^}]*)*})/<span class="source-marked">$1<\/span>/g;
	$line =~ s/(?<!\@.)({[^}]*})/<span class="source-correction">$1<\/span>/g;
	$line =~ s/(\@([^{])){/"<span class=\"source-atcode\" title=\"".&decode($2)."\">$1<\/span>{"/ge;
	return "<tr><td class=\"source-address\">$address</td><td class=\"source-line\">$line</td></tr>\n";
}

sub printInVerts
{
	return if (not $doVert);
	&printInAllStreems(@_)
}

sub printInHtml
{
	return if (not $doHtml);
	&printInAllStreems(@_)
}

sub printInAllStreems
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