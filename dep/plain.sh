#!/bin/sh
# copy config files to user home.

# create link if not file exists.
update_link ()
{
  if [ -e $2 ]
  then
    echo $2 "is already copied." > /dev/null
  else
    mkdir -p `dirname $1`
    ln -si $1 $2
  fi
  return 0
}

# clone git repo if not exists.
# pull git repo if exists.
update_git ()
{
  mkdir -p `dirname $1`
  cwd=`pwd`
  if [ -e $1 ]
  then
    echo "checking update ${1}"
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
update_git ~/local git://github.com/meiraka/local

# clone
VIM_PLUGINS_DIR=~/.vim-plugins
update_git $VIM_PLUGINS_DIR/neobundle.vim git://github.com/Shougo/neobundle.vim
update_git $VIM_PLUGINS_DIR/vimproc git://github.com/Shougo/vimproc
mkdir -p ~/src
update_git ~/src/hub git://github.com/github/hub.git

# link
update_link ~/local/etc/zsh/zshrc ~/.zshrc
update_link ~/local/etc/tmux.conf ~/.tmux.conf
update_link ~/local/etc/Xresources ~/.Xresources
update_link ~/local/etc/Xmodmap ~/.Xmodmap
mkdir -p ~/.config/sakura
update_link ~/local/config/sakura/sakura.conf ~/.config/sakura/sakura.conf
update_link ~/local/share/vimrc ~/.vimrc
update_link ~/local/share/vim/ ~/.vim
update_link ~/local/share/xmonad/ ~/.xmonad
update_link ~/local/share/xmobarrc ~/.xmobarrc

# compile
cd $VIM_PLUGINS_DIR/vimproc
make
mkdir -p ~/local/share/vim/autoload
cp -r $VIM_PLUGINS_DIR/vimproc/autoload/* ~/local/share/vim/autoload/

cd ~/src/hub
export PREFIX="$HOME"/local
rake install
