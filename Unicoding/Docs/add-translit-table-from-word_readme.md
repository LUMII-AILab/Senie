Kā pārtaisīt Word tabulu par perl substitūciju datu struktūru
-------------------------------------------------------------

1.  Izkopēt kolonnas "Unicode", "Transliterācija", "Reģistrjūtība" _tab-separated_ uz _Sublime_.
2.  Pārskatīt izmest `[]` no 2. kolonnas, regex: `^[^\r\n]*\t[^\r\n]*\[\]`,
    pārskatīt `[]` vārda vidū, regex: `(\p{L}|\\)\[\](\p{L}|\\)`,
    pārskatīt `{` un`}`;
    kopējais regex: `^[^\r\n]*\t[^\r\n]*\[\]|(\p{L}|\\)\[\](\p{L}|\\)|{|}`
5.  Replace:  `[]` -> `\b{wb}`
6.  Pārskatīt atlikušās kvadrātiekavas (atstāt `[^]`, kas iezīmē rindas sākumu, un `[$]`, kas beigas), izlabot kļūdas
7.  Replace: `	` -> `', '`
8.  Regexp:  `$` -> `' ],`
9.  Regexp:  `^` -> `[ '`
10. Replace: ` ''` -> 
11. Aizstāt `[^]`, `[$]` (regex: `\[[$^]\]`), ielikt norādes `	# Rindas beigas` un `	# Rindas sākums`
12. Pārbaudīt, vai nav kaut kur ` ',`, t.i., atstarpe aiz vārda un vai nav kaut kur `[,`, t.i., bijis lieks pārnesums tabulā, pārbaudīt atstarpes aiz 1 un blakus esošus komatus, kopējais regex: ` ',|1 '|\[,|,,`
13. Noņemt beigās tukšās rindas.
14. Pārskatīt palīgmaiņas un specsimbolu lietojumu:
    pielikt komentārus `	# Palīgmaiņa`, `	# Palīgmaiņas lietošana` un `	# Palīgmaiņas novākšana`,
    eskeipot, ja palīgmaiņas simbols ir speciāls un lietots pirmajā kolonnā.
    Līdz šim redzētie substitūciju simboli: `[#$%&*©Δ®§+@◊]`,
    pārskatāmais saraksts (ieskaitot specsimbolus un 0 reģistra kolonnā):
    `[#$%&*©®Δ§+@◊0.()?\/^]|\[^b]|''`

15. Iegūto tabulu iekopēt failā `LvSenie/Translit/SimpleTranslitTables.pm` attiecīgās kolekcijas (`$TABLES_SINGLES` viena faila avotiem, bet `$TABLES_Apokr1689`, `$TABLES_JT1685` vai `$TABLES_VD1689_94` Bībeles daļām) vārdnīcā (_hash_) kā sarakstu ar atslēgu, kas atbilst avota kodam elementu, t.i., `avota_kods => [iegūtā_tabula], `.

16. Ar IDEs palīdzību pārbaudīt, vai kaut kur nevajag eskeipot apastrofus vai pēdiņas.


Testējot neaizmirst savākt atbilstošo `*_Unicode_unhyphened.txt` no `Sources` un nolikt pareizajā datu mapītē (sk. `runFileCollector-sample.bat`).

