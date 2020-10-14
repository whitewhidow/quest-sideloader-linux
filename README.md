# quest-sideloader-linux
Simple quest sideloader for linux


## Installation
Download the sh file, and make itexecutable and globally available:
```
#navigate to the script directory
cd quest-sideloader-linux
#make executable
sudo chmod +x $PWD/sideload.sh
#make available on path
sudo ln -s $PWD/sideload.sh /usr/local/bin/sideload
```


## Prerequisites before first use
Linux needs udev rules to allow proper access via adb:
```
sudo su                                  #run the below as REAL sudo
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="2833", ATTR{idProduct}=="0186", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/51-android.rules
exit                                     #go back to regular user
usermod -a -G plugdev $user              #add regular user to plugdev group
udevadm control --reload-rules           #reload udev rules
#ps the above can also be done simpler, by using a group you are already part of, instead of the plugdev group
```


## Usage
Simple download an APK and (optinoal) obb file from your prefered source.
Navigate to the directory, and run sidequest.


###Example output:
```

sam@P7xxTM  ~/Downloads/Telegram Desktop/Vader Immortal - Episode 3 v3.0.2  sideload

    ============================================================
    = Easy quest sideloader for linux by Whitewhidow/BranchBit =
    ============================================================
    =======================================contact@branchbit.be=
    ============================================================

    [OK] ADB DEVICE found: /sdcard

    [READ] user.json NOT found on the deivce, Will attempt to dl it and push it now
    [OK] user.json pushed
    [READ] qq1091481055.json NOT found on the device, Will attempt to dl it and push it now
    [OK] qq1091481055.json pushed

    [OK] APK File found: Vader_Immortal_Episode_III.[3.0.2.236944]_patched.apk.
    [OK] OBB File found: com.ILMxLAB.VaderImmortal.ep3/main.236944.com.ILMxLAB.VaderImmortal.ep3.obb.

    [READ] Should we attempt to UNINSTALL EXISTING com.ILMxLAB.VaderImmortal.ep3 application from the device? (y/n) 
n

    Will now attempt to INSTALL the com.ILMxLAB.VaderImmortal.ep3 application. Failures here indicate a problem with the device connection or storage permissions and are fatal!
    Press any key to continue, or CTRL+C to Cancel ... AND BE PATIENT PLEASE
Success

    [READ] Should we now attempt to REMOVE EXISTING OBB data for the com.ILMxLAB.VaderImmortal.ep3 application? from the device? (y/n)
n

    Will now attempt to GRANT permissions to com.ILMxLAB.VaderImmortal.ep3.
    Press any key to continue, or CTRL+C to Cancel ... AND BE PATIENT PLEASE

    Will now attempt to PUSH the com.ILMxLAB.VaderImmortal.ep3 obb data file to the downloads folder. Failures here indicate storage problems missing SD card or bad permissions and are fatal.
    Press any key to continue, or CTRL+C to Cancel ... AND BE PATIENT PLEASE
com.ILMxLAB.VaderImmortal.ep3/main.236944.com.ILMxLAB.VaderImmortal.ep3.obb: 1 file pushed. 39.4 MB/s (3890209223 bytes in 94.135s)

    Will now attempt to move obb data file from the downloads folder to the Andoird/obb folder.
    Press any key to continue, or CTRL+C to Cancel ... AND BE PATIENT PLEASE

    [OK] Vader_Immortal_Episode_III.[3.0.2.236944]_patched.apk installed !!
```

Please feel free to ask for help when encountering any issues


 Copyright (c) 2020 WhiteWhidow/branchBit

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
