#!/bin/bash

case "$OSTYPE" in
  linux*)   OSTYPE="linux" ;;	
  darwin*)  OSTYPE="mac" ;;
  *)        echo "unknown OS: $OSTYPE DETECTED" && echo "please submit a ticket om github?" && sleep 30 && exit ;;
esac

if [[ $(which sideload) != *"sideload"* ]]; then
   echo ''
   echo 'Please globally install the sideloader first from https://github.com/whitewhidow/quest-sideloader-linux'
   echo ''
   read -p "Press enter to close"
   exit 1
fi


#if [[ $(which sideload-update) == *"sideload-update"* ]] && [ "$RANDOM" -lt 15276 ] &&; then
#	zenity --question --width=800 --text="Would you like to check for updates? (and/or new mount config(s))"
#	if [ $? = 0 ]; then
#		exec sideload-update
#	fi
#fi

echo "Checking zenity installation."
if [ -z $CI ] && [[ $(which zenity 2> /dev/null) != *"zenity"* ]]; then
  echo "Installing zenity."
  (sudo apt install zenity > /dev/null 2> /dev/null || brew install zenity > /dev/null 2> /dev/null) && echo "zenity installed."
else
  echo "Zenity installation found."
fi



FOLDER=$HOME
[ -z $CI ] && zenity --question --width=800 --text="Would you like to browse the drive directly? [!BETA!]"
if [ $? = 0 ]; then

    echo "Attempting to serve the mount, Please wait."
    nohup whitewhidow-mount "/tmp/mnt" fromgui </dev/null >/dev/null 2>&1 &
    FOLDER="/tmp/mnt/"
    
    	x=1
	while [ $x -le 5 ] && [ -z $MOUNTSUCCESS ]
	do
	  echo "Checking if drive is mounted (attempt $x/5)"
	  sleep 3
	  x=$(( $x + 1 ))
	  if [ "$(ls -A $FOLDER)" ]; then
	  	MOUNTSUCCESS=true
	  fi
	done

	if [ ! -z $MOUNTSUCCESS ]; then
	  	zenity --info --text="\n\n Cloud is mounted at: $FOLDER ($(ls -A $FOLDER | wc -l) folders available)\n\n" --width="600" 
	else
		ERRORTEXT="\nERROR\n\nSomething is wrong, the drive mount seems to be missing or empty.\nIf you post the output of the terminal window to www.github.com/whitewhidow/quest-sideloader-linux, I will be happy to help.\n\nYou can still use 'sideload-gui' to sideload apps you have manually downloaded\n\n"
		if [ $OSTYPE == "mac" ]; then
			ERRORTEXT+="[NOTE] Since are on OSX, make sure you have OSXFUSE installed.\nrun 'brew cask install osxfuse' or go to https://osxfuse.github.io/ (this requires reboot, which is why we dont automate this)\n\n"
		fi
		zenity --warning --text="$ERRORTEXT" --width="600"
	fi
    
else
    if [ "$(ls -A /tmp/mnt)" ]; then
        zenity --info --text="\n\n Wait, the Cloud is actually already to mounted at: $FOLDER ($(ls -A $FOLDER | wc -l) folders available)\n\n" --width="600" 
        FOLDER="/tmp/mnt/"
    fi
fi





cd "$FOLDER"
while [ -z $CI ] && true; do
	FOLDER=$(zenity  --file-selection --title="Please navigate to an (single) app location and click [OK]"  --directory --filename="$FOLDER" )
	[[ -z $FOLDER ]] && break;
	[ $? -eq 0 ] && break;

	cd "$FOLDER"
	APKCOUNT=$(ls -t | grep .apk | wc -l)	
	APKCOUNT=$(echo "$APKCOUNT" | sed 's/^[[:space:]]*//')
	echo "APKcount in $FOLDER: $APKCOUNT"
	if [[ $APKCOUNT == 1 ]]; then

		zenity --question --width=800 --text="Do you want to install the apk found in \"$(echo "$FOLDER" | sed -e 's/\\/\\\\/g' -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g')\" ?"
		if [ $? = 0 ]; then
		    echo '' > /tmp/sideload.log
		    sideload | tee /tmp/sideload.log
    		    #RESULT=$(cat /tmp/sideload.log | sed -e 's/\\/\\\\/g' -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' | tr '' '\n' | tail -n +2)
		    #zenity --info --width=800 --text="$(echo $RESULT| tr '' '\n' | tail -n +2)"
		    ISSUETEXT="If the sideload encoutered any issues, please provide me with the content of '/tmp/sideload.log' at \nhttps://github.com/whitewhidow/quest-sideloader-linux/issues
"
		    zenity --info --width=800 --text="The sideload process seems to have finished, please inspect the output in the terminal window for any errors.\n\n$ISSUETEXT"
		    echo -e "\nThe sideload process seems to have finished, please inspect the output above for any errors."
    		    echo -e "\n$ISSUETEXT"
		    echo -e ''
		    read -p "Press enter to sideload another app. or CTRL+C to close the sideloader."
		    continue
		else
		    echo -ne ''
		    cd ..
		fi
	elif [[ $APKCOUNT == 0 ]]; then
  		zenity --info --width=800 --text="No APK found in \"$FOLDER\"\nPlease select a single app directory."	
	elif [[ $APKCOUNT > 1 ]]; then
  		zenity --info --width=800 --text="Too many PKA's found in \"$FOLDER/*\"\nPlease select a single app directory."
	fi
done


echo "You may close me now!"
[ -z $CI ] && sleep 300
exit

