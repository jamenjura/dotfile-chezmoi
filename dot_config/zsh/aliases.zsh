# -----------------------------------------------------------------------------
# Module: Aliases
# Description: Common shell aliases.
# -----------------------------------------------------------------------------

# File listing (eza, the maintained fork of exa)
if command -v eza >/dev/null 2>&1; then
    alias ls='eza'
    alias ll='eza -lah --git --icons'
fi

# Search
alias grep='grep --color=auto'

# Disk usage
alias du1='du -h -d 1'

# Kubernetes (kubecolor adds colors to kubectl output)
if command -v kubecolor >/dev/null 2>&1; then
    alias k='kubecolor'
    alias kube='kubecolor'
else
    alias k='kubectl'
fi

# Terraform
alias tf='terraform'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gb='git branch'
