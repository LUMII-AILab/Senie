package LvSenie::Publishing::SqlLineTools;
use strict;
use utf8;
use warnings;

use LvSenie::Publishing::MetadataSql qw($AUTHOR_TABLE $BOOKS2AUTHORS_TABLE);
use LvSenie::Publishing::Utils qw(printInAllStreams);

use Exporter();
use parent qw(Exporter);
our @EXPORT_OK = qw($DO_SQL submitForPrintInSql emptySqlPrintingBuffer printPageInSql);

our $DO_SQL= 0;
our $CONTEXT_TABLE = 'content_lines';
our $PAGE_TABLE = 'pages';
my @insertBuffer = ();

sub submitForPrintInSql
{
    my $full_source = shift @_;
    my $address = shift @_;
    my $page = shift @_;
    my $pageSortOrder = shift @_;
    my $lineSortOrder = shift @_;
    my $dataHtml = shift @_;
    my $dataPlain = shift @_;
    my $outs = shift @_;
    my $addAuthor = shift @_;
    return unless ($DO_SQL);

    my $author = 0;
    $author = $1 if ($dataPlain =~ /^\s*\@a\{(.*?)\}\s*$/);
    my $sqlFullSource = &_transformToSqlString($full_source);
    my $sqlAddress = &_transformToSqlString($address);
    my $sqlPage = &_transformToSqlString($page, 0, 1);
    my $sqlHtml = &_transformToSqlString($dataHtml, 1);
    my $sqlPlain = &_transformToSqlString($dataPlain, 1);
    my $newStatement = "$sqlAddress, $lineSortOrder, $sqlHtml, $sqlPlain";
    $newStatement = "$newStatement, (SELECT id FROM $PAGE_TABLE WHERE $PAGE_TABLE.name <=> $sqlPage AND $PAGE_TABLE.sort_order = $pageSortOrder AND $PAGE_TABLE.source = $sqlFullSource)";
    $newStatement = "($newStatement)";
    push (@insertBuffer, $newStatement);
    
    if ($author and $addAuthor)
    {
        emptySqlPrintingBuffer($outs);
        my $sqlAuthor = $author;
        $sqlAuthor =~ s/\\/\\\\/g;
        $sqlAuthor =~ s/'/\\'/g;
        my $insertSecAuthor = "INSERT IGNORE INTO $AUTHOR_TABLE (name) VALUES ('$sqlAuthor');\n";
        $insertSecAuthor = "${insertSecAuthor}INSERT INTO $BOOKS2AUTHORS_TABLE (source, author_id, is_fragment_author)\n";
        $insertSecAuthor = "${insertSecAuthor}  VALUES ( $sqlFullSource, (SELECT id FROM $AUTHOR_TABLE WHERE $AUTHOR_TABLE.name = '$sqlAuthor'), TRUE)\n";
        $insertSecAuthor = "${insertSecAuthor}  ON DUPLICATE KEY UPDATE is_cover_author = (is_cover_author OR FALSE), is_fragment_author = TRUE;\n";
        printInAllStreams($insertSecAuthor, $outs->{'sql'}, $outs->{'total sql'});
    }
}

sub printPageInSql
{
    my $full_source = shift @_;
    my $page = shift @_;
    my $pageSortOrder = shift @_;
    my $outs = shift @_;
    return unless ($DO_SQL);

    my $sqlFullSource = &_transformToSqlString($full_source);
    my $sqlPage = &_transformToSqlString($page, 0, 1);
    &emptySqlPrintingBuffer($outs);

    my $insertPage = "INSERT INTO $PAGE_TABLE (source, name, sort_order)";
    $insertPage = "$insertPage VALUES ($sqlFullSource, $sqlPage, $pageSortOrder);\n";
    printInAllStreams($insertPage, $outs->{'sql'}, $outs->{'total sql'});

}

sub emptySqlPrintingBuffer
{
    my $outs = shift @_;
    return unless @insertBuffer;
    my $joinedValues = join (",\n", (map { "    $_" } @insertBuffer));
    my $insertContext = "INSERT INTO $CONTEXT_TABLE (address, line_sort_order, data_html, data_plain, page_id)\n";
    $insertContext = "$insertContext  VALUES\n$joinedValues;\n";
    # ('$full_source', $sqlAddress, $sqlPage, $pageSortOrder, $lineSortOrder, $sqlHtml, $sqlPlain);\n";
    printInAllStreams($insertContext, $outs->{'sql'}, $outs->{'total sql'});
    @insertBuffer = ();
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