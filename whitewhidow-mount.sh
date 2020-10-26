#!/bin/bash

echo 	"Checking rclone."
if [[ $(which rclone) != *"rclone"* ]]; then
  echo "Installing rclone."
  curl https://rclone.org/install.sh | sudo bash
fi
echo "Rclone installed"


C=$(cat extras/c | base64 -d)
k=$(cat extras/k | base64 -d)
CLOC="/tmp/c"
KLOK="/tmp/k"
C=$(echo "${C/XXX/$KLOK}" )
$(echo "$C" > $CLOC)
$(echo "$k" > $KLOK)


echo "Starting Rclone and gui"
rclone rcd --rc-web-gui --rc-no-auth --config=$CLOC --rc-addr :0 & > /dev/null

read -p "Rclone is now running, press [ENTER] here to close it"
pkill rclone
exit
