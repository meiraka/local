export PATH=$PATH:~/local/bin:~/bin
eval $(dircolors -b ~/local/etc/dir_colors) > /dev/null 2> /dev/null

export LANG=ja_JP.UTF-8

HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000
export EDITOR=vi
setopt correct
setopt hist_ignore_dups
setopt share_history
