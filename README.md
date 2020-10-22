# Quest-sideloader
Quest(1/2) sideloader for linux , mac and Windows(WSL1).

*GLOBAL INSTALL NOW SUPPORTS SIDELOADING STRAIGHT FROM FTP (RCLONE/GDRIVE) MOUNT !*

Will take care of installing and moving apk, obb(s), permissions and json(s) all in one go.

_Will also automatically place the OBB's in the CORRECT FOLDER, and provide CORRECT PERMISSIONS, occording to the APK's METADATA, no more guessing._

![](example.gif)


# Try the one-liner first, no install required!
Run this from inside any 'app-folder' folder containing an apk, and optional OBB file(s).
<!--
Last stable build: 
```bash
curl https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/v2.2/sideload.sh > sideload.sh && chmod +x ./sideload.sh && sudo ./sideload.sh
```
-->
Most recent build: 
```bash
curl https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/sideload.sh > sideload.sh && chmod +x ./sideload.sh && sudo ./sideload.sh
```
This will download and start the sideloader.

-----OR FOLLOW THE BELOW STEPS TO RUN LOCALLY, GLOBALLY, AND WITHOUT THE NEED FOR SUDO-----


<!-- ![example](https://i.imgur.com/cC70UUC.png) -->

## Global Installation (LINUX & MAC)
1. Download the project:
<!--
Last stable build: 
```bash
https://github.com/whitewhidow/quest-sideloader-linux/archive/v2.2.zip
```

Most recent build: 
-->

```bash
https://github.com/whitewhidow/quest-sideloader-linux/archive/main.zip
```
2. Unzip the archive and navigate to the folder:
```
unzip quest-sideloader-linux-main.zip && cd quest-sideloader-linux-main
```
3. Copy the file to your $PATH: 
```
sudo cp ./sideload.sh /usr/local/bin/sideload
```

you can now run `sideload` from any 'app-folder' folder containing an apk, and optional OBB file(s). (OR EVEN FROM AN FTP (RCLONE/GDRIVE) MOUNT)

## One-Time Prerequisites (LINUX OPTIONAL)

If your current linux need a special udev rule to allow permissions the adb device, run the following command to add them easely:
```
sudo ./extras/udev.sh $USER
```
   
   

## Ready to Sideload an apk!

Now run `sideload` from any 'app-folder' folder containing an apk, and optional OBB file(s).
Now just run the `sideload` command and follow the on screen prompts:


### Example output :
```
============================================================
= Quest(1/2) sideloader for linux by Whitewhidow/BranchBit =
============================================================
=support:contact@branchbit.be===============================
============================================================
=========www.github.com/whitewhidow/quest-sideloader-linux==

[INFO ] Testing adb installation 
[OK   ] ADB installation is present 
[INFO ] Testing headset connection 
* daemon not running; starting now at tcp:5037
* daemon started successfully
[OK   ] Device detected: 1WMHH8143H0355	 
[OK   ] Storage detected: /sdcard 
[INFO ] APK FOUND: ./Arizona Sunshine Quest [1.5] patch+savefix_MP-DLC.apk	 
[INFO ] Testing aapt installation 
[OK   ] Aapt installation found 
[INFO ] Package info auto-detected: 
package: name='com.vertigogames.azsq' versionCode='21474' versionName='1.5' platformBuildVersionName='' 
[INFO ] Permissions auto-detected:
android.permission.INTERNET
android.permission.ACCESS_NETWORK_STATE
android.permission.RECORD_AUDIO
android.permission.MODIFY_AUDIO_SETTINGS
android.permission.BROADCAST_STICKY
android.permission.BLUETOOTH
android.permission.READ_EXTERNAL_STORAGE
android.permission.WRITE_EXTERNAL_STORAGE 
[INFO ] OBB FOUND: ./com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb 


YOU ARE ABOUT TO INSTALL: "com.vertigogames.azsq" APK AND 1 OBB FILES INTO 1WMHH8143H0355	 !
VERIFY THE ABOVE INFO, AND CLICK ANY KEY TO CONINUE, or CTRL+C to Cancel


[INFO ] testing if json files are present 
[OK   ] user.json is present on device 
[OK   ] qq1091481055.json is present on device 
[INFO ] Please enter a username below and press ENTER (for new type of MP patches that dont use user.json) 
        jefke
[OK   ] mp username patched as: jefke 
[INFO ] Uninstalling com.vertigogames.azsq (in case previously installed) 
[OK   ] Uninstalled com.vertigogames.azsq 
[INFO ] Installing com.vertigogames.azsq 
[OK   ] Installed com.vertigogames.azsq 
[INFO ] Setting auto detected Permissions 
[INFO ] Setting permission 'android.permission.INTERNET' for package com.vertigogames.azsq 
[INFO ] Setting permission 'android.permission.ACCESS_NETWORK_STATE' for package com.vertigogames.azsq 
[INFO ] Setting permission 'android.permission.RECORD_AUDIO' for package com.vertigogames.azsq 
[INFO ] Setting permission 'android.permission.MODIFY_AUDIO_SETTINGS' for package com.vertigogames.azsq 
[INFO ] Setting permission 'android.permission.BROADCAST_STICKY' for package com.vertigogames.azsq 
[INFO ] Setting permission 'android.permission.BLUETOOTH' for package com.vertigogames.azsq 
[INFO ] Setting permission 'android.permission.READ_EXTERNAL_STORAGE' for package com.vertigogames.azsq 
[INFO ] Setting permission 'android.permission.WRITE_EXTERNAL_STORAGE' for package com.vertigogames.azsq 
[OK   ] Permissions set for com.vertigogames.azsq 
[INFO ] Removing old OBB file: com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb (in case previously installed) 
[OK   ] Removed old OBB file: com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb 
[INFO ] Pushing new OBB file: com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb to /sdcard/Download/obb/com.vertigogames.azsq 
com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb: 1 file pushed. 36.3 MB/s (3613580044 bytes in 94.947s)
[OK   ] Pushed new OBB file: com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb 
[INFO ] Moving OBB files to correct directory: /sdcard/Android/obb/com.vertigogames.azsq, please be patient, this step has no progress indicator 
[INFO ] Moved OBB files to correct directory 
[INFO ] Should we go ahead and enable 90hz while we are at it? (y/n)  
        y
[OK   ] 90hz enabled, please click the power button, to turn on and off your SCREEN to enable the 90hz mode! 
[OK   ]  
[OK   ]  
[OK   ] DONE, install finished, you can now disconnect your device
```


### Example output :
```

============================================================
= Quest(1/2) sideloader for linux by Whitewhidow/BranchBit =
============================================================
=support:contact@branchbit.be===============================
============================================================
=========www.github.com/whitewhidow/quest-sideloader-linux==

[INFO ] APK FOUND: ./The Walking Dead_ Saints & Sinners [2020.10.04 build 185308] patch+savefix.apk	 
[INFO ] Testing aapt installation 
[OK   ] Aapt installation found 
[INFO ] Package info auto-detected: 
package: name='com.SDI.TWD' versionCode='18530809' versionName='Shipping Stage / 2020.10.04 / build 185308' platformBuildVersionName='6.0-2438415' 
[INFO ] Permissions auto-detected:
android.permission.INTERNET
android.permission.ACCESS_NETWORK_STATE
android.permission.WAKE_LOCK
android.permission.ACCESS_WIFI_STATE
android.permission.RECORD_AUDIO
android.permission.READ_EXTERNAL_STORAGE
android.permission.WRITE_EXTERNAL_STORAGE 
[INFO ] OBB FOUND: ./com.SDI.TWD/main.18530809.com.SDI.TWD.obb 
[INFO ] OBB FOUND: ./com.SDI.TWD/patch.com.SDI.TWD.obb 


YOU ARE ABOUT TO INSTALL: 1 APK AND 2 OBB FILES !
VERIFY THE ABOVE INFO, AND CLICK ANY KEY TO CONINUE, or CTRL+C to Cancel


[INFO ] Testing adb installation 
[OK   ] ADB installation is present 
[INFO ] Testing headset connetcion 
[OK   ] ADB DEVICE DETECTED 
[INFO ] testing if json files are present 
[OK   ] user.json is present on device 
[OK   ] qq1091481055.json is present on device 
[INFO ] Please enter a username below and press ENTER (for new type of MP patches that dont use user.json) 
        jefke_vermeulen
[OK   ] mp username patched as: jefke_vermeulen 
[INFO ] Uninstalling com.SDI.TWD (in case previously installed) 
[OK   ] Uninstalled com.SDI.TWD 
[INFO ] Installing com.SDI.TWD 
[OK   ] Installed com.SDI.TWD 
[INFO ] Setting auto detected Permissions 
[INFO ] Setting permission 'android.permission.INTERNET' for package com.SDI.TWD 
[INFO ] Setting permission 'android.permission.ACCESS_NETWORK_STATE' for package com.SDI.TWD 
[INFO ] Setting permission 'android.permission.WAKE_LOCK' for package com.SDI.TWD 
[INFO ] Setting permission 'android.permission.ACCESS_WIFI_STATE' for package com.SDI.TWD 
[INFO ] Setting permission 'android.permission.RECORD_AUDIO' for package com.SDI.TWD 
[INFO ] Setting permission 'android.permission.READ_EXTERNAL_STORAGE' for package com.SDI.TWD 
[INFO ] Setting permission 'android.permission.WRITE_EXTERNAL_STORAGE' for package com.SDI.TWD 
[OK   ] Permissions set for com.SDI.TWD 
[INFO ] Removing old OBB file: com.SDI.TWD/main.18530809.com.SDI.TWD.obb (in case previously installed) 
[OK   ] Removed old OBB file: com.SDI.TWD/main.18530809.com.SDI.TWD.obb 
[INFO ] Pushing new OBB file: com.SDI.TWD/main.18530809.com.SDI.TWD.obb to /sdcard/Download/obb/com.SDI.TWD 
com.SDI.TWD/main.18530809.com.SDI.TWD.obb: 1 file pushed. 37.3 MB/s (4233449568 bytes in 108.204s)
[OK   ] Pushed new OBB file: com.SDI.TWD/main.18530809.com.SDI.TWD.obb 
[INFO ] Removing old OBB file: com.SDI.TWD/patch.com.SDI.TWD.obb (in case previously installed) 
[OK   ] Removed old OBB file: com.SDI.TWD/patch.com.SDI.TWD.obb 
[INFO ] Pushing new OBB file: com.SDI.TWD/patch.com.SDI.TWD.obb to /sdcard/Download/obb/com.SDI.TWD 
com.SDI.TWD/patch.com.SDI.TWD.obb: 1 file pushed. 37.4 MB/s (4035232225 bytes in 102.935s)
[OK   ] Pushed new OBB file: com.SDI.TWD/patch.com.SDI.TWD.obb 
[INFO ] Moving OBB files to correct directory: /sdcard/Android/obb/com.SDI.TWD, please be patient, this step has no progress indicator 
[INFO ] Moved OBB files to correct directory 
[INFO ] Should we go ahead and enable 90hz while we are at it? (y/n)  
        y
[OK   ] 90hz enabled, please click the power button, to turn on and off your SCREEN to enable the 90hz mode! 
[OK   ]  
[OK   ]  
[OK   ] DONE, install finished, you can now disconnect your device
```
Please feel free to ask for help when encountering any issues.


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
