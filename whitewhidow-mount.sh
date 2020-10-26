#!/bin/bash

echo 	"Checking rclone."
if [[ $(which rclone) != *"rclone"* ]]; then
  echo "Downloading and installing rclone."
  curl https://rclone.org/install.sh | sudo bash
fi
echo "Rclone installed"




CLOC="/tmp/c"
KLOC="/tmp/k"
curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/extras/c -o "$CLOC"  > /dev/null
curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/extras/k -o "$KLOC"  > /dev/null
C=$(cat $CLOC | base64 -d)
k=$(cat $KLOC | base64 -d)
C=$(echo "${C/XXX/$KLOC}" )
$(echo "$C" > $CLOC)
$(echo "$k" > $KLOC)


echo "Starting Rclone and gui"
rclone rcd --rc-web-gui --rc-no-auth --config=$CLOC --rc-addr :0 & > /dev/null
sleep 1
clear
read -p "\n\n   Rclone-web-gui is running and connected to WHITEWHIDOW_QUEST, press [ENTER] to close it gracefully\n\n"
rm $CLOC
rm $KLOC
pkill rclone
exit
