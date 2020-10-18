#!/bin/bash

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
   echo -e "${RED}[ERROR] $1 ${PURPLE}"
}
function warning(){
   echo -e "${ORANGE}[WARNING] $1 ${PURPLE}"
}
function verify(){
   printf "\n"
   echo -e "${BLUE}"
   echo -e "YOU ARE ABOUT TO INSTALL: \"$PACKAGENAME\" APK AND $1 OBB FILES INTO $DEVICE !"
   read -p "VERIFY THE ABOVE INFO, AND CLICK ANY KEY TO CONINUE, or CTRL+C to Cancel"
   
}




#start
clear
printf "\n"
echo -e "${PURPLE}===================================================================="
echo -e "= Quest(1/2) sideloader for linux , mac and Windows(WSL1 only atm)=="
echo -e "===================================================================="
echo -e "=================================== by Whitewhidow/BranchBit ======="
echo -e "==================================support:contact@branchbit.be======"
echo -e "===================================================================="
echo -e "=========www.github.com/whitewhidow/quest-sideloader-linux=========="
printf "\n"







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
  error "WINDOWS HOST ADB Detection"
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



## ADB INSTALL
info "LOCAL ADB Detection"
if [[ $(which $ADB) == *"$ADB"* ]]
then
 ADBGLOBALINSTALLED=true
else
 ADBGLOBALINSTALLED=false
fi

if [ "$ADBGLOBALINSTALLED" == false ]; then
  if [ $OSTYPE == "Linux" ]; then
    warning "PLEASE INSTALL adb from android-platform-tools, WE WILL JUST DOWNLOAD LOCALLY FOR NOW, NO WORRIES !"
    info "DOWNLOADING https://dl.google.com/android/repository/platform-tools_r30.0.4-linux.zip"
    curl -s -f https://dl.google.com/android/repository/platform-tools_r30.0.4-linux.zip -o platform-tools-linux.zip
    unzip -oq platform-tools-linux.zip
    ln -sf ./platform-tools/adb ./adb
    chmod +x ./adb
    ADB="./adb"
    warning "PLEASE INSTALL adb from android-platform-tools to avoid this download in the future !"
  fi
  if [ $OSTYPE == "Mac" ]; then
    warning "PLEASE INSTALL adb from android-platform-tools, WE WILL JUST DOWNLOAD LOCALLY FOR NOW, NO WORRIES !"
    info "DOWNLOADING https://dl.google.com/android/repository/fbad467867e935dce68a0296b00e6d1e76f15b15.platform-tools_r30.0.4-darwin.zip"
    curl -s -f https://dl.google.com/android/repository/fbad467867e935dce68a0296b00e6d1e76f15b15.platform-tools_r30.0.4-darwin.zip -o platform-tools-darwin.zip
    unzip -oq platform-tools-darwin.zip
    ln -sf ./platform-tools/adb ./adb
    chmod +x ./adb
    AAPT="./adb"
    warning "PLEASE INSTALL adb from android-platform-tools to avoid this download in the future !!"
  fi
  #IF NOT ISNTALLED AND WSL   INSTALL
  if [ $OSTYPE == "WSL1" ]; then
    warning "PLEASE INSTALL adb from android-platform-tools, WE WILL JUST DOWNLOAD LOCALLY FOR NOW, NO WORRIES !"
    info "DOWNLOADING https://dl.google.com/android/repository/platform-tools_r30.0.4-linux.zip"
    curl -s -f https://dl.google.com/android/repository/platform-tools_r30.0.4-linux.zip -o platform-tools-linux.zip
    unzip -oq platform-tools-linux.zip
    ln -sf ./platform-tools/adb ./adb
    chmod +x ./adb
    ADB="./adb"
    warning "PLEASE INSTALL adb from android-platform-tools to avoid this download in the future !"
  fi
fi


#IS INSTALLED BUT WRONG VERSION INSTALL
if [ "$ADBGLOBALINSTALLED" == true ] && [ $OSTYPE == "WSL1" ] && [ "$($ADB --version | sed -n 2p)" != "Version 30.0.4-6686687" ]; then
    error ""
    error "WRONG VERSION OF LOCAL ADB DETECTED $($ADB --version | sed -n 2p)"
    error "FOR USE WITH WSL1 PLEASE INSTALL adb (30.0.4) from android-platform-tools, OR REMOVE IT ALTOGETHER"
    info "https://dl.google.com/android/repository/platform-tools_r30.0.4-linux.zip"
    error "FOR UES WITH WSL1 PLEASE INSTALL adb (30.0.4) from android-platform-tools!"
    exit
fi



ok "LOCAL ADB $($ADB --version | sed -n 2p)"
ok "LOCAL ADB path set to: \"$ADB\""
## END ADB INSTALL




## AAPT INSTALL
info "LOCAL AAPT Detection"
if [[ $(which $AAPT) == *"$AAPT"* ]]; then
  AAPTGLOBALINSTALLED=true
else
  AAPTGLOBALINSTALLED=false
fi
if [ "$AAPTGLOBALINSTALLED" == false ]; then
  if [ $OSTYPE == "Linux" ] || [ $OSTYPE == "WSL1" ]; then
    warning "PLEASE INSTALL aapt from androidaapt.com, WE WILL JUST DOWNLOAD LOCALLY FOR NOW, NO WORRIES !"
    info "DOWNLOADING https://dl.google.com/android/repository/build-tools_r28.0.2-linux.zip"
    curl -s https://dl.google.com/android/repository/build-tools_r28.0.2-linux.zip -o build-tools_r28.0.2-linux.zip
    unzip -oq build-tools_r28.0.2-linux.zip
    ln -sf ./android-9/aapt ./aapt
    chmod +x ./aapt
    AAPT="./aapt"
    warning "PLEASE INSTALL aapt from androidaapt.com to avoid this download in the future !!"
  fi
  if [ $OSTYPE == "Mac" ]; then
    warning "PLEASE INSTALL aapt from androidaapt.com, WE WILL JUST DOWNLOAD LOCALLY FOR NOW, NO WORRIES !"
    info "DOWNLOADING https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/mac_aapt_lib/aapt"
    curl -s https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/mac_aapt_lib/aapt -o aapt
    chmod +x ./aapt
    AAPT="./aapt"
    warning "PLEASE INSTALL aapt from androidaapt.com to avoid this download in the future !!"
  fi
fi
ok "LOCAL AAPT path set to: \"$AAPT\""
## END AAPT INSTALL
















if [ "$(pgrep $ADB)" ]
then
 ADBPROCESSRUNNING=true
else
 ADBPROCESSRUNNING=false
fi
#if [ $ADBPROCESSRUNNING == true ]; then
#  info "ADB PROCESS RUNNING: $(pgrep $ADB)"
#fi


if timeout 1 bash -c '</dev/tcp/127.0.0.1/5037 &>/dev/null' &>/dev/null
then
  ADBPORTRUNNING=true
else
  ADBPORTRUNNING=false
fi
#if [ $ADBINSTALLED == true ]
#echo "Something Listening on port 5037"







#restart adb
#$ADB kill-server 2> /dev/null
#$ADB get-state 2> /dev/null


#device test
info "Device detetction"
DEVICES=$($ADB devices)
DEVICECHECK=$(($(echo "$DEVICES" | grep device | wc -l)-1))
if [ "$DEVICECHECK" == 2 ]
then
  error "Multiple devices found, make sure there is only ONE adb connection (check using \"adb devices\")."
  exit 1
fi
if [ "$DEVICECHECK" == 0 ]
then
  error "No device connected, make sure there is ONE adb connection (check using \"adb devices\")."
  exit 1
fi
    
#devicename   
DEVICE=$(echo "$DEVICES" | tail -1 | sed 's/device//')
ok "Device detected: $DEVICE"

STORAGE=$($ADB shell 'echo $EXTERNAL_STORAGE' 2> /dev/null)
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
info "Testing aapt installation"
if ! command -v $AAPT &> /dev/null
then
    error "aapt installation could not be found, please edit the aapt location in this file and restart, or enter the packagename manually below"
    if [[ $SINGLEDIR == 1 ]] ; then
       info "Packagename SUGGESTION BASED ON FOLDERNAME: ${BLUE}$SUGGESTION"
    fi
    info ""
    error "PLEASE MANUALLY ENTER THE CORRECT PACKAGENAME (such as ${BLUE}com.oculus.HouseFlipperVR${RED} or ${BLUE}com.SDI.TWD${RED}) BELOW AND PRESS ENTER:"
    printf "        " 
    read PACKAGENAME
    ok "Packagename SET AS : $PACKAGENAME"
else
    PACKAGENAME=$($AAPT dump badging "$APKNAME" | grep package:\ name | awk '/package/{gsub("name=|'"'"'","");  print $2}')
    PACKAGEINFO=$($AAPT dump badging "$APKNAME" | head -n 1 )
    PACKAGEPERMS=$($AAPT dump badging "$APKNAME" | grep "name='android.permission" | awk -F "'" '{print $2}')
    ok "Aapt installation found"
    ok "Package info auto-detected: \n${BLUE}$PACKAGEINFO"
    ok "Permissions auto-detected:\n${BLUE}$PACKAGEPERMS"
fi
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
info "Please enter a username below and press ENTER (for new type of MP patches that dont use user.json)"
printf "        " 
read USERNAME
$ADB shell settings put global username $USERNAME
ok "mp username patched as: $USERNAME"


echo "{\"username\":\"USERNAME\"}" >> /tmp/user.json
echo "{\"username\":\"USERNAME\"}" >> /tmp/qq1091481055.json
$ADB push /tmp/user.json $STORAGE/user.json
ok "user.json pushed"
$ADB push /tmp/qq1091481055.json $STORAGE/qq1091481055.json
  ok "qq1091481055.json pushed"
#end json and multiplayer user test











#uninstall and install
info "Uninstalling $PACKAGENAME (in case previously installed)"
$ADB uninstall $PACKAGENAME > /dev/null
ok "Uninstalled $PACKAGENAME"
info "Installing $PACKAGENAME"
$ADB install "$APKNAME" > /dev/null
ok "Installed $PACKAGENAME"
#uninstall and install



#set permissions
if ! command -v $AAPT &> /dev/null
then
	info "Setting default (all) Permissions"
	$ADB shell pm grant $PACKAGENAME android.permission.RECORD_AUDIO 2> /dev/null
	$ADB shell pm grant $PACKAGENAME android.permission.READ_EXTERNAL_STORAGE 2> /dev/null
	$ADB shell pm grant $PACKAGENAME android.permission.WRITE_EXTERNAL_STORAGE 2> /dev/null
	$ADB shell pm grant $PACKAGENAME android.permission.ACCESS_WIFI_STATE 2> /dev/null
	$ADB shell pm grant $PACKAGENAME android.permission.INTERNET 2> /dev/null
	$ADB shell pm grant $PACKAGENAME android.permission.ACCESS_NETWORK_STATE 2> /dev/null
	$ADB shell pm grant $PACKAGENAME android.permission.WAKE_LOCK 2> /dev/null
	#$ADB shell pm grant $PACKAGENAME com.android.vending.CHECK_LICENSE 2> /dev/null
	$ADB shell pm grant $PACKAGENAME com.google.android.c2dm.permission.RECEIVE 2> /dev/null
	$ADB shell pm grant $PACKAGENAME android.permission.BROADCAST_STICKY 2> /dev/null
	$ADB shell pm grant $PACKAGENAME android.permission.MODIFY_AUDIO_SETTINGS 2> /dev/null
	$ADB shell pm grant $PACKAGENAME android.permission.BLUETOOTH 2> /dev/null
else
  info "Setting auto detected Permissions"
  for PERM in $PACKAGEPERMS; do
    info "Setting permission '$PERM' for package $PACKAGENAME"
    $ADB shell pm grant $PACKAGENAME $PERM 2> /dev/null
  done
fi
ok "Permissions set for $PACKAGENAME"
#endset permissions





#copy and move obb
for file in $OBBLOCS; do
    [[ ! -e $file ]] && continue  # continue, if file does not exist
    HASOBBS=true

    OBBFILE=$(echo "$file"| cut -c 3-)
    OBBNAME=$(echo $OBBFILE | awk -F'/' '{print $2}')
    
    info "Removing old OBB file: $OBBFILE (in case previously installed)"
    $ADB shell rm -r $STORAGE/obb/$PACKAGENAME 2> /dev/null
    $ADB shell rm -r $STORAGE/Android/obb/$PACKAGENAME 2> /dev/null
    ok "Removed old OBB file: $OBBFILE"
    
    info "Pushing new OBB file: $OBBFILE to $STORAGE/Download/obb/$PACKAGENAME"
    $ADB push $OBBFILE $STORAGE/Download/obb/$PACKAGENAME/$OBBNAME
    ok "Pushed new OBB file: $OBBFILE"	
done

if [[ $HASOBBS == true ]] ; then
    info "Moving OBB files to correct directory: $STORAGE/Android/obb/$PACKAGENAME, please be patient, this step has no progress indicator"
    $ADB shell mv $STORAGE/Download/obb/$PACKAGENAME $STORAGE/Android/obb/$PACKAGENAME
    info "Moved OBB files to correct directory"
fi
#end copy and move obb

#90hz
info "${BLUE}Should we go ahead and enable 90hz while we are at it? (y/n) "
printf "        " 
read yesno < /dev/tty
if [ "x$yesno" = "xy" ];then

      $ADB shell setprop debug.oculus.refreshRate 90
      ok "90hz enabled, please click the power button, to turn on and off your SCREEN to enable the 90hz mode!"
fi
#end 90hz


ok ""
ok ""
ok "DONE, install finished, you can now disconnect your device"
