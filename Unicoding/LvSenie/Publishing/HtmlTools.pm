package LvSenie::Publishing::HtmlTools;
use strict;
use utf8;
use warnings;

use LvSenie::Publishing::Utils qw(printInAllStreams);
use LvSenie::Utils::CodeCatalog qw(decode);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw($DO_HTML printInHtml formLineForHtml printHtmlDocHead printHtmlDocTail);

our $DO_HTML = 0;

sub printHtmlDocHead
{
    my $fullSourceStub = shift @_;
    my $internalProperties = shift @_;
    my $outs = shift @_;
    &printInHtml("<html>\n\t<head>\n\t\t<meta charset=\"UTF-8\"/>\n", $outs);
    my $cssPath = $internalProperties->{'full ID'} eq $internalProperties->{'short ID'} ? '..' : '../..';
    &printInHtml("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"$cssPath/../css/source.css\">\n", $outs);
    &printInHtml("\t\t<title>$fullSourceStub</title>\n", $outs);
    &printInHtml("\t</head>\n", $outs);
    &printInHtml("\t<body>\n", $outs);
    &printInHtml("\t\t<table>\n", $outs);
}

sub printHtmlDocTail
{
    my $outs = shift @_;
    &printInHtml("\t\t<\/table>\t</body>\n</html>", $outs);
}

sub formLineForHtml
{
    my $address = shift @_;
    my $line = shift @_;

    return "<tr><td class=\"source-address\">&nbsp;</td><td class=\"source-line\">&nbsp;</td></tr>\n"
        if (not $line or $line =~ /^\s*$/);
    $address = '&nbsp;' unless ($address);
    $line = _htmlify_line_contents($line);
    return "<tr><td class=\"source-address\">$address</td><td class=\"source-line\">$line</td></tr>\n";
}

sub _htmlify_line_contents
{
    my $line = shift @_;
    return $line unless $line;
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
    return $line;
}

sub printInHtml
{
    my $text = shift @_;
    my $outs = shift @_;
    return if (not $DO_HTML);
    printInAllStreams($text, $outs->{'html'})
}

1;