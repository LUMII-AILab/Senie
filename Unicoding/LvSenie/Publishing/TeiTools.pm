package LvSenie::Publishing::TeiTools;
use strict;
use utf8;
use warnings;

use LvSenie::Publishing::Utils qw(printInAllStreams);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw($DO_TEI printInTei printTeiDocHead printTeiDocTail printTeiCorpusHead printTeiCorpusTail);

our $DO_TEI = 0;

sub printTeiCorpusHead
{
    my $outTotal = shift @_;
    return unless $DO_TEI;
    print $outTotal "<teiCorpus xmlns=\"http://www.tei-c.org/ns/1.0\">\n";
    print $outTotal " <teiHeader>\n";
    print $outTotal "  <titleStmt><title>Senie: latviešu valodas seno tekstu korpuss</title>\n";
    print $outTotal "  <publicationStmt><p>Distributed by UL IMCS AILab</p></publicationStmt>\n";
    print $outTotal "  <sourceDesc><p>Original digital compilation</p></sourceDesc>\n";
    print $outTotal " </teiHeader>\n";
}

sub printTeiCorpusTail
{
    my $outTotal = shift@_;
    return unless $DO_TEI;
    print $outTotal "</teiCorpus>\n";
}

sub printTeiDocHead
{
    my $internalProperties = shift @_;
    my $externalProperties = shift @_;
    my $outs = shift @_;

    my $domainType = 0;
    if ($externalProperties->{'genre'} eq 'Garīgie teksti') {$domainType = 'religious';}
    elsif ($externalProperties->{'genre'} eq 'Vārdnīcas') {$domainType = 'education';}
    elsif ($externalProperties->{'genre'} eq 'Laicīgie teksti') {$domainType = 'public';}
    else {warn "Unrecognised genree \"${\$externalProperties->{'author'}}\" for ${\$internalProperties->{'full ID'}}"};

    print {$outs->{'tei'}} "<TEI xmlns=\"http://www.tei-c.org/ns/1.0\">\n" if ($outs->{'tei'});
    print {$outs->{'total tei'}} " <TEI>\n" if ($outs->{'total tei'});
    printInTei("  <teiHeader>\n", $outs);
    printInTei("   <fileDesc id=\"${\$internalProperties->{'full ID'}}\">\n", $outs);
    printInTei("    <sourceDesc>\n", $outs);
    printInTei("     <author>${\$externalProperties->{'author'}}</author>\n", $outs);
    printInTei("     <title>${\$externalProperties->{'short name'}}</title>\n", $outs);
    printInTei("     <date>${\$externalProperties->{'year'}}</date>\n", $outs);
    printInTei("    </sourceDesc>\n", $outs);
    printInTei("   </fileDesc>\n", $outs);
    printInTei("   <profileDesc>\n", $outs);
    printInTei("    <chanel>manuscript</chanel\n", $outs) if ($externalProperties->{'manuscript'});
    printInTei("    <domain", $outs);
    printInTei(" type=\"$domainType\"", $outs) if ($domainType);
    printInTei(">${\$externalProperties->{'genre'}}", $outs);
    printInTei("; ${\$externalProperties->{'subgenre'}}", $outs) if ($externalProperties->{'subgenre'});
    printInTei("</domain\n", $outs);
    printInTei("   </profileDesc>\n", $outs);
    printInTei("  </teiHeader>\n", $outs);
    printInTei("  <text>\n", $outs);
    printInTei("   <body>\n", $outs);
}

sub printTeiDocTail
{
    my $outs = shift @_;
    printInTei("  </body>\n", $outs);
    printInTei("  </text>\n", $outs);
    printInTei(" </TEI>\n", $outs);
}

sub printInTei
{
    my $text = shift @_;
    my $outs = shift @_;
    return if (not $DO_TEI);
    printInAllStreams($text, $outs->{'tei'}, $outs->{'total tei'})
}

1;