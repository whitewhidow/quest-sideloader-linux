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
  linux*)   OSTYPE="linux" ;;	
  darwin*)  OSTYPE="mac" ;;
  *)        echo "unknown OS: $OSTYPE DETECTED" && echo "please submit a ticket om github?" && sleep 30 && exit ;;
esac




function failed(){
	LINE="\n\nInstall seems to have failed with the following reason:\n\n$1.\n\nPlease paste the terminal output to github,\nI will gladly assist! \n"
	[ -z $CI ] && zenity --warning --text="$LINE" --width="600" 
	echo -e "$LINE"
	read -p "Press [ENTER] to continue." < "$(tty 0>&2)"
	exit 1
}



echo "CHECKING AND INSTALLING DEPENDENCIES:"


if [ $OSTYPE == "mac" ]; then
	echo "Checking brew for mac."
	if ! command -v brew &> /dev/null; then
		echo "-> Please wait while we attempt to install missing 'brew' package. (requires sudo)"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && echo "Brew installed."
	fi
	if ! command -v git &> /dev/null; then	
		failed "Brew could not be installed ?"
	else
	 	echo "Brew installed at $(which brew)"
	 	BREWINSTALLED=true
	fi
fi




echo "Checking git installation."
if ! command -v git &> /dev/null; then
  echo "-> Please wait while we attempt to install missing 'git' package. (requires sudo)"
  (sudo apt install git > /dev/null 2> /dev/null || brew git unzip > /dev/null 2> /dev/null) && echo "Unzip installed."
fi
if ! command -v git &> /dev/null; then	
	failed "Git could not be installed ?"
else
 	echo "Git installed at $(which git)"
 	GITINSTALLED=true
fi








echo "Checking unzip installation."
if ! command -v unzip &> /dev/null; then
  echo "-> Please wait while we attempt to install missing 'unzip' pakckage. (requires sudo)"
  (sudo apt install unzip > /dev/null || brew install unzip > /dev/null ) && echo "Unzip installed."
fi
if ! command -v unzip &> /dev/null; then	
	failed "Unzip could not be installed ?"
else
 	echo "Unzip installed at $(which unzip)"
 	UNZIPINSTALLED=true
fi



echo "Checking adb."
which adb
sudo mv /Users/runner/Library/Android/sdk/platform-tools/adb /Users/runner/Library/Android/sdk/platform-tools/adb_back
if ! command -v adb &> /dev/null; then
  if [ $OSTYPE == "mac" ]; then
	echo "-> Please wait while we attempt to install missing 'adb' package. (requires sudo)"
	mkdir -p ${OSTYPE}_adb_lib
	curl --silent https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/$BRANCH/${OSTYPE}_adb_lib/adb -o ${OSTYPE}_adb_lib/adb > /dev/null
	chmod +x ${OSTYPE}_adb_lib/adb
	sudo rm -f /usr/local/bin/adb 2> /dev/null
	sudo cp ${OSTYPE}_adb_lib/adb /usr/local/bin && echo "Adb copied from ${OSTYPE}_adb_lib/adb to /usr/local/bin."
	rm -rf ${OSTYPE}_adb_lib/
  fi
  
  if [ $OSTYPE == "linux" ]; then
	echo "-> Please wait while we attempt to install missing 'adb' package. (requires sudo)"
	sudo apt install android-tools-adb > /dev/null
  fi
fi

if ! command -v adb &> /dev/null; then	
	failed "Adb could not be installed ?"
else
 	echo "Adb installed at $(which adb)"
 	ADBINSTALLED=true
fi





echo "Checking aapt."
if ! command -v aapt &> /dev/null; then
	if [ $OSTYPE == "linux" ]; then
	    echo "-> Please wait while we attempt to install missing 'aapt' package. (requires sudo)"
	    sudo apt install android-sdk-build-tools > /dev/null
	fi
	if [ $OSTYPE == "mac" ]; then
	    echo "-> Please wait while we attempt to install missing 'aapt' package. (requires sudo)"
	    curl -s https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/mac_aapt_lib/aapt -o aapt
	    #https://dl.androidaapt.com/aapt-macos.zip
	    chmod +x ./aapt
	    sudo cp ./aapt /usr/local/bin/
	    
	    
	fi	
fi

if ! command -v aapt &> /dev/null; then
	#echo -ne ''	
	failed "Aapt could not be installed ?"
else
 	echo "Aapt installed at $(which aapt)"
 	AAPTINSTALLED=true
fi



echo "Checking zenity."
if ! command -v zenity &> /dev/null; then	
  echo "-> Please wait while we attempt to install missing 'zenity' package. (requires sudo)"
  (sudo apt install zenity > /dev/null 2> /dev/null || brew install zenity > /dev/null 2> /dev/null)
fi
if ! command -v zenity &> /dev/null; then	
	failed "Zenity could not be installed ?"
else
 	echo "Zenity installed at $(which zenity)"
 	ZENITYINSTALLED=true
fi




echo 	"Checking rclone."
if ! command -v rclone &> /dev/null; then	
  echo "-> Please wait while we attempt to install missing 'rclone' paackage. (requires sudo)"
  curl --silent https://rclone.org/install.sh | sudo bash > /dev/null
fi
if ! command -v rclone &> /dev/null; then	
	failed "Rclone could not be installed ?"
else
 	echo "Rclone installed at $(which rclone)"
 	RCLONEINSTALLED=true
fi



BRANCH="main"
if [ ! -z "$1" ]; then
    BRANCH="$1"
fi

if [[ "$BRANCH" == "local" ]]; then
	echo -ne ""
fi


echo "Fetching newest version ($BRANCH)."


OLDPATH="$PWD"

if [[ "$BRANCH" == "local" ]]; then
	cd $OLDPATH
else
	cd /tmp
	rm -rf ./quest-sideloader-linux
	git clone https://github.com/whitewhidow/quest-sideloader-linux.git
	cd quest-sideloader-linux
	git checkout $BRANCH
fi




echo "Copying executables to PATH (requires sudo)"
sudo cp ./sideload.sh /usr/local/bin/sideload
sudo cp ./sideload-gui.sh /usr/local/bin/sideload-gui
sudo cp ./whitewhidow-mount.sh /usr/local/bin/whitewhidow-mount
sudo cp ./install.sh /usr/local/bin/sideload-update


cd $OLDPATH


if [[ "$ADBINSTALLED" ]] && [[ "$AAPTINSTALLED" ]] && [[ "$RCLONEINSTALLED" ]] && [[ "$ZENITYINSTALLED" ]] && [[ "$UNZIPINSTALLED" ]] && [[ $(which sideload) == *"sideload"* ]] && [[ $(which sideload-gui) == *"sideload-gui"* ]] && [[ $(which sideload-update) == *"sideload-update"* ]]; then
	echo -e "\n\n -> Install seems to have been successfull, you can now run 'sideload-gui' to open the sideloader.\n\n -> To self-update this package run 'sideload-update'.\n\n"
	[ -z $CI ] && zenity --question --text="whitewhidow/quest-sideloader-linux for Linux and Mac seems to have been successful,\nwould you like to open the sideload-gui now?" --width="600" 
	if [ $? = 0 ]; then
	    exec sideload-gui
	    exit 0
	fi
else
	failed ''
fi






