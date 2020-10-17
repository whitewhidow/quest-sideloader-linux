# Quest-sideloader-linux
Simple quest sideloader for linux and mac.

Will take care of installing and moving apk, obb(s), permissions and json(s) all in one go.

_Will also automatically place the OBB's in the CORRECT FOLDER, occording to the APK's METADATA, no more guessing._

![example](https://i.imgur.com/cC70UUC.png)



# Try the one-liner first!
`sudo bash <(curl -s https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/sideload.sh)`

Which will pull and run the script in one go, no need for udev rules since you use `sudo`

-----OR FOLLOW THE BELOW STEPS TO RUN LOCALLY, GLOBALLY, AND WITHOUT THE NEED FOR SUDO-----

## Global Installation (one time)
1. Download the archive `https://github.com/whitewhidow/quest-sideloader-linux/archive/main.zip`
2. Unzip the archive:
   `unzip quest-sideloader-linux-main.zip`
3. Navigate into the folder:
  `cd quest-sideloader-linux-main`
4. Copy the file to your $PATH : 
  `sudo cp ./sideload.sh /usr/local/bin/sideload`

you can now run `sideload` from any folder.


## Prerequisites (one time)

1. adb installed, device in dev mode, the usual...
2. aapt is OPTIONAL (`sudo apt-get install -y aapt1`      or get it from https://androidaapt.com/ )  (this will read packagenames)
3. Linux need a udev rule to allow proper access to the usb device, run the following lines command to add them:
   
   `sudo ./udev.sh $USER`
   
   

## Ready to Sideloading an apk!

Now run `sideload` folder any 'app-folder' that has a apk, and optional OBB files.
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
