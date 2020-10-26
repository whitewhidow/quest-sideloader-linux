#!/bin/bash
if [ ${EUID:-$(id -u)} -eq 0 ]; then
	echo "PLEASE DO NOT RUN THIS SCRIPT USING ROOT"
	exit
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


echo "Starting Rclone and gui"
rclone rcd --rc-web-gui --rc-no-auth --config=$CLOC --rc-addr :0 & > /dev/null
PID=$!
sleep 1


clear
read -p "$cr$cr     Rclone-web-gui ($!) is now serving, press [ENTER] to close it. $cr$cr" < "$(tty 0>&2)"
killall rclone 2> /dev/null
rm --force $CLOC
rm --force $KLOC
