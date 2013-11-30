nitrogen --restore & 
xcompmgr -c &
thunar --daemon &
xfce4-power-manager &


# enabling update manager and ubuntu software center
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & 
eval $(shell gnome-keyring-daemon -s) &

