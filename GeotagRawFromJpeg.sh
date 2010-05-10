#!/bin/bash
for j in `find . -name *.JPG` 
do

	FILE=`echo $j | cut -f 2 -d "." `
	FILE=".$FILE"
	if [ -f $FILE.NEF ]
	then
		echo $FILE
		IFS=$'\n'
		A=` exiv2 -Pkyv $FILE.JPG  | grep GPSInfo`
		echo -n "" > meta.txt
		for i in $A
		do
			echo "set $i" >> meta.txt 
		done
		exiv2 -m meta.txt $FILE.NEF
		mv $FILE.JPG ./oldjpegs/
	fi
done

