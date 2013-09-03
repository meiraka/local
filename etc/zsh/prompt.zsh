# zsh prompt settings.
#TODO remove global vars

function set-arrow {
  if [ "$1" = "top" ]; then
    HARD_RIGHT_ARROW=`echo "\u25E4"`
    SOFT_RIGHT_ARROW=`echo "\u29F8"`
    HARD_LEFT_ARROW=`echo "\u25E5"`
    SOFT_LEFT_ARROW=`echo "\u29F9"`
  elif [ "$1" = "bottom" ]; then
    HARD_RIGHT_ARROW=`echo "\u25E3"`
    SOFT_RIGHT_ARROW=">"
    HARD_LEFT_ARROW=`echo "\u25E2"`
    SOFT_LEFT_ARROW="<"
  elif [ "$1" = "tab" ]; then
    HARD_RIGHT_ARROW=`echo "\u2599"`
    SOFT_RIGHT_ARROW=`echo "\u2599"`
    HARD_LEFT_ARROW=`echo "\uE0B2"`
    SOFT_LEFT_ARROW=`echo "\uE0B3"`
  elif [ "$1" = "new" ]; then
    HARD_RIGHT_ARROW=`echo "\uE0B0"`
    SOFT_RIGHT_ARROW=`echo "\uE0B1"`
    HARD_LEFT_ARROW=`echo "\uE0B2"`
    SOFT_LEFT_ARROW=`echo "\uE0B3"`
  elif [ "$1" = "old" ]; then
    HARD_RIGHT_ARROW=`echo "\u2b80"`
    SOFT_RIGHT_ARROW=`echo "\u2b81"`
    HARD_LEFT_ARROW=` echo "\u2b82"`
    SOFT_LEFT_ARROW=` echo "\u2b83"`
  else
    HARD_RIGHT_ARROW=""
    SOFT_RIGHT_ARROW="|"
    HARD_LEFT_ARROW=""
    SOFT_LEFT_ARROW="|"
  fi
}

function color {
  if [ $1 = "tmux" ]; then
    if [ "$2" = "reset" ]; then
      echo "#[default]"
    else
      echo "#[$2=colour$3]"
    fi
  else
    if [ "$2" = "reset" ]; then
      echo $'\e[m'
    elif [ "$3" = "bg" ]; then
      echo $'\e[0;48;5;$2m'
    else
      echo $'\e[0;38;5;$2m'
    fi
  fi
}

function hysteria-color-wrapper-start {
  if [ $1 = 'tmux' ]; then
    echo "`color $1 bg ${COLOR_BG_TMUX}``color $1 fg ${COLOR_BG_TMUX}`"
  else
    echo ""
  fi
}

function hysteria-color-wrapper-end {
  if [ $1 = 'tmux' ]; then
    if [ ${PROMPT_POS} = 'left' ]; then
      echo "#[bg=colour${COLOR_BG_TMUX}]${HARD_RIGHT_ARROW}"
    fi
  else
    echo "%f%k"
  fi
}


function hysteria-color-wrapper {
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
      if [ "$1" = "NONE" ];then
        p1="%f%k${HARD_LEFT_ARROW}"
        p3=""
      else
        p1="%F{$1}${HARD_LEFT_ARROW}%K{$1}"
        p3="%K{$1}"
      fi
      if [ "$2" = "NONE" ]; then
        p2=" $3 "
      else
        p2="%F{$2} $3 %f%k"
      fi
      echo ${p1}${p2}${p3}
    else
      if [ "$1" = "NONE" ];then
        p1="%f%k${HARD_RIGHT_ARROW}"
        p3=""
      else
        p1="%k%K{$1}${HARD_RIGHT_ARROW}%f"
        p3="%F{$1}"
      fi
      if [ "$2" = "NONE" ]; then
        p2=" $3 "
      else
        p2="%F{$2} $3 %f"
      fi
      echo ${p1}${p2}${p3}
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
  if [ "PROMPT_SHELL" = "tmux" ]; then
    echo "%I:%M"
  else
    echo `date +"%H:%M"`
  fi
}

function prompt-arrow {
  arrow=">"
  case $KEYMAP in
    vicmd)
      arrow="<"
    ;;
    main|viins)
      arrow=">"
    ;;
  esac
  echo "${arrow}"
}


export USER_CONFIG_HELP=${USER_CONFIG_HELP}"prompt_left - zsh left prompt
prompt_left_arrow - zsh left prompt arrow
prompt_right - zsh right prompt
prompt_right_arrow - zsh left prompt arrow
prompt_right_tmux - tmux right line
prompt_right_tmux_arrow - tmux right line arrow
prompt_left_tmux - tmux left status line
prompt_left_tmux_arrow - tmux left status line arrow
"

# hysteria-line [left|right] [zsh|tmux] promptstyle
function hysteria-line {
  # PROMPT_POS and PROMPT_SHELL env uses in hysteria-* functions.
  if [ $1 = "right" ]; then
    PROMPT_POS="right"
  else
    PROMPT_POS="left"
  fi

  PROMPT_SHELL="$2"
  PROMPT_STYLE="$3"
  PROMPT_TEXT=`hysteria-color-wrapper-start $2`
  for prompt in ${=PROMPT_STYLE}; do
    CMD=`prompt-\`echo $prompt | cut -d"," -f3\``
    PROMPT_TEXT=$PROMPT_TEXT`hysteria-color-wrapper \`echo $prompt | cut -d"," -f1\` \`echo $prompt |  cut -d"," -f2\` "${CMD}"`
  done
  PROMPT_TEXT=${PROMPT_TEXT}`hysteria-color-wrapper-end $2`
  echo "${PROMPT_TEXT}"
}

function hysteria-line-update {
# re eval prompt text
  if [ -n "${prompt_right_arrow}" ]; then
    set-arrow ${prompt_right_arrow}
  else
    set-arrow "on"
  fi
  if [ -n "$prompt_right" ]; then
    PROMPT_ZSH="$prompt_right"
  else
    PROMPT_ZSH="232,124,vcs"
  fi
  RPROMPT="`hysteria-line right zsh ${PROMPT_ZSH}`"
  if [ -n "${prompt_left_arrow}" ]; then
    set-arrow "${prompt_left_arrow}"
  else
    set-arrow "off"
  fi
  if [ -n "$prompt_left" ]; then
    PROMPT_ZSH="$prompt_left"
  else
    PROMPT_ZSH="NONE,124,arrow"
  fi
  
  PROMPT="`hysteria-line left zsh ${PROMPT_ZSH}`"

  if [ -n "$TMUX" ]; then
    if [ -n "${prompt_left_tmux_arrow}" ]; then
      set-arrow "${prompt_left_tmux_arrow}"
    else
      set-arrow "on"
    fi
    if [ -n "$prompt_left_tmux" ]; then
      PROMPT_TMUX=${prompt_left_tmux}
    else
      PROMPT_TMUX="088,255,window 255,233,hostname"
    fi
    tmux set -g status-left "`hysteria-line left tmux ${PROMPT_TMUX}`" > /dev/null 2> /dev/null

    if [ -n "${prompt_right_tmux_arrow}" ]; then
      set-arrow "${prompt_right_tmux_arrow}"
    else
      set-arrow "on"
    fi
    if [ -n "$prompt_right_tmux" ]; then
      PROMPT_TMUX="$prompt_right_tmux"
    else
      PROMPT_TMUX="255,233,date $COLOR_LAMP,$COLOR_SNOW,time"
    fi
    tmux set -g status-right "`hysteria-line right tmux ${PROMPT_TMUX}`" > /dev/null 2> /dev/null
  fi
}


function hysteria-line-init {
  function zle-line-init zle-keymap-select {
    hysteria-line-update
    zle reset-prompt
  }
  hysteria-line-update
  
  # set fixed tmux prompt
  if [ -n "$TMUX" ]; then
    if [ -n "${prompt_tmux_arrow}" ]; then
      set-arrow "${prompt_tmux_arrow}"
    else
      set-arrow "off"
    fi
 
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
}

setopt print_exit_value
setopt prompt_subst

hysteria-line-init
SPROMPT="%F{$COLOR_BG_LPROMPT}%{$suggest%}(＠ﾟ△ﾟ%)ノ < もしかして %B%r%b かな? [そう!(y), 違う!(n),a,e] > "

