:: Run for single file like this.
::perl -e "use LvSenie2Unicode::Dehyphenator qw(transformFile); transformFile(@ARGV)" data Braum1699_LVV Baum1699_LVV_Unicode.txt

:: Run for a folder like this.
perl -e "use LvSenie2Unicode::Dehyphenator qw(transformDir); transformDir(@ARGV)" data Unicode
perl -e "use LvSenie2Unicode::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD Unicode
::perl -e "use LvSenie2Unicode::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT Unicode

pause