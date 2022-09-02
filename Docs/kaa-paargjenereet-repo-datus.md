Visas pamācības pieņem Windows uz lokālās mašīnas un Linux SkE serverī.

Ja ir mainījušies unikodi
-------------------------

Mainītos unikodus saliek atbilstošajās `Sources` mapēs pirms tālākas darbošanās.

Vajag pārģenerēt simbolu tabulu
===============================
1. Savāc `Unicoding` mapē atbilstošos failus ar komandu `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode` (sk. `runFileCollector-sample.bat`).
2. Pārģenerē simbolu tabulas ar komandu `perl -CS -e "use LvSenie::Utils::SymbolCollector qw(countInDirs); countInDirs(@ARGV)" . UTF-8 data data-Apokr data-JT data-VD` (sk. `runSymbolCollector-sample.bat`).
3. Pārvieto `unicode_symbols.html` uz mapi `Web` un `unicode_symbols.txt` uz `Docs`.



Vajag pārģenerēt atpārnesumotos failus
======================================

1. Savāc `Unicoding` mapē atbilstošos failus ar komandu `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode` (sk. `runFileCollector-sample.bat`).
2. Pārģenerē atpārnesumotos failus ar komandām (sk. `runDehyphenator-sample.bat`)
```
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data UTF-8 Unicode
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD UTF-8 Unicode
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT UTF-8 Unicode
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr UTF-8 Unicode
```
3. Pārkopē rezultātu failus no mapēm `data\res`, `data-Apokr\res`, `data-JT\res`, `data-VD\res` uz attiecīgi `Sources`, `Sources\Apokr1689`, `Sources\JT1685`, `Sources\VD1689_94`.


Vajag atjaunināt atbilstošos web failus
=======================================

1. Savāc mapītē `Unicoding` apstrādājamos failus ar komandu `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode` (sk. `runFileCollector-sample.bat`).
2. Pārģenerē HTML failus ar komandu `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 1 0 data data-Apokr data-JT data-VD` (sk. `runPubGenerator-sample.bat`).
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas.
4. Pārkopē rezultātu failus no mapēm `data\res`, `data-Apokr\res`, `data-JT\res`, `data-VD\res` uz attiecīgi `Web\unicode`, `Web\unicode\Apokr1689`, `Web\unicode\JT1685`, `Web\unicode\VD1689_94`.


Vajag atjaunināt transliterācijas
=================================

1. Savāc mapītē `Unicoding` apstrādājamos failus ar komandu `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode_unhyphened` (sk. `runFileCollector-sample.bat`).
2. Pārģenerē transliterācijas ar komandām (sk. `runTransliterator-sample.bat`)
```
perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data
perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-VD VD1689_94
perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-JT JT1685
perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-Apokr Apokr1689
```
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas, t.sk trūkstošas tabulas.
4. Pārkopē rezultātu failus no mapēm `data\res`, `data-Apokr\res`, `data-JT\res`, `data-VD\res` uz attiecīgi `Sources`, `Sources\Apokr1689`, `Sources\JT1685`, `Sources\VD1689_94`.


Vajag pārģenerēt vert failu
===========================
1. Mapē `Unicoding` ar komandu `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode_unhyphened` (sk. `runFileCollector-sample.bat`) savāc apstrādājamos failus.
2. Uztaisa pilno vertfailu (ar transliterācijām) ar komandu `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 1 data data-Apokr data-JT data-VD` (sk. `runPubGenerator-sample.bat`).
3. Apkopo tokenizācijas problēmas un noziņo valodniekiem.
4. Failu `all.vert` pārsauc par `senie_unicode.vert` (agrāk `senie_translit.vert`) un ielādē SkE serverī (sk. pēdējo nodaļu).

Ja otrajā solī lieto komandu `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 data data-Apokr data-JT data-VD`, tad iegūst vert failu bez transliterācijas kolonnas.



Ja ir mainījušies pre-unikoda faili
-----------------------------------

Mainītos failus saliek atbilstošajās `Sources` mapēs pirms tālākas darbošanās.

Vajag izdarbināt Java skriptu ne-servera daļu, lai pārģenerētu visu, ko tas māk
===============================================================================

1. Apkopo izmantojamos failus mapē `Unicoding` ar komandu `perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)` (sk. `runFileCollector-sample.bat`).
2. Iegūto mapīti `data` pārkopē uz `Indexing\run`, vajadzības gadījumā pirms tam izdzēšot tur jau esošās `data`, `result-txt`, `result-html` un `result-trash` mapes.
3. Ja nepieciešams, pārkompilē visu Java Seno kodu, un palaiž `PolySENIE.bat` no `Indexing\run`, lai iegūtu rezultātus. Pagaida dažas minūtes.
4. `Sources` mapē izdzēš visus failus, kas nosaukumā satur `log.txt`
5. `result-txt` saturu pārkopē uz `Sources`
6. `result-html` saturu pārkopē uz `Web\static`


Vajag atjaunināt statistikas `Web` mapītē
=========================================

1. Pārģenerē inverso vārdnīcu - mapītē `Unicoding` ar komandu `perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" inverse` savāc inversās vārdnīcas failus mapītē `data`, no kuras tos tālāk pārkopē uz `Web\inverse`.
2. Pārģenerē biežumsarakstus - mapītē `Unicoding` ar komandām 
```
perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" frequencies
perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" frequencies_lower
```
savāc failus mapītē `data`, no kuras tos tālāk pārkopē uz `Web\freq`.

Komandu piemēri apkopoti `runFileCollector-sample.bat`, pa vidu starp dažādām darbībām vajag iztīrīt `data` mapi.


Vajag pārģenerēt atpārnesumotos bezizlaidumu failus
===================================================

1. Mapītē `Unicoding` ar komandu `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)"` savāc apstrādājamos failus (sk. `runFileCollector-sample.bat`).
2. Pārģenerē atpārnesumotos bezizlaidumu failus ar komandām (sk. `runDehyphenator-sample.bat`)
```
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data cp1257 0 _full
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD cp1257 0 _full 
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT cp1257 0 _full
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr cp1257 0 _full
```
3. Pārkopē rezultātu failus no mapēm `data\res`, `data-Apokr\res`, `data-JT\res`, `data-VD\res` uz attiecīgi `Sources`, `Sources\Apokr1689`, `Sources\JT1685`, `Sources\VD1689_94`.


Vajag atjaunināt SkE vertfailu
==============================
1. Mapītē `Unicoding` ar komandu `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" unhyphened_full` (sk. `runFileCollector-sample.bat`) savāc iepriekšējā solī atpārnesumotos bezilaiduma failus.
2. Uztaisa vert failu ar komandu `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 1 0 0 data data-Apokr data-JT data-VD` (sk. `runPubGenerator-sample.bat`).
3. Pārskata konsoles izdrukas un noziņo valodniekiem tokenizācijas problēmas.
4. Failu `all.vert` pārsauc par `senie_sakotnejs.vert` un ielādē SkE serverī (sk. pēdējo nodaļu)



Tīmekļa failu atjaunināšana (kopsavilkums)
------------------------------------------
1. `Web\static` saturs rodas, pārdarbinot Java skriptu ne-servera daļu (skatīt pre-unikoda nodaļas sākumu).
2. `Web\inverse` saturs rodas, kad pārdarbinot Java skriptus, no rezultātiem atlasa inversu failus (skatīt pre-unikoda nodaļas statistiku sadaļu).
3. `Web\unicode` saturs rodas...
4. Pārējās `Web` sadaļas šobrīd nav iespējams automātiski atjaunināt.



SkE atjaunināšana
-----------------
TODO.