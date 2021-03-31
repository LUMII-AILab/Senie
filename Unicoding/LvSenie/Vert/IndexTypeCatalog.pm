package LvSenie::Vert::IndexTypeCatalog;
use strict;
use utf8;
use warnings FATAL => 'all';

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(getIndexType);

our $sourcePath = '../Sources/indexing.txt';
our $indexSpec = loadCatalog;

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

sub getIndexType
{
	my $source = join '/', @_;
	$source =~ tr#\t#/#;
	$source =~ s/^\s*(.*?)\s*$/$1/;
	return $indexSpec->{$source} if (exists $indexSpec->{$source});
	return undef;
}

1;