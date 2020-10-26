#!/bin/bash
#$IFS=$'\n'


if [[ $(which sideload) != *"sideload"* ]]; then
   echo ''
   echo 'Please globally install the sideloader first from https://github.com/whitewhidow/quest-sideloader-linux'
   echo ''
   read -p "Press enter to close"
   exit 1
fi

echo "Checking zenity."
if [[ $(which zenity) != *"zenity"* ]]; then
  echo "Installing zenity."
  (sudo apt install zenity > /dev/null 2> /dev/null || brew install zenity > /dev/null 2> /dev/null) && echo "zenity installed."
fi



FOLDER=$HOME
zenity --question --width=800 --text="Would you like to browse our drive? (will start rclone and mount)"
if [ $? = 0 ]; then
    nohup whitewhidow-mount "/tmp/mnt" &
    sleep 2
    FOLDER="/tmp/mnt/"
else
    echo -ne
fi
cd "$FOLDER"
while true; do
	#FOLDER=$PWD
	FOLDER=$(zenity  --file-selection --title="Please navigate to an (single) app location and click [OK]"  --directory --filename="$FOLDER" )
	#FOLDER=$(ls -t |sed '1s/^/Need all apps ? -> https\:\/\/t.me\/whitewhidow_q2_working \n/'|sed '$ a ../' | zenity --list --title="Browser for whitewhidow/quest-sideloader-linux" --text="Please browse to an (single) app location" \
	#--ok-label "Select" --cancel-label "Exit" \
	#--width=800 --height=600 --column="Filename"  2>/dev/null)
	echo "Navigating to $FOLDER"
	[[ "$FOLDER" == "" ]] && break;
	[[ -z $FOLDER ]] && break;
	[[ "$FOLDER" == *".." ]] && cd .. && continue;
	[ $? -eq 0 ] && break;


	cd "$FOLDER"
	APKCOUNT=$(ls -t | grep .apk | wc -l)	
	APKCOUNT=$(echo "$APKCOUNT" | sed 's/^[[:space:]]*//')
	echo "APKcount in folder: $APKCOUNT"
	if [[ $APKCOUNT == 1 ]]; then

		zenity --question --width=800 --text="Do you want to install the apk found in \"$FOLDER\" ?"
		if [ $? = 0 ]; then
		    sideload
		    echo "The sideload process seems to have finished, please inspect the output above for any errors, you may now close this window."
		    read -p "Press enter to resume ..."
		    continue
		else
		    echo -ne
		    cd ..
		fi
		
	elif [[ $APKCOUNT > 1 ]]; then
  		zenity --info --width=800 --text="Too many PKA's found in \"$FOLDER\"\nPlease select a single app directory."
	fi
done

exit

