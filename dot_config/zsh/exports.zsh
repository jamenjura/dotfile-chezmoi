# -----------------------------------------------------------------------------
# Module: Exports
# Description: Global environment variables and PATH.
# -----------------------------------------------------------------------------

# Homebrew prefix (Apple Silicon default; avoids a `brew --prefix` subprocess)
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

# PATH (typeset -U removes duplicate entries)
typeset -U path PATH
path=(
    "$HOMEBREW_PREFIX/bin"
    "$HOMEBREW_PREFIX/sbin"
    "$HOME/.local/bin"
    $path
)

# Docker
export DOCKER_DEFAULT_PLATFORM="linux/amd64"
