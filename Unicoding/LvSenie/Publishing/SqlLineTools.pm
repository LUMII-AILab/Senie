package LvSenie::Publishing::SqlLineTools;
use strict;
use utf8;
use warnings;

use LvSenie::Publishing::MetadataSql qw($AUTHOR_TABLE $BOOKS2AUTHORS_TABLE);
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
    my $addAuthor = shift @_;
    return unless ($DO_SQL);

    my $author = 0;
    $author = $1 if ($dataPlain =~ /^\s*\@a\{(.*?)\}\s*$/);
    my $sqlAddress = &_transformToSqlString($address);
    #my $sqlPage = &_transformToSqlString($page, 0, 1);
    my $sqlPage = &_transformToSqlString($page);
    my $sqlHtml = &_transformToSqlString($dataHtml, 1);
    my $sqlPlain = &_transformToSqlString($dataPlain, 1);
    my $insertContext = "INSERT INTO $SQL_CONTEXT_TABLE (source, adress, page, html_line_order, data_html, data_plain)\n";
    $insertContext = "$insertContext  VALUES ('$full_source', $sqlAddress, $sqlPage, $overallLine, $sqlHtml, $sqlPlain);\n";
    printInAllStreams($insertContext, $outs->{'sql'}, $outs->{'total sql'});
    if ($author and $addAuthor)
    {
        my $sqlAuthor = $author;
        $sqlAuthor =~ s/\\/\\\\/g;
        $sqlAuthor =~ s/'/\\'/g;
        my $insertSecAuthor = "INSERT IGNORE INTO $AUTHOR_TABLE (name) VALUES ('$sqlAuthor');\n";
        $insertSecAuthor = "${insertSecAuthor}INSERT IGNORE INTO $BOOKS2AUTHORS_TABLE (source, author_id, top_author)\n";
        $insertSecAuthor = "${insertSecAuthor}  VALUES ( '$full_source', (SELECT id FROM $AUTHOR_TABLE WHERE $AUTHOR_TABLE.name = '$sqlAuthor'), FALSE);\n";
        printInAllStreams($insertSecAuthor, $outs->{'sql'}, $outs->{'total sql'});
    }
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