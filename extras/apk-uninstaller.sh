#!/bin/bash





## DIALOG STUFF
#w=$(xdpyinfo | awk '/dimensions/{print $2}'|cut -f1 -dx); \
#h=$(xdpyinfo | awk '/dimensions/{print $2}'|cut -f2 -dx); \
w=600
h=400

TERMINAL=$(tty) #Gather current terminal session for appropriate redirection
HEIGHT=20
WIDTH=76
CHOICE_HEIGHT=16
BACKTITLE="www.github.com/whitewhidow/quest-sideloader-linux"
TITLE="Quest APK UnInstaller"
## DIALOG STUFF


APKS="
aaaaaa d ada
asdasd adad.sd a.d
adasda da
asdad
"

while [ "$RUN" != "FINISHED" ]; do
	while [ "$CHOICE" != "CONFIRMED" ]; do
		SELECTED=$(echo "${APKS}" | zenity --list  --column="$MENU" --text="Select a package to remove" --width="$w" --height="$h")
		
		if [ -z $SELECTED ]; then
			exit
		fi
		echo $SELECTED

		zenity --question --text="Are you sure you want to remove $SELECTED ?" --width="$w" --height="$h"
		if [ $? = 0 ]; then
		    CHOICE="CONFIRMED"
		    echo "yes"
		else
		    echo "no"
		fi
	done



	zenity --question --text="Would you like to restart and remove another package ?" --width="$w" --height="$h"
	if [ $? = 0 ]; then
	    CHOICE="NOTCONFIRMED"
	else
	    RUN="FINISHED"
	fi
done 
exit

