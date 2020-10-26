# Quest-sideloader
Quest Sideloader for Linux and Mac.


UPDATE: 22/10/2020: Grapchical Browser added!

UPDATE: 22/10/2020: Support for sideloading content straight from a mounted drive!

UPDATE: 25/20/2020: Install script added, no more manual dependency installs required!

UPDATE: 26/20/2020: `whitewhidow-mount` script added, and integrated into `sideloader-gui`!

<!-- ![example](https://i.imgur.com/cC70UUC.png) -->

# Installation:
Scripted install/update :
```
sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/main/install.sh)"
```

# Usage:
```
sideload-gui
```
![example](extras/1.png)

![example](extras/2.png)

![example](extras/3.png)


### One-Time Prerequisites (LINUX ONLY)

In case your distro need a special udev rule to allow permissions to the adb device:
```
sudo ./extras/udev.sh $USER
```
  







Please feel free to ask for help when encountering any issues.

Looking for content or support? Find me @ https://t.me/whitewhidow_q2_working

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
