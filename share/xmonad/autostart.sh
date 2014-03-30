
# set background
nitrogen --restore & 

# re appling desktop composition
killall xcompmgr
sleep 3 && xcompmgr -I 0.1 -O 0.1 -D 8 -f -c &

# file manager daemon
thunar --daemon &

# power management
xfce4-power-manager &


# enabling update manager and ubuntu software center
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & 
eval $(shell gnome-keyring-daemon -s) &

xmodmap ~/.Xmodmap
