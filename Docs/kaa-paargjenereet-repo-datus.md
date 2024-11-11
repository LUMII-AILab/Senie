Visas pamācības pieņem Windows uz lokālās mašīnas un Linux SkE serverī.

Windows komandrindā `chcp 65001` var noderēt, ja kļūdu paziņojumi neizskatās smalki.



# Ja ir mainījušies unikodi

Mainītos unikodus saliek atbilstošajās `Sources` mapēs pirms tālākas darbošanās.


## Vajag pārģenerēt simbolu tabulu

1. Savāc `Unicoding` mapē atbilstošos failus ar komandu 
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode`
   (sk. `runFileCollector-sample.bat`).
2. Pārģenerē simbolu tabulas ar komandu
   `perl -CS -e "use LvSenie::Utils::SymbolCollector qw(countInDirs); countInDirs(@ARGV)" . UTF-8 data data-Apokr1689 data-JT1685 data-VD1689_94`
   (sk. `runSymbolCollector-sample.bat`).
3. Pārvieto `unicode_symbols.txt` uz mapi `Docs`, bet failus `unicode_full.htm` un `unicode.htm` uz mapi `Web`.


## Vajag pārģenerēt atpārnesumotos failus

1. Savāc `Unicoding` mapē atbilstošos failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode`
   (sk. `runFileCollector-sample.bat`).
2. Pārģenerē atpārnesumotos failus ar komandām
   (sk. `runDehyphenator-sample.bat`)
```
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data UTF-8 Unicode
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 UTF-8 Unicode
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT1685 UTF-8 Unicode
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 UTF-8 Unicode
```
3. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `Sources`, `Sources/Apokr1689`, `Sources/JT1685`, `Sources/VD1689_94`.


## Vajag atjaunināt transliterāciju teksta failus

1. Savāc mapītē `Unicoding` apstrādājamos failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode_unhyphened`
   (sk. `runFileCollector-sample.bat`).
2. Pārģenerē transliterācijas ar komandām (sk. `runTransliterator-sample.bat`)
```
perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data 0
perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 0 VD1689_94
perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-JT1685 0 JT1685
perl -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 0 Apokr1689
```
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas, t.sk trūkstošas tabulas.
4. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `Sources`, `Sources/Apokr1689`, `Sources/JT1685`, `Sources/VD1689_94`.


## Vajag atjaunināt atbilstošos web failus

### HTML oriģināli

1. Savāc mapītē `Unicoding` apstrādājamos failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode`
   (sk. `runFileCollector-sample.bat`).
2. Pārģenerē HTML failus ar komandu
   `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 1 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
   (sk. `runPubGenerator-sample.bat`).
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas.
4. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `Web/unicode`, `Web/unicode/Apokr1689`, `Web/unicode/JT1685`, `Web/unicode/VD1689_94`.


### HTML transliterācijas

1. Savāc mapītē `Unicoding` apstrādājamos failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode_unhyphened`
   (sk. `runFileCollector-sample.bat`).
2. Pārģenerē HTML failus ar komandu
   `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 1 0 1 data data-Apokr1689 data-JT1685 data-VD1689_94`
   (sk. `runPubGenerator-sample.bat`).
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas.
4. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `Web/unicode`, `Web/unicode/Apokr1689`, `Web/unicode/JT1685`, `Web/unicode/VD1689_94`.


## Vajag pārģenerēt TEI failus

### TEI oriģināli

1. Savāc mapītē `Unicoding` apstrādājamos failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode`
   (sk. `runFileCollector-sample.bat`).
2. Pārģenerē TEI failus ar komandu
   `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 1 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
   (sk. `runPubGenerator-sample.bat`).
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas.
4. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `TEI`, `TEI/Apokr1689`, `TEI/JT1685`, `TEI/VD1689_94`.
5. Failu `all.tei.xml` pārsauc par `SENIE_Unicode.tei.xml` un pārvieto uz mapi `TEI`.


### TEI atpārnesumotie

1. Savāc mapītē `Unicoding` apstrādājamos failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode_unhyphened`
   (sk. `runFileCollector-sample.bat`).
2. Pārģenerē TEI failus ar komandu
   `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 1 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
   (sk. `runPubGenerator-sample.bat`).
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas.
4. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `TEI`, `TEI/Apokr1689`, `TEI/JT1685`, `TEI/VD1689_94`.
5. Failu `all.tei.xml` pārsauc par `SENIE_Unicode_unhyphened.tei.xml` un pārvieto uz mapi `TEI`.


### TEI transliterācijas

1. Savāc mapītē `Unicoding` apstrādājamos failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode_unhyphened`
   (sk. `runFileCollector-sample.bat`).
2. Pārģenerē TEI failus ar komandu
   `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 1 1 data data-Apokr1689 data-JT1685 data-VD1689_94`
   (sk. `runPubGenerator-sample.bat`).
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas.
4. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `TEI`, `TEI/Apokr1689`, `TEI/JT1685`, `TEI/VD1689_94`.
5. Failu `all.tei.xml` pārsauc par `SENIE_Unicode_translitered.tei.xml` un pārvieto uz mapi `TEI`.


## Vajag pārģenerēt vert failu

1. Mapē `Unicoding` ar savāc apstrādājamos failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" Unicode_unhyphened`
   (sk. `runFileCollector-sample.bat`).
2. Uztaisa pilno vertfailu (ar transliterācijām) ar komandu
   `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 1 data data-Apokr1689 data-JT1685 data-VD1689_94`
   (sk. `runPubGenerator-sample.bat`).
3. Apkopo tokenizācijas problēmas un noziņo valodniekiem.
4. Failu `all.vert` pārsauc par `senie_unicode.vert` (agrāk `senie_translit.vert`) un ielādē SkE serverī (sk. pēdējo nodaļu).

Ja otrajā solī lieto komandu
`perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`,
tad iegūst vert failu bez transliterācijas kolonnas.



# Ja ir mainījušies pre-unikoda faili

Mainītos failus saliek atbilstošajās `Sources` mapēs pirms tālākas darbošanās.


## Vajag izdarbināt Java skriptu ne-servera daļu, lai pārģenerētu visu, ko tas māk

1. Apkopo izmantojamos failus mapē `Unicoding` ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)`
   (sk. `runFileCollector-sample.bat`).
2. Iegūto mapīti `data` pārkopē uz `Indexing/run`, vajadzības gadījumā pirms tam izdzēšot tur jau esošās `data`, `result-txt`, `result-html` un `result-trash` mapes.
3. Ja nepieciešams, pārkompilē visu Java Seno kodu, un palaiž `PolySENIE.bat` no `Indexing/run`, lai iegūtu rezultātus. Pagaida dažas minūtes.
4. `Sources` mapē izdzēš visus failus, kas nosaukumā satur `_log.txt`
5. `result-txt` saturu pārkopē uz `Sources`
6. `result-html` saturu pārkopē uz `Web/static`


## Vajag atjaunināt statistikas `Web` mapītē (NOVECOJIS)

1. Pārģenerē inverso vārdnīcu - mapītē `Unicoding` ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" inverse`
   savāc inversās vārdnīcas failus mapītē `data`, no kuras tos tālāk pārkopē uz `Web/inverse`.
2. Pārģenerē biežumsarakstus - mapītē `Unicoding` ar komandām 
```
perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" frequencies
perl -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" frequencies_lower
```
savāc failus mapītē `data`, no kuras tos tālāk pārkopē uz `Web/freq`.

Komandu piemēri apkopoti `runFileCollector-sample.bat`, pa vidu starp dažādām darbībām vajag iztīrīt `data` mapi.


## Vajag pārģenerēt atpārnesumotos bezizlaidumu failus

1. Mapītē `Unicoding` ar savāc apstrādājamos failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)"`
   (sk. `runFileCollector-sample.bat`).
2. Pārģenerē atpārnesumotos bezizlaidumu failus ar komandām (sk. `runDehyphenator-sample.bat`)
```
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data cp1257 0 _full
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 cp1257 0 _full
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT1685 cp1257 0 _full
perl -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 cp1257 0 _full
```
3. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `Sources`, `Sources/Apokr1689`, `Sources/JT1685`, `Sources/VD1689_94`.


## Vajag atjaunināt SkE vertfailu

1. Mapītē `Unicoding` savāc iepriekšējā solī atpārnesumotos bezizlaiduma failus ar komandu
   `perl -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" unhyphened_full`
   (sk. `runFileCollector-sample.bat`).
2. Uztaisa vert failu ar komandu 
   `perl -CS -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 1 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
   (sk. `runPubGenerator-sample.bat`).
3. Pārskata konsoles izdrukas un noziņo valodniekiem tokenizācijas problēmas.
4. Failu `all.vert` pārsauc par `senie_sakotnejs.vert` un ielādē SkE serverī (sk. pēdējo nodaļu)



# Ja ir mainījušies transliterēšanas likumi (kopsavilkums)

1. `Sources` ir transliterāciju teksti, kas rodas, pārdarbinot perl skriptu `Transliterator` (sk. unikoda nodaļas transliterācijas daļu).
2. `TEI` ir transliterāciju TEIi, kas rodas, pārdarbinot perl skriptu `PubGenerator` (sk. unikoda nodaļas TEI daļu).
3. `Web/unicode` ir transliterāciju HTMLi, kas rodas, pārdarbinot perl skriptu `PubGenerator` (sk. unikoda nodaļas Web daļu).



# Tīmekļa failu atjaunināšana (kopsavilkums)

1. `Web/static` saturs rodas, pārdarbinot Java skriptu ne-servera daļu (skatīt pre-unikoda nodaļas sākumu).
2. `Web/inverse` saturs rodas, kad pārdarbinot Java skriptus, no rezultātiem atlasa inversu failus (skatīt pre-unikoda nodaļas statistiku sadaļu).
3. `Web/unicode` saturs rodas, pārdarbinot perl skriptu `PubGenerator` (sk. unikoda nodaļas Web daļu).
4. Pārējās `Web` sadaļas šobrīd nav iespējams automātiski atjaunināt.



# SkE atjaunināšana

1. Ja vajag izmainīt, kādi korpusi rādās kā pieejami izvēlnēs http://nosketch.korpuss.lv/ un http://sandbox.nosketch.korpuss.lv/, tad to app serverī var izdarīt atbilstoši `/data/services/nosketch/www/main/run.cgi` un `/data/services/nosketch/www/sandbox/run.cgi`
2. Ja vajag atjaunināt korpusu specifikācijas, tad atbilstošās specifikācijas iekopē no repozitorija mapes `Docs/SketchEngine specs` korpusu servera mapē `/data/services/nosketch/corpora/registry`
3. Jaunos `.vert` failus (sk. pirmās divu nodaļu attiecīgās sadaļas) iekopē korpusu servera mapē `/data/services/nosketch/corpora/vert`
4. Parkompilē katru no atjauninātajiem korpusiem ar komandu `cd /data/services/nosketch && sudo docker compose exec nosketch compilecorp --recompile-corpus --no-sketches korpusa_vārds`
5. Paskatās, vai komandrindā/logfailos nav kas acīmredzami slikts.
