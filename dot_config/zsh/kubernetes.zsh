# -----------------------------------------------------------------------------
# Module: Kubernetes
# Description: kubectl completion, cached on disk and regenerated weekly
#              (regenerating on every startup costs ~80 ms).
# Documentation: https://kubernetes.io/docs/reference/kubectl/
# -----------------------------------------------------------------------------

if command -v kubectl >/dev/null 2>&1; then
    _zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
    [[ -d "$_zsh_cache_dir" ]] || mkdir -p "$_zsh_cache_dir"

    _kubectl_completion="$_zsh_cache_dir/kubectl-completion.zsh"

    # Regenerate the cache if missing or older than one week
    if [[ ! -f "$_kubectl_completion" ]] || [[ -n "$_kubectl_completion"(Nmw+1) ]]; then
        kubectl completion zsh >| "$_kubectl_completion"
    fi

    source "$_kubectl_completion"

    # kubecolor wraps kubectl: reuse its completion
    command -v kubecolor >/dev/null 2>&1 && compdef kubecolor=kubectl

    unset _zsh_cache_dir _kubectl_completion
fi
