# Seno tekstu apstrādes skriptu izsaukumu piemēri

NB. Korpusa avotfailos tiek izmantota domēnspecifiskā valoda (DSL), kurā izmantoti divu veidu marķējumi:
- kļūdas marķējums formā `labojums{oriģināls}` (`oriģināls` var būt tukšs, ja `labojums` ir no jauna pievienots vārds), un
- teksta segmentu marķējumi formā `@x{marķētais teksta segments}`. Visu `x` vietā izmantojamo kodu skaidrojumi pieejami `/Docs/SENIE-DSL-kodi.xlsx`.

Reālās lietošanas plūsmas skatīt `/Docs/jaunu-avotu-pievienoshana.md` un `/Docs/kaa-paargjenereet-repo-datus.md`

_perl_ karodziņš `-I` norāda, kur meklēt izpildāmo programmu, šeit lietotais `-I.` pieņem, ka izpildīšana notiks, atrodoties mapē `/Unicoding`. Karodziņš `-CS` piespiež `STDIN`, `STDOUT` un `STDERR` plūsmās drukāt unikodā.

Priekšnosacījumi:
- Simbolu apkopotājam vajag _perl_ bibliotēku `Unicode::Semantics`



## 18.~gs. pilotkonvertors

- Palaišana atsevišķam vienkārša teksta failam
```
perl -I. -e "use LvSenie::Translit::Transliterator qw(process18thCentFile); process18thCentFile(@ARGV)" test.txt
```
- Palaišana atsevišķam Senie korpusa DSL failam
```
perl -I. -e "use LvSenie::Translit::Transliterator qw(process18thCentFile); process18thCentFile(@ARGV)" StendGF1774_AGG_Unicode_unhyphened.txt StendGF1774_AGG_Unicode_translitered.txt 1
```



## Apkopošana

### Failu apkopotājs tālākai apstrādei (`FileCollector`)

Otrajam parametram jāsatur pilns infikss pēc kura atlasīt failus – pilna virkne ar visu starp avota kodu, piemēram, `Baum1699_LVV` and faila paplašinājumu `.txt`, izņemot ievadošo apakšsvītru.

#### Darbināšana pilnam korpusam

**Plakanā apkopošana**: šie piemēri savāks visu korpusa saturu un sadalīs mapītēs `data`, `data-VD1689_94`, `data-JT1685`, `data-Apokr1689`.

- `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode_unhyphened` (atpārnesumotie unikodi)
- `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 Unicode` (oriģinālie unikodi)
- `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)"` (oriģinālie pirmsunikoda faili)
- `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" 0 unhyphened_full` (pilni atpārnesumotie pirmsunikoda faili, t.i., bez svešvalodu daļu izlaišanas)

**Hierarhiskā apkopošana**: šie piemēri savāks visu korpusu saturu un sakārtos mapju struktūrā atbilstoši tam, kā ir `/Sources` mapē.

- `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" 0 Unicode_unhyphened` (atpārnesumotie unikodi)
- `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)" 0 Unicode` (oriģinālie unikodi)
- `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectNested); collectNested(@ARGV)"`  (oriģinālie pirmsunikoda faili)

#### Darbināšana apkopošanai pēc "baltā" saraksta

Parametri ir "baltā" saraksta atrašanās vieta un apkopojamo failu infikss.
- `perl -I. -e "use LvSenie::Utils::FileCollector qw(collectFlat); collectFlat(@ARGV)" "..\Specs\Subcorpora\LVVV.txt" Unicode_unhyphened`


### Lietoto DSL kodu apkopotājs (`CodeCollector`)

Šie piemēri savāks visus izmantotos DSL kodus no plakani apkopotiem oriģinālfailiem, pirmais parametrs kodējums, pārējie – datu mapes.
- `perl -I. -e "use LvSenie::Utils::CodeCollector qw(collect); collect(@ARGV)" UTF-8 data data-VD1689_94`
- `perl -I. -e "use LvSenie::Utils::CodeCollector qw(collect); collect(@ARGV)" cp1257 data data-JT1685 data-VD1689_94 data-Apokr1689`


### Lietoto Unicode simbolu apkopotājs (`SymbolCollector`)

Lietošana vienam failam, parametri secīgi ir datu mape, faila nosaukums un kodējums.
- `perl -I. -e "use LvSenie::Utils::SymbolCollector qw(countInFile); countInFile(@ARGV)" data Elg1621_GCG_Unicode.txt UTF-8`
- `perl -I. -e "use LvSenie::Utils::SymbolCollector qw(countInFile); countInFile(@ARGV)" data Fuer1650_70_1ms.txt cp1257`

Lietošana vienai vai vairākām mapēm, parametri secīgi ir "kur likt rezultātu", kodējums un plakani apkopotas darba mapes.
- `perl -I. -e "use LvSenie::Utils::SymbolCollector qw(countInDirs); countInDirs(@ARGV)" . UTF-8 data`
- `perl -I. -e "use LvSenie::Utils::SymbolCollector qw(countInDirs); countInDirs(@ARGV)" . UTF-8 data data-Apokr1689 data-JT1685 data-VD1689_94`


### Veco indeksu apkopotājs (`StatsCollector`), novecojis?

Lietošana `/Sources` mapei, parametri secīgi ir apstrādājao failu kodējums un norāde uz `/Sources` mapi.
- `perl -I. -e "use LvSenie::Utils::StatsCollector qw(count); count(@ARGV)" cp1257 ../Sources`



## Unikodificēšana

### DSL failu unikodificēšana atbilstoši iekļautajām tabulām (`Unicodifier`)

Par jaunas tabulas pievienošanu skatīt `/Unicoding/Docs/add-translit-table-from-word_readme.md`.

Darbināšana atsevišķiem failiem, parametri ir datu mape un vai nu avota kods vai avota un kolekcijas kodi Bībeles daļām.
- `perl -I. -e "use LvSenie::Unicode::Unicodifier qw(transformFile); transformFile(@ARGV)" data Baum1699_LVV`
- `perl -I. -e "use LvSenie::Unicode::Unicodifier qw(transformFile); transformFile(@ARGV)" data-Apokr1689 Sal Apokr1689`

Darbināšana plakani apkopotām mapēm, parametri ir datu mape un kolekcijas kods, ja datu mape atbilst kolekcijai.
- `perl -I. -e "use LvSenie::Unicode::Unicodifier qw(transformDir); transformDir(@ARGV)" data` (ārpuskolekciju avotiem)
- `perl -I. -e "use LvSenie::Unicode::Unicodifier qw(transformDir); transformDir(@ARGV)" data-VD1689_94 VD1689_94` (Vecajai Derībai)
- `perl -I. -e "use LvSenie::Unicode::Unicodifier qw(transformDir); transformDir(@ARGV)" data-JT1685 JT1685` (Jaunajai Derībai)
- `perl -I. -e "use LvSenie::Unicode::Unicodifier qw(transformDir); transformDir(@ARGV)" data-Apokr1689 Apokr1689` (Apokrifiem)


### Vārdnīcas XML unikodificēšana (`DictUnicodifier`, vienreizlietojams)

- `perl -I. -e "use LvSenie::Unicode::DictUnicodifier qw(transformDictionary); transformDictionary(@ARGV)" lvvv.xml`



## Atpārnesumošana

- Apstrāde atsevišķiem failiem, parametr ir darba mape, avota kods, apstrādājamā faila nosaukums un kodējums
`perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformFile); transformFile(@ARGV)" data Braum1699_LVV Baum1699_LVV_Unicode.txt UTF-8`

- Apstrāde plakani apkopotām unikoda mapēm, parametri ir mape, kodējums un atlasāmo failu infikss
```
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data UTF-8 Unicode
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 UTF-8 Unicode
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT1685 UTF-8 Unicode
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 UTF-8 Unicode
```

- Apstrāde plakani apkopotām pirmsunikoda formāta (Win1257) mapēm, parametri ir mape, kodējums, atlasāmo failu infikss (0, ja nav) un rezultātfailam pievienojamais papildu infikss (t.i., rezultāts būs, piemēram, `Baum1699_LVV_unhyphened_full.txt`)
```
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data cp1257 0 _full
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 cp1257 0 _full
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-JT1685 cp1257 0 _full
perl -I. -e "use LvSenie::Utils::Dehyphenator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 cp1257 0 _full
```



## Transliterēšana

- Apstrāde vienam failam ar noklusēto iekļauto tabulu
`perl -I. -e "use LvSenie::Translit::Transliterator qw(transformFile); transformFile(@ARGV)" data 0 Br1520_PN`

- Apstrāde vienam failam, bet ar 18.~gs. pilotkonvertora tabulu
`perl -I. -e "use LvSenie::Translit::Transliterator qw(transformFile); transformFile(@ARGV)" data 18TH_CENTURY Lop1800_SDLS`

- Apstrāde plakani apkopotām mapēm ar noklusētajām tabulām
```
perl -I. -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data 0
perl -I. -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-VD1689_94 0 VD1689_94
perl -I. -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-JT1685 0 JT1685
perl -I. -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data-Apokr1689 0 Apokr1689
```
- Apstrāde plakani apkopotai mapei, bet 1r 18.~gs. pilotkonvertora tabulu
`perl -I. -e "use LvSenie::Translit::Transliterator qw(transformDir); transformDir(@ARGV)" data 18TH_CENTURY`



## Publicēšana

### Avotu failu sagatavošana publicēšanai (`PublishingFileGenerator`)

#### Apstrāde atsevišķiem failiem (bet parasti šito nevienam nevajag, sk. nākamo sadaļu)
Parametri ir datu mape, apstrādājamais fails, kodējums, vai taisīt VERT (0/1), vai taisīt HTML (0/1), vai taisīt TEI (0/1), vai taisīt SQL (0/1)
- `perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processFile); processFile(@ARGV)" data Elg1621_GCG_Unicode_unhyphened.txt UTF-8`
- `perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processFile); processFile(@ARGV)" data Fuer1650_70_1ms_unhyphened.txt cp1257`

#### Apstrāde mapēm 
Mapēm jābūt plakani apkopotām, parametri ir, kur likt rezultātu, kodējums, vai taisīt VERT (0/1), vai taisīt HTML (0/1), vai taisīt TEI (0/1), vai taisīt SQL (0/1), vai translaterēt (0/1), apstrādājamo mapju uzskaitījums.

**VERT**

- VERT bez transliterācijas (publicēšanai SkE labāk lietot atpārnesumotos unikoda failus)
`perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
- VERT bez transliterācijas no pirmsunikoda failiem (labāk lietot jauno _perl_ atpārnesumotāju, t.i., failus `unhyphened_full`, nevis veco _Java_) `perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 1 0 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
- VERT ar transliterāciju (jālieto atpārnesumotie unikoda faili).
`perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 1 0 0 0 1 data data-Apokr1689 data-JT1685 data-VD1689_94`

**HTML** (novecojis)

- HTML bez transliterācijas (publicēšanai labāk lietot failus ar oriģinālo dalījumu pārnesumos)
`perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 1 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
- HTML bez transliterācijas no pirmsunikoda failiem (publicēšanai labāk lietot failus ar oriģinālo dalījumu pārnesumos)
`perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . cp1257 0 1 0 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
- HTML ar transliterāciju (jālieto atpārnesumotie unikoda faili).
`perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 1 0 0 1 data data-Apokr1689 data-JT1685 data-VD1689_94`

**TEI**

- TEI bez transliterācijas (unikoda vai atpārnesumotiem unikoda failiem)
`perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 1 0 0 data data-Apokr1689 data-JT1685 data-VD1689_94`
- TEI ar transliterāciju (jālieto atpārnesumotie unikoda faili).
`perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 1 0 1 data data-Apokr1689 data-JT1685 data-VD1689_94`

**SQL**

- SQL importa skriptu pagatavošana (unikoda faili ar oriģinālo dalījumu)
`perl -I. -e "use LvSenie::Publishing::PublishingFileGenerator qw(processDirs); processDirs(@ARGV)" . UTF-8 0 0 0 1 0 data data-Apokr1689 data-JT1685 data-VD1689_94`


### Metadatu pārveide SQL

- `perl -I. -e "use LvSenie::Publishing::MetadataSql qw(processMetadataFile); processMetadataFile(@ARGV)" `

