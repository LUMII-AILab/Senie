package LvSenie::Publishing::PublishingFileGenerator;
use strict;
use utf8;
use warnings;

use IO::Dir;
use IO::File;
use Data::Dumper;

use LvSenie::Publishing::HtmlTools qw($DO_HTML printInHtml formLineForHtml printHtmlDocHead printHtmlDocTail);
use LvSenie::Publishing::TeiTools qw($DO_TEI printTeiCorpusHead printTeiCorpusTail printTeiCollectionHead
	printTeiCollectionTail printTeiDocHead printTeiDocTail);
use LvSenie::Publishing::VertTools qw($DO_VERT printVertDocHead printVertDocTail startVertPage endVertPage
	startVertBibleChapter endVertBibleChapter startVertVerse startVertParagraph endVertParagraphVerse
	startVertLine endVertLine startVertSubBlock endVertSubBlock startVertLatvian endVertLatvian printVertToken
	printVertGlue);
use LvSenie::Publishing::Utils qw(splitByLang tokenize printInAllStreams calculateAddressStub);
use LvSenie::Translit::Transliterator qw(transliterateString);
use LvSenie::Translit::SimpleTranslitTables qw(substTable);
use LvSenie::Utils::CodeCatalog qw(isLanguage canDecode decode mustIncludeLanguage);
use LvSenie::Utils::SourceProperties qw(getSourceProperties);
use LvSenie::Utils::ExternalPropertyCatalog qw(getIndexType getExternalProperties);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(processFile processDirs);

our $DO_TRANSLIT = 0;

# TODO manis vienotie dehyp faili ir citādāki kā Normunda??
# TODO ko darīt, ja transliterācijas tabula maina tokenizāciju

sub processDirs
{
	#STDOUT->autoflush(1);
	if (not @_ or @_ < 7)
	{
		print <<END;
Script for transforming SENIE sources to Sketch-appropriate vertical
format and/or html for senie.korpuss.lv.
If input data folder is called Apokr1689, JT1685, VD1689_94 or any of these
prefixed with data- or data_ then resulting TEI will contain appropriate
collection header.

Params:
   place for summarized result files
   endoding, expected cp1257 or UTF-8
   do vertical files?
   do html files?
   do TEI files?
   do transliteration?
   data directories

AILab, LUMII, 2022, provided under GPL
END
		exit 1;
	}
	my $totalResultDirName = shift @_;
	my $encoding = shift @_;
	$DO_VERT = shift @_;
	$DO_HTML = shift @_;
	$DO_TEI = shift @_;
	$DO_TRANSLIT = shift @_;
	my @dirNames = @_;

	unless ($DO_VERT or $DO_HTML or $DO_TEI) {
		print "\tNothing to do.\n";
		return;
	}

	my ($outForTotalVert, $outForTotalTei) = (0, 0);
	if ($DO_VERT) {
		$outForTotalVert = IO::File->new("$totalResultDirName/all.vert", "> :encoding(UTF-8)")
			or die "Could not open file $totalResultDirName/all.vert: $!";
	}
	if ($DO_TEI) {
		$outForTotalTei = IO::File->new("$totalResultDirName/all.tei.xml", "> :encoding(UTF-8)")
			or die "Could not open file $totalResultDirName/all.tei.xml: $!";
	}
	printTeiCorpusHead($outForTotalTei);

	my $baddies = 0;
	my $all = 0;

	for my $dirName (@dirNames)
	{
		my $dir = IO::Dir->new($dirName) or die "Folder $dirName is not available: $!";
		mkdir "$dirName/res/";
		my $dirCode = $dirName;
		$dirCode =~ s/^data[-_](.*)/$1/;
		my $externalProperties = getExternalProperties($dirCode);
		&_start_collection($dirCode, $externalProperties, $outForTotalVert, $outForTotalTei);

		while (defined(my $inFile = $dir->read))
		{
			if ((-f "$dirName/$inFile") and $inFile =~ /^(.*?)\.txt$/)
			{
				my $isBad = 0;
				eval
				{
					local $SIG{__WARN__} = sub {
						$isBad = 1;
						warn $_[0];
					}; # This magic makes eval count warnings.
					local $SIG{__DIE__} = sub {
						$isBad = 1;
						warn $_[0]
					}; # This magic makes eval warn on die and count it as problem.
					processFile($dirName, $inFile, $encoding, $DO_VERT, $DO_HTML, $DO_TEI,
						$outForTotalVert, $outForTotalTei);
				};
				$baddies = $baddies + $isBad;
				$all++;
			}
		}

		&_end_collection($externalProperties, $outForTotalVert, $outForTotalTei);
	}
	$outForTotalVert->close() if ($DO_VERT);
	printTeiCorpusTail($outForTotalTei);
	$outForTotalTei->close() if ($DO_TEI);

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
	#STDOUT->autoflush(1);
	if (not @_ or @_ < 3 or @_ > 8)
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
   do HTML files?
   do TEI files?
   filehandle for dumping copy of the processed vert contents [optional]
   filehandle for dumping copy of the processed Tei contents [optional]

AILab, LUMII, 2022, provided under GPL
END
		exit 1;
	}

	my $dirName = shift @_;
	my $fileName = shift @_;
	my $encoding = shift @_;
	$DO_VERT = shift @_;
	$DO_HTML = shift @_;
	$DO_TEI = shift @_;
	my $outTotalVert = shift @_;
	my $outTotalTei = shift @_;
	$fileName =~ /^(.*?)\.txt$/;
	my $fileNameStub = $1;

	print "Processing $fileNameStub.\n";
	unless ($DO_VERT or $DO_HTML or $DO_TEI) {
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

	# Prepare translit table
	my $translitTable = 0;
	if ($DO_TRANSLIT) {
		$translitTable = substTable($lowerSourceId, $internalProperties->{'collection'});
		print "\t$fullSourceStub has no transliteration table.\n"
			if (not $translitTable);
	}

	# Prepare IO
	my $in = IO::File->new("$dirName/$fileName", "< :encoding($encoding)")
		or die "Could not open file $dirName/$fileName: $!";
	mkdir "$dirName/res/";
	mkdir "$dirName/res/$lowerSourceId/";
	my $outs = {'vert' => 0, 'tei' => 0, 'html' => '0', 'total vert' => $outTotalVert, 'total tei' => $outTotalTei};
	&_initialize_outputs($fileNameStub, $internalProperties, $externalProperties, $dirName, $outs);

	# First two lines should always be file properties, not actual text.
	my $line = <$in>;
	warn "Author is not in the first line!" unless $line =~ /^\N{BOM}?\s*\@a\{(.*?)\}\s*$/;
	printInHtml(formLineForHtml($line), $outs);
	$line = <$in>;
	printInHtml(formLineForHtml($line), $outs);
	warn "Source ID is not in the second line!" unless $line =~ /^\s*\@z\{(.*?)\}\s*$/;

	# Booleans for positions inside certain elements
	my $status = {'paragraph' => 0, 'page' => 0, 'verse' => 0, 'chapter' => 0, 'Latvian' => 0, 'first word' => 1};
	# Counters for addresses
	my $counters = {'page' => 0, 'line' => 0, 'chapter' => 0, 'verse' => '0.', 'word' => 0};

	# Line by line processing
	my $seenBookCode = 0;
	my $previousHtmlLineAddress = 0; #for HTML printing
	my $newHtmlLineAddress = 0; #for HTML printing
	while ($line = <$in>)
	{
		$previousHtmlLineAddress = $newHtmlLineAddress;
		$newHtmlLineAddress = 0;
		# start of a new page
		if ($line =~ /^\s*\[(.*?)(\{(.*?)\})?\.lpp\.\]\s*$/)
		{
			# Retrieve written and corrected page numbers
			my $corrPageNo = $1;
			my $fullBookPageNo = $2;
			my $bookPageNo = $3;
			$bookPageNo = $corrPageNo unless ($fullBookPageNo);
			_change_page($status, $counters, $outs, $bookPageNo, $corrPageNo);
		}
		# bible book
		elsif ($line =~ /^\s*\@g\{(.*)\}\s*$/) {
			warn "Repeated Bible book code g (\@g{$1}!" if ($seenBookCode);
			$seenBookCode = 1;
		}
		# bible chapter
		elsif ($line =~ /^\s*\@n\{(.*)\}\s*$/) {
			_change_Bible_chapter($status, $counters, $outs, $1);
		}
		# repeated first word from next book;
		elsif ($line =~ /^\s*\@b\{(.*)\}\s*$/) {
			# Omit it.
			$counters->{'line'}++;
		}
		# other author;
		elsif ($line =~ /^\s*\@a\{(.*)\}\s*$/) {
			$author = $1;
			$counters->{'line'}++;
		}
		# empty line - paragraph border
		elsif ($line =~ /^\s*$/) {
			&_end_paragraph_verse($status, $outs);
		}
		# line with tokens
		else
		{
			&_start_paragraph($status, $outs)
				unless ($status->{'paragraph'} or $indexType eq 'GNP' or $indexType eq 'P');
			# Start verse (bible or law) if need be
			# @@ ir tikai Normunda savienoto domuzīmju failos, manos tāda nav.
			if($line =~ /^\s*\@\@((?:\d+\.)+)(\p{Z}+)(.*$)/ or
				($indexType eq 'GNP' or $indexType eq 'P') and $line =~ /^  +((?:\d+\.)+)(\p{Z}+)(.*$)/)
			{
				$line = "$3";
				&_start_verse($internalProperties, $status, $counters, $outs, $1,);
			}

			# Start line
			&_start_line($internalProperties, $counters, $outs, $author);
			$status->{'first word'} = 1;
			my $lineParts = splitByLang($line);
			for my $linePart (@$lineParts)
			{
				my $codeLetter = 0;
				if ($linePart =~ /^\s*@([\w\d]+){(.*?)}(\s*)$/) {
					$codeLetter = $1;
					$linePart = $2;
				}

				_start_sub_line($status, $outs, $codeLetter);
				my $addressStub = calculateAddressStub($internalProperties, $counters, 1);
				my @origTokens = @{tokenize($linePart)};
				my $translitLine = 0;
				my @translitTokens = 0;
				$newHtmlLineAddress = $addressStub if @origTokens;
				if ($DO_TRANSLIT)
				{
					$translitLine = ($status->{'Latvian'} and $translitTable) ?
						transliterateString($linePart, $translitTable) : $linePart;
					@translitTokens = @{tokenize($translitLine)};
					if (scalar(@origTokens) ne @translitTokens) {
						warn "$addressStub tokenization problem for \"$linePart\"->\"$translitLine\"";
						@translitTokens = @origTokens
					}
				}
				for my $tokenNo (0..scalar(@origTokens)-1)
				{
					&_print_token($internalProperties, $status, $counters, $outs,
							$origTokens[$tokenNo], $translitTokens[$tokenNo], $DO_TRANSLIT)
				}
				&_end_sub_line($status, $outs, $codeLetter);
			}
			&_end_line($outs);
		}

		# Do HTML for this line
		my $htmlLine = formLineForHtml($line,
			$newHtmlLineAddress eq $previousHtmlLineAddress ? "" : $newHtmlLineAddress);
		printInHtml($htmlLine, $outs);
	}

	# Print footers and finish everything.
	&_finish_outputs($status, $outs);
}

sub _initialize_outputs
{
	my $fileNameStub = shift @_;
	my $internalProperties = shift @_;
	my $externalProperties = shift @_;
	my $dirName = shift @_;
	my $outs = shift @_;

	my $fullSourceStub = $internalProperties->{'full ID'};
	my $lowerSourceId = $internalProperties->{'short ID'};

	# Vert file and its header
	if ($DO_VERT)
	{
		$outs->{'vert'} = IO::File->new("$dirName/res/$lowerSourceId/${fileNameStub}.vert", "> :encoding(UTF-8)")
			or die "Could not open file $dirName/res/$lowerSourceId/${fileNameStub}.vert: $!";
	}
	printVertDocHead($internalProperties, $externalProperties, $outs);

	# HTML file and its header
	if ($DO_HTML)
	{
		my $htmlFileName = $lowerSourceId;
		$htmlFileName =~ s/_Unicode//;
		$outs->{'html'} = IO::File->new("$dirName/res/$lowerSourceId/${htmlFileName}.html", "> :encoding(UTF-8)")
			or die "Could not open file $dirName/res/$lowerSourceId/${htmlFileName}.html: $!";
	}
	printHtmlDocHead($fullSourceStub, $internalProperties, $outs);

	# TEI file and its header
	if ($DO_TEI)
	{
		$outs->{'tei'} = IO::File->new("$dirName/res/$lowerSourceId/${fileNameStub}.tei.xml", "> :encoding(UTF-8)")
			or die "Could not open file $dirName/res/$lowerSourceId/${fileNameStub}.tei.xml: $!";
	}
	printTeiDocHead($internalProperties, $externalProperties, $outs);

}

sub _finish_outputs
{
	my $status = shift @_;
	my $outs = shift @_;

	printVertDocTail($status, $outs);
	close($outs->{'vert'}) if ($DO_VERT);

	printHtmlDocTail($outs);
	close($outs->{'html'}) if ($DO_HTML);

	printTeiDocTail($outs);
	close($outs->{'tei'}) if ($DO_TEI);
}

sub _start_collection
{
	my ($fullID, $externalProperties, $outForTotalVert, $outForTotalTei) = @_;
	return unless $externalProperties;
	printTeiCollectionHead($fullID, $externalProperties, $outForTotalTei)

}

sub _end_collection
{
	my ($externalProperties, $outForTotalVert, $outForTotalTei) = @_;
	return unless $externalProperties;
	printTeiCollectionTail($outForTotalTei);
}

sub _change_page
{
	my ($status, $counters, $outs, $bookPageNo, $corrPageNo) = @_;

	_end_paragraph_verse($status, $outs);
	if ($status->{'page'}) {
		endVertPage($outs);
		$status->{'page'} = 0;
	}
	startVertPage($outs, $bookPageNo, $corrPageNo);
	$status->{'page'} = 1;
	$counters->{'page'} = $corrPageNo;
	$counters->{'line'} = 0;
}

sub _change_Bible_chapter
{
	my $status = shift @_;
	my $counters = shift @_;
	my $outs = shift @_;
	my $chapterNo = shift @_;

	_end_paragraph_verse($status, $outs);
	endVertBibleChapter($outs) if ($status->{'chapter'});
	$counters->{'chapter'} = $chapterNo;
	startVertBibleChapter($outs, $counters->{'chapter'}) if ($status->{'chapter'});
	#TODO chapter commentary
	$counters->{'verse'} = '0.';
}

sub _start_paragraph
{
	my $status = shift @_;
	my $outs = shift @_;

	startVertParagraph($outs);
	$status->{'paragraph'} = 1;
}

sub _start_verse
{
	my $internalProperties = shift @_;
	my $status = shift @_;
	my $counters = shift @_;
	my $outs = shift @_;
	my $verseNo = shift @_;
	my $indexType = getIndexType($internalProperties->{'full ID'});

	$counters->{'verse'} = $verseNo;
	endVertParagraphVerse($outs) if ($status->{'verse'});
	my $address = calculateAddressStub($internalProperties, $counters, 0);
	startVertVerse($outs, $address, $verseNo, $indexType);
	$status->{'verse'} = 1;
	$counters->{'word'} = 0;
}

sub _end_paragraph_verse
{
	my $status = shift @_;
	my $outs = shift @_;

	if ($status->{'verse'} or $status->{'paragraph'}) {
		$status->{'verse'} = 0;
		$status->{'paragraph'} = 0;
		endVertParagraphVerse($outs),
	}
}

sub _start_line
{
	my $internalProperties = shift @_;
	my $counters = shift @_;
	my $outs = shift @_;
	my $currentAuthor = shift @_;

	my $fullSourceStub = $internalProperties->{'full ID'};
	my $indexType = getIndexType($internalProperties->{'full ID'});
	$counters->{'line'}++;
	my $address = "${fullSourceStub}_${\$counters->{'page'}}_${\$counters->{'line'}}";
	startVertLine($outs, $address, $counters->{'line'}, $currentAuthor, $indexType);
	$counters->{'word'} = 0 if ($indexType eq 'GLR' or $indexType eq 'LR');
}

sub _end_line
{
	my $outs = shift @_;
	endVertLine($outs);
}

sub _start_sub_line
{
	my $status = shift @_;
	my $outs = shift @_;
	my $codeLetter = shift @_;

	my $isLang = isLanguage($codeLetter);
	my $decoded = $codeLetter;
	$decoded = decode($codeLetter) if (canDecode($codeLetter));
	my $sketchElemType = ($isLang ? 'language' : 'block');
	my $sketchAttrType = ($isLang ? 'langName' : 'type');

	if ($codeLetter)
	{
		startVertSubBlock($outs, $sketchElemType, $sketchAttrType, $decoded);
		if (mustIncludeLanguage($codeLetter))
		{
			startVertLatvian($outs);
			$status->{'Latvian'} = 1;
		};
	}
	else
	{
		startVertLatvian($outs);
		$status->{'Latvian'} = 1;
	}
}

sub _end_sub_line
{
	my $status = shift @_;
	my $outs = shift @_;
	my $codeLetter = shift @_;

	my $isLang = isLanguage($codeLetter);
	my $sketchElemType = ($isLang ? 'language' : 'block');

	if ($codeLetter) {
		endVertSubBlock($outs, $sketchElemType);
		if (mustIncludeLanguage($codeLetter)) {
			endVertLatvian($outs);
			$status->{'Latvian'} = 0;
		}
	}
	else {
		endVertLatvian($outs);
		$status->{'Latvian'} = 0;
	}
}

sub _print_token
{
	my $internalProperties = shift @_;
	my $status = shift @_;
	my $counters = shift @_;
	my $outs = shift @_;
	my $token = shift @_;
	my $translitToken = shift @_;
	my $doTranslit = shift @_;
	my $addressStub = calculateAddressStub($internalProperties, $counters, 1);

	$counters->{'word'}++;
	printVertGlue($outs) unless ($token =~ /^\s+(.*)$/ or $status->{'first word'});
	$token =~ s/^\p{Z}*(.*)$/$1/;
	my $tokenAddress = "${addressStub}_${\$counters->{'word'}}"; #Everita pašlaik negrib vārda numuru, bet nav loģiski to ignorēt, ja adreses liek arī citur
	printVertToken($outs, $token, $translitToken, $doTranslit, $tokenAddress);
	$status->{'first word'} = 0;
}



1;