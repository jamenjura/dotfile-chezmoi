# 📖 Guía de uso — Dotfiles chezmoi

Dotfiles personales gestionados con [chezmoi](https://www.chezmoi.io/).
Un mismo repositorio sirve para la **Mac personal** y la **Mac del trabajo**
mediante *perfiles*.

| Perfil | Máquina | Qué recibe |
|---|---|---|
| `personal` | Mac personal (usuario `alexandermenjura`) | zsh modular (`~/.config/zsh/`), Brewfile, nvim, starship, atuin, gh, gitui, gitconfig con email personal |
| `work` | Mac del trabajo (usuario `jamenjura`) | `.zshrc` monolito MELI (verbatim), nvim, starship, atuin, gh, gitui, gitconfig con email laboral. **Sin** módulos zsh ni Brewfile |

El perfil de cada máquina se guarda en `~/.config/chezmoi/chezmoi.toml`
(se pregunta una sola vez en `chezmoi init`).

---

# ⏱️ Orden de comandos (ciclo completo de un cambio)

El orden importa: si saltas un paso, el cambio no llega a la otra máquina.

```
MÁQUINA A (donde editas)                MÁQUINA B (la otra)
──────────────────────────              ──────────────────────
1. nvim <archivo>
2. exec zsh          ← probar
3. chezmoi re-add    ← capturar
4. cd ~/.local/share/chezmoi
5. git add -A
6. git commit -m "..."
7. git push          ← subir
                                     →  8. chezmoi update   ← bajar y aplicar
                                     →  9. exec zsh         ← verificar
```

**Reglas del orden:**

1. `exec zsh` (probar) **siempre antes** de `re-add`: no subas lo que no arranca.
2. `re-add` **siempre antes** del commit: sin él, el repo no tiene tus cambios.
3. `push` **siempre antes** de `chezmoi update` en la otra máquina.
4. `chezmoi update` ya hace `pull` + `apply`: no necesitas git en la máquina B.
5. Si editaste un **template** (`.gitconfig`, `.zshrc`): reemplaza los pasos 1-3
   por `chezmoi edit <archivo>` + `chezmoi apply` (ver receta 8).

**Primera vez en una máquina:** el orden es el de la sección
[📥 Instalación limpia](#-instalación-limpia) (pasos numerados 1→8).
Después de eso, todo cambio sigue el ciclo de arriba.

---

# 📥 Instalación limpia

## Mac personal (nueva o formateada)

```zsh
# 1. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. chezmoi + git
brew install chezmoi git

# 3. Llave SSH para GitHub (si no existe)
ssh-keygen -t ed25519 -C "menjuraalexander@gmail.com"
cat ~/.ssh/id_ed25519.pub   # subir a GitHub → Settings → SSH Keys

# 4. Clonar y aplicar (preguntará el perfil → personal)
chezmoi init --apply git@github.com:jamenjura/dotfile-chezmoi.git

# 5. Instalar todos los paquetes
brew bundle --file=~/Brewfile

# 5b. terraform llega vía tfswitch (elige la versión que necesites)
tfswitch

# 6. Node (nvm no va por brew)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# 7. Si aparece "zsh compinit: insecure directories"
chmod go-w /opt/homebrew/share
chmod -R go-w /opt/homebrew/share/zsh

# 8. Cerrar y abrir la terminal. Abrir nvim (los plugins se instalan solos).
```

## Mac del trabajo

```zsh
# 1-3 igual (brew, chezmoi, llave SSH)

# 4. Clonar y aplicar → el perfil work se pre-selecciona solo (usuario jamenjura)
chezmoi init --apply git@github.com:jamenjura/dotfile-chezmoi.git
```

Eso es todo. El perfil `work`:
- deja el `.zshrc` MELI **idéntico** al que ya existe (no se toca nada laboral),
- pone `~/.gitconfig` con el email `@mercadolibre.com.co`,
- instala nvim/starship/atuin/gh/gitui,
- **no** instala los módulos zsh personales ni el Brewfile.

> Si la Mac del trabajo ya tenía el repo clonado de antes:
> `chezmoi init --apply` (re-ejecutar para que pregunte el perfil) y listo.

---

# 🔄 Flujo diario

## Regla de oro

> Se edita el **archivo real** en su ubicación (`~/.config/zsh/aliases.zsh`,
> `~/.config/starship.toml`...), **nunca** directamente en
> `~/.local/share/chezmoi/`. Luego se captura con `chezmoi re-add`.
>
> Excepción: archivos *template* (`.gitconfig`, `.zshrc`) → se editan con
> `chezmoi edit <archivo>` (abre el source) y se aplican con `chezmoi apply`.

## Subir cambios (en la máquina donde editaste)

```zsh
# 1. Editar y probar (ejemplo: alias)
nvim ~/.config/zsh/aliases.zsh
exec zsh                    # recarga el shell y verificas que funcione

# 2. Capturar en el repo
chezmoi re-add              # captura TODO lo que cambió (seguro: no toca templates)

# 3. Revisar qué cambió y subir
cd ~/.local/share/chezmoi
git status && git diff
git add -A
git commit -m "feat(zsh): agrego alias X"
git push
```

## Recibir cambios (en la otra máquina)

```zsh
chezmoi update        # = git pull + chezmoi apply
```

## ¿Dónde edito cada cosa?

| Quiero cambiar... | Archivo |
|---|---|
| Alias | `~/.config/zsh/aliases.zsh` |
| PATH / variables globales | `~/.config/zsh/exports.zsh` |
| Historia | `~/.config/zsh/history.zsh` |
| Node / nvm | `~/.config/zsh/node.zsh` |
| Java / jenv | `~/.config/zsh/java.zsh` |
| kubectl / kubernetes | `~/.config/zsh/kubernetes.zsh` |
| terraform | `~/.config/zsh/terraform.zsh` |
| fzf | `~/.config/zsh/fzf.zsh` |
| Plugins de shell (autosuggestions, highlight, atuin) | `~/.config/zsh/plugins.zsh` |
| Prompt (starship) | `~/.config/starship.toml` |
| Keybindings | `~/.config/zsh/keybindings.zsh` |
| nvim | `~/.config/nvim/` |
| git identity (email) | `chezmoi edit ~/.gitconfig` ⚠️ template |
| `.zshrc` | `chezmoi edit ~/.zshrc` ⚠️ template (casi nunca: es solo el loader) |
| Algo solo del trabajo | `~/.zshrc_work` (local, NO va al repo) |
| Orden de carga de módulos | `~/.config/zsh/loader.zsh` |

---

# 🔀 Gestores de versión

Cada herramienta cambia de versión con su gestor; la configuración ya está
preparada para ellos (no hay rutas fijas: todo se resuelve con `command -v`
y shims/symlinks dinámicos).

| Herramienta | Gestor | Cambiar de versión | Dónde vive |
|---|---|---|---|
| terraform | **tfswitch** | `tfswitch` (menú interactivo) | versiones en `~/.terraform.versions/`; `/usr/local/bin/terraform` es el symlink activo |
| node | **nvm** (lazy) | `nvm install X` / `nvm use X` | `~/.nvm` (módulo `node.zsh`) |
| java | **jenv** | `jenv global X` | shims en `~/.jenv/shims` (módulo `java.zsh`) |
| terraform (trabajo) | tfenv | dentro del `.zshrc` MELI | aislado en el perfil `work` |
| python/go (trabajo) | pyenv / goenv / mise | dentro del `.zshrc` MELI | aislado en el perfil `work` |

> ⚠️ **terraform NO se instala por Homebrew** en la personal: un
> `/opt/homebrew/bin/terraform` de brew taparía el symlink de tfswitch
> (Homebrew va primero en el PATH). Por eso el `Brewfile` instala
> `tfswitch` y no `terraform`. Tras una instalación limpia: `tfswitch`
> y eliges la versión (se guarda en `~/.terraform.versions/`).
>
> El completion de terraform sigue funcionando al cambiar de versión:
> `terraform.zsh` registra `complete -C "$(command -v terraform)"`, que
> apunta al symlink de tfswitch y se resuelve en cada invocación.

---

# 🍳 Recetas

## 1. Agregar un alias nuevo

```zsh
nvim ~/.config/zsh/aliases.zsh
#   alias kctx='kubectx'

exec zsh && alias kctx      # probar
chezmoi re-add
cd ~/.local/share/chezmoi && git add -A && git commit -m "feat(zsh): alias kctx" && git push
# En la otra máquina: chezmoi update && exec zsh
```

## 2. Cambiar de nvm a fnm

```zsh
brew install fnm

# Reemplazar el módulo node (todo el contenido):
cat > ~/.config/zsh/node.zsh << 'EOF'
# -----------------------------------------------------------------------------
# Module: Node.js (fnm)
# Description: Fast Node Manager.
# Documentation: https://github.com/Schniz/fnm
# -----------------------------------------------------------------------------

if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
EOF

exec zsh && fnm install --lts && node --version   # probar

chezmoi re-add
cd ~/.local/share/chezmoi && git add -A && git commit -m "refactor(zsh): nvm -> fnm" && git push
# En la otra máquina: chezmoi update && brew install fnm
```

## 3. Instalar un plugin de nvim y llevarlo al trabajo

```zsh
# 1. Crear el spec del plugin (LazyVim)
nvim ~/.config/nvim/lua/plugins/mi-plugin.lua
#   return { "autor/mi-plugin", opts = {} }

# 2. Abrir nvim → lazy.nvim lo instala y actualiza lazy-lock.json solo
nvim

# 3. Capturar spec + lockfile y subir
chezmoi re-add
cd ~/.local/share/chezmoi && git add -A && git commit -m "feat(nvim): agrego mi-plugin" && git push

# 4. En la Mac del trabajo:
chezmoi update
nvim --headless "+Lazy! sync" +qa    # o simplemente abrir nvim
```

## 4. Instalar un paquete brew nuevo

```zsh
brew install ripgrep
brew bundle dump --force --file=~/Brewfile   # regenera el Brewfile
chezmoi re-add ~/Brewfile
cd ~/.local/share/chezmoi && git add -A && git commit -m "feat(brew): agrego ripgrep" && git push
```

> El Brewfile es **solo personal**: no llega a la Mac del trabajo.

## 5. Empezar a gestionar un dotfile nuevo

```zsh
chezmoi add ~/.tmux.conf        # o una carpeta: chezmoi add ~/.config/kitty
cd ~/.local/share/chezmoi && git add -A && git commit -m "feat: agrego tmux.conf" && git push
```

> ⚠️ Antes de `chezmoi add`, revisa que el archivo **no tenga secretos**
> (tokens, contraseñas). Si tiene, no se sube (ver receta 7).

## 6. Cambio que SOLO aplica a esta máquina (no va al repo)

- Cosas laborales puntuales: `~/.zshrc_work` (lo carga `work.zsh`, no está gestionado).
- Secretos: `~/.zshrc_secrets` (ignorado por `.chezmoiignore`).

## 7. Manejar un secreto (token, API key)

**Nunca** entra al repo. Opciones:

```zsh
# a) Archivo local ignorado (ya configurado en .chezmoiignore):
echo 'export MI_TOKEN="..."' >> ~/.zshrc_secrets
#    y cargarlo desde ~/.zshrc_work:  [[ -f ~/.zshrc_secrets ]] && source ~/.zshrc_secrets

# b) Gestionado pero encriptado (chezmoi + age), ver:
#    https://www.chezmoi.io/user-guide/encryption/
```

## 8. Cambiar el email de git (personal o trabajo)

```zsh
chezmoi edit ~/.gitconfig      # abre el TEMPLATE en el repo
# editar el email del bloque {{ if eq .profile "work" }} o del {{ else }}
chezmoi apply ~/.gitconfig
cd ~/.local/share/chezmoi && git add -A && git commit -m "chore: actualizo email git" && git push
```

> ⚠️ `chezmoi re-add` **no** sirve para templates (`.gitconfig`, `.zshrc`):
> borraría las condiciones de perfil. Usa siempre `chezmoi edit` en esos dos.

---

# 🆘 Troubleshooting

| Síntoma | Solución |
|---|---|
| `chezmoi status` muestra `M archivo` | El local difiere del repo. ¿Cambio bueno? → `chezmoi re-add <archivo>` + commit. ¿Quiero el del repo? → `chezmoi apply <archivo>` |
| `MM lazy-lock.json` tras abrir nvim | lazy.nvim reescribió el lockfile. Si fue un update intencional: `chezmoi re-add` + commit. Si no: `chezmoi apply --force ~/.config/nvim/lazy-lock.json && nvim --headless "+Lazy! restore" +qa` |
| `warning: config file template has changed` | `chezmoi init` (regenera `~/.config/chezmoi/chezmoi.toml` conservando tu perfil) |
| `zsh compinit: insecure directories` | `chmod go-w /opt/homebrew/share && chmod -R go-w /opt/homebrew/share/zsh` |
| `node: command not found` en script no interactivo | nvm es *lazy* (solo shells interactivos). En scripts usa la ruta completa: `~/.nvm/versions/node/v24.18.0/bin/node` |
| Cambié de perfil y quedaron archivos del otro | `chezmoi apply` limpia vía `.chezmoiremove` (`.config/zsh` se elimina al pasar a work) |
| ¿Todo roto? | `chezmoi doctor` y `chezmoi status` para diagnosticar |

---

# 📖 Cheat sheet

```zsh
chezmoi status                 # ¿qué difiere entre local y repo?
chezmoi diff                   # ver las diferencias en detalle
chezmoi re-add                 # capturar cambios locales → repo
chezmoi apply                  # aplicar repo → local
chezmoi update                 # git pull + apply (recibir en la otra máquina)
chezmoi edit ~/.gitconfig      # editar un TEMPLATE en el source
chezmoi cat ~/.zshrc           # ver cómo quedaría un archivo aplicado
chezmoi managed                # listar todo lo gestionado
chezmoi add ~/.archivo         # empezar a gestionar algo nuevo
chezmoi forget ~/.archivo      # dejar de gestionar (no borra el archivo)
chezmoi doctor                 # diagnóstico general

# Repo (siempre en ~/.local/share/chezmoi):
cd ~/.local/share/chezmoi
git status / git add -A / git commit -m "..." / git push
```

Convención de commits del repo: `feat(zsh): ...`, `fix(nvim): ...`,
`chore: ...`, `refactor: ...` (ver `docs/conventions.md`).
