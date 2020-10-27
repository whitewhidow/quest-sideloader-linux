#!/bin/bash
if [ ${EUID:-$(id -u)} -eq 0 ]; then
	echo "PLEASE DO NOT RUN THIS SCRIPT USING ROOT"
	exit
fi


MNTLOC="/tmp/mnt/"
if [ $# -eq 1 ]; then
    MNTLOC="$1"
fi


echo 	"Checking rclone installation."
if [[ $(which rclone) != *"rclone"* ]]; then
  echo "Rclone not found."
  echo "Downloading and installing rclone. (requires sudo)"
  (curl --silent https://rclone.org/install.sh | sudo bash > /dev/null) && echo "Rclone installed" 
else
  echo "Rclone installation found."
fi



CLOC="/tmp/c"
KLOC="/tmp/k"
curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/extras/c -o "$CLOC"  > /dev/null
curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/extras/k -o "$KLOC"  > /dev/null
cr=`echo $'\n.'`
cr=${cr%.}
C=$(cat $CLOC | base64 -d)
k=$(cat $KLOC | base64 -d)
C=$(echo "${C/XXX/$KLOC}" )
$(echo "$C" > $CLOC)
$(echo "$k" > $KLOC)


sleep 1

[ ! -z $CI ] && echo "::debug::Quiting early because of CI" && exit 0


if [ $(rclone --config=$CLOC listremotes | wc -l) != "1" ]; then
	echo -e "\nERROR\n\nSomething is wrong, we cannot seem to find the remote reason.\nif you report this at github.com/whitewhidow/quest-sideloader-linux, I will be happy to help\n\n"
	read -p "$cr$cr Press [ENTER] to continue. $cr$cr" < "$(tty 0>&2)"
	exit 1
fi

if [ $# -eq 0 ]; then
	#echo "Starting Rclone and gui"
	
	
	rclone rcd --rc-web-gui --rc-no-auth --config=$CLOC --rc-addr :0 & > /dev/null
	PID=$!
	sleep 1
	echo -e "\n\n"
	read -p "$cr$cr     Rclone-web-gui ($!) is now serving, $cr$cr     press [ENTER] to stop it gracefully. $cr$cr" < "$(tty 0>&2)"
	killall rclone 2> /dev/null
	rm --force $CLOC
	rm --force $KLOC
else
	fusermount -uz $MNTLOC 2> /dev/null
	umount $MNTLOC 2> /dev/null
	rm -r $MNTLOC
	mkdir -p $MNTLOC
	REM=$(rclone --config=$CLOC listremotes)
	rclone mount --config=$CLOC $REM $MNTLOC & > /dev/null
	
	if [ $# -lt 2 ]; then
	    ##MOUNTCHECK
	    sleep 1
	    echo "just 2 more seconds, to make sure rclone had time to mount.."
	    sleep 2
	    FOLDER="/tmp/mnt/"
	    if [ ! "$(ls -A $FOLDER)" ]; then
		echo "Still no mount, lets wait another 5.."
		if [ ! "$(ls -A $FOLDER)" ]; then
			echo -e "\nERROR\n\nSomething is wrong, the folder seems to return as empty.\nif you report this at www.github.com/whitewhidow/quest-sideloader-linux, I will be happy to help"
			read -p "$cr$cr     press [ENTER] to quit. $cr$cr" < "$(tty 0>&2)"
			exit 1
	    	fi

	    fi
	    echo -e "\n\n Drive now mounted at: $MNTLOC ($(ls $FOLDER | wc -l) folders available)\n\n"
	    ##MOUNTCHECK
	fi
	

fi
#clear
