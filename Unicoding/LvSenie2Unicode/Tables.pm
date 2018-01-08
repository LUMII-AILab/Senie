package LvSenie2Unicode::Tables;
use strict;
use utf8;
use warnings;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(substTable);

our $ST = {
	'Baum1699_LVV' => {
		'§'  => "\x{017F}",
		'ś'  => "\x{1E9C}",
		'a^' => "\x{00E2}",
		'o^' => "\x{00F4}",
	},
	'Br1520_PN' => {
		'§'  => "\x{017F}",
		'a~'  => "\x{00E3}",
		'e~'  => "\x{1EBD}",
	}
};

sub substTable
{
	my $tableName = shift @_;
	return $ST->{$tableName};
}

1;