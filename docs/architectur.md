# Architecture

> Personal development environment managed with Chezmoi.

---

# Philosophy

This repository is more than a collection of dotfiles.

Its purpose is to provide a reproducible, modular and maintainable development environment that can be deployed consistently across machines.

Every design decision should support one or more of the following principles:

- Reproducibility
- Modularity
- Portability
- Maintainability
- Separation of concerns

The repository should evolve over time without requiring major redesigns.

---

# Design Principles

## Single Responsibility

Each module should configure one thing only.

Examples:

- `node.zsh`
- `java.zsh`
- `kubernetes.zsh`
- `fzf.zsh`

Avoid generic modules such as:

- `tools.zsh`
- `misc.zsh`

These usually become difficult to maintain over time.

---

## Explicit over Implicit

Configuration should be easy to understand.

Prefer explicit configuration over clever shell tricks.

Future maintenance is more important than saving a few lines of code.

---

## Loose Coupling

Modules should be as independent as possible.

For example:

- `aliases.zsh` should not initialize plugins.
- `plugins.zsh` should not modify PATH.
- `completion.zsh` should not define aliases.

Each module owns its own responsibility.

---

## Portability First

Avoid machine-specific configuration whenever possible.

Prefer:

```zsh
$HOME
command -v
brew --prefix
```

Instead of hardcoded paths.

The repository should require minimal changes when moving to another machine.

---

## Personal First

This repository represents a personal development environment.

Work-specific configuration must remain isolated and optional.

The personal environment should continue working even if work-related modules are absent.

---

# Repository Structure

```
chezmoi/
├── .chezmoi.toml.tmpl        # profile selection on chezmoi init (personal/work)
├── .chezmoiignore.tmpl       # per-profile exclusions (zsh modules, Brewfile on work)
├── .chezmoiremove.tmpl       # cleans .config/zsh when switching to work
├── .chezmoitemplates/
│   └── zshrc-work            # work machine .zshrc (isolated, verbatim)
├── Brewfile                  # personal brew bundle (~/Brewfile, personal only)
├── README.md                 # repository overview (repo only)
├── docs/                     # repo documentation (not deployed)
│   ├── usage.md              # daily workflow, clean installs, recipes
│   ├── architectur.md
│   └── conventions.md
├── dot_config/
│   ├── gh/                   # GitHub CLI (hosts.yml is never managed)
│   ├── gitui/
│   ├── nvim/
│   ├── starship.toml
│   ├── zsh/                  # personal modular shell configuration
│   └── private_atuin/
├── dot_gitconfig.tmpl        # git identity per profile (personal/work email)
└── dot_zshrc.tmpl            # work -> zshrc-work | personal -> module loader
```

Responsibilities are separated between documentation and configuration.

- `docs/` contains project documentation (kept in the repo only, never deployed).
- `dot_config/` contains managed configuration.
- Root files represent top-level configuration managed by Chezmoi.
- `.chezmoitemplates/` contains shared templates (the work configuration is isolated here).

---

# Zsh Architecture

The shell configuration is organized as independent modules.

```
exports
    ↓
editor
    ↓
history
    ↓
completion   (before terraform/kubernetes: bashcompinit and compdef dependency)
    ↓
keybindings
    ↓
aliases
    ↓
node
    ↓
java
    ↓
terraform
    ↓
kubernetes
    ↓
fzf
    ↓
plugins
    ↓
work
    ↓
prompt      (always last)
```

Each module performs a single responsibility and should remain independent whenever possible.

---

# Module Responsibilities

## exports.zsh

Defines global environment variables.

Examples:

- PATH
- HOMEBREW_PREFIX
- DOCKER_DEFAULT_PLATFORM

---

## editor.zsh

Defines the default command-line editor.

Examples:

- EDITOR
- VISUAL

---

## terraform.zsh

Terraform shell integration.

Examples:

- terraform completion (requires bashcompinit from completion.zsh)

---

## history.zsh

History behaviour.

Responsible for:

- history size
- duplicate handling
- history options

---

## node.zsh

Initializes the Node.js environment.

Current implementation:

- NVM

The implementation may change without affecting the overall architecture.

---

## java.zsh

Initializes the Java environment.

Current implementation:

- jenv

---

## keybindings.zsh

Interactive shell shortcuts.

Examples:

- history navigation
- editor shortcuts
- word navigation

---

## fzf.zsh

Configures FZF.

Responsible for:

- key bindings
- preview configuration
- default behaviour

---

## plugins.zsh

Loads interactive shell plugins.

Examples:

- Starship
- Atuin
- Fast Syntax Highlighting
- Zsh Autosuggestions

---

## completion.zsh

Initializes shell completion.

Examples:

- completion system
- Terraform completion
- Kubernetes completion

---

## kubernetes.zsh

Contains Kubernetes shell integration.

Examples:

- kubectl completion

Future Kubernetes tooling should also live here.

---

## aliases.zsh

Defines shell aliases.

Nothing else.

---

## work.zsh

Optional work-specific configuration.

Examples:

- company environment variables
- internal tools
- corporate aliases

This module should never be required for the personal environment.

---

## prompt.zsh

Initializes the shell prompt.

Always loaded last.

---

# Dependency Flow

The configuration follows a top-down dependency model.

```
Environment

↓

Language runtimes

↓

Interactive shell

↓

Developer tooling

↓

Prompt
```

Dependencies should always point downward.

Avoid circular dependencies between modules.

---

# Portability

The repository is designed to be portable.

Whenever possible:

- use `$HOME`
- detect binaries with `command -v`
- use `brew --prefix` when relying on Homebrew
- avoid user-specific paths

Machine-specific configuration should remain isolated.

---

# Personal vs Work

Personal configuration is the default.

Work-specific configuration is optional and isolated.

The repository implements this separation with **chezmoi profiles**:

- On `chezmoi init`, `.chezmoi.toml.tmpl` asks for the machine profile
  (`personal` or `work`) and stores it in `~/.config/chezmoi/chezmoi.toml`.
  The work machine is pre-selected automatically by its username.
- `dot_zshrc.tmpl` renders the work monolith
  (`.chezmoitemplates/zshrc-work`, kept verbatim) on work machines,
  or the modular loader (`~/.config/zsh/loader.zsh`) on personal machines.
- `.chezmoiignore.tmpl` prevents the personal modules from being deployed
  on work machines; `.chezmoiremove.tmpl` cleans them up when switching.

To switch the profile of a machine, edit `profile` in
`~/.config/chezmoi/chezmoi.toml` and run `chezmoi apply`.

```
Personal                          Work
│                                 │
├── exports                       └── .zshrc (verbatim monolith,
├── history                              isolated in
├── node                                   .chezmoitemplates/)
├── java
├── plugins
├── aliases
│
└── work (optional)
```

This separation allows the same repository to be used across personal and corporate machines.

---

# Future Evolution

The architecture is expected to evolve.

Future improvements may include:

- additional language modules
- additional development tools
- improved bootstrap automation
- Linux compatibility
- new version managers

Changes should preserve the design principles defined in this document.

---

# Architecture Review

When introducing a new module, ask the following questions:

1. Does it have a single responsibility?
2. Can it remain independent?
3. Is it portable?
4. Is it personal or work-specific?
5. Does it follow the existing architecture?

If the answer to any question is "no", reconsider the design before implementing it.
