# -----------------------------------------------------------------------------
# Module: Prompt
# Description: Initialize the interactive shell prompt.
# Documentation: https://starship.rs/
# -----------------------------------------------------------------------------

# Initialize Starship prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
