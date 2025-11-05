
REM Run for single plain text file like this.
perl -e "use LvSenie::Translit::Transliterator qw(process18thCentFile); process18thCentFile(@ARGV)" test.txt

REM Run for single Senie Corpus DSL text file like this.
::perl -e "use LvSenie::Translit::Transliterator qw(process18thCentFile); process18thCentFile(@ARGV)" StendGF1774_AGG_Unicode_unhyphened.txt StendGF1774_AGG_Unicode_translitered.txt 1


pause