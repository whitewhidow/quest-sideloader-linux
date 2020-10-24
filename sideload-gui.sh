#!/bin/bash



if [[ $(which sideload) != *"sideload"* ]]; then
   echo ''
   echo 'Please globally install the sideloader first from https://github.com/whitewhidow/quest-sideloader-linux'
   echo ''
   read -p "Press enter to close"
   exit 1
fi
if [[ $(which zenity) != *"zenity"* ]] && [[ $(which dialog) != *"dialog"* ]]; then
   echo ''
   echo 'Please globally install zenity OR dialog first'
   echo ''
   read -p "Press enter to close"
   exit 1
fi
if [[ $(which rclone) != *"rclone"* ]]; then
   echo ''
   echo 'Please install rclone and setup an ftpmount'
   echo ''
   #read -p "Press enter to close"
   #exit 1
   # use path such as /run/user/1000/gvfs/ftp:host=localhost,port=3333 to instalntly install stuff
fi


MODE="zenity"
MODE='dialog'




#$(dialog --stdout --title "Please choose a file" --fselect $HOME/ $(expr $LINES - 15) $(expr $COLUMNS - 10))
FOLDER=$HOME
cd $FOLDER
while true; do
        FOLDER=$PWD
        if [[ "$MODE" == "zenity" ]]; then
        	FOLDER=$(zenity  --file-selection --title="Please browse to an (single) app location" --directory --filename="$FOLDER" )
        else
        	FOLDER=$(dialog --stdout --title "Please browse to an (single) app location" --dselect $FOLDER/ 13 60)
        fi
	echo "Navigating to $FOLDER"
       [[ "$FOLDER" == "" ]] && break;
       [[ -z $FOLDER ]] && break;
       [[ "$FOLDER" == *".." ]] && cd .. && continue;
       [ $? -eq 0 ] && break;


	cd "$FOLDER"
	APKCOUNT=$(ls -t | grep .apk | wc -l)	
	echo "count:$APKCOUNT"	   
	if [[ $APKCOUNT == 1 ]]; then
   		if [[ "$MODE" == "zenity" ]]; then
   			zenity --question --width=800 "Do you want to install the apk found in \"$FOLDER\" ?"
   			if [ $? = 0 ]; then
			    sideload
			    echo "The sideload process seems to have finished, please inspect the output above for any errors, you may now close this window."
			    exit
			else
			    echo -ne
			    #cd ..
			fi
		else
			dialog --title "quest-sideloader-linux browser" --yesno --text="Do you want to install the apk found in \"$FOLDER\" ?" 13 60
			if [ $? = 0 ]; then
			    sideload
			    echo "The sideload process seems to have finished, please inspect the output above for any errors, you may now close this window."
			    exit
			else
			    echo -ne
			    cd ..
			fi
   		fi
		
		
		
	elif [[ $APKCOUNT > 1 ]]; then
		if [[ "$MODE" == "zenity" ]]; then
	  		zenity --warning --width=800 "Too many PKA's found in \"$FOLDER\"\nPlease select a single app directory."
	  	else
 		  	dialog --title "quest-sideloader-linux browser" --msgbox "Too many PKA's found in \"$FOLDER\"\nPlease select a single app directory." 13 60
	  	fi
	fi
done

exit

