#!/bin/sh
# Setup develop applications for ubuntu
# 

install() {
    if dpkg -l "$1" > /dev/null
    then
        echo > /dev/null
    else
        sudo apt-get install "$1"
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
        wget "https://raw.github.com/meiraka/local/master/dep/apply.sh" 2> /dev/null
        chmod +x apply.sh
        sh apply.sh
        rm apply.sh
    fi
fi
