#!/bin/bash

function updatelocal() {
#(
  echo '' > "$ORIPATH/badgelist.txt"
  COUNT=0
  ALLCOUNT=$(ls -l | grep "^d" | wc -l)
  for d in ./*; do
    ((COUNT++))
    PERCENT=$(awk "BEGIN {print int(100/$ALLCOUNT*$COUNT)}")
    if [[ -d "$d" ]]; then
      cd "$d"
      rm -r ./*-version.txt
      if [ ! "$(ls -la ./*-version.txt 2> /dev/null )" ]; then
        echo -e "Generating for $d\n"
        APKNAME=$(ls -t | grep -e "./*\.apk") && APKNAME=${APKNAME#/}
        #echo -e "AAPKNAME: $APKNAME \n\n"

        pv "$APKNAME" > "/tmp/$APKNAME"
        echo "transfer done, now badging"
        BADGING=$(aapt dump badging "/tmp/$APKNAME")
        rm "/tmp/$APKNAME"
        #sleep 10
        PACKAGEVERSION=$(echo "$BADGING" | grep versionCode= | sed -E "s/.*Code='(.*)' version.*/\1/")
        PACKAGENAME=$(echo "$BADGING" | grep package:\ name | awk '/package/{gsub("name=|'"'"'","");  print $2}')
        #echo "ectracted packageversin $PACKAGEVERSION \n"
        #echo "now writing"
        echo "# synced from without badgefile:$PACKAGENAME ($COUNT / $ALLCOUNT)"

        echo "$PACKAGENAME|$PACKAGEVERSION|$d/$APKNAME" > "$PACKAGENAME-version.txt"
        echo "$PACKAGENAME|$PACKAGEVERSION|$d/$APKNAME" >> "$ORIPATH/badgelist.txt"

        echo "$PERCENT"

      else
        echo "skipping $d\n"

        APKNAME=$(ls -t | grep -e "./*\.apk") && APKNAME=${APKNAME#/}
        FILE=$(ls -t *-version.txt 2> /dev/null )
        PACKAGENAME=$(echo "$FILE" | sed -e 's/\/\(.*\)-version/\1/'  | rev | cut -c13- | rev)
        echo "# synced from remote badgefile:$PACKAGENAME ($COUNT / $ALLCOUNT)"
        if [ "$PACKAGENAME" != "" ]; then
                echo "$PACKAGENAME|$(cat "$FILE")|$d/$APKNAME" >> "$ORIPATH/badgelist.txt"
        fi
        #cat "$(ls -t *_version.txt 2> /dev/null )"
        echo "$PERCENT"
      fi
      cd ../
    fi
  done


  cp "$ORIPATH/badgelist.txt" /tmp/mnt 2> /dev/null

  #) |
  #zenity --progress \
    --title="Updating badgelist.txt" \
    --text="Please wait" \
    --percentage=0


}







ORIPATH=$PWD
cd /tmp/mnt









  [ -z $CI ] && zenity --question --width=800 --text="Update and use local versionlist? ($(date -r "$ORIPATH/badgelist.txt" +"%Y-%m-%d %H:%M:%S")) ($(cat "$ORIPATH/badgelist.txt" | wc -l) items)\n\n
  If not we will use the remote one from ($(date -r "/tmp/mnt/badgelist.txt" +"%Y-%m-%d %H:%M:%S")) ($(cat "/tmp/mnt/badgelist.txt" | wc -l) items) and copy to local."
   if [ $? != 0 ]; then
	  [ -z $CI ] && cp /tmp/mnt/badgelist.txt "$ORIPATH/badgelist.txt"
	else
	  [ -z $CI ] && updatelocal
  fi

[ ! -z $CI ] && updatelocal

INSTALLEDPACKAGES=$(adb shell cmd package list packages -3|cut -f 2 -d":")

echo -e "CHECKING INSTALLED APPS: \n==========================\n$INSTALLEDPACKAGES\n==========================\n"
echo -e "\nCHECKING DRIVE FOR UPDATES: \n=========================="
#echo "INSTALLED PACKAGES:"
IFS='
'
for line in $INSTALLEDPACKAGES
do
  CHECKED=FALSE
  PACKAGETOCHECK="$line"
  #echo "CHECKING $PACKAGETOCHECK"
  OLDVERSION=$(adb shell dumpsys package $PACKAGETOCHECK)
  regex="versionCode=([0-9]*)"

  [[ $OLDVERSION =~ $regex ]]
  VERSIONTOCHECK=${BASH_REMATCH[1]}
  #echo "${BASH_REMATCH[0]}"
  #echo old version: $VERSIONTOCHECK
  #echo "$line"

  while read badgeline; do
    #echo "checking $line against $PACKAGETOCHECK"
    if [[ "$badgeline" == *"$PACKAGETOCHECK"* ]]; then
      CHECKED=TRUE
      #echo "MATCH"
      APKNAME=${badgeline%%|*}
      APKLOC=${badgeline##*|}
      APKVERSION=${badgeline#*|}
      APKVERSION=${APKVERSION%|*}
      #echo "INSTALLED: $APKNAME"
      #echo "LOCATION ON DRIVE: $APKLOC"
      #echo "VERSION ON DRIVE: $APKVERSION"
      if [[ "$APKVERSION" -gt  "$VERSIONTOCHECK" ]]; then
        echo "[+] NEWER VERSION OF $APKNAME FOUND, CURRENT: ($VERSIONTOCHECK), DRIVE: ($APKVERSION)"
      elif [[ "$APKVERSION" -lt  "$VERSIONTOCHECK" ]]; then
        echo "[-] OLDER VERSION OF $APKNAME FOUND, CURRENT: ($VERSIONTOCHECK), DRIVE: ($APKVERSION)"
      elif [[ "$APKVERSION" -eq  "$VERSIONTOCHECK" ]]; then
        echo "[=] SAME VERSION OF $APKNAME FOUND, CURRENT: ($VERSIONTOCHECK), DRIVE: ($APKVERSION)"
      fi
    fi
    #echo "$line"
  done <"$ORIPATH/badgelist.txt"


done



echo -e "==========================\n"

