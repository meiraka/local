# zsh prompt settings.

source ~/local/etc/zsh/prompt-*.zsh > /dev/null 2> /dev/null

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
  if [ "${PROMPT_SHELL}" = "tmux" ]; then
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

function powerline-color-wrapper-start {
  if [ ${PROMPT_SHELL} = 'tmux' ]; then
    echo "`color bg ${COLOR_BG_TMUX}``color fg ${COLOR_BG_TMUX}`"
  else
    echo ""
  fi
}
function powerline-color-wrapper-end {
  if [ ${PROMPT_SHELL} = 'tmux' ]; then
    if [ ${PROMPT_POS} = 'left' ]; then
      echo "#[bg=colour${COLOR_BG_TMUX}]${HARD_RIGHT_ARROW}"
    fi
  else
    echo "%k"
  fi
}

function powerline-color-wrapper {
  if [ ${PROMPT_SHELL} = 'tmux' ]; then
    if  [ "${PROMPT_POS}" = "right" ]; then
      echo "\
#[fg=colour$1]${HARD_LEFT_ARROW}
#[bg=colour$1,fg=colour$2] "$3" \
"
    else
      echo "\
#[bg=colour$1]${HARD_RIGHT_ARROW}\
#[fg=colour$2] "$3" \
#[fg=colour$1]"
    fi
  else
    if [ "${PROMPT_POS}" = "right" ]; then
      echo "%F{$1}${HARD_LEFT_ARROW}\
%K{$1}%F{$2}" $3 "%f%k\
%K{$1}"
    fi
  fi
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

function prompt-date {
  echo "%Y%m%d %a"
}

function prompt-time {
  echo `date +"%H:%M"`
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


export USER_CONFIG_HELP=${USER_CONFIG_HELP}"PROMPT_LEFT - off
PROMPT_RIGHT - \$COLOR_SAPPHIRE,\$COLOR_LAMP,vcs
PROMPT_RIGHT_TMUX - \$COLOR_TURQUOISE,\$COLOR_LAMP,date \$COLOR_LAMP,\$COLOR_SNOW,time
PROMPT_LEFT_TMUX - \$COLOR_PINK,\$COLOR_LAMP,window \$COLOR_MILKEY,\$COLOR_LAMP,hostname
"
function prompt {
  # PROMPT_POS and PROMPT_SHELL env uses in powerline-* functions.
  if [ $1 = "right" ]; then
    PROMPT_POS="right"
  else
    PROMPT_POS="left"
  fi

  # zsh
  PROMPT_SHELL=zsh
  if [ $1 = "right" ]; then
    if [ -n "$PROMPT_RIGHT" ]; then
      PROMPT_ZSH="$PROMPT_RIGHT"
    else
      PROMPT_ZSH="$COLOR_SAPPHIRE,$COLOR_LAMP,vcs"
    fi
  else
    if [ -n "$PROMPT_LEFT" ]; then
      PROMPT_ZSH="$PROMPT_LEFT"
    else
      PROMPT_ZSH="off"
    fi
  fi
  if [ "$PROMPT_ZSH" = "off" ]; then
    echo `prompt-arrow`
  else
    PROMPT_TEXT=`powerline-color-wrapper-start`
    for prompt in ${=PROMPT_ZSH}; do
      CMD=`prompt-\`echo $prompt | cut -d"," -f3\``
      PROMPT_TEXT=$PROMPT_TEXT`powerline-color-wrapper \`echo $prompt | cut -d"," -f1\` \`echo $prompt |  cut -d"," -f2\` "$CMD"`
    done
    PROMPT_TEXT=${PROMPT_TEXT}`powerline-color-wrapper-end`
    echo "${PROMPT_TEXT}"
  fi

  # tmux
  if [ -n "$TMUX" ]; then
    PROMPT_SHELL=tmux
    if [ $1 =  "right" ]; then
      if [ -n "$PROMPT_RIGHT_TMUX" ]; then
        PROMPT_TMUX="$PROMPT_RIGHT_TMUX"
      else
        PROMPT_TMUX="$COLOR_TURQUOISE,$COLOR_LAMP,date $COLOR_LAMP,$COLOR_SNOW,time"
      fi
    else
      if [ -n "$PROMPT_LEFT_TMUX" ]; then
        PROMPT_TMUX=${PROMPT_LEFT_TMUX}
      else
        PROMPT_TMUX="$COLOR_PINK,$COLOR_LAMP,window $COLOR_MILKEY,$COLOR_LAMP,hostname"
      fi
    fi
    PROMPT_TEXT=`powerline-color-wrapper-start`
    for prompt in ${=PROMPT_TMUX}; do
      CMD=`prompt-\`echo $prompt | cut -d"," -f3\``
      PROMPT_TEXT=$PROMPT_TEXT`powerline-color-wrapper \`echo $prompt | cut -d"," -f1\` \`echo $prompt |  cut -d"," -f2\` "$CMD"`
    done
    PROMPT_TEXT=${PROMPT_TEXT}`powerline-color-wrapper-end`
    tmux set -g status-$1 "${PROMPT_TEXT}" > /dev/null 2> /dev/null
  fi
}

# re eval prompt text
function zle-line-init zle-keymap-select {

  PROMPT="`prompt left`"
  RPROMPT="`prompt right`"

  zle reset-prompt
}

# set fixed tmux prompt
if [ -n "$TMUX" ]; then
  tmux set -g window-status-current-format "#[fg=colour${COLOR_BG_TMUX},bg=colour${COLOR_BG_LPROMPT}]${HARD_RIGHT_ARROW} #[fg=colour${COLOR_FG_LPROMPT}]#I.#W #[fg=colour${COLOR_BG_LPROMPT}]#[bg=colour${COLOR_BG_TMUX}]${HARD_RIGHT_ARROW}" > /dev/null 2> /dev/null
  tmux set -g status-bg colour${COLOR_BG_TMUX}             > /dev/null 2> /dev/null
  tmux set -g window-status-format " #I.#W "               > /dev/null 2> /dev/null
  tmux set -g pane-active-border-fg colour${COLOR_BG_TMUX} > /dev/null 2> /dev/null
  tmux set -g pane-active-border-bg colour${COLOR_BG_TMUX} > /dev/null 2> /dev/null
  tmux set -g pane-border-bg 8 > /dev/null 2> /dev/null
  tmux set -g pane-border-fg colour${COLOR_BG_TMUX} > /dev/null 2> /dev/null
fi



zle -N zle-line-init
zle -N zle-keymap-select

setopt print_exit_value
setopt prompt_subst

PROMPT="`prompt left`"
RPROMPT="`prompt right`"
SPROMPT="%F{$COLOR_BG_LPROMPT}%{$suggest%}(＠ﾟ△ﾟ%)ノ < もしかして %B%r%b かな? [そう!(y), 違う!(n),a,e] > "

