package LvSenie::Translit::NoreplaceCoding;
use strict;
use utf8;
use warnings;

#use LvSenie::Translit::SimpleTranslitTables qw(TABLES);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(encodeString decodeString $firstSymb $lastSymb);

# First project specification required to ensure that strings already replaced
# would never be considered for replacment agan, so the derived tables were used
# Where each character in resulting string is surrounded by \N{U+E001} (SPECIAL1)
# and \N{U+E002} (SPECIAL2) to ensure that it is never replaced again.
# Currently tables are depricated, however foreign language inserts are still
# denoted this way.

our $firstSymb = "\N{U+E001}";
our $lastSymb = "\N{U+E002}";

sub encodeString
{
	my $string = shift @_;
	$string =~ s/(.)/$firstSymb$1$lastSymb/g;
	return $string;
}

sub decodeString
{
	my $string = shift @_;
	$string =~ s/($firstSymb|$lastSymb)//g;
	return $string;
}

1;