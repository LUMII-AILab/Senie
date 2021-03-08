:: Run for single file like this.
perl -e "use LvSenieTranslit::Transliterator qw(transformFile); transformFile(@ARGV)" data Manc1638_Run

:: Run for a folder like this.
::perl -e "use LvSenieTranslit::Transliterator qw(transformDir); transformDir(@ARGV)" data
::perl -e "use LvSenieTranslit::Transliterator qw(transformDir); transformDir(@ARGV)" data-VD
::perl -e "use LvSenieTranslit::Transliterator qw(transformDir); transformDir(@ARGV)" data-JT
::perl -e "use LvSenieTranslit::Transliterator qw(transformDir); transformDir(@ARGV)" data-Apokr

pause