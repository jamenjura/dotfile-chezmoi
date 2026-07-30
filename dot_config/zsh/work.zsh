# -----------------------------------------------------------------------------
# Module: Work
# Description: Load optional work-specific configuration.
#
# This file is intentionally not managed by Chezmoi.
# It allows keeping work-specific configuration separate from
# the personal environment.
# -----------------------------------------------------------------------------

[[ -f "$HOME/.zshrc_work" ]] && source "$HOME/.zshrc_work"
