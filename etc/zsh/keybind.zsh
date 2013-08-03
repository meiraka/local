bindkey -v

# vim like settings
# backspace removes cursor backword
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char
# delete removes cursor forward
bindkey "[3~" delete-char


# tcsh like history search
function history-all { history -E 1 }
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# control + p or cursor up key to search backword
bindkey ""    history-beginning-search-backward-end
bindkey "[A"  history-beginning-search-backward-end
# control + n or cursor down key to search forward
bindkey ""    history-beginning-search-forward-end
bindkey "[B"  history-beginning-search-forward-end
