# -----------------------------------------------------------------------------
# Module: Java (jenv)
# Description: jenv shims are added to PATH immediately (zero cost, java works
#              right away); the full `jenv init` (~425 ms) is deferred to the
#              first `jenv` invocation.
# Documentation: https://www.jenv.be/
# -----------------------------------------------------------------------------

if [[ -d "$HOME/.jenv" ]]; then
    path=("$HOME/.jenv/bin" "$HOME/.jenv/shims" $path)

    jenv() {
        unfunction jenv
        eval "$(command jenv init -)"
        jenv "$@"
    }
fi
