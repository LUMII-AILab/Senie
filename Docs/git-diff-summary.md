Ja ir nepieciešams noskaidrot, kuri faili ir mainījušies ilgā laika posmā, noder šāda git komanda:
`git diff -l 5000 --output=diff_result.txt --stat=300 --compact-summary 414d408...51d8739`,
kur `414d408` un `51d8739` ir salīdzināmie _commit_ un 300 ir failu vārdu kolonnas maksimālais garums.