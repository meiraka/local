export PATH=~/local/bin:$PATH:~/bin
export CLICOLOR=1
if which dircolors > /dev/null; then
  python ~/local/etc/dir_colors.py > ~/local/etc/dir_colors
  eval $(dircolors -b ~/local/etc/dir_colors) > /dev/null 2> /dev/null
fi


if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
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
setopt nonomatch

zstyle ':completion:*:default' menu select=1
