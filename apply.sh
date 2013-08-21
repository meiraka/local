#!/bin/sh
# copy config files to user home.

# cd to home dir
cd ~/

# if there is no local git repo, clone.
#git clone hogehoge

# copy settings.
echo "source ~/local/etc/zsh/zshrc" >  ~/.zshrc
echo "source-file ~/local/etc/tmux.conf" > ~/.tmux.conf

# link settings.
ln -si ~/local/share/vimrc .vimrc
ln -si ~/local/share/vim/ .vim
