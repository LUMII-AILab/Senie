:: Run for single file like this.
::perl -e "use LvSenieUtils::Dehyphenator qw(transformFile); transformFile(@ARGV)" data Braum1699_LVV Baum1699_LVV_Unicode.txt

:: Run for a folder like this.
perl -e "use LvSenieUtils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data Unicode
perl -e "use LvSenieUtils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD Unicode
perl -e "use LvSenieUtils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT Unicode
perl -e "use LvSenieUtils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr Unicode

pause