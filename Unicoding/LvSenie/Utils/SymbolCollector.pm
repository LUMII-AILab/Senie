package LvSenie::Utils::SymbolCollector;
use strict;
use utf8;
use warnings;

use feature qw(say);
use IO::Dir;
use IO::File;
#use Data::Dumper;
use HTML::Entities qw(encode_entities);
use Unicode::Semantics qw(up us);
use LvSenie::Utils::SourceProperties qw(getSourceProperties);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(countInFile countInDirs);

###############################################################################
# Mostly meant for Unicode files, but should work for old corpus files as well.
###############################################################################

our $symbolCounter = {};

sub countInFile
{
    autoflush STDOUT 1;
    if (not @_ or @_ < 3 or @_ > 3)
    {
        print <<END;
Script for collecting simbols from unicode SENIE file (will expect \@z tag).

Params:
   data directory
   source filename, e.g. Baum1699_LVV_Unicode.txt
   encoding, expected cp1257 or UTF-8 [optional, UTF-8 default]

AILab, LUMII, 2022, provided under GPL
END
        exit 1;
    }

    my $dirName = shift @_;
    my $fileName = shift @_;
    my $encoding = (shift @_ or 'UTF-8');
    $fileName =~ /^(.*?)\.txt$/;
    my $fileNameStub = $1;

    say "Processing $fileNameStub.";
    # Get general file info
    my $properties = getSourceProperties("$dirName/$fileName", $encoding);
    readFileNotSmart("$dirName/$fileName", $properties->{'full ID'}, $encoding);
    printResult($properties->{'short ID'}."_symbols.txt", 0, $properties->{'short ID'}."_symbols.htm");
    say "Done!";
}

sub countInDirs
{
    autoflush STDOUT 1;
    if (not @_ or @_ < 3)
    {
        print <<END;
Script for collecting simbols from unicode SENIE files (will expect \@z tag).

Params:
   place for summarized result files
   encoding, expected cp1257 or UTF-8
   data directories

AILab, LUMII, 2022, provided under GPL
END
        exit 1;
    }

    my $totalResultDirName = shift @_;
    my $encoding = shift @_;
    my @dirNames = @_;
    my $all = 0;
    my $baddies = 0;

    for my $dirName (@dirNames)
    {
        my $dir = IO::Dir->new($dirName) or die "Folder $dirName is not available: $!";
        while (defined(my $fileName = $dir->read))
        {
            if ((-f "$dirName/$fileName") and $fileName =~ /^(.*?)\.txt$/)
            {
                my $isBad = 0;
                eval
                {
                    local $SIG{__WARN__} = sub {
                        $isBad = 1;
                        warn $_[0]
                    }; # This magic makes eval count warnings.
                    local $SIG{__DIE__} = sub {
                        $isBad = 1;
                        warn $_[0]
                    }; # This magic makes eval warn on die and count it as problem.
                    say "Processing $fileName.";
                    # Get general file info
                    my $properties = getSourceProperties("$dirName/$fileName", $encoding);
                    readFileNotSmart("$dirName/$fileName", $properties->{'full ID'}, $encoding);
                };
                $baddies = $baddies + $isBad;
                $all++;
            }
        }
        #$outForDir->close();
    }
    printResult("$totalResultDirName/unicode_symbols.txt", "$totalResultDirName/unicode_full.htm", "$totalResultDirName/unicode.htm");
    if ($baddies) {
        say "Processing finished, $baddies of $all files failed!";
    }
    else {
        say "Processing $all files finished successfully!";
    }
    return $baddies;
}


sub readFileNotSmart
{
    my $fileName = shift @_;
    my $fileId = shift @_;
    my $encoding = shift @_;
    my $in = IO::File->new("$fileName", "< :encoding($encoding)")
        or die "Could not open file $fileName: $!";
    while (my $line = <$in>)
    {
        up($line);
        #my @chars = split /(?=\p{L}\p{M}*|[^\p{L}])/, $line;
        my @chars = split //, $line;
        my @unitedChars = ();
        push(@unitedChars, shift(@chars));
        for my $char (@chars)
        {
            my $prevChar = pop @unitedChars;
            if ($char =~ /^\p{M}+$/ and $prevChar =~ /^\p{L}\p{M}*$/) {
                push @unitedChars, "$prevChar$char";
            }
            else {
                push @unitedChars, $prevChar, $char;
            }
        }
        for my $char (@unitedChars)
        {
            if (exists $symbolCounter->{$char})
            {
                $symbolCounter->{$char}->[0]++;
                $symbolCounter->{$char}->[1] = {%{$symbolCounter->{$char}->[1]}, $fileId => 1};
            }
            else
            {
                $symbolCounter->{$char} = [1, {$fileId => 1}];
            }
        }
    }

    $in->close;
}


sub printResult
{
    my $fileNameTxt = shift @_;
    my $fileNameBigHtml = shift @_;
    my $fileNameSmallHtml = shift @_;
    my $outTxt = IO::File->new("$fileNameTxt", "> :encoding(UTF-8)")
        or die "Could not open file $fileNameTxt: $!";
    my $outBigHtml = 0;
    if ($fileNameBigHtml)
    {
        $outBigHtml = IO::File->new("$fileNameBigHtml", "> :encoding(UTF-8)")
            or die "Could not open file $fileNameBigHtml: $!";
    }
    my $outSmallHtml = 0;
    if ($fileNameSmallHtml)
    {
        $outSmallHtml = IO::File->new("$fileNameSmallHtml", "> :encoding(UTF-8)")
            or die "Could not open file $fileNameSmallHtml: $!";
    }

    &_sayBigAndSmall($outBigHtml, $outSmallHtml, '<!doctype html>');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, '<html>');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, ' <head>');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, '  <meta http-equiv="content-type" content="text/html; charset=UTF-8">');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, '  <link rel="stylesheet" type="text/css" href="../css/senie.css">');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, '  <title>Senie</title>');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, ' </head>');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, ' <body style="font-family:Linux Libertine, DejaVu Sans, Arial Unicode MS, GNU Unifont;">');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, '  <table class="symbol-table">');
    say $outBigHtml "   <tr><th>Simboli<br/>(kombinēti)</th><th>Skaits</th><th>Unikodi</th><th>Avoti</th></tr>" if $outSmallHtml;
    say $outSmallHtml "   <tr><th>Simboli<br/>(kombinēti)</th><th>Skaits</th><th>Unikodi</th></tr>" if $outSmallHtml;


    # In the "big" HTML file and in the TXT we order symbols by their count
    for my $key (sort {$symbolCounter->{$b}->[0] <=> $symbolCounter->{$a}->[0]} (keys %$symbolCounter))
    {
        up($key);
        next if ($key =~/^[\r\n\t ]+$/);
        my $sources = join(', ', sort keys(%{$symbolCounter->{$key}->[1]}));
        my $count = $symbolCounter->{$key}->[0];
        my $endoded_symbols = encode_entities($key, '<>&"');
        #my $codePoints = unpack('H*', $key);
        #my $codePoints = join('; ', map {unpack('H*', $_)} split(//, $key));
        #my $codePoints = Unicode::Escape::escape($key);
        my $codePoints = sprintf("%vX", $key);
        say $outTxt "$key\t$count\t$codePoints\t$sources";
        say $outBigHtml "   <tr><td style=\"font-size:larger\">$endoded_symbols</td><td style=\"text-align:center\">$count</td><td style=\"text-align:center\">$codePoints</td><td style=\"font-size:smaller\">$sources</td></tr>";
    }

    # In the "small" file a fixed symbol ordering is needed
    for my $key (sort (keys %$symbolCounter))
    {
        up($key);
        next if ($key =~/^[\r\n\t ]+$/);
        my $sources = join(', ', sort keys(%{$symbolCounter->{$key}->[1]}));
        my $count = $symbolCounter->{$key}->[0];
        my $endoded_symbols = encode_entities($key, '<>&"');
        #my $codePoints = unpack('H*', $key);
        #my $codePoints = join('; ', map {unpack('H*', $_)} split(//, $key));
        #my $codePoints = Unicode::Escape::escape($key);
        my $codePoints = sprintf("%vX", $key);
        say $outSmallHtml "   <tr><td style=\"font-size:larger\">$endoded_symbols</td><td style=\"text-align:center\">$count</td><td style=\"text-align:center\">$codePoints</td></tr>";
    }

    &_sayBigAndSmall($outBigHtml, $outSmallHtml, '  </table>');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, ' </body>');
    &_sayBigAndSmall($outBigHtml, $outSmallHtml, '</html>');
    $outBigHtml->close if $outBigHtml;
    $outSmallHtml->close if $outSmallHtml;
    $outTxt->close;
}

sub _sayBigAndSmall
{
    my $outBigHtml = shift @_;
    my $outSmallHtml = shift @_;
    say $outBigHtml @_ if $outBigHtml;
    say $outSmallHtml @_ if $outSmallHtml;
}

1;