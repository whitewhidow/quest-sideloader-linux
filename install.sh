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
echo -e "===================================================================="
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


BRANCH="main"
if [ ! -z $CI ]; then
	#BRANCH=$(echo "$GITHUB_REF" | awk -F'/' '{print $3}')
	BRANCH="development"
fi


echo "Downloading and unzipping newest ($BRANCH) version."
rm -f ./quest-sideloader-linux-$BRANCH.zip 2> /dev/null


curl --silent https://codeload.github.com/whitewhidow/quest-sideloader-linux/zip/$BRANCH -o quest-sideloader-linux-$BRANCH.zip > /dev/null

unzip -oq quest-sideloader-linux-$BRANCH.zip && cd quest-sideloader-linux-$BRANCH > /dev/null








echo "Checking adb."
if [[ $(which adb) != *"adb"* ]]; then
  echo "Attempting to install missing 'adb' package. (requires sudo)"
  mkdir -p ${OSTYPE}_adb_lib
  curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/$BRANCH/${OSTYPE}_adb_lib/adb -o ${OSTYPE}_adb_lib/adb > /dev/null
  chmod +x ${OSTYPE}_adb_lib/adb
  sudo rm -f /usr/local/bin/adb 2> /dev/null
  sudo cp ${OSTYPE}_adb_lib/adb /usr/local/bin && echo "Adb copied from ${OSTYPE}_adb_lib/adb to /usr/local/bin."
  rm -rf ${OSTYPE}_adb_lib/
fi
([[ $(which adb) == *"adb"* ]] && echo "Adb installed") || echo "Adb install failed."





echo "Checking aapt."
echo "Which aapt: $(which aapt)"
[[ $(aapt 2> /dev/null) ]] && echo "found1" || echo "fail1"


if [[ ! $(aapt 2> /dev/null) ]] ; then


	
	
	if [ $OSTYPE == "linux" ]; then
	    sudo apt install android-sdk-build-tools
	fi
	if [ $OSTYPE == "mac" ]; then
	    warning "PLEASE INSTALL aapt from androidaapt.com, WE WILL JUST DOWNLOAD LOCALLY FOR NOW, NO WORRIES !"
	    info "DOWNLOADING https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/mac_aapt_lib/aapt"
	    curl -s https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/mac_aapt_lib/aapt -o aapt
	    chmod +x ./aapt
	    AAPT="./aapt"
	    warning "PLEASE INSTALL aapt from androidaapt.com to avoid this download in the future !!"
	fi	
	
	
	




 
fi

([[ $(which aapt) == *"bin/aapt"* ]] && echo "Aapt installed") || echo "Aapt install failed."


[[ $(aapt 2> /dev/null) ]] && echo "found1" || echo "fail1"

echo "Which aapt: $(which aapt)"
echo "aapt: $(aapt)"











echo "Checking zenity."
if [[ $(which zenity) != *"zenity"* ]]; then
  echo "Attempting to install missing 'zenity' package. (requires sudo)"
  (sudo apt install zenity > /dev/null 2> /dev/null || brew install zenity > /dev/null 2> /dev/null) && echo "Zenity installed."
fi
echo "Zenity installed"


echo 	"Checking rclone."
if [[ $(which rclone) != *"rclone"* ]]; then
  echo "Attempting to install missing 'rclone' paackage. (requires sudo)"
  curl --silent https://rclone.org/install.sh | sudo bash > /dev/null

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







if [[ $(which adb) == *"adb"* ]] && [[ $(which aapt) == *"bin/$AAPT"* ]] && [[ $(aapt) != *"aapt: error"* ]] && [[ $(which rclone) == *"rclone"* ]] && [[ $(which zenity) == *"zenity"* ]] && [[ $(which unzip) == *"unzip"* ]] && [[ $(which sideload) == *"sideload"* ]] && [[ $(which sideload-gui) == *"sideload-gui"* ]] && [[ $(which sideload-update) == *"sideload-update"* ]]; then
	echo -e "\n\n -> Install seems to have been successfull, you can now run 'sideload-gui'\n"
	[ -z $CI ] && zenity --question --text="whitewhidow/quest-sideloader-linux for Linux and Mac seems to have been successful,\nwould you like to open the sideload-gui now?" --width="600" 
	if [ $? = 0 ]; then
	    exec sideload-gui
	    exit 0
	fi
else
	[ -z $CI ] && zenity --warning --text="Install seems to have failed, please post the terminal output to\nhttp://www.github.com/whitewhidow/quest-sideloader-linux,\nand i will gladly assist!" --width="600" 
	echo -e "\n\n -> Install seems to have failed, please post the terminal output to www.github.com/whitewhidow/quest-sideloader-linux,\ni will gladly assist! \n"
	read -p "Press [ENTER] to continue." < "$(tty 0>&2)"
	exit 1
fi





