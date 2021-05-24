package LvSenie::Translit::SimpleTranslitTables;
use strict;
use warnings;
use utf8;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(substTable hasTable TABLES);

# Human readable substitution tables.
our $TABLES = {
	'Br1520_PN'   => [ ### IR OK.
		[ '^Tew', 'Tēv', ],
		[ '\b{wb}muſe\b{wb}', 'mūse', ],
		[ '\b{wb}muſs', 'mūs', ],
		[ '\b{wb}Muſse\b{wb}', 'Mūse', ],
		[ '\b{wb}excã\b{wb}', 'iekšan', ],
		[ '\b{wb}eck', 'iek', ],
		[ 'ſch', 'š', ],
		[ 'bb', 'b', ],
		[ 'ſiſs', 'sīs', 1 ],
		[ '\b{wb}Swetytz\b{wb}', 'Svētīts', ],
		[ 'ouw', 'av', ],
		[ '\b{wb}waardt', 'vārds', ],
		[ '\b{wb}Ena', 'Ienā', ],
		[ 'ck', 'k', ],
		[ '\b{wb}wallſtibſs', 'valstībs', ],
		[ 'atz\b{wb}', 'āts', ],
		[ '\b{wb}bus\b{wb}', 'būs', ],
		[ '\b{wb}ka\b{wb}', 'kā', ],
		[ 'ss', 's', ],
		[ '\b{wb}Ta\b{wb}', 'Tā', ],
		[ '\b{wb}arriſ', 'arīdz', ],
		[ '\b{wb}wurſ', 'virs', ],
		[ '\b{wb}ſemm', 'zem', ],
		[ '\b{wb}deniſ', 'dieni', ],
		[ 'yſe\b{wb}', 'ize', ],
		[ '\b{wb}duth\b{wb}', 'dot', ],
		[ 'deẽ', 'dien', ],
		[ 'mm', 'm', ],
		[ '\b{wb}gre', 'grē', ],
		[ '\b{wb}mes\b{wb}', 'mēs', ],
		[ 'rr', 'r', ],
		[ 'adu', 'ādnie', ],
		[ 'ekw', 'iev', ],
		[ 'dſ', 'dz', ],
		[ '\b{wb}ļou', 'ļau', ],
		[ '\b{wb}AEth\s*peſti', 'Atpesti', ],
		[ '\b{wb}wyſ', 'vis', ],
	],
	'Reit1675_OD' => [
		[ 'muuſch', 'mūž', ],
		[ 'ſch', 'š', ],
		[ 'Maiſ', 'maiz', ],
		[ 'ſ', 's', ],
		[ 'ää', 'ē', ],
		[ 'Täwß', 'tēvs', ],
		[ 'Swät', 'svēt', ],
		[ 'kiän', 'ķēn', ],
		[ '\b{wb}mäß', 'mēs', ],
		[ 'kärdin', 'kārdin', ],
		[ 'kän', 'ķēn', ],
		[ 'ä', 'e', ],
		[ 'ß', 's', ],
		[ 'dz', 'ds', ],
		[ 'tz', 'ts', ],
		[ 'y', 'i', ],
		[ 'iaw', 'jau', ],
		[ 'w', 'v', ],
		[ 'li', 'ļ', ],
		[ 'bb', 'b', ],
		[ 'mm', 'm', ],
		[ 'tt', 't', ],
		[ 'dd', 'd', ],
		[ 'uu', 'ū', ],
		[ 'ee', 'ie', ],
		[ 'oo', 'o', ],
		[ 'aa', 'ā', ],
		[ 'Sem', 'zem', ],
		[ 'den', 'dien', ],
		[ 'MŪso', 'mūsu', ],
	],
};

sub substTable
{
	my $tableName = shift @_;
	return $TABLES->{$tableName};
}

sub hasTable
{
	my $tableName = shift @_;
	return exists $TABLES->{$tableName};
}

1;