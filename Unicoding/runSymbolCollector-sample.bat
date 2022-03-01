::CHCP 65001

REM Run for single file like this.
::perl -CS -e "use LvSenie::Utils::SymbolCollector qw(countInFile); countInFile(@ARGV)" data Elg1621_GCG_Unicode.txt UTF-8
::perl -CS -e "use LvSenie::Utils::SymbolCollector qw(countInFile); countInFile(@ARGV)" data Fuer1650_70_1ms.txt cp1257

REM Run for a folder like this.
::perl -CS -e "use LvSenie::Utils::SymbolCollector qw(countInDirs); countInDirs(@ARGV)" . UTF-8 data
REM Run for multiple folders like this.
::perl -CS -e "use LvSenie::Utils::SymbolCollector qw(countInDirs); countInDirs(@ARGV)" . UTF-8 data data-Apokr data-JT data-VD

pause