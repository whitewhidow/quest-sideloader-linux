#!/bin/bash


case "$OSTYPE" in
  linux*)   echo "OS: Linux DETECTED" && OSTYPE="linux" ;;	
  darwin*)  echo "Mac OS DETECTED" && OSTYPE="mac" ;;
  *)        echo "unknown OS: $OSTYPE DETECTED" && echo "please submit a ticket om github?" && exit ;;
esac




echo "CHECKING AND INSTALLING DEPENDENCIES:"

echo "Checking unzip."
if [[ $(which unzip) != *"unzip"* ]]; then
  echo "Installing unzip. (requires sudo)"
  (sudo apt install unzip > /dev/null 2> /dev/null || brew install unzip > /dev/null 2> /dev/null) && echo "Unzip installed."
fi



echo "Downloading newest version"
rm -f ./quest-sideloader-linux-main.zip 2> /dev/null
curl --silent https://codeload.github.com/whitewhidow/quest-sideloader-linux/zip/main -o quest-sideloader-linux-main.zip > /dev/null
echo "Unzipping newest version"
unzip -oq quest-sideloader-linux-main.zip && cd quest-sideloader-linux-main > /dev/null
echo "Copying"
if [ -f "../sideload.sh" ];then 
  rm -f ../sideload.sh
fi
if [ -f "../sideload-gui.sh" ];then 
  rm -f ../sideload-gui.sh
fi
if [ -f "../whitewhidow-mount.sh" ];then 
  rm -f ../whitewhidow-mount.sh
fi
cp ./sideload.sh ../sideload.sh
cp ./sideload-gui.sh ../sideload-gui.sh
cp ./whitewhidow-mount.sh ../whitewhidow-mount.sh
cd ../
#








if [ $OSTYPE == "mac" ]; then
	echo "Checking brew for mac."
	if [[ $(which brew) != *"brew"* ]]; then
		echo "Installing brew. (requires sudo)"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && echo "brew installed installed."
	fi
fi



echo "Checking adb."
if [[ $(which adb) != *"adb"* ]]; then
  echo "Installing adb. (requires sudo)"
  mkdir -p ${OSTYPE}_adb_lib
  curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/${OSTYPE}_adb_lib/adb -o ${OSTYPE}_adb_lib/adb > /dev/null
  chmod +x ${OSTYPE}_adb_lib/adb
  sudo rm -f /usr/local/bin/adb 2> /dev/null
  sudo cp ${OSTYPE}_adb_lib/adb /usr/local/bin && echo "adb copied from ${OSTYPE}_adb_lib/adb to /usr/local/bin."
  rm -rf ${OSTYPE}_adb_lib/
fi
echo "Adb installed"

echo "Checking aapt."
if [[ $(which aapt) != *"aapt"* ]]; then
  echo "Installing aapt. (requires sudo)"
  mkdir -p ${OSTYPE}_aapt_lib
  curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/${OSTYPE}_aapt_lib/aapt -o ${OSTYPE}_aapt_lib/aapt > /dev/null
  chmod +x ${OSTYPE}_aapt_lib/aapt
  sudo rm -f /usr/local/bin/aapt 2> /dev/null
  sudo cp ${OSTYPE}_aapt_lib/aapt /usr/local/bin && echo "aapt copied from ${OSTYPE}_aapt_lib/aapt to /usr/local/bin."
  rm -rf ${OSTYPE}_aapt_lib
fi
echo "Aapt installed"

echo "Checking zenity."
if [[ $(which zenity) != *"zenity"* ]]; then
  echo "Installing zenity. (requires sudo)"
  (sudo apt install zenity > /dev/null 2> /dev/null || brew install zenity > /dev/null 2> /dev/null) && echo "zenity installed."
fi
echo "Zenity installed"





#zenity --question --text="Update to the latest version of whitewhidow/quest-sideloader-linux for Linux And Mac?" --width="700" 
#if [ $? = 0 ]; then
#    UPDATE="YES"
#else
#    UPDATE="NO"
#fi

#if [ "$UPDATE" == "YES" ]; then
	#if update
#	echo "Downloading new version"
#	rm ./quest-sideloader-linux-main.zip 2> /dev/null
#	curl --silent https://codeload.github.com/whitewhidow/quest-sideloader-linux/zip/main -o quest-sideloader-linux-main.zip > /dev/null
#	echo "Unzipping out of folder"
#	unzip -oq quest-sideloader-linux-main.zip && cd quest-sideloader-linux-main > /dev/null
#	echo "Copying"
#	cp -u ./sideload.sh ../sideload.sh
#	cp -u ./sideload-gui.sh ../sideload-gui.sh
#	cd ../
#fi

echo "Copying sideload and sideload-gui to PATH (requires sudo)"
sudo cp ./sideload.sh /usr/local/bin/sideload
sudo cp ./sideload-gui.sh /usr/local/bin/sideload-gui
sudo cp ./whitewhidow-mount.sh /usr/local/bin/whitewhidow-mount


echo "Removing install leftovers"
rm -f quest-sideloader-linux-main.zip
rm -rf quest-sideloader-linux-main


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



#ask
#echo 	"Checking rclone."
#if [[ $(which rclone) != *"rclone"* ]]; then
#  echo "Downloading and installing rclone. (requires sudo)"
#  curl --silent https://rclone.org/install.sh | sudo bash
#fi
#echo "Rclone installed"

