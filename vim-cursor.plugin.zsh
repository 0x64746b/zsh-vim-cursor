# vim-cursor
export VICMD_CURSOR=1
export VIINS_CURSOR=5

change-cursor() {
    echo -ne "\e[$1 q"
}

zle-keymap-select() {
    if [[ $KEYMAP == vicmd ]]; then
        change-cursor $VICMD_CURSOR
    else
        change-cursor $VIINS_CURSOR
    fi

    zle reset-prompt
    zle -R
}

# This belongs in `zle-line-init`, but that breaks the
# `history-substring-search` plugin :(
zle-line-finish() { change-cursor $VIINS_CURSOR }

zle -N zle-keymap-select
zle -N zle-line-finish

bindkey -v
