#!/bin/sh
# Setup develop applications for ubuntu
# 

install() {
    if dpkg -l "$1" | grep ii > /dev/null
    then
        echo > /dev/null
    else
        sudo apt-get install --yes "$1"
    fi
}

if grep Ubuntu /etc/issue > /dev/null
    then
    install thunar
    install thunar-archive-plugin
    install thunar-media-tags-plugin
    install xfce4-power-manager
    install xfce4-power-manager-plugins
    install vlc
    install lxappearance
    install xcompmgr
    install nitrogen
    install gmrun
    install xmonad
    install xmobar
    wget "https://raw.github.com/meiraka/local/master/dep/ubuntu.sh" 2> /dev/null
    chmod +x ubuntu.sh
    ./ubuntu.sh
    rm ubuntu.sh
fi
