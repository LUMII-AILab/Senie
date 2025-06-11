package LvSenie::Publishing::Utils;
use strict;
use utf8;
use warnings;

use LvSenie::Utils::ExternalPropertyCatalog qw(getIndexType);

use Exporter();
use parent qw(Exporter);
our @EXPORT_OK = qw(splitByLang tokenize splitCorrection printInAllStreams calculateAddressStub);

our $DO_WARN_ATS = 1;
our $DO_WARN_EMPTY_BRACES = 0;
our $DO_WARN_OTHER_BRACES = 1;

# Split line so that each fragment in different language becomes a new segment.
sub splitByLang
{
    my $line = shift @_;
    $line =~ s/([ \t]+)(\@[\w\d]+{)/$2$1/g; #This is to preserve information about whitespaces on the language borders
    my @result = split /(?=\@[\w\d]+{)/, $line;
    @result = map {/^(\@[\w\d]+\{(?:[^\{\}]*\{[^{}]*\})*[^\{\}]*\})?(.*?)$/; ($1, $2)} @result;
    @result = grep {$_ and $_ =~ /[^\s]/} @result; #Filter out empty ones
    return \@result;
}

# Split a line in tokens, taking into account specifics like "=" usage.
sub tokenize
{
    my $line = shift @_;
    $line =~ s/^(.*?)\s*$/$1/;	# Remove trailing whitespaces
    $line =~ tr/\t/ /;	# Remove tabs
    $line =~ s/(\p{Z})\p{Z}+(?!\p{Z})/$1/g;	# Remove double whitespaces
    my @tooMuchTokens = split /(?=\p{Z})|(?=\{\})|(?=[\\\/](\p{Z}|$))|(?=[^=\{\}\[\]\p{L}\p{M}\p{N}^~`'´\\\/ß§\$#"])|(?<=[,.?!\(])(?=[\p{L}\p{N}])/, $line;
    @tooMuchTokens = grep {$_} @tooMuchTokens; #Filter out empty ones
    my @result = ();
    while (@tooMuchTokens)
    {
        my $token = shift @tooMuchTokens;
        $token = $token . shift(@tooMuchTokens) while ($token =~ /^\p{Z}*$/ or ($token =~ /\{[^}]*$/ and @tooMuchTokens));
        push @result, $token;
    }
    return \@result;
}

# Split token{correction} into two strings and remove {}.
sub splitCorrection
{
    my $token = shift @_;
    my $address = shift @_;
    my ($orig, $corr) = ($token, $token);
    # Corrections: in figure brackets - sic, outside brackets - the corrected number
    ($corr, $orig) = ($1, $2) if ($token =~ /^([^{]+){([^}]+)}$/ );
    warn "Suspicious token $orig at $address\n" if ($orig =~/[@]/ and $DO_WARN_ATS);
    warn "Suspicious token $orig at $address\n" if ($orig =~/\{\}/ and $DO_WARN_EMPTY_BRACES);
    warn "Suspicious token $orig at $address\n" if ($orig =~/[\{\}]/ and $orig !~ /\{\}/ and $DO_WARN_OTHER_BRACES);
    warn "Suspicious correction $corr at $address\n" if ($corr =~/[@]/ and $DO_WARN_ATS);
    warn "Suspicious correction $corr at $address\n" if ($corr =~/\{\}/ and $DO_WARN_EMPTY_BRACES);
    warn "Suspicious correction $corr at $address\n" if ($corr =~/[\{\}]/ and $corr !~ /\{\}/ and $DO_WARN_OTHER_BRACES);

    #TODO kā pareizi apstrādāt tos tukšos? Jo tas nenozīmē, ka iepriekšējo vārdu nevajag.
    #$corr = '_' unless $corr;
    return [$corr, $orig];
}

sub printInAllStreams
{
    my $text = shift @_;
    my @outs = @_;
    for my $out (@outs)
    {
        print $out $text if ($out);
    }
}

sub calculateAddressStub
{
    my $internalProperties = shift @_;
    my $counters = shift @_;
    my $addPage = shift @_;
    my $fullSourceStub = $internalProperties->{'full ID'};
    my $indexType = getIndexType($internalProperties->{'full ID'});

    my $addressStub = "${fullSourceStub}_";
    $addressStub = "$addressStub${\$counters->{'chapter'}}:"
        if($indexType eq 'GNP');
    $addressStub = "$addressStub${\$counters->{'verse'}}"
        if($indexType eq 'GNP' or $indexType eq 'P');
    if ($addPage and ($indexType eq 'LR' or $indexType eq 'GLR'))
    {
        $addressStub = "$addressStub${\$counters->{'corrPage'}}";
        $addressStub = "$addressStub\{${\$counters->{'origPage'}}\}"
            if ($counters->{'origPage'} and ($counters->{'origPage'} ne $counters->{'corrPage'}));
        $addressStub = "${addressStub}_${\$counters->{'line'}}";
    }

    return $addressStub;
}

1;