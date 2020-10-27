#!/bin/bash
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


#some settings
ADB=adb # LOCATION TO ADB EXECUTABLE
AAPT=aapt # LOCATION TO AAPT EXECUTABLE

#some colors
RED='\033[0;31m'
ORANGE='\033[0;40m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m'
HASOBBS=false

#some helper functions
function info(){
   echo -e "${PURPLE}[INFO ] $1 ${PURPLE}"
}
function ok(){
   echo -e "${GREEN}[OK   ] $1 ${PURPLE}"
}
function blue(){
   echo -e "${BLUE}$1 ${BLUE}"
}
function error(){
   echo -e "${BLUE}[ERROR] $1 ${PURPLE}"
}
function warning(){
   echo -e "${BLUE}[WARNING]${BLUE} $1 ${PURPLE}"
}
function verify(){
   printf "\n"
   echo -e "${BLUE}"
   echo -e "YOU ARE ABOUT TO INSTALL: \"$PACKAGENAME\" APK AND $1 OBB FILES INTO $DEVICE !"
   read -p "VERIFY THE ABOVE INFO, AND CLICK ANY KEY TO CONINUE, or CTRL+C to Cancel"
   
}








#start


##OS DETECT
WSL=$(uname -r | grep Microsoft > /dev/null && echo "WSL")
if [ "$WSL" == "WSL" ]
then
  if [ "$WSL_INTEROP" ]
  then
    WSL="WSL2"
    OSTYPE="WSL2"
  else
    WSL="WSL1"
    OSTYPE="WSL1"
  fi
fi
#OSTYPE="WSL1"
info "OS Detection"
case "$OSTYPE" in
  linux*)   ok "Linux DETECTED" && OSTYPE="Linux" ;;
  WSL1*)    ok "WINDOWS SUBSYSTEM FOR LINUX DETECTED" && OSTYPE="WSL1" ;;	
  WSL2*)    ok "WSL2 DETECTED" && OSTYPE="WSL2" ;;	
  darwin*)  ok "Mac OS DETECTED" && OSTYPE="Mac" ;;
  win*)     ok "Windows DETECTED" && OSTYPE="Windows"  ;;
  cygwin*)  ok "Cygwin DETECTED" && OSTYPE="Cygwin"  ;;
  bsd*)     ok "BSD DETECTED" && OSTYPE="BSD"  ;;
  solaris*) ok "Solaris DETECTED" && OSTYPE="Solaris"  ;;
  *)        error "unknown OS: $OSTYPE DETECTED" && echo "please submit a ticket ?" && exit 0 ;;
esac
#END OS DETECT



if [ $OSTYPE == "WSL1" ]; then
  error "WINDOWS HOST ADB CAN NOT BE AUTOMATICALLY COMPLETED"
  warning ""
  warning "YOU ARE USING WSL1, THIS SCRIPT DOES NOT KNOW IF YOU HAVE ADB INSTALLED IN WINDOWS OR NOT"
  warning "PLEASE MAKE SURE YOUR HOST(WINDOWS) HAS THE FOLLOWING ADB VERSION(30.0.4) INSTALLED AND DETECTS YOUR DEVICE: "
  warning "https://dl.google.com/android/repository/platform-tools_r30.0.4-windows.zip"
  warning "AS YOUR WSL's ADB WILL CONNECT TO THE ADB ON YOU WINDOWS HOST"
  warning ""
  echo -e "${BLUE}"
  read -p "VERIFY THE ABOVE INFO, AND CLICK ANY KEY TO CONINUE" 
  #$ADB kill-server 2> /dev/null
fi




if [[ $(which adb) == *"adb"* ]] && [[ $(which aapt) == *"aapt"* ]] && [[ $(which rclone) == *"rclone"* ]] && [[ $(which zenity) == *"zenity"* ]] && [[ $(which unzip) == *"unzip"* ]] && [[ $(which sideload) == *"sideload"* ]] && [[ $(which sideload-gui) == *"sideload-gui"* ]] && [[ $(which sideload-update) == *"sideload-update"* ]]; then
	ok 'All pakcages are present.'
else
	error "You seem to be missing some packages, should we reinstall ?"
	while true; do
	    read -p "(Yy/Nn) " yn
	    case $yn in
		[Yy]* ) exec sideload-update;;
		[Nn]* ) exit 0;;
		* ) echo "Please answer yes or no.";;
	    esac
	done
	exit 1
fi




ok "LOCAL ADB path set to: \"$ADB\""
## END ADB INSTALL
echo "which aapt: $(which adb)"



## AAPT INSTALL
info "LOCAL AAPT Detection"
if [ $OSTYPE == "Mac" ]; then
    warning "PLEASE INSTALL aapt from androidaapt.com, WE WILL JUST DOWNLOAD LOCALLY FOR NOW, NO WORRIES !"
    info "DOWNLOADING https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/mac_aapt_lib/aapt"
    curl -s https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/mac_aapt_lib/aapt -o aapt
    chmod +x ./aapt
    AAPT="./aapt"
    warning "PLEASE INSTALL aapt from androidaapt.com to avoid this download in the future !!"
fi
ok "LOCAL AAPT path set to: \"$AAPT\""
## END AAPT INSTALL
echo "which aapt: $(which aapt)"





#restart adb
#$ADB kill-server 2> /dev/null
#$ADB get-state 2> /dev/null


#device test
info "Device detection"
DEVICES=$($ADB devices 2> /dev/null)
#DEVICECHECK=$(($(echo "$DEVICES" | grep device | wc -l)-1))
DEVICECHECK=$(($(echo "$DEVICES" | grep device | wc -l)-1))
if [ "$DEVICECHECK" == 2 ]
then
  error "Multiple devices found, make sure there is only ONE adb connection (check using \"adb devices\")."
  [ -z $CI ] && exit 1
fi
if [ "$DEVICECHECK" == 0 ]
then
  error "No device connected, make sure there is ONE adb connection (check using \"adb devices\")..$CI"
  [ -z $CI ] && exit 1
fi
    
#devicename   
DEVICE=$(echo "$DEVICES" | tail -1 | sed 's/device//' 2> /dev/null)
ok "Device detected: $DEVICE"

[ -z $CI ] && STORAGE=$($ADB shell 'echo $EXTERNAL_STORAGE' 2> /dev/null)
ok "Storage detected: $STORAGE"
#end device test



#singledir check for obb suggestion of aapt is missing
SINGLEDIR=$(ls -l | grep "^d" | wc -l)
SUGGESTION=$(ls -l | grep "^d" | sed 's/.* //')



APKNAME=$(find ./ -name "*.apk"| cut -c 3-)
APKNAME=${APKNAME#/}
APKCOUNT=$(echo "$APKNAME" | wc -l | xargs)


#apk test
if test -f "$APKNAME"; then
    ok "APK FOUND: ${BLUE}./$APKNAME	"
else
    if [[ $APKCOUNT == 1 ]] ; then
      echo $APKCOUNT
      error "NO APK FOUND IN CURRENT DIRECTORY (inc. subdirectories)"
      exit 1
    else
      echo $APKNAME
      error "TOO MANY ($APKCOUNT) APK's FOUND IN CURRENT DIRECTORY (inc. subdirectories)"
      exit 1
    fi
fi
#end apk test




#aapt test and packagename setup
    if ([[ "$PWD" == *"ftp:host"* ]]); then
        info "FTP DETECTED, WILL COPY APK TO TMP, TO RUN AAPT, PLEASE WAIT A SEC"
        cp "$APKNAME" "/tmp/$APKNAME"
        PACKAGENAME=$($AAPT dump badging "/tmp/$APKNAME" | grep package:\ name | awk '/package/{gsub("name=|'"'"'","");  print $2}')
        PACKAGEINFO=$($AAPT dump badging "/tmp/$APKNAME" | head -n 1 )
        PACKAGEPERMS=$($AAPT dump badging "/tmp/$APKNAME" | grep "name='android.permission" | awk -F "'" '{print $2}')
    else 
        PACKAGENAME=$($AAPT dump badging "$APKNAME" | grep package:\ name | awk '/package/{gsub("name=|'"'"'","");  print $2}')
        PACKAGEINFO=$($AAPT dump badging "$APKNAME" | head -n 1 )
        PACKAGEPERMS=$($AAPT dump badging "$APKNAME" | grep "name='android.permission" | awk -F "'" '{print $2}')
    fi
 
    ok "Aapt installation found"
    ok "Package info auto-detected: \n${BLUE}$PACKAGEINFO"
    ok "Permissions auto-detected:\n${BLUE}$PACKAGEPERMS"
#end aapt test and packagename setup




#obb test
OBBCOUNT=$(find ./ -name "*.obb" | wc -l)
OBBLOCS=$(find ./ -name "*.obb")
if [[ $OBBCOUNT -gt 0 ]] ; then
 for file in $OBBLOCS; do
    [[ ! -e $file ]] && continue
    ok "OBB FOUND: ${BLUE}$file"
 done
fi
#end obb test




#ask verification
verify $OBBCOUNT
printf "\n"
printf "\n"



#MP user stuff
[ -z $CI ] && OLDUSER=$($ADB shell settings get global username)
info "${BLUE}Please enter a multiplayer username below: [$OLDUSER]:"
printf "        " 
read USERNAME
USERNAME=${USERNAME:-$OLDUSER}

[ -z $CI ] && $ADB shell settings put global username $USERNAME
[ -z $CI ] && $ADB shell "echo '{\"username\":\"$USERNAME\"}' > /sdcard/user.json"
[ -z $CI ] && $ADB shell "echo '{\"username\":\"$USERNAME\"}' > /sdcard/qq1091481055.json"

ok "Multiplayer username set as: $USERNAME"

#end json and multiplayer user test












info "(Re)Installing $PACKAGENAME"
[ -z $CI ] && $ADB uninstall "$APKNAME" > /dev/null
[ -z $CI ] && $ADB install -g -d "$APKNAME" > /dev/null
ok "(Re)Installed $PACKAGENAME"
#uninstall and install




#copy and move obb
for file in $OBBLOCS; do
    [[ ! -e $file ]] && continue  # continue, if file does not exist
    HASOBBS=true

    file=$(echo "$file" | sed 's/.\/\//.\//')

    OBBFILE=$(echo "$file"| cut -c 3-)
    OBBNAME=$(echo $OBBFILE | awk -F'/' '{print $2}')
    OBBNAME=${OBBNAME#/}
    OBBFILE=${OBBFILE#/}


    info "Removing old OBB file: $OBBFILE (in case previously installed)"
    [ -z $CI ] && $ADB shell rm -r $STORAGE/obb/$PACKAGENAME 2> /dev/null
    [ -z $CI ] && $ADB shell rm -r $STORAGE/Android/obb/$PACKAGENAME 2> /dev/null
    ok "Removed old OBB file: $OBBFILE"
    
    info "Pushing new OBB file: $OBBFILE to $STORAGE/Download/obb/$PACKAGENAME"
    $ADB push $OBBFILE $STORAGE/Download/obb/$PACKAGENAME/$OBBNAME
    ok "Pushed new OBB file: $OBBFILE"	
done

if [[ $HASOBBS == true ]] ; then
    info "Moving OBB files to correct directory: $STORAGE/Android/obb/$PACKAGENAME, please be patient, this step has no progress indicator"
    [ -z $CI ] && $ADB shell mv $STORAGE/Download/obb/$PACKAGENAME $STORAGE/Android/obb/$PACKAGENAME
    info "Moved OBB files to correct directory"
fi
#end copy and move obb


if [ -z $CI ] && [ "$($ADB shell getprop debug.oculus.refreshRate)" != "90" ];then
	info "${BLUE}Should we go ahead and enable 90hz while we are at it? (y/n) "
	printf "        " 
	read yesno < /dev/tty
	if [ "x$yesno" = "xy" ];then

	      $ADB shell setprop debug.oculus.refreshRate 90
	      ok "90hz enabled, please click the power button, to turn on and off your SCREEN to enable the 90hz mode!"
	fi
fi
#end 90hz


ok ""
ok ""
ok "DONE, install finished, you can now disconnect your device"
