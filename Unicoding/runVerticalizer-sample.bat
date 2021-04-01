:: Run for single file like this.
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeFile); verticalizeFile(@ARGV)" data Elg1621_GCG_Unicode_unhyphened.txt UTF-8
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeFile); verticalizeFile(@ARGV)" data Fuer1650_70_1ms_unhyphened.txt cp1257

:: Run for a folder like this.
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeDir); verticalizeDir(@ARGV)" data cp1257
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeDir); verticalizeDir(@ARGV)" data-Apokr cp1257
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeDir); verticalizeDir(@ARGV)" data-JT cp1257
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeDir); verticalizeDir(@ARGV)" data-VD cp1257

pause