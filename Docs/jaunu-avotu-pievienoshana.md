# Jaunu avotu pievienošana
## Jauna pirmsunikoda avota pievienošana

- Avotam jābūt Windows (Baltic) 1257 kodējumā.
- Avota nosaukums satur tikai avota kodu un paplašinājumu `.txt`.
- Metadatu tabulā jāieraksta atbilstošie metadati (saite pieejama _Google Drive_ projekta mapē, rediģējot jāatceras izņemt ķeksi no pēdējās kolonnas).


## Jauna unikoda avota pievienošana

Avotu vai nu ģenerē no pirmsunikoda faila un attiecīgās tabulas, vai arī pievieno pilnīgi no nulles. Pievienojot no nulles:

- Avotam jābūt UTF-8 (without BOM) kodējumā.
- Avota nosaukums satur avota kodu un `_Unicode.txt`.
- Metadatu tabulā jāieraksta atbilstošie metadati (saite pieejama _Google Drive_ projekta mapē, rediģējot jāatceras izņemt ķeksi no pēdējās kolonnas).


# Prasības pārviedojumu tabulām

Tabulai, kas satur pārveidojumu no pirmsunikoda formāta uz unikodu ir jāsatur viena kolonna ar pirmsunikoda simboliem un viena kolonna ar unikoda kodiem.

Tabulai, kas satur transliterāciju, blakusesošās kolonnās jābūt vispirms meklējamajiem simboliem, tad aizvietojamajiem simboliem, un tad reģistrjūtībai. Pirms transliterācijas tabulas ir jāuzskaita specsimboli (ne burti, bet zvaigznītes, punkti, dolārzīmes utt.), ko lietojat substitūcijām vai meklēšanai.

Neviena tabula nedrīkst saturēt tukšas rindas un liekus entersimbolus. Tabulas drīkst saturēt papildus kolonnas labajā vai kreisajā pusē - rindu numurus, piezīmes utt.

Tabulas drīkst būt Word, Excel vai _tab-separated plain text_ formātos.


# Citas tehniskas piezīmes

## Teksta redaktori

Darbam ar jau iepriekš sagatavotiem teksta failiem vēlams lietot kādu no programmētāju teksta redaktoriem nevis _MS Word_, tāpēc ka _Word_ daudzus simbolus aizvieto automātiski ar citiem vizuāli līdzīgiem simboliem. Īsi par divām alternatīvām - _Notepad++_ un _Sublime Text_. Windows datoriem var izvēlēties, kurš labāk patīk, pārējiem datoriem - _Sublime_. Abi šie rīki nodrošina dokumenta atvēršanu jebkurā kodējumā un patiesīgu saglabāšanu pēc labojumiem tajā pašā vai savietojamā kodējumā. Abi rīki lielākoties arī pareizi uzmin, kurā kodējumā ir atvērtais teksta dokuments, taču, ja neuzmin - zemāk aprakstīts, kā to nomainīt.

_**Notepad++**_ var lejuplādēt https://notepad-plus-plus.org/ . Ja atvērtam failam vajag nomainīt kodējumu, to dara izvēlnē _Encoding_, izvēloties _UTF-8_ unikoda failiem un _Character Sets/Baltic/Windows-1257_ pirmsunikoda failiem. Ja nepatīk gaišs teksts uz tumša forna, tad to var nomainīt, izvēlnē _Settings/Preferences/Dark Mode_ uzstādot _Light mode_.

_**Sublime Text**_ var lejuplādēt https://www.sublimetext.com/index2 . Ja atvērtam failam vajag nomainīt kodējumu, to dara izvēlnē _File/Reopen with Encoding_. Tur būs attiecīgi _UTF-8_ un _Baltic (Windows 1257)_. Ja nepatīk gaišs teksts uz tumša fona,
tad to var nomainīt izvēlnē _Preferences/Select Color Scheme_, izvēloties _Breakers_, _Celeste_ vai _Sixteen_.

## Eksports no MS Word

Ja no `.docx` vai kāda cita dokumenta ir nepieciešams ar Word eksportēt tekstu, tad to dara _File/Save As_, tad izvēlās vēlamo mapi un faila vārdu, lodziņā _Save as Type:_ norāda _Plain Text (*.txt)_ un spiež _Save_. Pēc tam logā _File Conversion_ izvēlas _Other Encoding_ un _Unicode (UTF-8)_ vai _Baltic (Windows)_ atkarībā no iegūstamā dokumenta veida (attiecīgi unikoda un pirmsunikoda). Glabājot _Baltic (Windows)_ ir īpaši svarīgi sekot līdzi brīdinājumiem par simbolu neattēlojamību (piemēram, paziņojumam _Text marked in red will not save correctly in the chosen encoding_), un izlabot nepiemērotos simbolus uz citiem, kas ļauj saglabāt failu pareizi.

## Windows 1257 pieejamie simboli

Visu Windows 1257 simbolu uzskaitījums pieejas https://lv.wikipedia.org/wiki/Windows-1257 . Redzamie neatstarpju simboli ir šādi:
```
! " # $ % & ' ( ) * + , - . /
0 1 2 3 4 5 6 7 8 9 : ; < = > ?
@ A B C D E F G H I J K L M N O
P Q R S T U V W X Y Z [ \ ] ^ _
` a b c d e f g h i j k l m n o
p q r s t u v w x y z { | } ~ 
€ ‚ „ … † ‡ ‰ ‹ ¨ ˇ ¸
‘ ’ “ ” • – — ™ › ¯ ˛ 
 ¢ £ ¤ ¦ § Ø © Ŗ « ¬ ® Æ
° ± ² ³ ´ µ ¶ · ø ¹ ŗ » ¼ ½ ¾ æ
Ą Į Ā Ć Ä Å Ę Ē Č É Ź Ė Ģ Ķ Ī Ļ
Š Ń Ņ Ó Ō Õ Ö × Ų Ł Ś Ū Ü Ż Ž ß
ą į ā ć ä å ę ē č é ź ė ģ ķ ī ļ
š ń ņ ó ō õ ö ÷ ų ł ś ū ü ż ž ˙
```