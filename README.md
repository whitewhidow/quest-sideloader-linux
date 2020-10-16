# quest-sideloader-linux
Simple quest sideloader for linux (or mac)

![example](https://i.imgur.com/cC70UUC.png)



# try the one-liner!
`sudo bash <(curl -s https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/sideload.sh)`
Which will pull and run the script in one go, no need for udev rules since you use `sudo`

-----OR FOLLOW THE BELOW STEPS TO RUN LOCALLY WITHOUT THE NEED FOR SUDO-----

## Global Installation
1. Download the zip file from 'https://github.com/whitewhidow/quest-sideloader-linux/archive/main.zip'
2. Unzip the archive
3. Navigate into the folder
4. Make the file executable : 
  `sudo chmod +x ./sideload.sh`
5. Copy the file to your $PATH : 
  `sudo cp ./sideload.sh /usr/local/bin/sideload`


## Prerequisites
ADB is REQUIRED

aapt is OPTIONAL (`sudo apt-get install -y aapt1`      or get it from https://dl.androidaapt.com/aapt-linux.zip )

Linux needs udev rules to allow proper access via adb, run the following lines one by one in :
1. Enter true sudo mode :
   `sudo su`
2. Create udev rule :
   `echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="2833", ATTR{idProduct}=="0186", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/51-android.rules`
3. Exit out of sude :
    `exit`
4. Add yourself to plugdev usergroup :
   `sudo usermod -a -G plugdev $user`
5. Reload udev rules
   `sudo udevadm control --reload-rule`



## Ready to Sideloading an apk!

Simply navigate to a folder that has a SINGLE apk, and optional OBB files.
Now just run the `sideload` command and follow the on screen prompts:


###Example output:
```


    ============================================================
    = Quest(1/2) sideloader for linux by Whitewhidow/BranchBit =
    ============================================================
    =support:contact@branchbit.be===============================
    ============================================================
    =========www.github.com/whitewhidow/quest-sideloader-linux==

1
    [INFO ] APK FOUND: ./Arizona Sunshine Quest [1.5] patch+savefix_MP-DLC.apk	 
    [INFO ] Testing aapt installation 
    [INFO ] aapt installation is present, autodetecting packagename as: com.vertigogames.azsq 
    [INFO ] OBB FOUND: ./com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb 


    YOU ARE ABOUT TO INSTALL: 1 APK AND 1 OBB FILES !
    VERIFY THE ABOVE INFO, AND CLICK ANY KEY TO CONINUE, or CTRL+C to Cancel


    [INFO ] Testing adb installation 
    [OK   ] ADB installation is present 
    [INFO ] Testing headset connetcion 
    [OK   ] ADB DEVICE DETECTED 
    [INFO ] testing if json files are present 
    [OK   ] user.json is present on device 
    [OK   ] qq1091481055.json is present on device 
    [INFO ] Please enter a username below and press ENTER (for new type of MP patches that dont use user.json) 
whitewhidow
    [OK   ] mp username patched as: whitewhidow 
    [INFO ] Uninstalling com.vertigogames.azsq (in case previously installed) 
    [OK   ] Uninstalled com.vertigogames.azsq 
    [INFO ] Installing com.vertigogames.azsq 
    [OK   ] Installed com.vertigogames.azsq 
    [INFO ] Setting Permissions 
    [OK   ] Permissions set for com.vertigogames.azsq 
    [INFO ] Removing old OBB file: com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb (in case previously installed) 
    [OK   ] Removed old OBB file: com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb 
    [INFO ] Pushing new OBB file: com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb to /sdcard/Download/obb/com.vertigogames.azsq 
com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb: 1 file pushed. 39.1 MB/s (3613580044 bytes in 88.212s)
    [OK   ] Pushed new OBB file: com.vertigogames.azsq/main.21474.com.vertigogames.azsq.obb 
    [INFO ] Moving OBB files to correct directory: /sdcard/Android/obb/com.vertigogames.azsq, please be patient, this step has no progress indicator 
    [INFO ] Moved OBB files to correct directory 
    [INFO ] Should we go ahead and enable 90hz while we are at it? (y/n)  
n
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
