package LvSenie::Publishing::VertTools;
use strict;
use utf8;
use warnings;

use LvSenie::Publishing::Utils qw(printInAllStreams splitCorrection calculateAddressStub);
use LvSenie::Utils::CodeCatalog qw(isLanguage canDecode decode mustIncludeLanguage);
use LvSenie::Utils::ExternalPropertyCatalog qw(getIndexType);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw($DO_VERT printInVerts printVertDocHead printVertDocTail changeVertPage changeVertBibleChapter
    startVertVerse startVertParagraph endVertParagraphVerse startVertLine endVertLine startVertSubBlock endVertSubBlock
    printVertToken);

our $DO_VERT = 0;

sub printVertDocHead
{
    my $internalProperties = shift @_;
    my $externalProperties = shift @_;
    my $outs = shift @_;
    my $fullSourceStub = $internalProperties->{'full ID'};
    my $urlPart = $internalProperties->{'full ID'};
    $urlPart =~ s/[\/]+/#/;
    &printInVerts("<doc id=\"$fullSourceStub\"", $outs);
    &printInVerts(" title=\"${\$externalProperties->{'short name'}}\"", $outs) if ($externalProperties->{'short name'});
    &printInVerts(" year=\"${\$externalProperties->{'year'}}\"", $outs) if ($externalProperties->{'year'});
    &printInVerts(" century=\"${\$externalProperties->{'century'}}\"", $outs) if ($externalProperties->{'century'});
    &printInVerts(" genre=\"${\$externalProperties->{'genre'}}\"", $outs) if ($externalProperties->{'genre'});

    my $subgenre = 0;
    $subgenre = join(',', @{$externalProperties->{'subgenre'}}) if ($externalProperties->{'subgenre'});
    &printInVerts(" subgenre=\"$subgenre\"", $outs) if ($subgenre);
    my $manuscript = $externalProperties->{'manuscript'} ? 'Jā' : 'Nē';
    &printInVerts(" manuscript=\"$manuscript\"", $outs);
    &printInVerts(" external=\"http://senie.korpuss.lv/source.jsp?codificator=$urlPart\"", $outs);
    &printInVerts(">\n", $outs);
}

sub printVertDocTail
{
    my $status = shift @_;
    my $outs = shift @_;
    &printInVerts("</para>\n", $outs) if ($status->{'paragraph'} or $status->{'verse'});
    &printInVerts("</page>\n", $outs) if ($status->{'page'});
    &printInVerts("</doc>\n", $outs);
}

sub changeVertPage
{
    my $status = shift @_;
    my $counters = shift @_;
    my $outs = shift @_;
    my $bookPageNo = shift @_;
    my $corrPageNo = shift @_;

    endVertParagraphVerse($status, $outs);
    if ($status->{'page'}) {
        printInVerts("</page>\n", $outs);
        $status->{'page'} = 0;
    }
    printInVerts("<page sourceNo=\"$bookPageNo\" correctedNo=\"$corrPageNo\">\n", $outs);
    $status->{'page'} = 1;

    $counters->{'page'} = $corrPageNo;
    $counters->{'line'} = 0;
}

sub changeVertBibleChapter
{
    my $status = shift @_;
    my $counters = shift @_;
    my $outs = shift @_;
    my $chapterNo = shift @_;

    endVertParagraphVerse($status, $outs);
    printInVerts("</chapter>\n", $outs) if ($status->{'chapter'});
    $counters->{'chapter'} = $chapterNo;
    printInVerts("<chapter no=\"${\$counters->{'chapter'}}\">\n", $outs) if ($status->{'chapter'});
    #TODO chapter commentary
    $counters->{'verse'} = '0.';
}

sub startVertParagraph
{
    my $status = shift @_;
    my $outs = shift @_;

    printInVerts("<para type=\"Paragraph\">\n", $outs);
    $status->{'paragraph'} = 1;
}

sub endVertParagraphVerse
{
    my $status = shift @_;
    my $outs = shift @_;

    if ($status->{'verse'} or $status->{'paragraph'}) {
        printInVerts("</para>\n", $outs);
        $status->{'verse'} = 0;
        $status->{'paragraph'} = 0;
    }
}

sub startVertVerse
{
    my $internalProperties = shift @_;
    my $status = shift @_;
    my $counters = shift @_;
    my $outs = shift @_;
    my $verseNo = shift @_;
    my $indexType = getIndexType($internalProperties->{'full ID'});

    $counters->{'verse'} = $verseNo;
    printInVerts("</para>\n", $outs) if ($status->{'verse'});
    my $paraType = "Section";
    $paraType = "Verse" if ($indexType eq 'GNP');
    my $address = calculateAddressStub($internalProperties, $counters, 0);
    printInVerts("<para no=\"${\$counters->{'verse'}}\" type=\"$paraType\" address=\"${address}\">\n", $outs);
    $status->{'verse'} = 1;
    $counters->{'word'} = 0;
}

sub startVertLine
{
    my $internalProperties = shift @_;
    my $counters = shift @_;
    my $outs = shift @_;
    my $currentAuthor = shift @_;

    my $fullSourceStub = $internalProperties->{'full ID'};
    my $indexType = getIndexType($internalProperties->{'full ID'});

    printInVerts("<line author=\"$currentAuthor\"", $outs);
    $counters->{'line'}++;
    printInVerts(" no=\"${\$counters->{'line'}}\" address=\"${fullSourceStub}_${\$counters->{'page'}}_${\$counters->{'line'}}\"", $outs)
        if ($indexType eq 'LR' or $indexType eq 'GLR');
    printInVerts(">\n", $outs);
    $counters->{'word'} = 0 if ($indexType eq 'GLR' or $indexType eq 'LR');
}

sub endVertLine
{
    my $outs = shift @_;
    printInVerts("</line>\n", $outs);
}

sub startVertSubBlock
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
        printInVerts("<$sketchElemType $sketchAttrType=\"$decoded\">\n", $outs);
        startVertLatvian($status, $outs)
            if (mustIncludeLanguage($codeLetter));
    }
    else
    {
        startVertLatvian($status, $outs);
    }
}

sub endVertSubBlock
{
    my $status = shift @_;
    my $outs = shift @_;
    my $codeLetter = shift @_;

    my $isLang = isLanguage($codeLetter);
    my $sketchElemType = ($isLang ? 'language' : 'block');

    if ($codeLetter) {
        printInVerts("</$sketchElemType>\n", $outs);
        endVertLatvian($status, $outs) if (mustIncludeLanguage($codeLetter));
    }
    else {
        endVertLatvian($status, $outs);
    }
}
sub startVertLatvian
{
    my $status = shift @_;
    my $outs = shift @_;
    printInVerts("<language langName=\"Latvian\">\n", $outs);
    $status->{'Latvian'} = 1;
}

sub endVertLatvian
{
    my $status = shift @_;
    my $outs = shift @_;
    printInVerts("</language>\n", $outs);
    $status->{'Latvian'} = 0;
}

sub printVertToken
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
    printInVerts("<g/>\n", $outs) unless ($token =~ /^\s+(.*)$/ or $status->{'first word'});
    $token =~ s/^\p{Z}*(.*)$/$1/;

    my $tokenAddress = "${addressStub}_${\$counters->{'word'}}"; #Everita pašlaik negrib vārda numuru, bet nav loģiski to ignorēt, ja adreses liek arī citur
    my ($splitTok, $splitCorr) = @{splitCorrection($token, $tokenAddress)};
    printInVerts("$splitTok\t$splitCorr", $outs);
    printInVerts("\t$translitToken", $outs) if ($doTranslit);
    printInVerts("\t$tokenAddress\n", $outs);
    $status->{'first word'} = 0;
}

sub printInVerts
{
    my $text = shift @_;
    my $outs = shift @_;
    return if (not $DO_VERT);
    printInAllStreams($text, $outs->{'vert'}, $outs->{'total vert'});
}

1;