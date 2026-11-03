# Repozitorija un saistīto serveru datu pārģenerēšana

Windows komandrindā `chcp 65001` var noderēt, ja kļūdu paziņojumi neizskatās smalki. _perl_ karodziņš `-CS` var palīdzēt terminālī paziņojumus drukāt unikodā.


## Ja ir mainījušies unikodi

Mainītos unikodus saliek atbilstošajās `/Sources` mapēs pirms tālākas darbošanās.


### Vajag pārģenerēt simbolu tabulu

1. Savāc `/Unicoding` mapē atbilstošos failus ar komandu 
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode`
2. Pārģenerē simbolu tabulas ar komandu
   `perl -I. -e "use LvSenie::Utils::SymbolCollector qw(countInDirs); countInDirs(@ARGV)" . UTF-8 data data-Apokr1689 data-JT1685 data-VD1689_94`
3. Pārvieto `unicode_symbols.txt` uz mapi `/Docs`, bet failus `symbols_full.html` un `symbols.html` uz mapi `/src/main/resources/templates` repozitorijā `Senie-Web`.


### Ja ir labotas formāta kļūdas vai nākuši klāt jauni kodi, vajag atjaunināt kodu tabulu

1. Savāc `/Unicoding` mapē atbilstošos failus ar komandu 
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode`
2. Savāc izmantoto kodu apkopojumu no datu failiem ar komandu
   `perl -I. -e "use LvSenie::Utils::CodeCollector qw(collect); collect(@ARGV)" UTF-8 data data-Apokr1689 data-JT1685 data-VD1689_94`
3. Uzmanīgi manuāli atjaunina tabulu `/Docs/SENIE-kodi.ods`.


### Vajag pārģenerēt atpārnesumotos failus

1. Savāc `/Unicoding` mapē atbilstošos failus ar komandu
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode`
2. Pārģenerē atpārnesumotos failus ar komandām
```
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data UTF-8 Unicode ;\
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 UTF-8 Unicode ;\
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT1685 UTF-8 Unicode ;\
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 UTF-8 Unicode
```
3. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `/Sources`, `/Sources/Apokr1689`, `/Sources/JT1685`, `/Sources/VD1689_94`.


### Vajag atjaunināt transliterāciju teksta failus

1. Savāc mapītē `/Unicoding` apstrādājamos failus ar komandu
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode_unhyphened`
2. Pārģenerē transliterācijas ar komandām
```
perl -I. -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data 0 ;\
perl -I. -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 0 Apokr1689 ;\
perl -I. -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-JT1685 0 JT1685 ;\
perl -I. -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 0 VD1689_94
```
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas, t.sk trūkstošas tabulas.
4. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `/Sources`, `/Sources/Apokr1689`, `/Sources/JT1685`, `/Sources/VD1689_94`.


### Vajag pārģenerēt TEI failus

#### TEI oriģināli

1. Savāc mapītē `/Unicoding` apstrādājamos failus ar komandu
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode`
2. Pārģenerē TEI failus ar komandu
   `perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 1 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas.
4. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `/TEI`, `/TEI/Apokr1689`, `/TEI/JT1685`, `/TEI/VD1689_94`.
5. Failu `all.tei.xml` pārsauc par `SENIE_Unicode.tei.xml` un pārvieto uz mapi `/TEI`.


#### TEI atpārnesumotie

1. Savāc mapītē `/Unicoding` apstrādājamos failus ar komandu
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode_unhyphened`
2. Pārģenerē TEI failus ar komandu
   `perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 1 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
3. Noziņo valodniekiem, ja rezultātu izdrukā parādās kādas problēmas.
4. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `/TEI`, `/TEI/Apokr1689`, `/TEI/JT1685`, `/TEI/VD1689_94`.
5. Failu `all.tei.xml` pārsauc par `SENIE_Unicode_unhyphened.tei.xml` un pārvieto uz mapi `/TEI`.


### Vajag atjaunināt mājaslapu

#### Mājaslapas DB 

1. Savāc mapītē `/Unicoding` apstrādājamos failus ar komandu
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode`
2. Pārģenerē `insert_metadata_autogen.sql` ar komandu
   `perl -I. -e "use LvSenie::Publishing::MetadataSql qw(processMetadataFile); processMetadataFile(@ARGV)"`
3. Pārģenerē `insert_contentlines_autogen.sql` ar komandu
   `perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 0 1 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
4. Izveido apvienoto datubāzes atjaunināšanas failu `update_db_full.sql`, apvienojot šādā secībā:
   4.1. failu `create_tables_for_update.sql` no mapes `/Specs/DB`,
   4.2. failu `insert_metadata_autogen.sql`,
   4.3. failu `insert_contentlines_autogen.sql`.
5. `update_db_full.sql` saarhivē par `update_db_full.sql.gz` un augšuplādē komandrindā vai caur, piemēram, _DBeaver_. Caur _adminer_ augšuplāde mēdz būt pārāk lēna.

Ja izveidoto failu lieto lokālās (vai jebkuras) datubāzes izmainīšanai ar _DBeaver_ (otrais peles taustiņš uz attiecīgās datubāzes, _Tools_ / _Restore database_), tad ielādes brīdī jānorāda papildu parametrs `--default-character-set=utf8mb4` un jālieto nesaarhivētais fails.


#### Mājaslapas lapas

1. Pārliecinās, ka https://github.com/LUMII-AILab/Senie-Web ir jaunākās simbolu tabulas.
2. Pārliecinās, ka app serverī `/data/services/apache/www/data.app.ailab.lv/senie/` ir jaunākie faksimili un bibliogrāfijas.
2. app serverī izpilda `cd /data/services/Senie-Web && ./deploy.sh`


### Vajag atjaunināt NoSke saturu

#### Vert faila ģenerēšana

1. Mapē `/Unicoding` ar savāc apstrādājamos failus ar komandu
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode_unhyphened`
2. Uztaisa pilno vertfailu (ar transliterācijām) ar komandu
   `perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 0 1 data data-Apokr1689 data-JT1685 data-VD1689_94`
3. Apkopo tokenizācijas problēmas un noziņo valodniekiem.
4. Failu `all.vert` pārsauc par `senie_unicode.vert` (agrāk `senie_translit.vert`) un ielādē SkE serverī (sk. pēdējo nodaļu).

Ja otrajā solī lieto komandu
`perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`,
tad iegūst vert failu bez transliterācijas kolonnas.

#### NoSkE atjaunināšana

1. Ja vajag izmainīt, kādi korpusi rādās kā pieejami izvēlnēs http://nosketch.korpuss.lv/ un http://sandbox.nosketch.korpuss.lv/, tad to app serverī var izdarīt atbilstoši `/data/services/nosketch/www/main/run.cgi` un `/data/services/nosketch/www/sandbox/run.cgi`
2. Ja vajag atjaunināt korpusu specifikācijas, tad atbilstošās specifikācijas (ieskaitot apakškorpusu definīciju failus) iekopē no repozitorija mapes `Docs/SketchEngine specs` korpusu servera mapē `/data/services/nosketch/corpora/registry`
3. Jaunos `.vert` failus (sk. pirmās divu nodaļu attiecīgās sadaļas) iekopē korpusu servera mapē `/data/services/nosketch/corpora/vert`
4. Parkompilē katru no atjauninātajiem korpusiem ar komandu `cd /data/services/nosketch && sudo docker compose exec nosketch compilecorp --recompile-corpus --no-sketches korpusa_vārds`
5. Paskatās, vai komandrindā/logfailos nav kas acīmredzami slikts.




## Ja ir mainījušies pre-unikoda faili (GANDRĪZ NOVECOJIS)

Mainītos failus saliek atbilstošajās `/Sources` mapēs pirms tālākas darbošanās.


### Vajag izdarbināt Java skriptu ne-servera daļu, lai pārģenerētu visu, ko tas māk

1. Apkopo izmantojamos failus mapē `/Unicoding` ar komandu
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)`
2. Iegūto mapīti `data` pārkopē uz `Indexing/run`, vajadzības gadījumā pirms tam izdzēšot tur jau esošās `data`, `result-txt`, `result-html` un `result-trash` mapes.
3. Ja nepieciešams, pārkompilē visu Java Seno kodu, un palaiž `PolySENIE.bat` no `/Indexing/run`, lai iegūtu rezultātus. Pagaida dažas minūtes.
4. `Sources` mapē izdzēš visus failus, kas nosaukumā satur `_log.txt`.
5. `result-txt` saturu pārkopē uz `Sources`.
6. `result-html` saturu vairs nelieto.


### Vajag pārģenerēt atpārnesumotos bezizlaidumu failus

1. Mapītē `/Unicoding` ar savāc apstrādājamos failus ar komandu
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)"`
2. Pārģenerē atpārnesumotos bezizlaidumu failus ar komandām
```
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data cp1257 0 _full ;\
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 cp1257 0 _full ;\
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT1685 cp1257 0 _full ;\
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 cp1257 0 _full
```
3. Pārkopē rezultātu failus no mapēm `data/res`, `data-Apokr1689/res`, `data-JT1685/res`, `data-VD1689_94/res` uz attiecīgi `/Sources`, `/Sources/Apokr1689`, `/Sources/JT1685`, `/Sources/VD1689_94`.


### Vajag atjaunināt SkE vertfailu

1. Mapītē `/Unicoding` savāc iepriekšējā solī atpārnesumotos bezizlaiduma failus ar komandu
   `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" unhyphened_full`
2. Uztaisa vert failu ar komandu 
   `perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 1 0 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
3. Pārskata konsoles izdrukas un noziņo valodniekiem tokenizācijas problēmas.
4. Failu `all.vert` pārsauc par `senie_sakotnejs.vert` un ielādē SkE serverī (sk. augstāk).

