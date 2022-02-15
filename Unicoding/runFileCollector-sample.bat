:: Run for full corpuss like this. Parameter must give full infix for the files
:: to be selected - everything between source code (e.g., Baum1699_LVV and
:: .txt) except leading underscore.

:: This collect everything in folders data, data-VD, data-JT, data-Apokr.
::perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode_unhyphened
::perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode
::perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)"

:: This collect everything in folder data with appropriate subfolders.
::perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" Unicode_unhyphened
::perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" Unicode
::perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)"

pause