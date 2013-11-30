#!/bin/sh
# copy config files to user home.

update_link ()
{
  if [ -e $2 ]
  then
    echo $2 "is already copied."
  else
    ln -si $1 $2
  fi
  return 0
}

update_git ()
{
  cwd=`pwd`
  if [ -e $1 ]
  then
    cd $1
    git pull
    cd $cwd
  else
    git clone $2 $1
  fi
    
}

# cd to home dir
cd ~/

# if there is no local git repo, clone.
#git clone hogehoge

# copy settings.
echo "source ~/local/etc/zsh/zshrc" >  ~/.zshrc
echo "source-file ~/local/etc/tmux.conf" > ~/.tmux.conf

# clone vim plugins
VIM_PLUGINS_DIR=~/.vim-plugins
mkdir -p $VIM_PLUGINS_DIR
update_git $VIM_PLUGINS_DIR/neobundle.vim git://github.com/Shougo/neobundle.vim
update_git $VIM_PLUGINS_DIR/vimproc git://github.com/Shougo/vimproc

# link settings.
update_link ~/local/share/vimrc ~/.vimrc
update_link ~/local/share/vim/ ~/.vim
update_link ~/local/share/xmonad/ ~/.xmonad

# compile
cd $VIM_PLUGINS_DIR/vimproc
make
