package LvSenie::Publishing::PublishingFileGenerator;
use strict;
use utf8;
use warnings;

use IO::Dir;
use IO::File;

use LvSenie::Publishing::HtmlTools qw($DO_HTML printInHtml formLineForHtml printHtmlDocHead printHtmlDocTail htmlifyLineContents);
use LvSenie::Publishing::SqlLineTools qw($DO_SQL submitForPrintInSql emptySqlPrintingBuffer);
use LvSenie::Publishing::TeiTools qw($DO_TEI printTeiCorpusHead printTeiCorpusTail printTeiCollectionHead
	printTeiCollectionTail printTeiDocHead printTeiDocTail startTeiBibleChapter endTeiBibleChapter
	startTeiParagraph startTeiVerse endTeiParagraphVerse changeTeiPage changeTeiLine startTeiSubBlock endTeiSubBlock
	startTeiLatvian endTeiLatvian printTeiSubBlockContents);
use LvSenie::Publishing::VertTools qw($DO_VERT printVertDocHead printVertDocTail startVertPage endVertPage
	startVertBibleChapter endVertBibleChapter startVertVerse startVertParagraph endVertParagraphVerse
	startVertLine endVertLine startVertSubBlock endVertSubBlock startVertLatvian endVertLatvian printVertToken
	printVertGlue);
use LvSenie::Publishing::Utils qw(splitByLang tokenize printInAllStreams calculateAddressStub formPageNumber);
use LvSenie::Translit::Transliterator qw(transliterateString);
use LvSenie::Translit::SimpleTranslitTables qw(substTable);
use LvSenie::Utils::CodeCatalog qw(isLanguage canDecode decode mustIncludeLanguage);
use LvSenie::Utils::SourceProperties qw(getSourceProperties);
use LvSenie::Utils::ExternalPropertyCatalog qw(getIndexType getExternalProperties);

use Exporter();
use parent qw(Exporter);
our @EXPORT_OK = qw(processFile processDirs);

our $DO_TRANSLIT = 0;

# TODO Normunds ieteica TEI exportam hederī iekļaut indeksēšanas tipu.
# TODO novērst, ka vert faila atribūtos iet atstarpes galos.

sub processDirs
{
	#STDOUT->autoflush(1);
	if (not @_ or @_ < 8)
	{
		print <<END;
Script for transforming SENIE sources to Sketch-appropriate vertical
format and/or html for senie.korpuss.lv.

Note: if input data folder is called Apokr1689, JT1685, VD1689_94 or any of
  these prefixed with data- or data_ then resulting TEI will contain
  appropriate collection header.
Note: files without transliteration table, when transliteration is required,
  will be omitted from HTML and TEI, but included in vert.

Params:
   place for summarized result files
   endoding, expected cp1257 or UTF-8
   do vertical files?
   do html files?
   do TEI files?
   do SQL output?
   do transliteration?
   data directories

AILab, LUMII, 2025, provided under GPL
END
		exit 1;
	}
	my $totalResultDirName = shift @_;
	my $encoding = shift @_;
	my $doAllVert = shift @_;
	my $doAllHtml = shift @_;
	my $doAllTei = shift @_;
	my $doAllSql = shift @_;
	$DO_TRANSLIT = shift @_;
	my @dirNames = @_;

	unless ($doAllVert or $doAllHtml or $doAllTei or $doAllSql) {
		print "\tNothing to do.\n";
		return;
	}

	$DO_VERT = $doAllVert;
	$DO_HTML = $doAllHtml;
	$DO_TEI = $doAllTei;
	$DO_SQL = $doAllSql;

	my ($outForTotalVert, $outForTotalTei, $outForTotalSql) = (0, 0, 0);
	if ($doAllVert) {
		$outForTotalVert = IO::File->new("$totalResultDirName/all.vert", "> :encoding(UTF-8)")
			or die "Could not open file $totalResultDirName/all.vert: $!";
	}
	if ($doAllSql) {
		$outForTotalSql = IO::File->new("$totalResultDirName/insert_contexts_autogen.sql", "> :encoding(UTF-8)")
			or die "Could not open file $totalResultDirName/indert_contexts_autogen.sql: $!";
		print $outForTotalSql "-- AUTOMATICALLY GENERATED document line data.\n\n";
	}
	if ($doAllTei) {
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
					processFile($dirName, $inFile, $encoding, $doAllVert, $doAllHtml, $doAllTei, $doAllSql,
						$outForTotalVert, $outForTotalTei, $outForTotalSql);
				};
				$baddies = $baddies + $isBad;
				$all++;
			}
		}

		&_end_collection($externalProperties, $outForTotalVert, $outForTotalTei);
	}
	$outForTotalVert->close() if ($doAllVert);
	$outForTotalSql->close() if ($doAllSql);
	printTeiCorpusTail($outForTotalTei);
	$outForTotalTei->close() if ($doAllTei);

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
	if (not @_ or @_ < 3 or @_ > 10)
	{
		print <<END;

Script for transforming a single SENIE source to Sketch-appropriate vertical
format and/or html for senie.korpuss.lv. Source file name must end with .txt.
Output file name is formed as filename stub + .vert, .htm, or .tei.xml.
It is expected that file starts with lines \@a{author name} and
\@z{source code}.

Note: files without transliteration table, when transliteration is required,
  will be skipped from HTML and TEI, but transformed to vert.

Params:
   data directory
   source filename, e.g. Baum1699_LVV_Unicode.txt
   encoding, expected cp1257 or UTF-8
   do vertical files?
   do HTML files?
   do TEI files?
   do SQL output?
   filehandle for dumping copy of vert contents [optional]
   filehandle for dumping copy of TEI contents [optional]
   filehandle for dumping copy of SQL contents [optional]

AILab, LUMII, 2025, provided under GPL
END
		exit 1;
	}

	my $dirName = shift @_;
	my $fileName = shift @_;
	my $encoding = shift @_;
	my $doAllVert = shift @_;
	my $doAllHtml = shift @_;
	my $doAllTei = shift @_;
	my $doAllSql = shift @_;
	my $outTotalVert = shift @_;
	my $outTotalTei = shift @_;
	my $outTotalSql = shift @_;
	$fileName =~ /^(.*?)\.txt$/;
	my $fileNameStub = $1;

	print "Processing $fileNameStub.\n";
	unless ($doAllVert or $doAllHtml or $doAllTei or $doAllSql) {
		print "\tNothing to do.\n";
		return;
	}

	$DO_VERT = $doAllVert;
	$DO_HTML = $doAllHtml;
	$DO_TEI = $doAllTei;
	$DO_SQL = $doAllSql;

	# Get general file info and indexing type
	my $internalProperties = getSourceProperties("$dirName/$fileName", $encoding);
	my $fullSourceStub = $internalProperties->{'full ID'};
	my $lowerSourceId = $internalProperties->{'short ID'};
	my $indexType = getIndexType($internalProperties->{'full ID'});
	my $externalProperties = getExternalProperties($internalProperties->{'full ID'});
	my $author = $externalProperties->{'author'};

	# Prepare translit table
	my $translitTable = 0;
	if ($DO_TRANSLIT)
	{
		$translitTable = substTable($lowerSourceId, $internalProperties->{'collection'});
		if (not $translitTable) {
			print "\t$fullSourceStub has no transliteration table.\n";
			$DO_HTML = 0;
			$DO_TEI = 0;
			unless ($DO_VERT or $DO_SQL) {
				print "\t\tSkipping file without transliteration table.\n";
				return;
			}
		}
	}

	# Prepare IO
	my $in = IO::File->new("$dirName/$fileName", "< :encoding($encoding)")
		or die "Could not open file $dirName/$fileName: $!";
	mkdir "$dirName/res/";
	mkdir "$dirName/res/$lowerSourceId/";
	my $outs = {
		'vert' => 0, 'tei' => 0, 'html' => '0', 'sql' => '0',
		'total vert' => $outTotalVert, 'total tei' => $outTotalTei,
		'total sql' => $outTotalSql};
	&_initialize_outputs($fileNameStub, $internalProperties, $externalProperties, $dirName, $outs);

	# Booleans for positions inside certain elements
	my $status = {'paragraph' => 0, 'page' => undef, 'verse' => 0, 'chapter' => 0, 'Latvian' => 0, 'first word' => 1};
	# Counters for addresses
	my $counters = {'corrPage' => undef, 'origPage' => undef, 'line' => 0, 'chapter' => 0, 'verse' => '0.', 'word' => 0, 'overallLine' => 0, 'overallPage' => 0};

	# First two lines should always be file properties, not actual text.
	my $line = <$in>;
	$line =~ s/^\N{BOM}//;
	printInHtml(formLineForHtml(0, $line), $outs);
	submitForPrintInSql($fullSourceStub, "", "", $counters->{'overallPage'}, ++$counters->{'overallLine'}, htmlifyLineContents($line), $line, $outs);
	warn "Author is not in the first line!" unless $line =~ /^\s*\@a\{(.*?)\}\s*$/;
	$line = <$in>;
	printInHtml(formLineForHtml(0, $line), $outs);
	submitForPrintInSql($fullSourceStub, "", "", $counters->{'overallPage'}, ++$counters->{'overallLine'}, htmlifyLineContents($line), $line, $outs);
	warn "Source ID is not in the second line!" unless $line =~ /^\s*\@z\{(.*?)\}\s*$/;

	# Line by line processing
	my $seenBookCode = 0;
	my $previousLineAddress = 0; #for HTML and SQL printing
	my $newLineAddress = 0; #for HTML and SQL printing
	while ($line = <$in>)
	{
		$previousLineAddress = $newLineAddress;
		$newLineAddress = 0;
		# start of a new page
		# In figure brackets - sic, outside brackets - the corrected number
		if ($line =~ /^\s*\[(.*?)(\{(.*?)\})?\.lpp\.\]\s*$/)
		{
			# Retrieve written and corrected page numbers
			my $corrPageNo = $1;
			my $fullBookPageNo = $2;
			my $origPageNo = $3;
			$origPageNo = $corrPageNo unless ($fullBookPageNo);
			_change_page($status, $counters, $outs, $corrPageNo, $origPageNo);
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
				$line = "$1$2$3";
				&_end_paragraph_verse($status, $outs);
				&_start_verse($internalProperties, $status, $counters, $outs, $1,);
			}

			# Start line
			&_start_line($internalProperties, $counters, $outs, $author);
			$status->{'first word'} = 1;
			my $lineParts = splitByLang($line);
			for my $linePart (@$lineParts)
			{
				my $codeLetter = 0;
				if ($linePart =~ /^(\s*)@([\w\d]+){(.*?)}(\s*)$/) {
					$codeLetter = $2;
					$linePart = "$1$3";
				}

				_start_sub_line($status, $outs, $codeLetter);
				my $addressStub = calculateAddressStub($internalProperties, $counters, 1);
				my @origTokens = @{tokenize($linePart)};
				my $translitLine = $linePart;
				my @translitTokens = 0;
				$newLineAddress = $addressStub if @origTokens;
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
				for my $tokenNo (0..scalar(@origTokens)-1) {
					&_print_token($internalProperties, $status, $counters, $outs,
							$origTokens[$tokenNo], $translitTokens[$tokenNo], $DO_TRANSLIT)
				}
				if ($DO_TRANSLIT) {printTeiSubBlockContents($outs, $translitLine);}
				else {printTeiSubBlockContents($outs, $linePart);}
				&_end_sub_line($status, $outs, $codeLetter);
			}
			&_end_line($outs);
		}

		# Do HTML and SQL for this line
		my $textLineForHtml =  $DO_TRANSLIT ? transliterateString($line, $translitTable) : $line;
		my $printAddress = $newLineAddress eq $previousLineAddress ? "" : $newLineAddress;
		my $htmlLine = formLineForHtml($printAddress, $textLineForHtml);
		printInHtml($htmlLine, $outs);
		submitForPrintInSql($fullSourceStub, $printAddress,
			formPageNumber($counters->{'corrPage'}, $counters->{'origPage'}),
			$counters->{'overallPage'}, ++$counters->{'overallLine'},
			htmlifyLineContents($line), $line, $outs, 1);
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
	my $fullFileNameStub = $fileNameStub;
	my $htmlFileNameStub = $lowerSourceId;
	if ($DO_TRANSLIT)
	{
		$fullFileNameStub =~ s/_unhyphened$//;
		$fullFileNameStub = "${fullFileNameStub}_translitered";
		$htmlFileNameStub = "${lowerSourceId}_translitered";
	}

	# Vert file and its header
	if ($DO_VERT)
	{
		$outs->{'vert'} = IO::File->new("$dirName/res/$lowerSourceId/$fullFileNameStub.vert", "> :encoding(UTF-8)")
			or die "Could not open file $dirName/res/$lowerSourceId/$fullFileNameStub.vert: $!";
	}
	printVertDocHead($internalProperties, $externalProperties, $outs);

	# HTML file and its header
	if ($DO_HTML)
	{
		my $htmlFileName = $lowerSourceId;
		$htmlFileName =~ s/_Unicode//;
		$outs->{'html'} = IO::File->new("$dirName/res/$lowerSourceId/$htmlFileNameStub.htm", "> :encoding(UTF-8)")
			or die "Could not open file $dirName/res/$lowerSourceId/$htmlFileNameStub.htm: $!";
	}
	printHtmlDocHead($fullSourceStub, $internalProperties, $outs);

	# TEI file and its header
	if ($DO_TEI)
	{
		$outs->{'tei'} = IO::File->new("$dirName/res/$lowerSourceId/$fullFileNameStub.tei.xml", "> :encoding(UTF-8)")
			or die "Could not open file $dirName/res/$lowerSourceId/$fullFileNameStub.tei.xml: $!";
	}
	printTeiDocHead($internalProperties, $externalProperties, $outs);

	if ($DO_SQL)
	{
		$outs->{'sql'} = IO::File->new("$dirName/res/$lowerSourceId/${fullFileNameStub}_inserts.sql", "> :encoding(UTF-8)")
			or die "Could not open file $dirName/res/$lowerSourceId/${fullFileNameStub}_inserts.sql: $!";
	}
}

sub _finish_outputs
{
	my $status = shift @_;
	my $outs = shift @_;

	_end_paragraph_verse($status, $outs);
	_end_Bible_chapter($status, $outs);

	printVertDocTail($status, $outs);
	close($outs->{'vert'}) if ($DO_VERT);

	printHtmlDocTail($outs);
	close($outs->{'html'}) if ($DO_HTML);

	printTeiDocTail($outs);
	close($outs->{'tei'}) if ($DO_TEI);

	if ($DO_SQL)
	{
		emptySqlPrintingBuffer($outs);
		printInAllStreams("\n", $outs->{'sql'}, $outs->{'total sql'});
		close($outs->{'sql'});
	}
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
	my ($status, $counters, $outs, $corrPageNo, $origPageNo) = @_;

	_end_paragraph_verse($status, $outs);
	if ($status->{'page'}) {
		endVertPage($outs);
		$status->{'page'} = 0;
	}
	startVertPage($outs, $corrPageNo, $origPageNo);
	$status->{'page'} = 1;
	$counters->{'corrPage'} = $corrPageNo;
	$counters->{'origPage'} = $origPageNo;
	$counters->{'line'} = 0;
	$counters->{'overallPage'}++;
	changeTeiPage($outs, $corrPageNo, $origPageNo);
}

sub _change_Bible_chapter
{
	my $status = shift @_;
	my $counters = shift @_;
	my $outs = shift @_;
	my $chapterNo = shift @_;
	_end_Bible_chapter($status, $outs);
	$counters->{'chapter'} = $chapterNo;
	_start_Bible_chapter($status, $counters, $outs);
}

sub _start_Bible_chapter
{
	my ($status, $counters, $outs) = @_;
	if ($status->{'chapter'})
	{
		startVertBibleChapter($outs, $counters->{'chapter'});
		startTeiBibleChapter($outs, $counters->{'chapter'});
		#TODO chapter commentary
	}
	$counters->{'verse'} = '0.';
}

sub _end_Bible_chapter
{
	my ($status, $outs) = @_;
	_end_paragraph_verse($status, $outs);
	if ($status->{'chapter'})
	{
		endVertBibleChapter($outs);
		endTeiBibleChapter($outs);
	}
}

sub _start_paragraph
{
	my $status = shift @_;
	my $outs = shift @_;

	startVertParagraph($outs);
	startTeiParagraph($outs);
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
	startTeiVerse($outs, $address, $verseNo, $indexType);
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
		endVertParagraphVerse($outs);
		endTeiParagraphVerse($outs);
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
	my $address = defined(${\$counters->{'corrPage'}}) ?
		"${fullSourceStub}_${\$counters->{'corrPage'}}" : "${fullSourceStub}_0";
	$address = "$address\{${\$counters->{'origPage'}}\}"
		if (defined($counters->{'origPage'}) and $counters->{'origPage'}
			and ($counters->{'origPage'} ne $counters->{'corrPage'}));
	$address = "${address}_${\$counters->{'line'}}";
	startVertLine($outs, $address, $counters->{'line'}, $currentAuthor, $indexType);
	changeTeiLine($outs, $address, $indexType);
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

	if ($codeLetter)
	{
		if ($isLang)
		{
			startVertSubBlock($outs, 'language', 'langName', $decoded);
			startTeiSubBlock($outs, 'Language', $decoded);
		}
		else
		{
			startVertSubBlock($outs, 'block', 'type', $decoded);
			startTeiSubBlock($outs, $decoded);
		}
		if (mustIncludeLanguage($codeLetter))
		{
			startVertLatvian($outs);
			startTeiLatvian($outs);
			$status->{'Latvian'} = 1;
		};
	}
	else
	{
		startVertLatvian($outs);
		startTeiLatvian($outs);
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

	if ($codeLetter)
	{
		if (mustIncludeLanguage($codeLetter)) {
			endVertLatvian($outs);
			endTeiLatvian($outs);
			$status->{'Latvian'} = 0;
		}
		endVertSubBlock($outs, $sketchElemType);
		endTeiSubBlock($outs);
	}
	else
	{
		endVertLatvian($outs);
		endTeiLatvian($outs);
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
	$token =~ s/^\p{Z}*(.*?)\p{Z}*$/$1/;
	$translitToken =~ s/^\p{Z}*(.*?)\p{Z}*$/$1/ if $translitToken;
	my $tokenAddress = "${addressStub}_${\$counters->{'word'}}"; #Everita pašlaik negrib vārda numuru, bet nav loģiski to ignorēt, ja adreses liek arī citur
	printVertToken($outs, $token, $translitToken, $doTranslit, $tokenAddress);
	$status->{'first word'} = 0;
}

1;