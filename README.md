# Quest-sideloader-linux (& mac osx)
Quest Sideloader for Linux and Mac with integrated drive access to app library.

# Install (and/or) Update:
Latest Stable: ![example](https://img.shields.io/github/workflow/status/whitewhidow/quest-sideloader-linux/CI/main)
```
curl -fsSL https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/development/install.sh | /bin/bash -s -- main
```
Latest Dev: ![example](https://img.shields.io/github/workflow/status/whitewhidow/quest-sideloader-linux/CI/development)
```
curl -fsSL https://raw.githubusercontent.com/whitewhidow/quest-sideloader-linux/development/install.sh | /bin/bash -s -- development
```
<details>
<summary>Example output:</summary>

```
====================================================================
= Quest(1/2) sideloader for Linux & Mac(OSX) =======================
====================================================================
========================================= by Whitewhidow/BranchBit =
===================================== support:contact@branchbit.be =
============================== https://t.me/whitewhidow_q2_working =
================ www.github.com/whitewhidow/quest-sideloader-linux =
====================================================================

CHECKING AND INSTALLING DEPENDENCIES:
Checking git installation.
Git installed
Checking unzip installation.
Unzip installed
Checking adb.
Adb installed
Checking aapt.
Aapt installed
Checking zenity.
Zenity installed
Checking rclone.
Rclone installed
Fetching newest version (main).
Cloning into 'quest-sideloader-linux'...
remote: Enumerating objects: 273, done.
remote: Counting objects: 100% (273/273), done.
remote: Compressing objects: 100% (185/185), done.
remote: Total 1210 (delta 164), reused 160 (delta 73), pack-reused 937
Receiving objects: 100% (1210/1210), 8.84 MiB | 10.12 MiB/s, done.
Resolving deltas: 100% (713/713), done.
Already on 'main'
Your branch is up to date with 'origin/main'.
Copying executables to PATH (requires sudo)


 -> Install seems to have been successfull, you can now run 'sideload-gui' to open the sideloader.

 -> To self-update this package run 'sideload-update'.


```
</details>  


# Usage:
```
sideload-gui
```
![example](extras/1.png)

![example](extras/2.png)

![example](extras/3.png)


<details>
<summary>Linux udev rules?</summary>

In case your distro need a special udev rule to allow permissions to the adb device:
```
sudo ./extras/udev.sh $USER
```
</details>  



<details>
<summary>Changelog</summary>
  
```
UPDATE: 22/10/2020: Grapchical Browser added!
UPDATE: 22/10/2020: Support for sideloading content straight from a mounted drive!
UPDATE: 25/20/2020: Install script added, no more manual dependency installs required!
UPDATE: 26/20/2020: Integrated drive access to app library!
UPDATE: 27/20/2020: Streamlined (re)install process and better libs install for linux!
UPDATE: 29/20/2020: All inputs and choices now performed trough gui

```
</details>  





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
