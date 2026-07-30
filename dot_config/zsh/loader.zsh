# -----------------------------------------------------------------------------
# Zsh bootstrap
# Description: Entry point for the personal shell configuration.
#              Modules are loaded in a specific order:
#              exports must be first (HOMEBREW_PREFIX, PATH),
#              completion precedes terraform/kubernetes (compdef dependency)
#              and prompt must be last (see docs/conventions.md).
# -----------------------------------------------------------------------------

ZSH_CONFIG_DIR="${ZSH_CONFIG_DIR:-$HOME/.config/zsh}"

for _zsh_module in \
    exports \
    editor \
    history \
    completion \
    keybindings \
    aliases \
    node \
    java \
    terraform \
    kubernetes \
    fzf \
    plugins \
    work \
    prompt
do
    [[ -f "$ZSH_CONFIG_DIR/$_zsh_module.zsh" ]] && source "$ZSH_CONFIG_DIR/$_zsh_module.zsh"
done

unset _zsh_module ZSH_CONFIG_DIR
