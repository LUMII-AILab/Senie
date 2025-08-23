package LvSenie::Publishing::SqlLineTools;
use strict;
use utf8;
use warnings;

use LvSenie::Publishing::Utils qw(printInAllStreams);

use Exporter();
use parent qw(Exporter);
our @EXPORT_OK = qw($DO_SQL printInSql);

our $DO_SQL= 0;
our $SQL_CONTEXT_TABLE = 'contexts_new';

sub printInSql
{
    my $full_source = shift @_;
    my $address = shift @_;
    my $page = shift @_;
    my $overallLine = shift @_;
    my $dataHtml = shift @_;
    my $dataPlain = shift @_;
    my $outs = shift @_;
    return unless ($DO_SQL);

    my $sqlAddress = &_transformToSqlString($address);
    #my $sqlPage = &_transformToSqlString($page, 0, 1);
    my $sqlPage = &_transformToSqlString($page);
    my $sqlHtml = &_transformToSqlString($dataHtml, 1);
    my $sqlPlain = &_transformToSqlString($dataPlain, 1);
    my $result = "INSERT INTO $SQL_CONTEXT_TABLE (source, adress, page, html_line_order, data_html, data_plain)\n";
    $result = "$result  VALUES ('$full_source', $sqlAddress, $sqlPage, $overallLine, $sqlHtml, $sqlPlain);\n";
    printInAllStreams($result, $outs->{'sql'}, $outs->{'total sql'});
}

sub _transformToSqlString
{
    my $text = shift @_;
    my $disallowNull = shift @_;
    my $allowZeroes = shift @_;

    my $sqlified_text = 'NULL';
    $sqlified_text = "''" if $disallowNull;
    if ($allowZeroes and defined $text and $text ne '' or $text)
    {
        $sqlified_text = $text;
        $sqlified_text =~ s/^\s*(.*?)\s*$/$1/;
        $sqlified_text =~ s/\\/\\\\/g;
        $sqlified_text =~ s/'/\\'/g;
        $sqlified_text = "'$sqlified_text'";
    }
    return $sqlified_text;
}

1;