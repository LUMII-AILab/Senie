::CHCP 65001

REM Run for single file like this.
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeFile); verticalizeFile(@ARGV)" data Elg1621_GCG_Unicode_unhyphened.txt UTF-8
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeFile); verticalizeFile(@ARGV)" data Fuer1650_70_1ms_unhyphened.txt cp1257

REM Run for a folder like this.
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeDirs); verticalizeDirs(@ARGV)" . cp1257 data
REM Run for multiple folders like this.
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeDirs); verticalizeDirs(@ARGV)" . cp1257 data data-Apokr data-JT data-VD

REM Run for a folder like this.
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeDirs); verticalizeDirs(@ARGV)" . UTF-8 data
REM Run for multiple folders like this.
::perl -e "use LvSenie::Vert::Verticalizer qw(verticalizeDirs); verticalizeDirs(@ARGV)" . UTF-8 data data-Apokr data-JT data-VD

pause