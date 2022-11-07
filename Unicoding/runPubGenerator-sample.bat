::CHCP 65001

REM Run for single file like this.
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processFile); processFile(@ARGV)" data Elg1621_GCG_Unicode_unhyphened.txt UTF-8
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processFile); processFile(@ARGV)" data Fuer1650_70_1ms_unhyphened.txt cp1257

REM Run for a folder to make vert file like this.
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 1 0 0 0 data
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 0 data
REM Run for a folder to make HTML files like this.
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 0 1 0 0 data
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 1 0 0 data
REM Run for a folder to make TEI files like this.
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 0 0 1 0 data
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 1 0 data

REM Run for multiple folders to make vert file like this (for publishing in Sketch use unhyphened unicode files, if available).
REM For old Senie files it is better to use the new perl dehyphenator (unhyphened_full), not the old java one.
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 1 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94
REM Run for multiple folders to make vert file with transliterationlike this (use unhyphened unicode files).
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 1 data data-Apokr1689 data-JT1685 data-VD1689_94
REM Run for multiple folders to make html files like this (for publishing in SENIE homepage use files with original hyphens).
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 0 1 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94
::perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 1 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94


pause