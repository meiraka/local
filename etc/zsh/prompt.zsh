# zsh prompt setting24
#TODO remove global vars


# set this file path.
PROMPT_SCRIPT=$0

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
  if [ $2 = 'tmux' ]; then
      echo "`color $2 bg ${5}``color $2 fg ${6}`$3"
  else
    echo ""
  fi
}

function hysteria-color-wrapper-end {
  if [ $2 = 'tmux' ]; then
    if [ $1 = 'left' ]; then
      echo "#[bg=colour${5}]$3"
    fi
  else
    echo "%f%k"
  fi
}

function hysteria-color-wrapper {
  # if empty
  if [ -z $9 ]; then
    return
  fi
  if [ ${PROMPT_SHELL} = 'tmux' ]; then
    if  [ "${PROMPT_POS}" = "right" ]; then
      echo "\
#[fg=colour$7]${3}\
#[bg=colour$7,fg=colour$8] "$9" \
"
    else
      echo "\
#[bg=colour$7]${3}\
#[fg=colour$8] "$9" \
#[fg=colour$7]"
    fi
  else
    if [ $1 = "right" ]; then
      if [ "$7" = "NONE" ];then
        p1="%f%k${3}"
        p3=""
      else
        p1="%F{$7}${3}%K{$7}"
        p3="%K{$7}"
      fi
      if [ "$8" = "NONE" ]; then
        p2=" $9 "
      else
        p2="%F{$8} $9 %f%k"
      fi
      echo ${p1}${p2}${p3}
    else
      if [ "$7" = "NONE" ];then
        p1="%f%k${HARD_RIGHT_ARROW}"
        p3=""
      else
        p1="%k%K{$7}${HARD_RIGHT_ARROW}%f"
        p3="%F{$7}"
      fi
      if [ "$8" = "NONE" ]; then
        p2=" $9 "
      else
        p2="%F{$8} $9 %f"
      fi
      echo ${p1}${p2}${p3}
    fi
  fi
}

function prompt-mpd {
  out=`mpc`
  python -c "\
import commands,sys,os;\
a=commands.getoutput('mpc');\
b = a.split('\n')[0] if a.split('\n')[1].startswith('[playing') else '';\
c = ':%s' % os.environ['MPD_PORT'] if 'MPD_PORT' in os.environ else '';\
c = 'at %s%s. ' % (os.environ['MPD_HOST'],c) if 'MPD_HOST' in os.environ else '';\
d = 'now playing %s%s' % (c,b) if b else '';\
print d"

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
  tmux display -p "## #S.#I"
}

function prompt-date {
  date +"%Y%m%d"
}

function prompt-time {
    date +"%H:%M"
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

# hysteria-line [left|right] [zsh|tmux] hardarrow softarrow bg fg promptstyle
function hysteria-line {
  # PROMPT_POS and PROMPT_SHELL env uses in hysteria-* functions.
  if [ $1 = "right" ]; then
    PROMPT_POS="right"
  else
    PROMPT_POS="left"
  fi

  PROMPT_SHELL="$2"
  PROMPT_STYLE="$7"
  HARD_ARROW="$3"
  SOFT_ARROW="$4"
  BG="$5"
  FG="$6"
  PROMPT_TEXT=`hysteria-color-wrapper-start ${PROMPT_POS} ${PROMPT_SHELL} "${HARD_ARROW}" "${SOFT_ARROW}" "${BG}" "${FG}"`
  for prompt in ${=PROMPT_STYLE}; do
    CMD=`prompt-\`echo $prompt | cut -d"," -f3\``
    PROMPT_TEXT=$PROMPT_TEXT`hysteria-color-wrapper ${PROMPT_POS} ${PROMPT_SHELL} "${HARD_ARROW}" "${SOFT_ARROW}" "${BG}" "${FG}" \`echo $prompt | cut -d"," -f1\` \`echo $prompt |  cut -d"," -f2\` "${CMD}"`
  done
  PROMPT_TEXT=${PROMPT_TEXT}`hysteria-color-wrapper-end ${PROMPT_POS} ${PROMPT_SHELL} "${HARD_ARROW}" "${SOFT_ARROW}" "${BG}" "${FG}"`
  echo "${PROMPT_TEXT}"
}

function hysteria-line-update {
# re eval prompt text
  PROMPT_RIGHT_ARROW="on"
  if [ -n "${prompt_right_arrow}" ]; then
    PROMPT_RIGHT_ARROW=${prompt_right_arrow}
  fi
  PROMPT_ZSH="232,124,vcs"
  if [ -n "$prompt_right" ]; then
    PROMPT_ZSH="$prompt_right"
  fi
  set-arrow ${PROMPT_RIGHT_ARROW}
  RPROMPT=`hysteria-line right zsh "${HARD_LEFT_ARROW}" "${SOFT_LEFT_ARROW}" NONE NONE "${PROMPT_ZSH}"`

  PROMPT_LEFT_ARROW="off"
  if [ -n "${prompt_left_arrow}" ]; then
    PROMPT_LEFT_ARROW="${prompt_left_arrow}"
  fi
  if [ -n "$prompt_left" ]; then
    PROMPT_ZSH="$prompt_left"
  else
    PROMPT_ZSH="NONE,124,arrow"
  fi
  set-arrow ${PROMPT_LEFT_ARROW}
  PROMPT=`hysteria-line left zsh "${HARD_RIGHT_ARROW}" "${SOFT_RIGHT_ARROW}" NONE NONE "${PROMPT_ZSH}"`
}

function hysteria-line-init {
  function zle-line-init zle-keymap-select {
    hysteria-line-update
    zle reset-prompt
  }
  hysteria-line-update
  
  zle -N zle-line-init
  zle -N zle-keymap-select
}

if [ $# = 8 ]; then
  if [ $1 = "command" ]; then
    source ~/local/conf/user-env.zsh
    source ~/local/conf/user-config.zsh
    hysteria-line $3 $2 "$4" "$5" "$6" "$7" "$8"
  fi
fi
