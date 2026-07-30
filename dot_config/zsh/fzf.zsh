# -----------------------------------------------------------------------------
# Module: FZF
# Description: FZF key bindings and default behaviour (Homebrew install).
# Documentation: https://github.com/junegunn/fzf
# -----------------------------------------------------------------------------

if command -v fzf >/dev/null 2>&1; then
    [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]] && \
        source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"

    [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] && \
        source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

# -----------------------------------------------------------------------------
# Default options
# -----------------------------------------------------------------------------

export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"

export FZF_CTRL_T_OPTS="
--preview 'bat --style=numbers --color=always --line-range=:500 {} 2>/dev/null'
"

export FZF_ALT_C_OPTS="
--preview 'eza --tree --level=2 --color=always {} 2>/dev/null'
"
