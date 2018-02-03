#!/usr/bin/env bash
if id -nG "$USER" | grep -qw "input"; then
    apt install xdotool wmctrl libinput-tools git -y
    (cd /tmp && git clone http://github.com/bulletmark/libinput-gestures && cd libinput-gestures; sudo ./libinput-gestures-setup install)
    (cd ~/.config && touch libinput-gestures.conf && cat > libinput-gestures.conf << TEXT
# KDE: Present Windows (current desktop)
gesture swipe up    xdotool key ctrl+F9

# KDE: Present Windows (Window class)
gesture swipe down    xdotool key ctrl+F7

# KDE: Show desktop
gesture pinch out xdotool key ctrl+F12

#next desktop
gesture swipe right xdotool key super+ctrl+Right

#previous desktop
gesture swipe left xdotool key super+ctrl+Left
TEXT
)
    libinput-gestures-setup start
    libinput-gestures-setup autostart
    libinput-gestures-setup restart

else
	sudo gpasswd -a $USER input
    echo You have been added to input group, please logout and run this script again
fi