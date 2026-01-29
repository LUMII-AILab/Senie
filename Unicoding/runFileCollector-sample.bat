REM Run for full corpuss like this. Parameter must give full infix for the files
REM to be selected - everything between source code (e.g., Baum1699_LVV and
REM .txt) except leading underscore.

REM This collect everything in folders data, data-VD1689_94, data-JT1685, data-Apokr1689.
REM perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode_unhyphened
REM perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode
REM perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)"
REM perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 unhyphened_full

REM This collect everything in folder data with appropriate subfolders.
REM perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" 0 Unicode_unhyphened
REM perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" 0 Unicode
REM perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)"

REM this ir for collecting with whitelist.
::perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" "..\Specs\Subcorpora\LVVV.txt" Unicode_unhyphened


pause