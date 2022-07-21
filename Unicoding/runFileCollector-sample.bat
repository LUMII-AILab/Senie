REM Run for full corpuss like this. Parameter must give full infix for the files
REM to be selected - everything between source code (e.g., Baum1699_LVV and
REM .txt) except leading underscore.

REM This collect everything in folders data, data-VD, data-JT, data-Apokr.
REM perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode_unhyphened
REM perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode
REM perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)"
REM perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" unhyphened_full

REM This collect everything in folder data with appropriate subfolders.
REM perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" Unicode_unhyphened
REM perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" Unicode
REM perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)"

REM This ir for Web/inverse
REM perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" inverse
REM This ir for Web/freq
REM perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" frequencies
REM perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" frequencies_lower


pause