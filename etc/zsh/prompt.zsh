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

# set fixed tmux prompt
if [ -n "$TMUX" ]; then
  tmux set -g window-status-current-format "#[fg=colour${COLOR_BG_TMUX},bg=colour${COLOR_BG_LPROMPT}]${HARD_RIGHT_ARROW} #[fg=colour${COLOR_FG_LPROMPT}]#I.#W #[fg=colour${COLOR_BG_LPROMPT},bg=colour${COLOR_BG_TMUX}]${HARD_RIGHT_ARROW}" > /dev/null 2> /dev/null
  tmux set -g status-bg colour${COLOR_BG_TMUX} > /dev/null 2> /dev/null
  tmux set -g window-status-format " #I.#W " > /dev/null 2> /dev/null
  tmux set -g status-right "#[fg=colour163]${HARD_LEFT_ARROW}#[fg=colour232,bg=colour163] %Y%m%d %a #[bold]${SOFT_LEFT_ARROW}#[default,fg=colour232,bg=colour163] %H:%M " > /dev/null 2> /dev/null
fi

#print out left prompt
function left_prompt {
  COLOR_BG_LPROMPT=${COLOR_BG_LPROMPT}
  COLOR_FG_LPROMPT=${COLOR_FG_LPROMPT}
  LEFT_TMUX_TEXT="\
#[fg=colour${COLOR_FG_TMUX},bg=colour${COLOR_BG_TMUX}]\
 ## #S.#I \
#[fg=colour${COLOR_BG_TMUX}]"
  LEFT_PROMPT_TEXT="> "

  # toggle arrow by vi INSERT/NORMAL mode
  case $KEYMAP in
    vicmd)
      LEFT_PROMPT_TEXT="< "
    ;;
    main|viins)
      LEFT_PROMPT_TEXT="> "
    ;;
  esac

  # show user and hostname tmux status or zsh prompt
  if [ -n "$TMUX" ]; then
    LEFT_TMUX_TEXT=${LEFT_TMUX_TEXT}"\
#[bg=colour${COLOR_BG_LPROMPT}]\
${HARD_RIGHT_ARROW}\
#[default,fg=colour${COLOR_FG_LPROMPT},bg=colour${COLOR_BG_LPROMPT}]\
 #(whoami)\
 #[bold]\
${SOFT_RIGHT_ARROW}\
#[default,fg=colour${COLOR_FG_LPROMPT},bg=colour${COLOR_BG_LPROMPT}]\
 #(hostname) \
#[default,fg=colour${COLOR_BG_LPROMPT}]\
"
  else
    LEFT_PROMPT_TEXT="%n@%m "${LEFT_PROMPT_TEXT}
  fi

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
    LEFT_TMUX_TEXT=${LEFT_TMUX_TEXT}"\
#[bg=colour${COLOR_BG_VCS}]
${HARD_RIGHT_ARROW} \
#[default,fg=colour${COLOR_FG_VCS},bg=colour${COLOR_BG_VCS}]\
${VCS_REMOTE_TEXT}\
#[bold]\
 ${SOFT_RIGHT_ARROW} \
#[default,fg=colour${COLOR_FG_VCS},bg=colour${COLOR_BG_VCS}]\
${VCS_BRANCH_TEXT} \
#[default,fg=colour${COLOR_BG_VCS}]"
  fi

  if [ -n "$TMUX" ]; then
    LEFT_TMUX_TEXT=${LEFT_TMUX_TEXT}"\
${HARD_RIGHT_ARROW}"
    tmux set -g status-left "${LEFT_TMUX_TEXT}" > /dev/null 2> /dev/null
  fi
  echo "%F{$COLOR_BG_LPROMPT}${LEFT_PROMPT_TEXT}%f%F{$COLOR_MAIN}"
}


# print out right prompt
function right_prompt {
  PROMPT_TEXT="%F{$COLOR_BG_RPROMPT}[zsh@%~]"

  # show NORMAL message if vi NORMAL mode.
  case $KEYMAP in
    vicmd)
      PROMPT_TEXT="--NORMAL--"
    ;;
    viins)
      PROMPT_TEXT="--INSERT--"
    ;;
  esac

  echo "${PROMPT_TEXT}"
}


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

