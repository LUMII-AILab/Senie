:: Run for full corpuss like this. Parameter must give full infix for the files
:: to be selected - everything between source code (e.g., Baum1699_LVV and
:: .txt) except leading underscore.
perl -e "use LvSenieUtils::FileCollector qw(collect); collect(@ARGV)" Unicode
::perl -e "use LvSenieUtils::FileCollector qw(collect); collect(@ARGV)"

pause