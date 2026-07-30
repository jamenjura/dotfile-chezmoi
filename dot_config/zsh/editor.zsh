# -----------------------------------------------------------------------------
# Module: Editor
# Description: Default command-line editor configuration.
# -----------------------------------------------------------------------------

if command -v nvim >/dev/null 2>&1; then
    export EDITOR="$(command -v nvim)"
    export VISUAL="$EDITOR"
fi
