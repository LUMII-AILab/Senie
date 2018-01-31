:: Run for single file like this.
::perl -e "use LvSenie2Unicode::Transformator qw(transformFile); transformFile(@ARGV)" data Braum1699_LVV

:: Run for a folder like this.
perl -e "use LvSenie2Unicode::Transformator qw(transformDir); transformDir(@ARGV)" data
perl -e "use LvSenie2Unicode::Transformator qw(transformDir); transformDir(@ARGV)" data-VD
perl -e "use LvSenie2Unicode::Transformator qw(transformDir); transformDir(@ARGV)" data-JT

pause