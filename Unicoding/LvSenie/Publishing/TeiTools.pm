package LvSenie::Publishing::TeiTools;
use strict;
use utf8;
use warnings;

use LvSenie::Publishing::Utils qw(printInAllStreams);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw($DO_TEI printTeiCorpusHead printTeiCorpusTail printTeiCollectionHead printTeiCollectionTail
    printTeiDocHead printTeiDocTail startTeiBibleChapter endTeiBibleChapter startTeiParagraph startTeiVerse
    endTeiParagraphVerse changeTeiPage changeTeiLine startTeiSubBlock endTeiSubBlock startTeiLatvian endTeiLatvian
    printTeiSubBlockContents);

our $DO_TEI = 0;

sub printTeiCorpusHead
{
    my $outTotal = shift @_;
    return unless $DO_TEI;
    print $outTotal "<teiCorpus xmlns=\"http://www.tei-c.org/ns/1.0\">\n";
    print $outTotal " <teiHeader>\n";
    print $outTotal "  <titleStmt><title>Senie: latviešu valodas seno tekstu korpuss</title></titleStmt>\n";
    print $outTotal "  <publicationStmt><p>Distributed by UL IMCS AILab</p></publicationStmt>\n";
    print $outTotal "  <sourceDesc><p>Original digital compilation</p></sourceDesc>\n";
    print $outTotal " </teiHeader>\n";
}

sub printTeiCorpusTail
{
    my $outTotal = shift @_;
    return unless $DO_TEI;
    print $outTotal "</teiCorpus>\n";
}

sub printTeiCollectionHead
{
    my $fullID = shift @_;
    my $externalProperties = shift @_;
    my $outTotal = shift @_;
    return unless $DO_TEI;
    print $outTotal " <TEI>\n";
    print $outTotal &_make_header_string($fullID, $externalProperties);
}

sub printTeiCollectionTail
{
    my $outTotal = shift @_;
    return unless $DO_TEI;
    print $outTotal " </TEI>\n";
}

sub printTeiDocHead
{
    my $internalProperties = shift @_;
    my $externalProperties = shift @_;
    my $outs = shift @_;

    print {$outs->{'tei'}} "<TEI xmlns=\"http://www.tei-c.org/ns/1.0\">\n" if ($outs->{'tei'});
    print {$outs->{'total tei'}} "  <TEI>\n" if ($outs->{'total tei'});
    my $header = &_make_header_string($internalProperties->{'full ID'}, $externalProperties);
    printInTei($header, $outs);
    printInTei("   <text>\n", $outs);
    printInTei("    <body>", $outs);
}

sub _make_header_string
{
    my $fullID = shift @_;
    my $externalProperties = shift @_;
    my $domainType = 0;
    if ($externalProperties->{'genre'} eq 'Garīgie teksti') {$domainType = 'religious';}
    elsif ($externalProperties->{'genre'} eq 'Vārdnīcas') {$domainType = 'education';}
    elsif ($externalProperties->{'genre'} eq 'Laicīgie teksti') {$domainType = 'public';}
    else {warn "Unrecognised genree \"${\$externalProperties->{'author'}}\" for $fullID"};
    my $subDomain = 0;
    $subDomain = join (', ', @{$externalProperties->{'subgenre'}})
        if ($externalProperties->{'subgenre'});

    my $result =
        "   <teiHeader>\n" .
        "    <fileDesc id=\"$fullID\">\n" .
        "     <sourceDesc>\n" .
        "      <author>${\$externalProperties->{'author'}}</author>\n" .
        "      <title>${\$externalProperties->{'short name'}}</title>\n" .
        "      <date>${\$externalProperties->{'year'}}</date>\n" .
        "     </sourceDesc>\n" .
        "    </fileDesc>\n" .
        "    <profileDesc>\n".
        ($externalProperties->{'manuscript'} ? "     <chanel>manuscript</chanel>\n" : "") .
        "     <domain" . ($domainType ? " type=\"$domainType\"" : "") .
        ">${\$externalProperties->{'genre'}}" . ($subDomain ? "; $subDomain" : "") .
        "</domain>\n" .
        "    </profileDesc>\n" .
        "   </teiHeader>\n";
    return $result;
}

sub printTeiDocTail
{
    my $outs = shift @_;
    printInTei("\n    </body>\n", $outs);
    printInTei("   </text>\n", $outs);
    printInTei("  </TEI>\n", $outs);
}

sub startTeiBibleChapter
{
    my $outs = shift @_;
    my $chapterNo = shift @_;
    printInTei("\n     <div n=\"$chapterNo\">", $outs);
}

sub endTeiBibleChapter
{
    my $outs = shift @_;
    printInTei("\n     </div>", $outs);
}

sub changeTeiPage
{
    my ($outs, $corrPageNo, $origPageNo) = @_;
    printInTei("\n      <pb n=\"$corrPageNo\"/>", $outs);
    printInTei("<sic>$origPageNo</sic>", $outs) if ($origPageNo and $origPageNo ne $corrPageNo);
}

sub startTeiParagraph
{
    my $outs = shift @_;
    printInTei("\n      <div type=\"Paragraph\">", $outs);
}

sub startTeiVerse
{
    my $outs = shift @_;
    my $address = shift @_;
    my $verseNo = shift @_;
    my $indexType = shift @_;

    my $paraType = "Section";
    $paraType = "Verse" if ($indexType eq 'GNP');
    printInTei("\n      <div n=\"$verseNo\" type=\"$paraType\" id=\"${address}\">", $outs);
}

sub endTeiParagraphVerse
{
    my $outs = shift @_;
    printInTei("\n      </div>", $outs);
}

sub changeTeiLine
{
    my ($outs, $adress) = @_;
    printInTei("\n       <lb id=\"$adress\"/>", $outs);
}

sub startTeiSubBlock
{
    my $outs = shift @_;
    my $elementType = shift @_;
    my $languageName = shift @_;
    printInTei("\n       <div type=\"$elementType\"", $outs);
    printInTei(" lang=\"$languageName\"", $outs) if $languageName;
    printInTei(">", $outs);
}

sub endTeiSubBlock
{
    my $outs = shift @_;
    printInTei("</div>", $outs);
}

sub startTeiLatvian
{
    my $outs = shift @_;
    printInTei("\n        <div type=\"Language\" lang=\"Latvian\">", $outs);
}

sub endTeiLatvian
{
    my $outs = shift @_;
    printInTei("</div>", $outs);
}

sub printTeiSubBlockContents
{
    my ($outs, $contents) = @_;
    $contents =~ /^\s*(.*?)\s*$/;
    $contents = $1;
    # Mandatory escapes
    $contents =~ s/\&/&amp;/g;
    $contents =~ s/</&lt;/g;
    # Corrections
    $contents =~ s/\b{wb}(([^{}]((?!\b{wb})|(?==))|=)*.)(?={)/<corr>$1<\/corr>/g;
    $contents =~ s/(?<!\@.)({([^}]*)})/<sic>$2<\/sic>/g;
    printInTei($contents, $outs);
}

sub printInTei
{
    my $text = shift @_;
    my $outs = shift @_;
    return if (not $DO_TEI);
    printInAllStreams($text, $outs->{'tei'}, $outs->{'total tei'})
}

1;