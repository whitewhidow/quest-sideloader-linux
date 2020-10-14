#!/bin/bash

# [CONFIG]
ADB=adb # LOCATION TO ADB EXECUTABLE

# [INFO]
# before this can be used, make sure udev rules are in place:
#
#sudo su                                  #run the below as REAL sudo
#echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="2833", ATTR{idProduct}=="0186", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/51-android.rules     # or sudo ipv plugdev and skip rest ? 
#exit                                     #go back to regular user
#usermod -a -G plugdev $user              #add regular user to plugdev group
#udevadm control --reload-rules           #reload udev rules
#and from then on, this script can be run at will


# [CRAP]
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color
function pause(){
   read -p "    Press any key to continue, or CTRL+C to Cancel ... AND BE PATIENT PLEASE"
}
function pauseForObb(){
   read -p "ONLY IF YOU WANT TO CONTINUE WITHOUT AN OBB FILE, press any key, OTHERWISE press CTRL+C to Cancel this sideloading action ..."
}

	
	
	





clear
printf "\n"
echo -e "${PURPLE}    ============================================================"
echo -e "    = Easy quest sideloader for linux by Whitewhidow/BranchBit ="
echo -e "    ============================================================"
echo -e "    =======================================contact@branchbit.be="
echo -e "    ============================================================"


# check if adb installed, if not, error
if ! command -v $ADB &> /dev/null
then
      printf "\n"
      echo -e "    ${RED}[ERROR] ADB installation could not be found, please edit the adb location in this file"
      printf "\n"
      exit 1
fi



#printf "\n" printf "\n" 



# check if DEVICE is attached, if not, error
STORAGE=$($ADB -d shell 'echo $EXTERNAL_STORAGE' 2> /dev/null)
if [ -z "$STORAGE" ]
then
  printf "\n"
  echo -e "    ${RED}[ERROR] NO DEVICE FOUND, please test manually using \"$ADB devices\", there needs to be a device attached"
  printf "\n"
  exit 1
  echo 's'
fi



# DEVICE is attached, tell the user
printf "\n"
echo -e "    ${GREEN}[OK] ADB DEVICE found: $STORAGE"
printf "\n" 



# // COPY MISSING JSON FILES IF NOT EXISTING https://www.thetopsites.net/article/51827886.shtml // https://gist.github.com/seamountain/5940102




if [[ `adb shell ls /mnt/sdcard/user.json 2> /dev/null` ]]; then
  echo -e "    ${GREEN}[OK] user.json is present on device"
else
  echo -e "    ${PURPLE}[READ] user.json NOT found on the deivce, Will attempt to dl it and push it now"
  wget -q https://gist.githubusercontent.com/whitewhidow/58a0e10ad06743e1c031e3eecc286d37/raw/903ad48bd595e6c40dd1a8dd85b31cb4d0f7d006/user.json
  $ADB push ./user.json $STORAGE/user.json
  echo -e "    ${GREEN}[OK] user.json pushed"
fi


if [[ `adb shell ls /mnt/sdcard/qq1091481055.json 2> /dev/null` ]]; then
  echo -e "    ${GREEN}[OK] qq1091481055.json is present on device"
else
  echo -e "    ${PURPLE}[READ] qq1091481055.json NOT found on the device, Will attempt to dl it and push it now"
  wget -q https://gist.githubusercontent.com/whitewhidow/cf42c26110509698e43c0d0c363772ca/raw/55abd1ee1bc55508271caa1dc4b74fd82567ef60/qq1091481055.json
  $ADB push ./qq1091481055.json $STORAGE/qq1091481055.json
  echo -e "    ${GREEN}[OK] qq1091481055.json pushed"
fi


printf "\n" 










APKNAME=$(find ./ -name "*.apk"| cut -c 3-)
#echo "    APKNAME: $APKNAME"

OBBLOC=$(find ./ -name "*.obb"| cut -c 3-)
#echo OBBLOC: $OBBLOC

COMNAME=$(echo $OBBLOC | awk -F'/' '{print $1}')
#echo "    COMNAME: $COMNAME		"

OBBNAME=$(echo $OBBLOC | awk -F'/' '{print $2}')
#echo "    OBBNAME: $OBBNAME	"



# CHECK IF APK FOUND
if test -f "$APKNAME"; then
    echo -e "    ${GREEN}[OK] APK File found: $APKNAME."
else
      clear
      printf "\n"
      echo -e "    ${RED}[ERROR] NO APK FOUND"
      printf "\n"
      exit 1
fi

# CHECK IF OBB FOUND AND/OR WANTED
if test -f "$OBBLOC"; then
    echo -e "    ${GREEN}[OK] OBB File found: $OBBLOC."
else
    echo -e "    ${RED}[READ] OBB File MISSING: !!!!!!!! ${PURPLE}"
    printf "\n    ${RED}[READ]${PURPLE} "
    pauseForObb
    echo -e "${NC}"
fi






printf "\n"
 



# delete old app?
echo -e "    ${PURPLE}[READ] Should we attempt to UNINSTALL EXISTING $COMNAME application from the device? (y/n) "
read yesno < /dev/tty
if [ "x$yesno" = "xy" ];then
   
  adb uninstall $COMNAME
  printf "\n"
fi


echo -e "    ${GREEN}Will now attempt to INSTALL the $COMNAME application. Failures here indicate a problem with the device connection or storage permissions and are fatal!"
pause
adb install "$APKNAME"
printf "\n"



#other removals?
#adb shell rm -r $STORAGE/UE4Game/Pavlov
#adb shell rm -r $STORAGE/UE4Game/UE4CommandLine.txt



echo -e "    ${PURPLE}[READ] Should we now attempt to REMOVE EXISTING OBB data for the $COMNAME application? from the device? (y/n)"
read yesno < /dev/tty
if [ "x$yesno" = "xy" ];then
  adb shell rm -r $STORAGE/obb/$COMNAME
  adb shell rm -r $STORAGE/Android/obb/$COMNAME
  printf "\n"
fi



echo -e "    ${GREEN}Will now attempt to GRANT permissions to $COMNAME."
pause
adb shell pm grant $COMNAME android.permission.RECORD_AUDIO 2> /dev/null
adb shell pm grant $COMNAME android.permission.READ_EXTERNAL_STORAGE
adb shell pm grant $COMNAME android.permission.WRITE_EXTERNAL_STORAGE
printf "\n"



#other requirements?
#adb push name.txt $STORAGE/pavlov.name.txt

echo "    Will now attempt to PUSH the $COMNAME obb data file to the downloads folder. Failures here indicate storage problems missing SD card or bad permissions and are fatal."
pause
adb push $OBBLOC $STORAGE/Download/obb/$COMNAME/$OBBNAME
printf "\n"


echo "    Will now attempt to move obb data file from the downloads folder to the Andoird/obb folder."
pause
adb shell mv $STORAGE/Download/obb/$COMNAME $STORAGE/Android/obb/$COMNAME
printf "\n"


echo "    [OK] $APKNAME installed !!"
printf "\n"



