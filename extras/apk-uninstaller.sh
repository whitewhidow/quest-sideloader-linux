#!/bin/bash

echo "UNFINISHED"
exit 1

APKS="
asdadsasd
das.dasd
ffff
aas.dasd.asdasd.
"

options_file=$(options_file 2>/dev/null) || options_file=/tmp/options$$   

COUNTER=1
for file in $APKS; do
    trimmed=$(echo $file | xargs)
    echo "$COUNTER $trimmed" >> $options_file;
    #echo $file
    COUNTER=$((COUNTER+1)); 
    # your code here
done


options=$(cat $options_file)
  
choice_file=$(choice_file 2>/dev/null) || choice_file=/tmp/choice$$   
dialog --no-cancel --menu "Selet apk:" 1000 1000 10 $options  2> $choice_file

cat $options_file | sed "$(cat $choice_file)q;d" | sed "s/$(cat $choice_file) //g"

