#!/bin/bash


# the below if, so you add can this script to your udev for automatic wireless connection !!     , RUN+="path/to/connectviawifi.sh sleep"
if [ $# -eq 1 ]
  then
    sleep 3
fi


DEVICES=$(adb devices)
DEVICECHECK=$(($(echo "$DEVICES" | grep device | wc -l)-1))
##echo "$DEVICECHECK Device found"
  if [ "$DEVICECHECK" == 2 ]
  then
    echo "2 Devices found, you are most likely connected via wifi AND usb."
    exit 1
  fi
  if [ "$DEVICECHECK" == 0 ]
  then
    echo "No device connected, please connect usb."
    exit 1
  fi


DEVICE=$(echo "$DEVICES" | tail -1)

if [[ $DEVICE == 192* ]]
then
  echo "1 Device found, already connected via wifi."
  exit 1
fi


WIFIIP=$(adb shell ip addr show wlan0 2> /dev/null | grep 'inet ' | cut -d' ' -f6|cut -d/ -f1 | sed '/^$/d') 2> /dev/null


if [ -z "$WIFIIP" ]
then
  echo "NO USB DEVICE DETECTED, THAT HAS WIFI ENABLED, PLEASE CONNECT USB DEVICE THAT HAS WIFI ENABLED"
  exit 1
fi


[[ $a == z* ]]


  echo "HMD IP Found: $WIFIIP"
  
  
  
  WIFISTART=$(adb tcpip 5555)
  
  WIFICHECK=$(adb connect $WIFIIP:5555)

  if [ "$WIFICHECK" == "connected to $WIFIIP:5555" ]
  then
    sleep 1
    adb devices 2> /dev/null
    sleep 1
    echo "ADB over WIFI established on ip $WIFIIP , GOOD TO GO, YOU CAN UNPLUG NOW"
    exit 1
  fi
