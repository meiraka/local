
# set background
nitrogen --restore & 

# re appling desktop composition
if killall xcompmgr ; then
  sleep 1 && xcompmgr -I 0.1 -O 0.1 -D 8 -f -c &
  sleep 2 && notify-send xmonad "restart xcompmgr" &
else
  xcompmgr -I 0.1 -O 0.1 -D 8 -f -c &
fi

# file manager daemon
thunar --daemon &

# power management
xfce4-power-manager &


# enabling update manager and ubuntu software center
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & 
eval $(shell gnome-keyring-daemon -s) &

# set touchpad settings
synclient TapButton1=0
synclient TapButton2=0
synclient HorizTwoFingerScroll=1
synclient VertScrollDelta=-237
synclient HorizScrollDelta=-237

xmodmap ~/.Xmodmap
