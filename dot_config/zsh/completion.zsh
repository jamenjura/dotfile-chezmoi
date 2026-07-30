# -----------------------------------------------------------------------------
# Module: Completion
# Description: Zsh completion system. Runs compinit once, reusing the dump
#              cache for 24 hours to keep shell startup fast.
# -----------------------------------------------------------------------------

# Additional completion definitions (Homebrew zsh-completions)
[[ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]] && \
    fpath=("$HOMEBREW_PREFIX/share/zsh-completions" $fpath)

# Initialize completion system (rebuild dump only once every 24 hours)
autoload -Uz compinit
if [[ ! -f "${ZDOTDIR:-$HOME}/.zcompdump" ]] || [[ -n "${ZDOTDIR:-$HOME}/.zcompdump"(Nmh+24) ]]; then
    compinit
else
    compinit -C
fi

# Better completion menu
zstyle ':completion:*' menu select

# Completion UI
zmodload zsh/complist

# Include hidden files
_comp_options+=(globdots)

# Bash completion compatibility (required by terraform.zsh)
autoload -U +X bashcompinit && bashcompinit
