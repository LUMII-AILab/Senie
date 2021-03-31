package SourceProperties;
use strict;
use utf8;
use warnings;

use IO::File;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw();

# Find the necassary properties for indexing in the given text file.
# Params:
#	path
#	indexing type (GNP, GLR, LR, P)
# Result: hash with keys a for author, z for source code and g for bible book.
sub getSourceProperties
{
	my $sourcePath = shift @_;
	my $indexType = shift @_;
	my $res = {};

	my $in = IO::File->new($sourcePath, "< :encoding(UTF-8)")
		or die "Could not open file $sourcePath: $!";
	my $isGNeeded = ($indexType =~ /^G/);

	while (my $line = <$in>)
	{
		$res->{'a'} = $1 if ($line =~ /\@a\{([^}]*)\}/); # a - autors
		$res->{'z'} = $1 if ($line =~ /\@z\{([^}]*)\}/); # g - bībeles grāmata priekš GLR un GNP
		$res->{'g'} = $1 if ($line =~ /\@g\{([^}]*)\}/); # z - avota saīsinājums - visiem
		last if (scalar keys %$res > 3 or not $isGNeeded and scalar keys %$res > 2);
	}

	$in->close;
	return $res;
}

1;