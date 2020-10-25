#!/bin/bash


case "$OSTYPE" in
  linux*)   echo "OS: Linux DETECTED" && OSTYPE="linux" ;;	
  darwin*)  echo "Mac OS DETECTED" && OSTYPE="mac" ;;
  *)        echo "unknown OS: $OSTYPE DETECTED" && echo "please submit a ticket ?" && exit ;;
esac


echo "CHECKING DEPS:"

echo "Checking adb."
if [[ $(which adb) != *"adb"* ]]; then
  sudo cp ${OSTYPE}_adb_lib/adb /usr/local/bin && echo "adb copied from ${OSTYPE}_adb_lib/adb to /usr/local/bin."
fi
echo "Adb installed"

echo "Checking aapt."
if [[ $(which aapt) != *"aapt"* ]]; then
  sudo cp ${OSTYPE}_aapt_lib/aapt /usr/local/bin && echo "aapt copied from ${OSTYPE}_aapt_lib/adb to /usr/local/bin."
fi
echo "Aapt installed"

echo "Checking zenity."
if [[ $(which zenity) != *"zenity"* ]]; then
  (sudo apt install zenity > /dev/null 2> /dev/null || brew install zenity > /dev/null 2> /dev/null) && echo "zenity installed."
fi
echo "Unzip installed"

echo "Checking unzip."
if [[ $(which unzip) != *"unzip"* ]]; then
  (sudo apt install unzip > /dev/null 2> /dev/null || brew install unzip > /dev/null 2> /dev/null) && echo "unzip installed."
fi
echo "Unzip installed"



zenity --question --text="Would you also like to update to the latest version?" --width="600" 
if [ $? = 0 ]; then
    UPDATE="YES"
else
    UPDATE="NO"
fi

if [ "$UPDATE" == "YES" ]; then
	#if update
	echo "Downloading new version"
	rm ./quest-sideloader-linux-main.zip 2> /dev/null
	curl --silent https://codeload.github.com/whitewhidow/quest-sideloader-linux/zip/main -o quest-sideloader-linux-main.zip > /dev/null
	echo "Unzipping out of folder"
	unzip -oq quest-sideloader-linux-main.zip && cd quest-sideloader-linux-main > /dev/null
	echo "Copying"
	cp -u ./sideload.sh ../sideload.sh
	cp -u ./sideload-gui.sh ../sideload-gui.sh
	cd ../
fi

echo "Copying to PATH"
#zoiszo
sudo cp ./sideload.sh /usr/local/bin/sideload
sudo cp ./sideload-gui.sh /usr/local/bin/sideload-gui


if [ "$UPDATE" == "YES" ]; then
	echo "Removing install leftovers"
	#if update
	rm quest-sideloader-linux-main.zip
	rm -rf quest-sideloader-linux-main
fi

if [[ $(which adb) == *"adb"* ]] && [[ $(which aapt) == *"aapt"* ]] && [[ $(which zenity) == *"zenity"* ]] && [[ $(which unzip) == *"unzip"* ]] && [[ $(which sideload) == *"sideload"* ]] && [[ $(which sideload-gui) == *"sideload-gui"* ]]; then
	echo INSTALLED
else
	echo FAILED
fi


exit

sideload-gui
