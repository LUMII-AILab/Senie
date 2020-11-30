:: Run for single file like this.
::perl -e "use LvSenieTranslit::Verticalizer qw(verticalizeFile); verticalizeFile(@ARGV)" data Elg1621_GCG_Unicode_unhyphened.txt
::perl -e "use LvSenieTranslit::Verticalizer qw(verticalizeFile); verticalizeFile(@ARGV)" data Fuer1650_70_1ms_Unicode_unhyphened.txt

:: Run for a folder like this.
perl -e "use LvSenieTranslit::Verticalizer qw(verticalizeDir); verticalizeDir(@ARGV)" data
::perl -e "use LvSenieTranslit::Verticalizer qw(verticalizeDir); verticalizeDir(@ARGV)" data-VD
::perl -e "use LvSenieTranslit::Verticalizer qw(verticalizeDir); verticalizeDir(@ARGV)" data-JT

pause