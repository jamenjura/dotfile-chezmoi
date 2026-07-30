# -----------------------------------------------------------------------------
# Module: History
# Description: Zsh history configuration.
# -----------------------------------------------------------------------------

# History file
HISTFILE="$HOME/.zsh_history"

# History size
HISTSIZE=50000
SAVEHIST=50000

# History behaviour
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
