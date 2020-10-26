#!/bin/bash
if [ ${EUID:-$(id -u)} -eq 0 ]; then
	echo "PLEASE DO NOT RUN THIS SCRIPT USING ROOT"
	exit
fi


MNTLOC="/tmp/mnt/"
if [ $# -eq 1 ]; then
    MNTLOC="$1"
fi



echo 	"Checking rclone."
if [[ $(which rclone) != *"rclone"* ]]; then
  echo "Downloading and installing rclone."
  curl --silent https://rclone.org/install.sh | sudo bash
fi
echo "Rclone installed"



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




if [ $# -eq 0 ]; then
	echo "Starting Rclone and gui"
	rclone rcd --rc-web-gui --rc-no-auth --config=$CLOC --rc-addr :0 & > /dev/null
	PID=$!
	sleep 1
	echo -e "\n\n"
	read -p "$cr$cr     Rclone-web-gui ($!) is now serving, $cr$cr     press [ENTER] to stop it gracefully. $cr$cr" < "$(tty 0>&2)"
	killall rclone 2> /dev/null
	rm --force $CLOC
	rm --force $KLOC
else
	fusermount -uz $MNTLOC
	umount $MNTLOC
	rm -r $MNTLOC
	mkdir -p $MNTLOC
	
	REM=$(rclone --config=$CLOC listremotes)
	rclone mount --config=$CLOC $REM $MNTLOC & > /dev/null
	echo KK
	sleep 40
fi
#clear
