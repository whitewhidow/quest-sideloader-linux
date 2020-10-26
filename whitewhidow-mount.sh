#!/bin/bash

echo 	"Checking rclone."
if [[ $(which rclone) != *"rclone"* ]]; then
  echo "Installing rclone."
  curl https://rclone.org/install.sh | sudo bash
fi
echo "Rclone installed"




CLOC="/tmp/c"
KLOC="/tmp/k"



curl https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/extras/c -o "$CLOC"
curl https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/extras/k -o "$KLOC"



C=$(cat $CLOC | base64 -d)
k=$(cat $KLOC | base64 -d)
C=$(echo "${C/XXX/$KLOC}" )
$(echo "$C" > $CLOC)
$(echo "$k" > $KLOC)


echo "Starting Rclone and gui"
rclone rcd --rc-web-gui --rc-no-auth --config=$CLOC --rc-addr :0 & > /dev/null
sleep 1
clear
echo ''
echo ''
read -p "   Rclone-gui is running, press [ENTER] here to close it gracefully"
rm $CLOC
rm $KLOC
pkill rclone
exit
