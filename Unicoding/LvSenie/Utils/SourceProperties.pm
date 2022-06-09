package LvSenie::Utils::SourceProperties;
use strict;
use utf8;
use warnings;

use IO::File;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(getSourceProperties);

# Find the necassary properties for indexing in the given text file.
# Params:
#	path
#   encoding [optional, UTF-8 by default]
#	indexing type (GNP, GLR, LR, P) [optional]
# Result: hash with keys a for author, z for source code and g for bible book.
sub getSourceProperties
{
	my $sourcePath = shift @_;
	my $encoding = (shift @_ or 'UTF-8');
	my $indexType = shift @_;
	my $res = {};

	my $in = IO::File->new($sourcePath, "< :encoding($encoding)")
		or die "Could not open file $sourcePath: $!";
	my $noG = ($indexType and ($indexType !~ /^G/));

	while (my $line = <$in>)
	{
		$res->{'a'} = $1 if ($line =~ /\@a\{([^}]*)\}/); # a - autors
		$res->{'z'} = $1 if ($line =~ /\@z\{([^}]*)\}/); # z - avota saīsinājums - visiem
		#$res->{'k'} = $1 if ($line =~ /\@k\{([^}]*)\}/ and not defined $res->{'g'}); # k - pirmais komentārs priekš GLR un GNP pirms g
		$res->{'g'} = $1 if ($line =~ /\@g\{([^}]*)\}/); # g - bībeles grāmata priekš GLR un GNP
		last if (scalar keys %$res > 3 or $noG and scalar keys %$res > 2);
	}
	$res->{'k'} = undef unless $res->{'g'};

	$res->{'author'} = $res->{'a'};	# for convenience
	$res->{'year'} = $1 if ($res->{'z'} =~ /^.*?(\d{4}(_\d+)?).*$/);
	$res->{'century'} = $1 + 1 if ($res->{'year'} and $res->{'year'} =~ /^(\d\d)/);
	$res->{'full ID'} = $res->{'z'};
	$res->{'full ID'} = $res->{'full ID'} . "/" . $res->{'g'} if (exists $res->{'g'});
	$res->{'short ID'} = $res->{'z'};
	$res->{'short ID'} = $res->{'g'} if (exists $res->{'g'});
	$res->{'collection'} = "";
	$res->{'collection'} = $res->{'z'} if (exists $res->{'g'});

	$in->close;
	return $res;
}

1;