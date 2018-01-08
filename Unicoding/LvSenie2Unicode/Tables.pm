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
	},
	'CC1585' => {
		'§'  => "\x{017F}",
		'u~' => "\x{0169}",
		'e~' => "\x{1EBD}",
		'z' => "\x{0292}",	# TODO ask Everita, if this is needed.
	},
	'CekFJ1790_KD' => {
		'§'  => "\x{017F}",
		'ś' => "\x{1E9C}",
		'a^' => "\x{00E2}",
		'o^' => "\x{00F4}",
		'a`' => "\x{00E0}",
		'e^' => "\x{00EA}",
		'i^' => "\x{00EE}",
		'e`' => "\x{00E8}",
		'Ś' => "\x{A7A8}",
	},
	'CekFV1796_NL' => {
		'§'  => "\x{017F}",
		'ś' => "\x{1E9C}",
		'a^' => "\x{00E2}",
		'o^' => "\x{00F4}",
		'a`' => "\x{00E0}",
		'e^' => "\x{00EA}",
		'i^' => "\x{00EE}",
		'Ś' => "\x{A7A8}",
	},
	#'Elg1621_GCG' => {},	# TODO table needed from linguists!
	'Ench1586' => {
		'§'  => "\x{017F}",
		'e~' => "\x{1EBD}",
		'n~' => "\x{00F1}",
		'm~' => "m\x{0303}", # TODO combined char?
		'a~' => "\x{00E3}",
		'tz' => "\x{A729}",
		'z' => "\x{0292}",
	},
	'Ench1615' => {
		'§'  => "\x{017F}",
		'e~' => "\x{1EBD}",
		'n~' => "\x{00F1}",
		'm~' => "m\x{0303}", # TODO combined char?
		'a~' => "\x{00E3}",
		'e_' => "e",
		'r_' => "r",
		'o\'' => "ö",
	},
	'EvEp1587' => {
		'§'  => "\x{017F}",
		'e~' => "\x{1EBD}",
		'n~' => "\x{00F1}",
		'a~' => "\x{00E3}",
		'u~' => "\x{0169}",
		'm~' => "m\x{0304}",	# TODO combined m tilde?
		'tz' => "\x{A729}",
		'z' => "\x{0292}",
	},
#	'' => {
#		'' => "\x{}",
#	},
};

sub substTable
{
	my $tableName = shift @_;
	return $ST->{$tableName};
}

1;