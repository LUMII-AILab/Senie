package LvSenie::Utils::CodeCatalog;
use strict;
use utf8;
use warnings;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(canDecode decode isLanguage mustIncludeLanguage);

our $CODES = {
	'0' => { 'Name' => 'Strikethrough', 'IsLang' => 0},
	'1' => { 'Name' => 'Sheet', 'IsLang' => 0, },
	'2' => { 'Name' => 'Title (even)', 'IsLang' => 0, },
	'3' => { 'Name' => 'Title (odd)', 'IsLang' => 0, },
	'a' => { 'Name' => 'Author', 'IsLang' => 0, },
	'b' => { 'Name' => 'Carry-over', 'IsLang' => 0, },
	'c' => { 'Name' => 'Polish', 'IsLang' => 1, },
	'd' => { 'Name' => 'French', 'IsLang' => 1, },
	'e' => { 'Name' => 'Estonian', 'IsLang' => 1, },
	'f' => { 'Name' => 'Flemish', 'IsLang' => 1, },
	'g' => { 'Name' => 'Chapter ID', 'IsLang' => 0, 'LangInside' => 0, },
	'h' => { 'Name' => 'Greek', 'IsLang' => 1, },
	'i' => { 'Name' => 'Italian', 'IsLang' => 1, },
	#'j' => { 'Name' => 0, 'IsLang' => 0, 'LangInside' => 0, },
	'k' => { 'Name' => 'Comment', 'IsLang' => 0, 'LangInside' => 1, },
	'l' => { 'Name' => 'Latin', 'IsLang' => 1, },
	#'m' => { 'Name' => 0, 'IsLang' => 0, 'LangInside' => 0, },
	'n' => { 'Name' => 'Chapter ID', 'IsLang' => 0, 'LangInside' => 0, },
	#'o' => { 'Name' => 0, 'IsLang' => 0, 'LangInside' => 0, },
	'p' => { 'Name' => 'Remark', 'IsLang' => 0, 'LangInside' => 1, },
	#'q' => { 'Name' => 0, 'IsLang' => 0, 'LangInside' => 0, },
	'r' => { 'Name' => 'Aramaic', 'IsLang' => 1, },
	's' => { 'Name' => 'English', 'IsLang' => 1, },
	't' => { 'Name' => 'Parallel', 'IsLang' => 0, },
	#'u' => { 'Name' => 0, 'IsLang' => 0, 'LangInside' => 0, },
	'v' => { 'Name' => 'German', 'IsLang' => 1, },
	#'w' => { 'Name' => 0, 'IsLang' => 0, 'LangInside' => 0, },
	'x' => { 'Name' => 'Empty', 'IsLang' => 0, },
	#'y' => { 'Name' => 0, 'IsLang' => 0, 'LangInside' => 0, },
	'z' => { 'Name' => 'Source ID', 'IsLang' => 0, 'LangInside' => 0, },
};

sub isLanguage
{
	my $codifier = shift @_;
	return 0 unless (exists $CODES->{$codifier} and $CODES->{$codifier});
	return $CODES->{$codifier}->{'IsLang'};
}

sub mustIncludeLanguage
{
	my $codifier = shift @_;
	return 0 unless (exists $CODES->{$codifier} and $CODES->{$codifier});
	return $CODES->{$codifier}->{'LangInside'};
}

sub decode
{
	my $codifier = shift @_;
	warn "Missing $codifier $!" unless (exists $CODES->{$codifier} and $CODES->{$codifier});
	return undef unless (exists $CODES->{$codifier} and $CODES->{$codifier});
	return $CODES->{$codifier}->{'Name'};
}

sub canDecode
{
	my $codifier = shift @_;
	return (exists $CODES->{$codifier} and $CODES->{$codifier});
}

1;