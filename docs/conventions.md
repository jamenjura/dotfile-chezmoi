# Conventions

> Development conventions for the personal development environment managed with Chezmoi.

---

# Purpose

This document defines the conventions used throughout the repository.

Its purpose is to keep the project:

- consistent
- predictable
- maintainable
- easy to extend

Every new module should follow these conventions.

---

# Naming

Module names should describe a single responsibility.

Good examples:

```
exports.zsh
history.zsh
node.zsh
java.zsh
fzf.zsh
plugins.zsh
```

Avoid generic names such as:

```
tools.zsh
misc.zsh
general.zsh
custom.zsh
```

A filename should answer the question:

> "What responsibility does this module own?"

---

# One Module, One Responsibility

Each module should configure one thing only.

For example:

| Module | Responsibility |
|---------|----------------|
| exports.zsh | Environment variables |
| history.zsh | Shell history |
| node.zsh | Node.js |
| java.zsh | Java |
| aliases.zsh | Aliases |
| plugins.zsh | Interactive plugins |

Avoid combining unrelated configuration inside a single file.

---

# Module Layout

Every module should follow the same structure.

```zsh
# -----------------------------------------------------------------------------
# Module:
# Description:
# Documentation:
# -----------------------------------------------------------------------------

# Configuration

# Initialization

# Optional functions
```

A consistent layout makes navigation easier.

---

# Loading Order

Modules should be loaded in a predictable order.

```
exports

↓

editor

↓

history

↓

completion

↓

keybindings

↓

aliases

↓

language runtimes (node, java)

↓

tool integrations (terraform, kubernetes)

↓

fzf

↓

plugins

↓

work

↓

prompt
```

The prompt should always be initialized last.

Note: `completion` must load before the tool integrations because
`terraform.zsh` requires `bashcompinit` and `kubernetes.zsh` uses `compdef`.

---

# Environment Variables

Always prefer:

```zsh
$HOME
```

instead of:

```zsh
/Users/username
```

Environment variables should be declared only inside the module responsible for them.

Examples:

- node.zsh
- java.zsh
- exports.zsh

---

# Paths

Avoid hardcoded paths whenever possible.

Preferred:

```zsh
command -v

brew --prefix

$HOME
```

Avoid:

```zsh
/opt/homebrew/Cellar/...

/Users/username/...
```

Machine-specific paths reduce portability.

---

# Plugins

Plugins should only be initialized inside:

```
plugins.zsh
```

Examples:

- Starship
- Atuin
- Fast Syntax Highlighting
- Zsh Autosuggestions

Plugin modules should not modify aliases or PATH.

---

# Completions

Shell completions belong exclusively in:

```
completion.zsh
```

Examples:

- compinit
- bashcompinit
- Terraform
- kubectl
- future completions

Completion configuration should remain independent from plugin initialization.

---

# Aliases

Aliases should remain simple.

Good example:

```zsh
alias gs='git status'
```

Avoid aliases containing complex logic.

If a command requires conditionals, loops, or multiple commands, create a function instead.

---

# Functions

Functions should only be added when aliases are no longer sufficient.

Complex shell logic should eventually become standalone scripts.

The shell configuration should remain focused on initialization rather than application logic.

---

# Comments

Every module should begin with the standard header.

```zsh
# -----------------------------------------------------------------------------
# Module:
# Description:
# Documentation:
# -----------------------------------------------------------------------------
```

Section separators should follow the same style.

Consistency improves readability.

---

# Documentation

Every module should answer three questions.

1. What does it configure?
2. Why does it exist?
3. Where is the official documentation?

Whenever possible, include the upstream documentation URL inside the module header.

---

# Dependencies

Dependencies should always point in one direction.

Example:

```
exports

↓

node

↓

plugins

↓

prompt
```

Avoid circular dependencies between modules.

Modules should remain independent whenever possible.

---

# Work Configuration

Personal configuration is the default.

Work-specific configuration should remain isolated.

Examples:

```
work.zsh
```

The personal environment should continue working when work modules are absent.

---

# Portability

Configuration should work across machines with minimal changes.

Prefer runtime detection over fixed paths.

Examples:

```zsh
command -v

brew --prefix
```

Avoid assumptions about usernames or filesystem layouts.

---

# Adding a New Module

Before creating a new module, answer the following questions.

- Does it have a single responsibility?
- Can it remain independent?
- Does a module already exist for this purpose?
- Is it personal or work-specific?
- Does it require documentation?

If the answer is unclear, reconsider the design.

---

# Version Managers

Language version managers should remain isolated.

Examples:

- node.zsh
- java.zsh
- python.zsh (future)
- go.zsh (future)

Changing a version manager should not require modifying unrelated modules.

---

# Error Handling

Initialization should fail gracefully whenever possible.

Prefer:

```zsh
command -v tool >/dev/null 2>&1 && tool init
```

instead of assuming every dependency is installed.

A missing optional tool should never prevent the shell from starting.

---

# Code Style

Prefer readability over compactness.

Use:

- descriptive comments
- logical grouping
- blank lines between sections
- explicit configuration

Avoid unnecessary shell tricks.

Future maintenance is more important than reducing line count.

---

# Review Checklist

Before committing a new module, verify the following.

- [ ] Single responsibility
- [ ] Correct filename
- [ ] Standard header
- [ ] Portable paths
- [ ] No hardcoded usernames
- [ ] No unrelated configuration
- [ ] Official documentation referenced
- [ ] Compatible with the existing loading order
- [ ] Documented if necessary

Every new module should satisfy this checklist before being merged.

---

# Final Principle

The repository should become easier to maintain over time.

Every change should improve one or more of the following:

- readability
- modularity
- portability
- reproducibility
- consistency

If a change makes the repository harder to understand, it should be reconsidered before implementation.
