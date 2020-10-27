command -v adb &> /dev/null && ADBINSTALLED=true
command -v aapt &> /dev/null && AAPTINSTALLED=true
command -v rclone &> /dev/null && RCLONEINSTALLED=true
command -v zenity &> /dev/null && ZENITYINSTALLED=true
command -v unzip &> /dev/null && UNZIPINSTALLED=true

command -v sideload &> /dev/null && SIDELOUADINSTALLED=true
command -v sideload-gui &> /dev/null && GUIINSTALLED=true
command -v sideload-update &> /dev/null && UPDATEINSTALLED=true
command -v whitewhidow-mount &> /dev/null && MOUNTINSTALLED=true


if [[ "$ADBINSTALLED" ]] && [[ "$AAPTINSTALLED" ]] && [[ "$RCLONEINSTALLED" ]] && [[ "$ZENITYINSTALLED" ]] && [[ "$UNZIPINSTALLED" ]] && [[ $(which sideload) == *"sideload"* ]] && [[ $(which sideload-gui) == *"sideload-gui"* ]] && [[ $(which sideload-update) == *"sideload-update"* ]]; then
	ok 'All pakcages are present.'
else
	error "You seem to be missing some packages, should we reinstall ?"
	while true; do
	    read -p "(Yy/Nn) " yn
	    case $yn in
		[Yy]* ) exec sideload-update;;
		[Nn]* ) exit 0;;
		* ) echo "Please answer yes or no.";;
	    esac
	done
	exit 1
fi
