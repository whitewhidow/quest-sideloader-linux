#!/bin/bash


case "$OSTYPE" in
  linux*)   echo "OS: Linux DETECTED" && OSTYPE="linux" ;;	
  darwin*)  echo "Mac OS DETECTED" && OSTYPE="mac" ;;
  *)        echo "unknown OS: $OSTYPE DETECTED" && echo "please submit a ticket om github?" && exit ;;
esac


echo "CHECKING AND INSTALLING DEPENDENCIES:"


if [ $OSTYPE == "mac" ]; then
	echo "Checking brew for mac."
	if [[ $(which brew) != *"brew"* ]]; then
		echo "Installing brew."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && echo "brew installed installed."
	fi
fi


echo "Checking adb."
if [[ $(which adb) != *"adb"* ]]; then
  echo "Installing adb."
  sudo cp ${OSTYPE}_adb_lib/adb /usr/local/bin && echo "adb copied from ${OSTYPE}_adb_lib/adb to /usr/local/bin."
fi
echo "Adb installed"

echo "Checking aapt."
if [[ $(which aapt) != *"aapt"* ]]; then
  echo "Installing aapt."
  sudo cp ${OSTYPE}_aapt_lib/aapt /usr/local/bin && echo "aapt copied from ${OSTYPE}_aapt_lib/adb to /usr/local/bin."
fi
echo "Aapt installed"

echo "Checking zenity."
if [[ $(which zenity) != *"zenity"* ]]; then
  echo "Installing zenity."
  (sudo apt install zenity > /dev/null 2> /dev/null || brew install zenity > /dev/null 2> /dev/null) && echo "zenity installed."
fi
echo "Unzip installed"

echo "Checking unzip."
if [[ $(which unzip) != *"unzip"* ]]; then
  echo "Installing unzip."
  (sudo apt install unzip > /dev/null 2> /dev/null || brew install unzip > /dev/null 2> /dev/null) && echo "unzip installed."
fi
echo "Unzip installed"



zenity --question --text="Update to the latest version of whitewhidow/quest-sideloader-linux for Linux And Mac?" --width="700" 
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
	echo "Install seems to have been successfull, you can now run 'sideload-gui' or just 'sideload'"
	zenity --question --text="whitewhidow/quest-sideloader-linux for Linux and Mac seems to have been successful,\nwould you like to open the sideload-gui now?" --width="600" 
	if [ $? = 0 ]; then
	    sideload-gui
	else
	    echo -ne ''
	fi
else
	zenity --warning --text="Install seems to have failed, please post the above output on\nhttp://www.github.com/whitewhidow/quest-sideloader-linux, i will gladly assist!" --width="600" 
	echo "Install seems to have failed, please post the above output on www.github.com/whitewhidow/quest-sideloader-linux,\ni will gladly assist!"
fi


exit

