#!/bin/bash
if [ -z "$1" ]; then
  echo "Please provide an ftp mount as the first argument"
  exit
else 
  DRIVEMOUNT=$1
fi

if [[ $(which sideload) != *"sideload"* ]]; then
   echo ''
   echo 'Please globally install the sideloader first from https://github.com/whitewhidow/quest-sideloader-linux'
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
fi




cd $DRIVEMOUNT

echo $PWD

echo "fetching data from drive"




while :
do
options=( "."/* )
echo "Please select an option below:"

	select option in "${options[@]}" "quit"; do
	  case $option in
	    *)
	      echo "fetching data from drive"
	      cd "$(echo $option| cut -c 3-)"
	      APKCOUNT=$(ls | grep .apk | wc -l)
	      sleep 1
	      if [ $APKCOUNT == 1 ]; then
	        sideload
	      fi
	      break
	      ;;
	  esac
	done
done



exit
