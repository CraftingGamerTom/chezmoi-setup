# chezmoi-setup

Minimal bootstrap to prepare a fresh macOS or Ubuntu/Debian machine for use with
[chezmoi](https://www.chezmoi.io/). Installs the essentials needed before applying
your own dotfiles repo:

1. **chezmoi** — declarative dotfile manager
2. **Homebrew** (macOS only) — package manager
3. **1Password CLI (`op`)** — secret retrieval at apply time
4. **1Password sign-in** — interactive, once per machine

After this runs, the machine has everything required for `chezmoi init --apply`
against a dotfiles repository.

## Fresh machine — one-liner

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/CraftingGamerTom/chezmoi-setup/main/bootstrap.sh)
```

That's it. The script is idempotent — re-running is safe.

## What it does

| Step | Script | Purpose |
|------|--------|---------|
| 0 | `bootstrap.sh` | Installs chezmoi into `~/.local/bin`, then invokes the steps below |
| 1 | `run_once_before_01-install-homebrew.sh.tmpl` | Installs Homebrew (macOS only) |
| 2 | `run_once_before_02-install-1password-cli.sh.tmpl` | Installs `op` via brew (macOS) or apt + signed repo (Linux) |
| 3 | `run_once_before_03-signin-1password.sh` | Prompts for interactive 1Password sign-in |

## Requirements

- macOS (Apple Silicon or Intel) **or** Ubuntu/Debian Linux
- Internet access
- Sudo password (for Homebrew on macOS, apt on Linux)
- A 1Password account (sign-in is interactive)

## Customization

Bootstrap reads environment variables for overrides. To point at a different
dotfiles repo:

```bash
CHEZMOI_REPO="git@github.com:youruser/your-dotfiles.git" \
  bash <(curl -fsSL https://raw.githubusercontent.com/CraftingGamerTom/chezmoi-setup/main/bootstrap.sh)
```

See `bootstrap.sh` for the full list of supported variables.

## After bootstrap

Open a new shell to pick up `PATH` and `brew shellenv`. chezmoi will then keep
the machine in sync with whatever dotfiles repo you applied:

```bash
chezmoi update    # pull + apply latest changes
chezmoi diff      # preview pending changes
chezmoi apply     # apply changes
```

## License

MIT.
