# -----------------------------------------------------------------------------
# Module: Plugins
# Description: Third-party shell plugins (installed via Homebrew).
#              fast-syntax-highlighting must be sourced near the end
#              of the configuration.
# -----------------------------------------------------------------------------

# Zsh Autosuggestions
[[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
    source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Fast Syntax Highlighting
[[ -f "$HOMEBREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]] && \
    source "$HOMEBREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# Atuin (shell history)
if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
fi
