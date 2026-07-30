# -----------------------------------------------------------------------------
# Module: Terraform
# Description: Terraform shell integration. Requires bashcompinit
#              (loaded in completion.zsh).
# -----------------------------------------------------------------------------

if command -v terraform >/dev/null 2>&1; then
    complete -o nospace -C "$(command -v terraform)" terraform
fi
