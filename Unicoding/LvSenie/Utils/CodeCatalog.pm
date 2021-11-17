package LvSenie::Utils::CodeCatalog;
use strict;
use utf8;
use warnings;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(canDecode decode isLanguage);

our $CODES = {
	'1' => [ 'Sheet', 0 ],
	'2' => [ 'Title (even)', 0 ],
	'3' => [ 'Title (odd)', 0 ],
	'a' => [ 'Author', 0],
	'b' => [ 'Carry over', 0],
	'c' => [ 'Polish', 1],
	'd' => [ 'French', 1],
	'e' => [ 'Estonian', 1],
	'f' => [ 'Flemish', 1],
	#'g' => [ 'Bible Book', 0],
	'h' => [ 'Greek', 1],
	'i' => [ 'Italian', 1],
	#'j' => [ 0, 0],
	'k' => [ 'Comment', 0],
	'l' => [ 'Latin', 1],
	#'m' => [ 0, 0],
	#'o' => [ 0, 0],
	'p' => [ 'Remark', 0],
	#'q' => [ 0, 0],
	'r' => [ 'Aramaic', 1],
	's' => [ 'English', 1],
	't' => [ 'Parallel', 0],
	#'u' => [ 0, 0],
	'v' => [ 'German', 1],
	#'w' => [ 0, 0],
	'x' => [ 'Empty', 0],
	#'y' => [ 0, 0],
	#'z' => [ 'sorce-id', 0],
};

sub isLanguage
{
	my $codifier = shift @_;
	return 0 unless exists $CODES->{$codifier};
	return $CODES->{$codifier}->[1];
}

sub decode
{
	my $codifier = shift @_;
	return undef unless exists $CODES->{$codifier};
	return $CODES->{$codifier}->[0];
}

sub canDecode
{
	my $codifier = shift @_;
	return exists $CODES->{$codifier};
}

1;