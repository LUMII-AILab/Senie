:: Run for single file with default table like this.
::perl -e "use LvSenie::Translit::Transliterator qw(transformFile); transformFile(@ARGV)" data 0 Br1520_PN
::perl -e "use LvSenie::Translit::Transliterator qw(transformFile); transformFile(@ARGV)" data 0 Manc1638_Run

:: Run for single file, but with 18th century table like this.
::perl -e "use LvSenie::Translit::Transliterator qw(transformFile); transformFile(@ARGV)" data 18TH_CENTURY Lop1800_SDLS
::perl -e "use LvSenie::Translit::Transliterator qw(transformFile); transformFile(@ARGV)" data 18TH_CENTURY StendGF1789_SL
::perl -e "use LvSenie::Translit::Transliterator qw(transformFile); transformFile(@ARGV)" data 18TH_CENTURY Hag1790_IM

:: Run for a folder with default tables like this.
::perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data 0
::perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 0 VD1689_94
::perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-JT1685 0 JT1685
::perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 0 Apokr1689

::Run for a folder, but with 18th century table like this
::perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data 18TH_CENTURY

pause