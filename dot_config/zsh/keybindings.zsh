# -----------------------------------------------------------------------------
# Module: Keybindings
# Description: Interactive shell keybindings and editor shortcuts.
# -----------------------------------------------------------------------------

# Use Emacs keybindings
bindkey -e

# -----------------------------------------------------------------------------
# Edit current command in $EDITOR (Ctrl+X Ctrl+E)
# -----------------------------------------------------------------------------

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# -----------------------------------------------------------------------------
# History navigation
# -----------------------------------------------------------------------------

bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# -----------------------------------------------------------------------------
# Word navigation
# -----------------------------------------------------------------------------

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# macOS Option + Arrow keys
if [[ "$OSTYPE" == darwin* ]]; then
    bindkey '^[^[[C' forward-word
    bindkey '^[^[[D' backward-word
fi
