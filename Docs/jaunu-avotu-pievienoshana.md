# Jauna pirmsunikoda avota pievienošana

- Avotam jābūt Windows (Baltic) 1257 kodējumā.
- Avota nosaukums satur tikai avota kodu un paplašinājumu `.txt`.
- Metadatu tabulā jāieraksta atbilstošie metadati (saite pieejama _Google Drive_ projekta mapē, rediģējot jāatceras izņemt ķeksi no pēdējās kolonnas).


# Jauna unikoda avota pievienošana

Avotu vai nu ģenerē no pirmsunikoda faila un attiecīgās tabulas, vai arī pievieno pilnīgi no nulles. Pievienojot no nulles:

- Avotam jābūt UTF-8 (without BOM) kodējumā.
- Avota nosaukums satur avota kodu un `_Unicode.txt`.
- Metadatu tabulā jāieraksta atbilstošie metadati (saite pieejama _Google Drive_ projekta mapē, rediģējot jāatceras izņemt ķeksi no pēdējās kolonnas).

# Citas tehniskas piezīmes
## Teksta redaktori

Darbam ar jau iepriekš sagatavotiem teksta failiem vēlams lietot kādu no programmētāju teksta redaktoriem nevis _MS Word_, tāpēc ka _Word_ daudzus simbolus aizvieto automātiski ar citiem vizuāli līdzīgiem simboliem. Īsi par divām alternatīvām - _Notepad++_ un _Sublime Text_. Windows datoriem var izvēlēties, kurš labāk patīk, pārējiem datoriem - _Sublime_. Abi šie rīki nodrošina dokumenta atvēršanu jebkurā kodējumā un patiesīgu saglabāšanu pēc labojumiem tajā pašā vai savietojamā kodējumā. Abi rīki lielākoties arī pareizi uzmin, kurā kodējumā ir atvērtais teksta dokuments, taču, ja neuzmin - zemāk aprakstīts, kā to nomainīt.

_**Notepad++**_ var lejuplādēt https://notepad-plus-plus.org/ . Ja atvērtam failam vajag nomainīt kodējumu, to dara izvēlnē _Encoding_, izvēloties _UTF-8_ unikoda failiem un _Character Sets/Baltic/Windows-1257_ pirmsunikoda failiem. Ja nepatīk gaišs teksts uz tumša forna, tad to var nomainīt, izvēlnē _Settings/Preferences/Dark Mode_ uzstādot _Light mode_.

_**Sublime Text**_ var lejuplādēt https://www.sublimetext.com/index2 . Ja atvērtam failam vajag nomainīt kodējumu, to dara izvēlnē _File/Reopen with Encoding_. Tur būs attiecīgi _UTF-8_ un _Baltic (Windows 1257)_. Ja nepatīk gaišs teksts uz tumša fona,
tad to var nomainīt izvēlnē _Preferences/Select Color Scheme_, izvēloties _Breakers_, _Celeste_ vai _Sixteen_.

## Eksports no MS Word

Ja no `.docx` vai kāda cita dokumenta ir nepieciešams ar Word eksportēt tekstu, tad to dara _File/Save As_, tad izvēlās vēlamo mapi un faila vārdu, lodziņā _Save as Type:_ norāda _Plain Text (*.txt)_ un spiež _Save_. Pēc tam logā _File Conversion_ izvēlas _Other Encoding_ un _Unicode (UTF-8)_ vai _Baltic (Windows)_ atkarībā no iegūstamā dokumenta veida (attiecīgi unikoda un pirmsunikoda). Glabājot _Baltic (Windows)_ ir īpaši svarīgi sekot līdzi brīdinājumiem par simbolu neattēlojamību (piemēram, paziņojumam _Text marked in red will not save correctly in the chosen encoding_), un izlabot nepiemērotos simbolus uz citiem, kas ļauj saglabāt failu pareizi.