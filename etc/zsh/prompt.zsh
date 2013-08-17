# zsh prompt settings.

autoload -Uz vcs_info

export USER_CONFIG_HELP=${USER_CONFIG_HELP}"powerline - off, top, bottom, new and other..
"

if [ "${powerline}" = "off" ]; then
  HARD_RIGHT_ARROW=""
  SOFT_RIGHT_ARROW=">"
  HARD_LEFT_ARROW=""
  SOFT_LEFT_ARROW="<"
elif [ "${powerline}" = "top" ]; then
  HARD_RIGHT_ARROW=`echo "\u25E4"`
  SOFT_RIGHT_ARROW=`echo "\u29F8"`
  HARD_LEFT_ARROW=`echo "\u25E5"`
  SOFT_LEFT_ARROW=`echo "\u29F9"`
elif [ "${powerline}" = "bottom" ]; then
  HARD_RIGHT_ARROW=`echo "\u25E3"`
  SOFT_RIGHT_ARROW=">"
  HARD_LEFT_ARROW=`echo "\u25E2"`
  SOFT_LEFT_ARROW="<"
elif [ "${powerline}" = "new" ]; then
  HARD_RIGHT_ARROW=`echo "\uE0B0"`
  SOFT_RIGHT_ARROW=`echo "\uE0B1"`
  HARD_LEFT_ARROW=`echo "\uE0B2"`
  SOFT_LEFT_ARROW=`echo "\uE0B3"`
else
  HARD_RIGHT_ARROW=`echo "\u2b80"`
  SOFT_RIGHT_ARROW=`echo "\u2b81"`
  HARD_LEFT_ARROW=` echo "\u2b82"`
  SOFT_LEFT_ARROW=` echo "\u2b83"`
fi

function color {
  if [ "${PROMPT_MODE}" = "tmux" ]; then
    if [ "$1" = "reset" ]; then
      echo "#[default]"
    else
      echo "#[$1=colour$2]"
    fi
  else
    if [ "$1" = "reset" ]; then
      echo $'\e[m'
    elif [ "$1" = "bg" ]; then
      echo $'\e[0;48;5;$2m'
    else
      echo $'\e[0;38;5;$2m'
    fi
  fi
}

function tmux-color-wrapper {
  echo "\
#[bg=colour$1]${HARD_RIGHT_ARROW}\
#[fg=colour$2] "$3" \
#[fg=colour$1]"
}

function prompt-vcs {
  # vcs branch
  if git status > /dev/null 2> /dev/null; then
    VCS_TEXT="git"
    VCS_REMOTE_TEXT=`git config --list | grep "origin.url" | cut -d"=" -f 2`
    VCS_BRANCH_TEXT=`git branch | grep "\*" | sed "s/\* //"`
    # set branch icons
    if echo ${VCS_BRANCH_TEXT} | grep "master" > /dev/null 2> /dev/null; then
      VCS_BRANCH_TEXT=`echo "\u265b"`" ${VCS_BRANCH_TEXT}"
    elif echo ${VCS_BRANCH_TEXT} | grep "develop" > /dev/null 2> /dev/null; then
      VCS_BRANCH_TEXT=`echo "\u265a"`" ${VCS_BRANCH_TEXT}"
    elif echo ${VCS_BRANCH_TEXT} | grep "hotfix" > /dev/null 2> /dev/null; then
      VCS_BRANCH_TEXT=`echo "\u265d"`" ${VCS_BRANCH_TEXT}"
    else
      VCS_BRANCH_TEXT=`echo "\u265F"`" ${VCS_BRANCH_TEXT}"
    fi
  fi
  if [ "${PROMPT_TYPE}" = 'left' ]; then
    ARROW=${SOFT_RIGHT_ARROW}
  else
    ARROW=${SOFT_LEFT_ARROW}
  fi
  if [ "${VCS_TEXT}" = "" ]; then
  else
    echo "\
${VCS_REMOTE_TEXT}\
 ${ARROW} \
${VCS_BRANCH_TEXT}"
  fi
}

function prompt-hostname {
  # show user and hostname tmux status or zsh prompt
  echo "`whoami` ${SOFT_RIGHT_ARROW} `hostname`"
}

function prompt-window {
  echo "## #S.#I"
}

function prompt-arrow {
  arrow="> "
  case $KEYMAP in
    vicmd)
      arrow="< "
    ;;
    main|viins)
      arrow="> "
    ;;
  esac
  echo "%F{$COLOR_BG_LPROMPT}${LEFT_PROMPT_TEXT}%f${arrow}%F{$COLOR_MAIN}"
}

#print out left prompt
function left_prompt {
  PROMPT_TYPE="left"
  LEFT_PROMPT_TEXT=`prompt-arrow`


  if [ -n "$TMUX" ]; then
    PROMPT_MODE=tmux
    LEFT_TMUX_TEXT="`color bg ${COLOR_BG_TMUX}``color fg ${COLOR_BG_TMUX}`\
`tmux-color-wrapper ${COLOR_BG_TMUX} ${COLOR_FG_TMUX} "\`prompt-window\`"`\
`tmux-color-wrapper ${COLOR_BG_LPROMPT} ${COLOR_FG_LPROMPT} "\`prompt-hostname\`"`\
`tmux-color-wrapper ${COLOR_BG_VCS} ${COLOR_FG_VCS} "\`prompt-vcs\`"`\
`color bg ${COLOR_BG_TMUX}`${HARD_RIGHT_ARROW}"
    tmux set -g status-left "${LEFT_TMUX_TEXT}" > /dev/null 2> /dev/null
  fi
  echo ${LEFT_PROMPT_TEXT}
}


# print out right prompt
function right_prompt {
  PROMPT_TYPE="right"
  PROMPT_MODE=zsh
  PROMPT_TEXT="%F{$COLOR_BG_RPROMPT}%f`prompt-vcs`"
  echo "${PROMPT_TEXT}"
}

# set fixed tmux prompt
if [ -n "$TMUX" ]; then
  tmux set -g window-status-current-format "#[fg=colour${COLOR_BG_TMUX},bg=colour${COLOR_BG_LPROMPT}]${HARD_RIGHT_ARROW} #[fg=colour${COLOR_FG_LPROMPT}]#I.#W #[fg=colour${COLOR_BG_LPROMPT}]#[bg=colour${COLOR_BG_TMUX}]${HARD_RIGHT_ARROW}" > /dev/null 2> /dev/null
  tmux set -g status-bg colour${COLOR_BG_TMUX} > /dev/null 2> /dev/null
  tmux set -g window-status-format " #I.#W " > /dev/null 2> /dev/null
  tmux set -g status-right "#[fg=colour163]${HARD_LEFT_ARROW}#[fg=colour232,bg=colour163] %Y%m%d %a #[bold]${SOFT_LEFT_ARROW}#[default,fg=colour232,bg=colour163] %H:%M " > /dev/null 2> /dev/null
fi



# re eval prompt text
function zle-line-init zle-keymap-select {

  PROMPT="`left_prompt`"
  RPROMPT="`right_prompt`"

  zle reset-prompt
}


zle -N zle-line-init
zle -N zle-keymap-select

setopt print_exit_value
setopt prompt_subst

PROMPT="`left_prompt`"
RPROMPT="`right_prompt`"
SPROMPT="%F{$COLOR_BG_LPROMPT}%{$suggest%}(＠ﾟ△ﾟ%)ノ < もしかして %B%r%b かな? [そう!(y), 違う!(n),a,e] > "

