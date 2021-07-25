#!/usr/bin/bash

## Tulostaa tiedostot kansiossa numero järjestykseen ja antaa niille ID3 tagit
## Luo kansio Albumin/Artistin nimellä ja cd sinne siirretyäsi mp3 tiedostot sen alle
## Suorita skripti

lista=`ls -l|grep '.mp3'|wc -l`
n=0
kansio=${PWD##*/}  

if ! [ -z "$1" ] 
then
	kansio=$1
	mkdir "$1"
	mv -- *"$kansio"* "$kansio/" 
	cd "$kansio"
fi

for f in *.mp3 ; do
	n=$(( $n + 1 )) 
	IFS="." read -ra nimi <<< "$f"
	mp3info "$f" -l "$kansio" -t "$nimi" -n "$n" -a "$kansio" -y 2021 -g 55
	mv -- "$f" "0$n. $f" ;
done

echo "All files converted"
