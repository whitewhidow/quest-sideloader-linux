#!/bin/bash
if [ -z "$1" ]; then
  FOLDER=$PWD
  echo "Enter a folder or mount location."
  echo "Or leave blank to start at $PWD"
  read FOLDER
  if [ -z "$FOLDER" ]; then
    FOLDER=$PWD
  fi
else 
  FOLDER=$1
fi



if [[ $(which sideload) != *"sideload"* ]]; then
   echo ''
   echo 'Please globally install the sideloader first from https://github.com/whitewhidow/quest-sideloader-linux'
   echo ''
   read -p "Press enter to close"
   exit 1
fi
if [[ $(which zenity) != *"zenity"* ]]; then
   echo ''
   echo 'Please globally install zenity first'
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




cd $FOLDER
echo "fetching data..."


	while true; do
	Array=( "."/* )
	    Option=$(zenity --list --title="Browser for whitewhidow/quest-sideloader-linux" --text="Please browse to an (single) app location" \
		--ok-label "Select" --cancel-label "Exit" \
		--width=800 --height=600 --column="Filename" "${Array[@]}" "../"  2>/dev/null)
	    [[ "$Option" == "" ]] && break
	    [[ "$Option" == "../" ]] && cd ..
	    if [[ "$Option" != "../" ]]; then
		   #echo "Option: $Option"
		   echo "fetching data from drive"
		   cd "$(echo $Option| cut -c 3-)"
		   APKCOUNT=$(ls | grep .apk | wc -l)
		   
		   if [ $APKCOUNT == 1 ]; then
		   	zenity --question --width=800 --text="Try to install $Option ?"
			if [ $? = 0 ]; then
			    sideload
			    echo "The sideload process seems to have finished, please inspect the output aobe for any errors, you may now close this window."
			    exit
			else
			    echo -ne ''
			    cd ..
			fi
		   fi
	    fi	     	      
	done


exit
