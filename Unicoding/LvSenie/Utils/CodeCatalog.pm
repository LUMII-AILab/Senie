package LvSenie::Utils::CodeCatalog;
use strict;
use utf8;
use warnings;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(canDecode decode isLanguage);

our $CODES = {
	'1' => [ 'sheet', 0 ],
	'2' => [ 'title-even', 0 ],
	'3' => [ 'title-odd', 0 ],
	#'a' => ['author', 0],
	'b' => [ 'carry-over', 0],
	'c' => [ 'polish', 1],
	'd' => [ 'french', 1],
	'e' => [ 'estonian', 1],
	'f' => [ 'flemish', 1],
	#'g' => [ 'bible-book', 0],
	'h' => [ 'greek', 1],
	'i' => [ 'italian', 1],
	#'j' => [ 'unknown', 0],
	'k' => [ 'comment', 0],
	'l' => [ 'latin', 1],
	#'m' => [ 'unknown', 0],
	'o' => [ 0, 0], #TODO saprast, kas ar šito ir
	'p' => [ 'remark', 0],
	#'q' => [ '', 0],
	'r' => [ 'aramaic', 1],
	's' => [ 'english', 1],
	't' => [ 'parallel', 0],
	#'u' => [ 'unknown', 0],
	'v' => [ 'german', 1],
	#'w' => [ 'unknown', 0],
	#'x' => [ 'empty', 0],
	#'y' => [ 'unknown', 0],
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