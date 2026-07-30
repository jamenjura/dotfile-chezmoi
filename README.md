# 🏠 dotfile-chezmoi

> Entorno de desarrollo **reproducible** para macOS, gestionado con
> [chezmoi](https://www.chezmoi.io/).
> Un solo repositorio, dos máquinas: **personal** y **trabajo**.

![shell](https://img.shields.io/badge/shell-zsh-blue)
![os](https://img.shields.io/badge/os-macOS%20(Apple%20Silicon)-lightgrey)
![manager](https://img.shields.io/badge/dotfiles-chezmoi-orange)

---

## ✨ Qué incluye

- **Perfiles por máquina** (`personal` / `work`) con templates de chezmoi:
  mismo repo, configuraciones distintas donde importa.
- **Shell zsh modular** (`~/.config/zsh/`, un archivo por responsabilidad)
  con arranque de ~0.18 s: lazy-loading de nvm y jenv, completion con caché,
  plugins vía Homebrew.
- **Editor**: Neovim (LazyVim) idéntico en ambas máquinas.
- **Prompt**: Starship · **Historial**: Atuin · **Git TUI**: gitui.
- **Identidad git por perfil**: email personal o `@mercadolibre.com.co`
  según la máquina.
- **Gestores de versión** contemplados: `tfswitch` (terraform), `nvm` (node),
  `jenv` (java).
- **Brewfile** para reproducir todos los paquetes (solo perfil personal).
- **Secretos fuera del repo** (`.chezmoiignore` + archivos locales).

## 🚀 Quickstart

```zsh
brew install chezmoi git
chezmoi init --apply git@github.com:jamenjura/dotfile-chezmoi.git
# → te pregunta el perfil: personal (default) o work
#    (en la Mac del trabajo se pre-selecciona "work" automáticamente)
```

Guía completa con el orden exacto de los pasos:
**[docs/usage.md](docs/usage.md)**

## 🗂️ Estructura

```
├── .chezmoi.toml.tmpl        # selección de perfil en `chezmoi init`
├── .chezmoiignore.tmpl       # exclusiones por perfil (zsh, Brewfile en work)
├── .chezmoiremove.tmpl       # limpieza al cambiar de perfil
├── .chezmoitemplates/
│   └── zshrc-work            # .zshrc del trabajo (aislado, verbatim)
├── Brewfile                  # paquetes brew (solo personal)
├── README.md                 # este archivo
├── docs/                     # documentación (no se despliega)
│   ├── usage.md              # guía diaria: orden de comandos, recetas
│   ├── architectur.md        # arquitectura y decisiones de diseño
│   └── conventions.md        # convenciones del repo
├── dot_config/
│   ├── zsh/                  # shell modular (15 módulos, solo personal)
│   ├── nvim/                 # Neovim (LazyVim)
│   ├── gh/                   # GitHub CLI (hosts.yml nunca)
│   ├── gitui/
│   ├── starship.toml
│   └── private_atuin/
├── dot_gitconfig.tmpl        # identidad git por perfil
└── dot_zshrc.tmpl            # work → monolito | personal → loader modular
```

## 📚 Documentación

| Documento | Contenido |
|---|---|
| [docs/usage.md](docs/usage.md) | **Uso diario**: orden de comandos, instalación limpia (personal y trabajo), recetas (alias, plugin nvim, nvm→fnm...), troubleshooting |
| [docs/architectur.md](docs/architectur.md) | Arquitectura: principios, módulos, perfiles, flujo de dependencias |
| [docs/conventions.md](docs/conventions.md) | Convenciones: naming, layout de módulos, checklist para cambios |

## 🧭 Filosofía

1. **Reproducibilidad** — una máquina nueva queda lista con dos comandos.
2. **Modularidad** — un archivo, una responsabilidad.
3. **Portabilidad** — `$HOME` y `command -v`, nunca rutas fijas.
4. **Personal first** — la configuración del trabajo es opcional y está aislada.

---

<sub>Última máquina sincronizada: MacBook Pro personal (Apple Silicon).</sub>
