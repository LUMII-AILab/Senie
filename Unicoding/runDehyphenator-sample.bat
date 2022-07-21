:: Run for single file like this.
::perl -e "use LvSenie::Utils::Dehyphenator qw(transformFile); transformFile(@ARGV)" data Braum1699_LVV Baum1699_LVV_Unicode.txt UTF-8

:: Run for Unicode folders like this.
::perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data UTF-8 Unicode
::perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD UTF-8 Unicode
::perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT UTF-8 Unicode
::perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr UTF-8 Unicode

:: Run for Win1257 folders like this (do not store these files in git instead of old unhyphened files!!!).
::perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data cp1257 0 _full
::perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD cp1257 0 _full
::perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT cp1257 0 _full
::perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr cp1257 0 _full

pause