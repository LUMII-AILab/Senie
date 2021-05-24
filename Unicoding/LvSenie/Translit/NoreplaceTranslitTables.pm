package LvSenie::Translit::NoreplaceTranslitTables;
use strict;
use utf8;
use warnings;

use LvSenie::Translit::SimpleTranslitTables qw(TABLES);


use Exporter();
our @ISA = qw(Exporter);
#our @EXPORT_OK = qw(derivedSubstTable hasDerivedTable encodeString decodeString);
our @EXPORT_OK = qw(encodeString decodeString);

# First project specification required to ensure that strings already replaced
# would never be considered for replacment agan, so the derived tables were used
# Where each character in resulting string is surrounded by \N{U+E001} and
# \N{U+E002} to ensure that it is never replaced again.
# Currently deprecated.
#our $NOREPL_TABLES = deriveNonreplacementST($TABLES);

#sub deriveNonreplacementST
#{
#	my $sourceTables = shift @_;
#	my $resultST = {};
#	for my $source (keys %{$sourceTables})
#	{
#		my $subtable = {};
#		for my $target (keys %{$sourceTables->{$source}})
#		{
#			$subtable->{$target} = encodeString($sourceTables->{$source}->{$target});
#		}
#		$resultST->{$source} = $subtable;
#	}
#	return $resultST;
#}

#sub derivedSubstTable
#{
#	my $tableName = shift @_;
#	return $NOREPL_TABLES->{$tableName};
#}

#sub hasDerivedTable
#{
#	my $tableName = shift @_;
#	return exists $NOREPL_TABLES->{$tableName};
#}

# Still used part.
sub encodeString
{
	my $string = shift @_;
	$string =~ s/(.)/\N{U+E001}$1\N{U+E002}/g;
	return $string;
}

sub decodeString
{
	my $string = shift @_;
	$string =~ s/[\N{U+E001}\N{U+E002}]//g;
	return $string;
}

1;