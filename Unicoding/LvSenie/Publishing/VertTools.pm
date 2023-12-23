package LvSenie::Publishing::VertTools;
use strict;
use utf8;
use warnings;

use LvSenie::Publishing::Utils qw(printInAllStreams splitCorrection calculateAddressStub);
use LvSenie::Utils::CodeCatalog qw(isLanguage canDecode decode mustIncludeLanguage);
use LvSenie::Utils::ExternalPropertyCatalog qw(getIndexType);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw($DO_VERT printInVerts printVertDocHead printVertDocTail startVertPage endVertPage
    startVertBibleChapter endVertBibleChapter startVertVerse startVertParagraph endVertParagraphVerse
    startVertLine endVertLine startVertSubBlock endVertSubBlock startVertLatvian endVertLatvian
    printVertToken printVertGlue);

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
    &printInVerts(" collection=\"${\$internalProperties->{'collection'}}\"", $outs) if ($internalProperties->{'collection'});
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
    #&printInVerts("</para>\n", $outs) if ($status->{'paragraph'} or $status->{'verse'});
    &printInVerts("</page>\n", $outs) if ($status->{'page'});
    &printInVerts("</doc>\n", $outs);
}

sub startVertPage
{
    my $outs = shift @_;
    my $corrPageNo = shift @_;
    my $origPageNo = shift @_;
    printInVerts("<page sourceNo=\"$origPageNo\" correctedNo=\"$corrPageNo\">\n", $outs);
}

sub endVertPage
{
    my $outs = shift @_;
    printInVerts("</page>\n", $outs);
}

sub startVertBibleChapter
{
    my $outs = shift @_;
    my $chapterNo = shift @_;
    printInVerts("<chapter no=\"$chapterNo\">\n", $outs);
}

sub endVertBibleChapter
{
    my $outs = shift @_;
    printInVerts("</chapter>\n", $outs);
}

sub startVertParagraph
{
    my $outs = shift @_;
    printInVerts("<para type=\"Paragraph\">\n", $outs);
}

sub startVertVerse
{
    my $outs = shift @_;
    my $address = shift @_;
    my $verseNo = shift @_;
    my $indexType = shift @_;

    my $paraType = "Section";
    $paraType = "Verse" if ($indexType eq 'GNP');
    printInVerts("<para no=\"$verseNo\" type=\"$paraType\" address=\"${address}\">\n", $outs);
}

sub endVertParagraphVerse
{
    my $outs = shift @_;
    printInVerts("</para>\n", $outs);
}

sub startVertLine
{
    my $outs = shift @_;
    my $address = shift @_;
    my $lineNo = shift @_;
    my $currentAuthor = shift @_;
    my $indexType = shift @_;

    printInVerts("<line author=\"$currentAuthor\"", $outs);
    printInVerts(" no=\"$lineNo\" address=\"$address\"", $outs)
        if ($indexType eq 'LR' or $indexType eq 'GLR');
    printInVerts(">\n", $outs);
}

sub endVertLine
{
    my $outs = shift @_;
    printInVerts("</line>\n", $outs);
}

sub startVertSubBlock
{
    my $outs = shift @_;
    my $element = shift @_;
    my $attribute = shift @_;
    my $attrValue = shift @_;
    printInVerts("<$element $attribute=\"$attrValue\">\n", $outs);
}

sub endVertSubBlock
{
    my $outs = shift @_;
    my $element = shift @_;
    printInVerts("</$element>\n", $outs);
}
sub startVertLatvian
{
    my $outs = shift @_;
    printInVerts("<language langName=\"Latvian\">\n", $outs);
}

sub endVertLatvian
{
    my $outs = shift @_;
    printInVerts("</language>\n", $outs);
}

sub printVertToken
{
    my $outs = shift @_;
    my $token = shift @_;
    my $translitToken = shift @_;
    my $doTranslit = shift @_;
    my $tokenAddress = shift @_;
    my ($splitCorr, $splitOrig) = @{splitCorrection($token, $tokenAddress)};
    printInVerts("$splitOrig\t$splitCorr", $outs);
    if ($doTranslit) {
        my ($splitTranslitCorr, ) = @{splitCorrection($translitToken, $tokenAddress)};
        printInVerts("\t$splitTranslitCorr", $outs);
    }
    printInVerts("\t$tokenAddress\n", $outs);
}

sub printVertGlue
{
    my $outs = shift @_;
    printInVerts("<g/>\n", $outs);
}

sub printInVerts
{
    my $text = shift @_;
    my $outs = shift @_;
    return if (not $DO_VERT);
    printInAllStreams($text, $outs->{'vert'}, $outs->{'total vert'});
}

1;