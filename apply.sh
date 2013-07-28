#!/bin/sh
# copy config files to user home.

# cd to home dir
cd ~/

# if there is no local git repo, clone.
#git clone hogehoge

# copy settings.
cp ~/local/etc/zsh/loadrc ~/.zshrc
cp ~/local/etc/tmux.conf ~/.tmux.conf
