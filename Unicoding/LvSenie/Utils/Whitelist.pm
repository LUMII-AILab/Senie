package LvSenie::Utils::Whitelist;
use strict;
use utf8;
use warnings;

use parent qw(Exporter);
our @EXPORT_OK = qw(loadWhitelist isWhitelisted);

sub loadWhitelist
{
    my $path = shift @_;
    return unless $path;
    my $whitelist = {};
    my $in = IO::File->new($path, "< :encoding(UTF-8)")
        or die "Could not open file $path: $!";
    while (my $line = <$in>)
    {
        if ($line =~ /^\s*(\S.*?)(\t.+)?\s*$/)
        {
            $whitelist->{$1} = 1;
        }
    }
    return $whitelist;
}

sub isWhitelisted
{
    my $whitelist = shift @_;
    return unless $whitelist;
    my $result = 1;
    for my $item (@_)
    {
        $result = 0 unless $whitelist->{$item};
    }
    return $result;
}

1;