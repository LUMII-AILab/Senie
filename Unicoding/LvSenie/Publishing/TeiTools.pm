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
    my $outs = shift();
    return unless $DO_TEI;
    print {$outs->{'tei'}} " <TEI xmlns=\"http://www.tei-c.org/ns/1.0\">";
    print {$outs->{'total tei'}} " <TEI>";
    printInTei("<teiCorpus xmlns=\"http://www.tei-c.org/ns/1.0\">\n", $outs);
    printInTei(" <teiHeader>\n", $outs);
    printInTei("  <titleStmt><title>Senie: latviešu valodas seno tekstu korpuss</title>\n", $outs);
    printInTei("  <publicationStmt><p>Distributed by UL IMCS AILab</p></publicationStmt>\n", $outs);
    printInTei("  <sourceDesc><p>Original digital compilation</p></sourceDesc>\n", $outs);
    printInTei(" </teiHeader>\n", $outs);
}

sub printTeiCorpusTail
{
    my $output = shift();
    return unless $DO_TEI;
    print $output "</teiCorpus>\n";
}

sub printTeiDocHead
{
    my $fullSourceStub = shift @_;
    my $internalProperties = shift @_;
    my $externalProperties = shift @_;
    my $outs = shift @_;
}

sub printTeiDocTail
{
    my $outs = shift @_;
}

sub printInTei
{
    my $text = shift @_;
    my $outs = shift @_;
    return if (not $DO_TEI);
    printInAllStreams($text, $outs->{'tei'}, $outs->{'total tei'})
}

1;