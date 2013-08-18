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

function tmux-color-wrapper-start {
  echo "`color bg ${COLOR_BG_TMUX}``color fg ${COLOR_BG_TMUX}`"
}
function tmux-color-wrapper-end {}

function tmux-color-wrapper {
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
}

function zsh-color-wrapper-start {
  echo ""
}

function zsh-color-wrapper-end {
  echo "%k"
}

function zsh-color-wrapper {
  if [ "${PROMPT_POS}" = "right" ]; then
    echo "%F{$1}${HARD_LEFT_ARROW}\
%K{$1}%F{$2}" $3 "%f%k\
%K{$1}"
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

#print out left prompt
function left_prompt {
  PROMPT_POS="left"
  LEFT_PROMPT_TEXT=`prompt-arrow`
  echo ${LEFT_PROMPT_TEXT}
  if [ -n "$TMUX" ]; then
    PROMPT_SHELL=tmux
    if [ -n "$LEFT_TMUX" ];then
    else
      LEFT_TMUX="$PINK,$LAMP,window $MILKEY,$LAMP,hostname"
    fi
    LEFT_TMUX_TEXT="`color bg ${COLOR_BG_TMUX}``color fg ${COLOR_BG_TMUX}`"
    for prompt in ${=LEFT_TMUX}; do
      CMD=`prompt-\`echo $prompt | cut -d"," -f3\``
      LEFT_TMUX_TEXT=$LEFT_TMUX_TEXT`tmux-color-wrapper \`echo $prompt | cut -d"," -f1\` \`echo $prompt |  cut -d"," -f2\` "$CMD"`
    done
    LEFT_TMUX_TEXT="${LEFT_TMUX_TEXT}`color bg ${COLOR_BG_TMUX}`${HARD_RIGHT_ARROW}"
    tmux set -g status-left "${LEFT_TMUX_TEXT}" > /dev/null 2> /dev/null
  fi
}


# print out right prompt
function right_prompt {
  PROMPT_POS="right"

  # zsh
  PROMPT_SHELL=zsh
  if [ -n "$PROMPT_RIGHT" ]; then
    PROMPT_ZSH="$PROMPT_ZSH"
  else
    PROMPT_ZSH="$SAPPHIRE,$LAMP,vcs"
  fi
  PROMPT_TEXT=`zsh-color-wrapper-start`
  for prompt in ${=PROMPT_ZSH}; do
    CMD=`prompt-\`echo $prompt | cut -d"," -f3\``
    PROMPT_TEXT=$PROMPT_TEXT`zsh-color-wrapper \`echo $prompt | cut -d"," -f1\` \`echo $prompt |  cut -d"," -f2\` "$CMD"`
  done
  PROMPT_TEXT=${PROMPT_TEXT}`zsh-color-wrapper-end`
  echo "${PROMPT_TEXT}"

  # tmux
  if [ -n "$TMUX" ]; then
    PROMPT_SHELL=tmux
    if [ -n "$PROMPT_RIGHT_TMUX" ];then
      PROMPT_TMUX="$PROMPT_RIGHT_TMUX"
    else
      PROMPT_TMUX="$TURQUOISE,$LAMP,date $LAMP,$SNOW,time"
    fi
    PROMPT_TEXT=`tmux-color-wrapper-start`
    for prompt in ${=PROMPT_TMUX}; do
      CMD=`prompt-\`echo $prompt | cut -d"," -f3\``
      PROMPT_TEXT=$PROMPT_TEXT`tmux-color-wrapper \`echo $prompt | cut -d"," -f1\` \`echo $prompt |  cut -d"," -f2\` "$CMD"`
    done
    tmux set -g status-right "${PROMPT_TEXT}" > /dev/null 2> /dev/null
  fi
}

# set fixed tmux prompt
if [ -n "$TMUX" ]; then
  tmux set -g window-status-current-format "#[fg=colour${COLOR_BG_TMUX},bg=colour${COLOR_BG_LPROMPT}]${HARD_RIGHT_ARROW} #[fg=colour${COLOR_FG_LPROMPT}]#I.#W #[fg=colour${COLOR_BG_LPROMPT}]#[bg=colour${COLOR_BG_TMUX}]${HARD_RIGHT_ARROW}" > /dev/null 2> /dev/null
  tmux set -g status-bg colour${COLOR_BG_TMUX} > /dev/null 2> /dev/null
  tmux set -g window-status-format " #I.#W " > /dev/null 2> /dev/null
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

