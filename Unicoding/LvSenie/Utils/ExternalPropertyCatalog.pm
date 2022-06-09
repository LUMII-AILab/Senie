package LvSenie::Utils::ExternalPropertyCatalog;
use strict;
use utf8;
use warnings;

use IO::File;
#use Data::Dumper;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(getIndexType getExternalProperties getAnyProperty);

# Path to file where indexing type for each source is listed
our $SOURCE_PATH = '../Sources/indexing.txt';

# Key names
our ($INDEX_KEY, $SHORTNAME_KEY, $AUTHOR_KEY, $ORDERNO_KEY, $YEAR_KEY, $CENTURY_KEY, $GENRE_KEY, $SUBGENRES_KEY, $MANUSCRIPT_KEY) =
	('index', 'short name', 'author', 'order no', 'year', 'century', 'genre', 'subgenre', 'manuscript');

# Catalog mapping source code, e.g., Has1550_PN or JT1685/1J to indexing type
# GNP, GLR, LR, or P.
our $CATALOG = &loadCatalog();

# Load file where indexing type for each source is listed
sub loadCatalog
{
	my $in = IO::File->new($SOURCE_PATH, "< :encoding(UTF-8)")
		or die "Could not open file $SOURCE_PATH: $!";

	my $result = {};
	while (my $line = <$in>)
	{
		my @parts = map {/^\s*(.*?)\s*$/} (split("\t", $line));
		if (scalar(@parts) > 9)
		#if ($line =~ /^\s*([^\t]*?)\s*\t\s*([^\t]*?)\s*\t\s*([^\t]*?)\s*\t\s*.*?\s*$/)
		{
			#my $type = $1;
			my $source = $parts[1];
			#my $shortName = $3;
			$source =~ tr#\\#/#;
			$result->{$source} = {
				$INDEX_KEY     => $parts[0],
				$SHORTNAME_KEY => $parts[2],
				$AUTHOR_KEY    => $parts[3],
				$YEAR_KEY      => $parts[5],
				$CENTURY_KEY   => $parts[6],
				$GENRE_KEY     => $parts[7]
			};
			$result->{$source}->{$ORDERNO_KEY} = $parts[4] unless ($parts[4] =~ /^_$/);
			my @subgenres = split(/\s*;\s*/, $parts[8]);
			$result->{$source}->{$SUBGENRES_KEY} = \@subgenres unless ($parts[8] =~ /^_$/);
			$result->{$source}->{$MANUSCRIPT_KEY} = ($parts[9] =~ /^(true)$/i);

		}
	}
	$in->close;
	return $result;
}

sub getAnyProperty
{
	my $propertyKey = shift @_;
	my $source = join '/', (grep {defined} @_);
	$source =~ tr#\t\\#//#;
	$source =~ s/^\s*(.*?)\s*$/$1/;
	return $CATALOG->{$source}->{$propertyKey} if (exists $CATALOG->{$source});
	return undef;
}

sub getExternalProperties
{
	my $source = join '/', (grep {defined} @_);
	$source =~ tr#\t\\#//#;
	$source =~ s/^\s*(.*?)\s*$/$1/;
	return $CATALOG->{$source} if (exists $CATALOG->{$source});
	return undef;
}

# Get indexing code (currently GNP, GLR, LR, or P) from Senie source name.
# For bible books source name must contain collection code first, then tab or /,
# and then book code, e.g., JT1685/1J.
sub getIndexType
{
	return getAnyProperty($INDEX_KEY, @_);
}


1;