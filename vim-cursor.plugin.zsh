# vim-cursor
export VICMD_CURSOR=1
export VIINS_CURSOR=5

export VICMD_CURSOR_COLOR="#93a1a1"
export VIINS_CURSOR_COLOR="#268bd2"

change-cursor() {
    # change cursor shape
    #  https://stackoverflow.com/a/42118416/1666398
    echo -ne "\e[$1 q"

    if [[ -n $2 ]]; then
        # change cursor color
        #  http://ass.kameli.org/cursor_tricks.html
        echo -ne "\e]12;$2\x7"
    fi
}

zle-keymap-select() {
    if [[ $KEYMAP == vicmd ]]; then
        change-cursor $VICMD_CURSOR $VICMD_CURSOR_COLOR
    else
        change-cursor $VIINS_CURSOR $VIINS_CURSOR_COLOR
    fi

    zle reset-prompt
    zle -R
}

# This belongs in `zle-line-init`, but that breaks the
# `history-substring-search` plugin :(
zle-line-finish() { change-cursor $VIINS_CURSOR $VIINS_CURSOR_COLOR}

zle -N zle-keymap-select
zle -N zle-line-finish

bindkey -v
