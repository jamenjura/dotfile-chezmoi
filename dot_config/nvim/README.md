# nvim-meli

Personal Neovim config based on [LazyVim](https://lazyvim.org).

## Requirements

- Neovim >= 0.9.0
- Git
- [Nerd Font](https://www.nerdfonts.com/) (terminal font)
- Node.js (for LSP servers)
- ripgrep (`brew install ripgrep`)
- fd (`brew install fd`)

## Install

```bash
# Back up existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone
git clone git@github.com:jamenjura/nvim-meli.git ~/.config/nvim

# Open Neovim — LazyVim will bootstrap and install all plugins automatically
nvim
```

Plugins are pinned via `lazy-lock.json`. On first open, run `:Lazy restore` to install the exact versions.

## Update plugins

```vim
:Lazy update
```

Then commit the updated `lazy-lock.json` to keep versions in sync across machines.
