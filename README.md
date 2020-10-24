# Quest-sideloader
Quest(1/2) sideloader for linux , mac and Windows(WSL1).


UPDATE: 22/10/2020: Grapchical Browser added! (LINUX/MAC)

UPDATE: 22/10/2020: Support for sideloading content straight from a mounted drive! (LINUX/MAC/WSL1)

UPDATE: 22/10/2020: Cli-based browser added with suport for dialog! (LINUX/MAC/WSL1)

# Try the one-liner first, no install required (CLI only, no gui)!
Run from inside any 'app-folder' folder containing an apk, and optional OBB file(s).
```bash
curl https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/sideload.sh > sideload.sh && chmod +x ./sideload.sh && sudo ./sideload.sh
```
<!--
Last stable build for one-liner: 
```bash
curl https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/v2.2/sideload.sh > sideload.sh && chmod +x ./sideload.sh && sudo ./sideload.sh
```

<!-- ![example](https://i.imgur.com/cC70UUC.png) -->

# Global Installation (LINUX/MAC/WSL1)
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
3. Copy the files to your $PATH: 
```
sudo cp ./sideload.sh /usr/local/bin/sideload
sudo cp ./sideload-gui.sh /usr/local/bin/sideload-gui
```

### One-Time Prerequisites (LINUX ONLY)

If your current linux need a special udev rule to allow permissions the adb device, run the following command to add them easely:
```
sudo ./extras/udev.sh $USER
```
   
   
## CLI-USAGE (LINUX/MAC/WSL1) :
Once globally installed, simply run `sideload` from inside any 'app-folder' folder containing an apk, and optional OBB file(s).
```
sideload
```
<!-- ![](extras/example.gif) -->

## BROWSER USAGE (LINUX/MAC/WSL):
Once globally installed, simply run `sideload-gui` from anywhere.
```
sideload-gui
```
Full Graphical browser:
![](extras/gui-example.png)
Full CLI Browser:
![](extras/gui-example2.png)
https://t.me/whitewhidow_q2_working







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
