#!/bin/bash
echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"2833\", ATTR{idProduct}==\"0186\", MODE=\"0666\", OWNER=\"$1\"" >> /etc/udev/rules.d/51-android.rules
