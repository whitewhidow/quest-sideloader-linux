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


if [ $# -eq 0 ]; then
	#echo "Starting Rclone and gui"
	
	if [ $(rclone --config=$CLOC listremotes | wc -l) != "1" ]; then
		echo -e "\nERROR\n\nSomething is wrong, we cannot seem to start rclone for some reason.\nYf you report this at github.com/whitewhidow/quest-sideloader-linux, I will be happy to help"
		read -p "$cr$cr Press [ENTER] to continue. $cr$cr" < "$(tty 0>&2)"
		exit
	fi
	
	
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

fi
#clear
