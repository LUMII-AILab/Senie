Kā pārtaisīt Word tabulu par perl substitūciju datu struktūru
-------------------------------------------------------------

Pārbaudīts ar _Sublime Text Build 4200_.

1.  Izkopēt kolonnas "Unicode", "Transliterācija", "Reģistrjūtība" _tab-separated_ formā uz _Sublime Text_ redaktoru.
2.  Pārskatīt izmest `[]` no 2. kolonnas, regulārā izteiksme: `^[^\r\n]*\t[^\r\n]*\[\]`,
    pārskatīt `[]` vārda vidū, regulārā izteiksme: `(\p{alpha}|[\p{punct}|\\)\[\](\p{alpha}|[\p{punct}|\\)`,
    pārskatīt atstarpes pirms un pēc `[]`, regulārā izteiksme `\[\] | \[\]`,
    pārskatīt `{` un`}`;
    kopējā izteiksme: `^[^\r\n]*\t[^\r\n]*\[\]|(\p{alpha}|\p{punct}|\\)\[\](\p{alpha}|\p{punct}|\\)|{|}|\[\] | \[\]` (_Sublime Text_) vai `^[^\r\n]*\t[^\r\n]*\[\]|(\p{L}|\p{P}|\\)\[\](\p{L}|\p{P}|\\)|{|}|\[\] | \[\]` rīkiem, kam ir standarta unikoda klašu atbalsts
5.  Azvietot kā tekstu:  `[]` -> `\b{wb}`
6.  Pārskatīt atlikušās kvadrātiekavas (atstāt `[^]`, kas iezīmē rindas sākumu, un `[$]`, kas beigas), izlabot kļūdas
7.  Aizvietot kā tekstu: `	` -> `', '`
8.  Aizvietot kā izteiksmi:  `$` -> `' ],`
9.  Aizvietot kā izteiksmi:  `^` -> `[ '`
10. Aizvietot kā tekstu: ` ''` -> 
11. Aizstāt `[^]`, `[$]` (izteiksme: `\[[$^]\]`), ielikt attiecīgo rindas beigās komentārus
    `	# Rindas beigas` un `	# Rindas sākums`
12. Pārbaudīt, vai nav kaut kur ` ',`, t.i., atstarpe aiz vārda un vai nav kaut kur `[,`, t.i., bijis lieks pārnesums tabulā, pārbaudīt atstarpes aiz 1 un blakus esošus komatus, kopējā izteiksme: ` ',|1 '|\[,|,,`
13. Noņemt beigās tukšās rindas.
14. Pārskatīt palīgmaiņas un specsimbolu lietojumu:
    pielikt attiecīgo rindu beigās komentārus `	# Palīgmaiņa`, `	# Palīgmaiņas lietošana` un `	# Palīgmaiņas novākšana`,
    un pielikt atsoļa slīpsvītru, ja palīgmaiņas simbols ir speciāls un lietots pirmajā kolonnā.
    Līdz šim fiksētie substitūciju simboli: `[#$%&*©Δ®§+@◊]`,
    pārskatāmais saraksts (ieskaitot specsimbolus un 0 reģistra kolonnā):
    `[#$%&*©®Δ§+@◊0.()?\/^|]|\[^b]|''`

15. Iegūto tabulu iekopēt failā `LvSenie/Translit/SimpleTranslitTables.pm` attiecīgās kolekcijas (`$TABLES_SINGLES` viena faila avotiem, bet `$TABLES_Apokr1689`, `$TABLES_JT1685` vai `$TABLES_VD1689_94` Bībeles daļām) vārdnīcā (_hash_) kā sarakstu ar atslēgu, kas atbilst avota kodam elementu, t.i., `avota_kods => [iegūtā_tabula], `.

16. Ar IDEs palīdzību pārbaudīt, vai kaut kur nevajag pielikt atsoļa slīpsvītras pirms apostrofiem vai pēdiņām.


Testējot neaizmirst savākt atbilstošo `*_Unicode_unhyphened.txt` no `Sources` un nolikt pareizajā datu mapītē (sk. `runFileCollector-sample.bat`).

