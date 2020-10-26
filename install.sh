#!/bin/bash
clear
printf "\n"
printf "\n"
printf "\n"
echo -e "===================================================================="
echo -e "= Quest(1/2) sideloader for Linux & Mac(OSX) ======================="
echo -e "===================================================================="
echo -e "========================================= by Whitewhidow/BranchBit ="
echo -e "===================================== support:contact@branchbit.be ="
echo -e "============================== https://t.me/whitewhidow_q2_working ="
echo -e "================ www.github.com/whitewhidow/quest-sideloader-linux ="
printf "\n"



case "$OSTYPE" in
  linux*)   echo "OS: Linux DETECTED" && OSTYPE="linux" ;;	
  darwin*)  echo "Mac OS DETECTED" && OSTYPE="mac" ;;
  *)        echo "unknown OS: $OSTYPE DETECTED" && echo "please submit a ticket om github?" && exit ;;
esac



echo "CHECKING AND INSTALLING DEPENDENCIES:"


if [ $OSTYPE == "mac" ]; then
	echo "Checking brew for mac."
	if [[ $(which brew) != *"brew"* ]]; then
		echo "Attempting to install missing 'brew' package. (requires sudo)"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && echo "Brew installed."
	fi
fi


#echo "Checking unzip installation."
if [[ $(which unzip) != *"unzip"* ]]; then
  echo "Attempting to install missing 'unzip' pakckage. (requires sudo)"
  (sudo apt install unzip > /dev/null 2> /dev/null || brew install unzip > /dev/null 2> /dev/null) && echo "Unzip installed."
fi



OLDPATH="$PWD"
rm -rf /tmp/sideload-install
mkdir /tmp/sideload-install
cd /tmp/sideload-install



echo "Downloading and unzipping newest version."
rm -f ./quest-sideloader-linux-main.zip 2> /dev/null
curl --silent https://codeload.github.com/whitewhidow/quest-sideloader-linux/zip/main -o quest-sideloader-linux-main.zip > /dev/null
unzip -oq quest-sideloader-linux-main.zip && cd quest-sideloader-linux-main > /dev/null








echo "Checking adb."
if [[ $(which adb) != *"adb"* ]]; then
  echo "Attempting to install missing 'adb' package. (requires sudo)"
  mkdir -p ${OSTYPE}_adb_lib
  curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/${OSTYPE}_adb_lib/adb -o ${OSTYPE}_adb_lib/adb > /dev/null
  chmod +x ${OSTYPE}_adb_lib/adb
  sudo rm -f /usr/local/bin/adb 2> /dev/null
  sudo cp ${OSTYPE}_adb_lib/adb /usr/local/bin && echo "Adb copied from ${OSTYPE}_adb_lib/adb to /usr/local/bin."
  rm -rf ${OSTYPE}_adb_lib/
fi
echo "Adb installed"

echo "Checking aapt."
if [[ $(which aapt) != *"aapt"* ]]; then
  echo "Attempting to install missing 'aapt' package. (requires sudo)"
  mkdir -p ${OSTYPE}_aapt_lib
  curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/${OSTYPE}_aapt_lib/aapt -o ${OSTYPE}_aapt_lib/aapt > /dev/null
  chmod +x ${OSTYPE}_aapt_lib/aapt
  sudo rm -f /usr/local/bin/aapt 2> /dev/null
  sudo cp ${OSTYPE}_aapt_lib/aapt /usr/local/bin && echo "Aapt copied from ${OSTYPE}_aapt_lib/aapt to /usr/local/bin."
  rm -rf ${OSTYPE}_aapt_lib/
fi
echo "Aapt installed"

echo "Checking zenity."
if [[ $(which zenity) != *"zenity"* ]]; then
  echo "Attempting to install missing 'zenity' package. (requires sudo)"
  (sudo apt install zenity > /dev/null 2> /dev/null || brew install zenity > /dev/null 2> /dev/null) && echo "Zenity installed."
fi
echo "Zenity installed"


echo 	"Checking rclone."
if [[ $(which rclone) != *"rclone"* ]]; then
  echo "Attempting to install missing 'rclone' paackage. (requires sudo)"
  curl --silent https://rclone.org/install.sh -o rcloneinstall.sh > /dev/null
  sudo ./rcloneinstall.sh > /dev/null
fi
echo "Rclone installed"




echo "Copying executables to PATH (requires sudo)"
sudo cp ./sideload.sh /usr/local/bin/sideload
sudo cp ./sideload-gui.sh /usr/local/bin/sideload-gui
sudo cp ./whitewhidow-mount.sh /usr/local/bin/whitewhidow-mount
sudo cp ./install.sh /usr/local/bin/sideload-update


echo "Removing downloaded files"
cd $OLDPATH
rm -rf /tmp/sideload-install







if [[ $(which adb) == *"adb"* ]] && [[ $(which aapt) == *"aapt"* ]] && [[ $(which rclone) == *"rclone"* ]] && [[ $(which zenity) == *"zenity"* ]] && [[ $(which unzip) == *"unzip"* ]] && [[ $(which sideload) == *"sideload"* ]] && [[ $(which sideload-gui) == *"sideload-gui"* ]] && [[ $(which sideload-update) == *"sideload-update"* ]]; then
	echo -e "\n\n -> Install seems to have been successfull, you can now run 'sideload-gui'\n"
	[ -z $CI ] && zenity --question --text="whitewhidow/quest-sideloader-linux for Linux and Mac seems to have been successful,\nwould you like to open the sideload-gui now?" --width="600" 
	if [ $? = 0 ]; then
	    exec sideload-gui
	    exit 0
	fi
else
	[ -z $CI ] && zenity --warning --text="Install seems to have failed, please post the terminal output to\nhttp://www.github.com/whitewhidow/quest-sideloader-linux,\nand i will gladly assist!" --width="600" 
	echo -e "\n\n -> Install seems to have failed, please post the terminal output to www.github.com/whitewhidow/quest-sideloader-linux,\ni will gladly assist! \n"
	exit 1
fi





