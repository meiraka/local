alias x=exit
alias reload="source ~/.zshrc"
if [ `uname` = Darwin ]; then
  #BSD ls
  alias ls="ls -G"
else
  #GNU ls
  alias ls="ls --color=auto"
fi

function user-config {
  ~/local/bin/generate-zsh-env ~/local/conf/config.zsh ${1} ${2} ${3}
  source ~/.zshrc
}
