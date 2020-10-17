#!/bin/bash

#some settings
ADB=adb # LOCATION TO ADB EXECUTABLE
AAPT=aapt # LOCATION TO AAPT EXECUTABLE

#some colors
RED='\033[0;31m'
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
function error(){
   echo -e "${RED}[ERROR] $1 ${PURPLE}"
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
echo -e "${PURPLE}============================================================"
echo -e "= Quest(1/2) sideloader for linux by Whitewhidow/BranchBit ="
echo -e "============================================================"
echo -e "=support:contact@branchbit.be==============================="
echo -e "============================================================"
echo -e "=========www.github.com/whitewhidow/quest-sideloader-linux=="
printf "\n"






#adb test
info "Testing adb installation"
if ! command -v $ADB &> /dev/null
then
	error "ADB installation could not be found, please edit the adb location in this file"
	exit 1
fi
ok "ADB installation is present"
#end adb test


#device test
info "Testing headset connection"
DEVICES=$(adb devices)
DEVICECHECK=$(($(echo "$DEVICES" | grep device | wc -l)-1))
if [ "$DEVICECHECK" == 2 ]
then
  error "Multiple devices found, make sure there is only ONE adb connection (check using \"adb devices\")."
  exit 1
fi
if [ "$DEVICECHECK" == 0 ]
then
  error "No device connected, make sure there is ONE adb connection (check using \"adb devices\")."
  #exit 1
fi
    
#devicename   
DEVICE=$(echo "$DEVICES" | tail -1 | sed 's/device//')

ok "Device detected: $DEVICE"
STORAGE=$($ADB shell 'echo $EXTERNAL_STORAGE' 2> /dev/null)
if [ -z "$STORAGE" ]
then
  error "NO DEVICE FOUND, please test manually using \"$ADB devices\", there needs to be a device attached"
  #exit 1
fi
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
    info "APK FOUND: ${BLUE}./$APKNAME	"
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
    info "Package info auto-detected: \n${BLUE}$PACKAGEINFO"
    info "Permissions auto-detected:\n${BLUE}$PACKAGEPERMS"
fi
#end aapt test and packagename setup




#obb test
OBBCOUNT=$(find ./ -name "*.obb" | wc -l)
OBBLOCS=$(find ./ -name "*.obb")
if [[ $OBBCOUNT -gt 0 ]] ; then
 for file in $OBBLOCS; do
    [[ ! -e $file ]] && continue
    info "OBB FOUND: ${BLUE}$file"
 done
fi
#end obb test




#ask verification
verify $OBBCOUNT
printf "\n"
printf "\n"



#json and multiplayer user test
info "testing if json files are present"
if [[ `adb shell ls /mnt/sdcard/user.json 2> /dev/null` ]]; then
  ok "user.json is present on device"
else
  info "user.json NOT found on the device, Will attempt to dl it and push it now"
  wget -q https://gist.githubusercontent.com/whitewhidow/58a0e10ad06743e1c031e3eecc286d37/raw/903ad48bd595e6c40dd1a8dd85b31cb4d0f7d006/user.json
  $ADB push ./user.json $STORAGE/user.json
  ok "user.json pushed"
fi
if [[ `adb shell ls /mnt/sdcard/qq1091481055.json 2> /dev/null` ]]; then
  ok "qq1091481055.json is present on device"
else
  info "qq1091481055.json NOT found on the device, Will attempt to dl it and push it now"
  wget -q https://gist.githubusercontent.com/whitewhidow/cf42c26110509698e43c0d0c363772ca/raw/55abd1ee1bc55508271caa1dc4b74fd82567ef60/qq1091481055.json
  $ADB push ./qq1091481055.json $STORAGE/qq1091481055.json
  ok "qq1091481055.json pushed"
fi


info "Please enter a username below and press ENTER (for new type of MP patches that dont use user.json)"
printf "        " 
read USERNAME
$ADB shell settings put global username $USERNAME
ok "mp username patched as: $USERNAME"
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
