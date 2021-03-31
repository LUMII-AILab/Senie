package LvSenie::Vert::IndexTypeCatalog;
use strict;
use utf8;
use warnings;

use IO::File;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(getIndexType);

# Path to file where indexing type for each source is listed
our $sourcePath = '../Sources/indexing.txt';
# Catalog mapping source code, e.g., Has1550_PN or JT1685/1J to indexing type
# GNP, GLR, LR, or P.
our $indexSpec = loadCatalog;

# Load file where indexing type for each source is listed
sub loadCatalog
{
	my $in = IO::File->new($sourcePath, "< :encoding(UTF-8)")
		or die "Could not open file $sourcePath: $!";

	my $result = {};
	while (my $line = <$in>)
	{
		if ($line =~ /^\s*([^\t]*?)\s*\t\s*(.*?)\s*$/)
		{
			my $type = $1;
			my $source = $2;
			$source =~ tr#\t#/#;
			$result->{$source} = $type;
		}
	}
	return $result;
}

# Get indexing code (currently GNP, GLR, LR, or P) from Senie source name.
# For bible books source name must contain collection code first, then tab or /,
# and then book code, e.g., JT1685/1J.
sub getIndexType
{
	my $source = join '/', @_;
	$source =~ tr#\t#/#;
	$source =~ s/^\s*(.*?)\s*$/$1/;
	return $indexSpec->{$source} if (exists $indexSpec->{$source});
	return undef;
}

1;