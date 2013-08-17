export PATH=$PATH:~/local/bin:~/bin
export CLICOLOR=1
if which dircolors > /dev/null; then
  eval $(dircolors -b ~/local/etc/dir_colors) > /dev/null 2> /dev/null
fi

export LANG=ja_JP.UTF-8
export LC_LANG=${LANG}
export LC_ALL=${LANG}

HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000
export EDITOR=vi
setopt correct
setopt hist_ignore_dups
setopt share_history
setopt transient_rprompt

zstyle ':completion:*:default' menu select=1
