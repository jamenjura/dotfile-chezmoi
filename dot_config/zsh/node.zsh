# -----------------------------------------------------------------------------
# Module: Node.js (NVM)
# Description: Lazy-loads NVM on first use of nvm/node/npm/npx.
#              Eager loading costs ~500 ms of shell startup time.
# Documentation: https://github.com/nvm-sh/nvm
# -----------------------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"

_nvm_lazy_load() {
    unfunction nvm node npm npx 2>/dev/null
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

nvm()  { _nvm_lazy_load; nvm "$@"; }
node() { _nvm_lazy_load; node "$@"; }
npm()  { _nvm_lazy_load; npm "$@"; }
npx()  { _nvm_lazy_load; npx "$@"; }
