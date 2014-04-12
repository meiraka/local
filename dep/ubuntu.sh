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
    install git
    install zsh
    install tmux
    install vim
    install rake
    if [ -e ~/local ]
    then
        echo ~/local "is already copied." > /dev/null
    else
        wget "https://raw.github.com/meiraka/local/master/dep/plain.sh" 2> /dev/null
        chmod +x plain.sh
        sh plain.sh
        rm plain.sh
    fi
fi
