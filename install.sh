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



function failed(){
	[ -z $CI ] && zenity --warning --text="Install seems to have failed, please post the terminal output to\nhttp://www.github.com/whitewhidow/quest-sideloader-linux,\nand i will gladly assist!" --width="600" 
	echo -e "\n\n -> Install seems to have failed, please post the terminal output to www.github.com/whitewhidow/quest-sideloader-linux,\ni will gladly assist! \n"
	read -p "Press [ENTER] to continue." < "$(tty 0>&2)"
	exit 1
}


case "$OSTYPE" in
  linux*)   echo "OS: Linux DETECTED" && OSTYPE="linux" ;;	
  darwin*)  echo "Mac OS DETECTED" && OSTYPE="mac" ;;
  *)        echo "unknown OS: $OSTYPE DETECTED" && echo "please submit a ticket om github?" && exit ;;
esac



echo "CHECKING AND INSTALLING DEPENDENCIES:"


if [ $OSTYPE == "mac" ]; then
	echo "Checking brew for mac."
	if [[ $(which brew) != *"brew"* ]]; then
		echo "-> Attempting to install missing 'brew' package. (requires sudo)"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && echo "Brew installed."
	fi
fi




echo "Checking git installation."
if ! command -v git &> /dev/null; then
  echo "-> Attempting to install missing 'git' pakckage. (requires sudo)"
  (sudo apt install git > /dev/null 2> /dev/null || brew git unzip > /dev/null 2> /dev/null) && echo "Unzip installed."
fi
if ! command -v git &> /dev/null; then	
	echo "Git could not be installed ?"
	failed
else
 	echo "Git installed"
 	GITINSTALLED=true
fi








BRANCH="main"
if [ ! -z $CI ]; then
	#BRANCH=$(echo "$GITHUB_REF" | awk -F'/' '{print $3}')
	BRANCH="development"
fi


echo "Downloading and unzipping newest ($BRANCH) version."
rm -f ./quest-sideloader-linux-$BRANCH.zip 2> /dev/null






echo "Checking unzip installation."
if ! command -v unzip &> /dev/null; then
  echo "-> Attempting to install missing 'unzip' pakckage. (requires sudo)"
  (sudo apt install unzip > /dev/null 2> /dev/null || brew install unzip > /dev/null 2> /dev/null) && echo "Unzip installed."
fi
if ! command -v unzip &> /dev/null; then	
	echo "Unzip could not be installed ?"
	failed
else
 	echo "Unzip installed"
 	UNZIPINSTALLED=true
fi



echo "Checking adb."
if ! command -v adb &> /dev/null; then
  if [ $OSTYPE == "mac" ]; then
	echo "-> Attempting to install missing 'adb' package. (requires sudo)"
	mkdir -p ${OSTYPE}_adb_lib
	curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/$BRANCH/${OSTYPE}_adb_lib/adb -o ${OSTYPE}_adb_lib/adb > /dev/null
	chmod +x ${OSTYPE}_adb_lib/adb
	sudo rm -f /usr/local/bin/adb 2> /dev/null
	sudo cp ${OSTYPE}_adb_lib/adb /usr/local/bin && echo "Adb copied from ${OSTYPE}_adb_lib/adb to /usr/local/bin."
	rm -rf ${OSTYPE}_adb_lib/
  fi
  
  if [ $OSTYPE == "linux" ]; then
	echo "-> Attempting to install missing 'adb' package. (requires sudo)"
	sudo apt install android-tools-adb > /dev/null 2> /dev/null
  fi
fi

if ! command -v adb &> /dev/null; then	
	echo "Adb could not be installed ?"
	failed
else
 	echo "Adb installed"
 	ADBINSTALLED=true
fi





echo "Checking aapt."
if ! command -v aapt &> /dev/null; then
	if [ $OSTYPE == "linux" ]; then
	    echo "-> Attempting to install missing 'aapt' package. (requires sudo)"
	    sudo apt install android-sdk-build-tools > /dev/null 2> /dev/null
	fi
	if [ $OSTYPE == "mac" ]; then
	    echo "PLEASE INSTALL aapt from androidaapt.com, WE WILL JUST DOWNLOAD LOCALLY FOR NOW, NO WORRIES !"
	    info "DOWNLOADING https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/mac_aapt_lib/aapt"
	    curl -s https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/mac_aapt_lib/aapt -o aapt
	    chmod +x ./aapt
	    AAPT="./aapt"
	    echo "PLEASE INSTALL aapt from androidaapt.com to avoid this download in the future !!"
	fi	
fi

if ! command -v aapt &> /dev/null; then	
	echo "Aapt could not be installed ?"
	failed
else
 	echo "Aapt installed"
 	AAPTINSTALLED=true
fi








echo "Checking zenity."
if ! command -v zenity &> /dev/null; then	
  echo "-> Attempting to install missing 'zenity' package. (requires sudo)"
  (sudo apt install zenity > /dev/null 2> /dev/null || brew install zenity > /dev/null 2> /dev/null)
fi
if ! command -v zenity &> /dev/null; then	
	echo "Zenity could not be installed ?"
	failed
else
 	echo "Zenity installed"
 	ZENITYINSTALLED=true
fi




echo 	"Checking rclone."
if ! command -v rclone &> /dev/null; then	
  echo "-> Attempting to install missing 'rclone' paackage. (requires sudo)"
  curl --silent https://rclone.org/install.sh | sudo bash > /dev/null
fi
if ! command -v rclone &> /dev/null; then	
	echo "Rclone could not be installed ?"
	failed
else
 	echo "Rclone installed"
 	RCLONEINSTALLED=true
fi



OLDPATH="$PWD"
rm -rf /tmp/sideload-install
mkdir /tmp/sideload-install
cd /tmp/sideload-install

curl --silent https://codeload.github.com/whitewhidow/quest-sideloader-linux/zip/$BRANCH -o quest-sideloader-linux-$BRANCH.zip > /dev/null
unzip -oq quest-sideloader-linux-$BRANCH.zip && cd quest-sideloader-linux-$BRANCH > /dev/null


echo "Copying executables to PATH (requires sudo)"
sudo cp ./sideload.sh /usr/local/bin/sideload
sudo cp ./sideload-gui.sh /usr/local/bin/sideload-gui
sudo cp ./whitewhidow-mount.sh /usr/local/bin/whitewhidow-mount
sudo cp ./install.sh /usr/local/bin/sideload-update


echo "Removing downloaded files"
cd $OLDPATH
rm -rf /tmp/sideload-install







if [[ $(which sideload) == *"sideload"* ]] && [[ $(which sideload-gui) == *"sideload-gui"* ]] && [[ $(which sideload-update) == *"sideload-update"* ]]; then
	echo -e "\n\n -> Install seems to have been successfull, you can now run 'sideload-gui'\n"
	[ -z $CI ] && zenity --question --text="whitewhidow/quest-sideloader-linux for Linux and Mac seems to have been successful,\nwould you like to open the sideload-gui now?" --width="600" 
	if [ $? = 0 ]; then
	    exec sideload-gui
	    exit 0
	fi
else
	failed
fi





