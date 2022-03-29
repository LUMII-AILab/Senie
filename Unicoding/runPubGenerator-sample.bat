::CHCP 65001

REM Run for single file like this.
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processFile); processFile(@ARGV)" data Elg1621_GCG_Unicode_unhyphened.txt UTF-8
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processFile); processFile(@ARGV)" data Fuer1650_70_1ms_unhyphened.txt cp1257

REM Run for a folder to make vert file like this.
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 1 0 data
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 data
REM Run for a folder to make html files like this.
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 0 1 data
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 1 data

REM Run for multiple folders to make vert file like this (for publishing in Sketch use unhyphened files).
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 1 0 data data-Apokr data-JT data-VD
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 data data-Apokr data-JT data-VD
REM Run for multiple folders to make html files like this (for publishing in SENIE homepage use files with original hyphens).
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 0 1 data data-Apokr data-JT data-VD
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 1 data data-Apokr data-JT data-VD

pause