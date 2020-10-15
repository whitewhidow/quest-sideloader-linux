#!/bin/bash

ADB=adb # LOCATION TO ADB EXECUTABLE
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
HASOBBS=false

function pause(){
   printf "\n"
   read -p "    Press any key to continue, or CTRL+C to Cancel"
}

function info(){
   echo -e "    ${PURPLE}[INFO ] $1 ${PURPLE}"
}
function ok(){
   echo -e "    ${GREEN}[OK   ] $1 ${PURPLE}"
}

function error(){
   echo -e "    ${RED}[ERROR] $1 ${PURPLE}"
}

function verify(){
   printf "\n"
   echo -e "${BLUE}"
   echo -e "    YOU ARE ABOUT TO INSTALL: 1 APK AND $1 OBB FILES !"
   read -p "    VERIFY THE ABOVE INFO, AND CLICK ANY KEY TO CONINUE, or CTRL+C to Cancel"
   
}



clear
printf "\n"
echo -e "${PURPLE}    ============================================================"
echo -e "    = Quest(1/2) sideloader for linux by Whitewhidow/BranchBit ="
echo -e "    ============================================================"
echo -e "    =support:contact@branchbit.be==============================="
echo -e "    ============================================================"
printf "\n"






APKNAME=$(find ./ -name "*.apk"| cut -c 3-)
PACKAGENAME=$(aapt dump badging "$APKNAME" | grep package:\ name | awk '/package/{gsub("name=|'"'"'","");  print $2}')


# CHECK IF APK FOUND
if test -f "$APKNAME"; then
    info "APK FOUND: ${BLUE}./$APKNAME ($PACKAGENAME)	"
else
      error "NO VALID APK FOUND IN CURRENT DIRECTORY"
      exit 1
fi




OBBCOUNT=$(find ./ -name "*.obb" | wc -l)
OBBLOCS=$(find ./ -name "*.obb")


if [[ $OBBCOUNT -gt 0 ]] ; then
 for file in $OBBLOCS; do
    [[ ! -e $file ]] && continue
    info "OBB FOUND: ${BLUE}$file"
 done
fi



verify $OBBCOUNT
printf "\n"
printf "\n"




















info "Testing adb installation"
if ! command -v $ADB &> /dev/null
then
	error "ADB installation could not be found, please edit the adb location in this file"
	exit 1
fi
# adb is attached, tell the user
ok "ADB installation is present"





info "Testing headset connetcion"
STORAGE=$($ADB shell 'echo $EXTERNAL_STORAGE' 2> /dev/null)
if [ -z "$STORAGE" ]
then
  error "NO DEVICE FOUND, please test manually using \"$ADB devices\", there needs to be a device attached"
  #exit 1
fi


# DEVICE is attached, tell the user

ok "ADB DEVICE DETECTED"




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



















info "Uninstalling $PACKAGENAME (in case previously installed)"
$ADB uninstall $PACKAGENAME > /dev/null
ok "Uninstalled $PACKAGENAME"
info "Installing $PACKAGENAME"
$ADB install "$APKNAME" > /dev/null
ok "Installed $PACKAGENAME"
info "Setting Permissions"
$ADB shell pm grant $PACKAGENAME android.permission.RECORD_AUDIO 2> /dev/null
$ADB shell pm grant $PACKAGENAME android.permission.READ_EXTERNAL_STORAGE 2> /dev/null
$ADB shell pm grant $PACKAGENAME android.permission.WRITE_EXTERNAL_STORAGE 2> /dev/null
ok "Permissions set for $PACKAGENAME"





for file in $OBBLOCS; do
    [[ ! -e $file ]] && continue  # continue, if file does not exist
    HASOBBS=true

    OBBFILE=$(echo "$file"| cut -c 3-)
    OBBNAME=$(echo $OBBFILE | awk -F'/' '{print $2}')
    #echo -e "OBB File found: $OBBFILE"
    #echo -e "OBBName : $OBBNAME"
    
    
    info "Removing old OBB file: $OBBFILE (in case previously installed)"
    $ADB shell rm -r $STORAGE/obb/$PACKAGENAME 2> /dev/null
    $ADB shell rm -r $STORAGE/Android/obb/$PACKAGENAME 2> /dev/null
    ok "Removed old OBB file: $OBBFILE"
    
    info "Pushing new OBB file: $OBBFILE to $STORAGE/Download/obb/$PACKAGENAME"
    $ADB push $OBBFILE $STORAGE/Download/obb/$PACKAGENAME/$OBBNAME
    ok "Pushed new OBB file: $OBBFILE"
    	
    	
done

if [[ $HASOBBS == true ]] ; then
    info "Moving OBB files to correct directory:"
    $ADB shell mv $STORAGE/Download/obb/$PACKAGENAME $STORAGE/Android/obb/$PACKAGENAME
    info "Moved OBB files to correct directory: $STORAGE/Android/obb/$PACKAGENAME"
fi

ok ""
ok ""
ok "DONE, install finished, you can now disconnect your device"




