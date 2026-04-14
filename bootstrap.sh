#!/usr/bin/env bash
# Minimal bootstrap — just installs chezmoi, then chezmoi handles the rest.
#
# Run on a fresh machine:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/CraftingGamerTom/chezmoi-setup/main/bootstrap.sh)"
#
# Override the dotfiles repo (e.g. for a work config):
#   CHEZMOI_REPO="git@github.com:CraftingGamerTom/chezmoi-work.git" ./bootstrap.sh

set -euo pipefail

GREEN='\033[0;32m'; NC='\033[0m'
log() { echo -e "\n${GREEN}==>${NC} $1"; }

GITHUB_USER="${GITHUB_USER:-CraftingGamerTom}"
SETUP_REPO="https://github.com/${GITHUB_USER}/chezmoi-setup.git"
CHEZMOI_REPO="${CHEZMOI_REPO:-git@github.com:${GITHUB_USER}/chezmoi-personal.git}"
OS="$(uname -s)"

# ── 1. Install chezmoi ───────────────────────────────────────────────────────
if ! command -v chezmoi &>/dev/null; then
  log "Installing chezmoi..."
  if [[ "$OS" == "Darwin" ]]; then
    # Homebrew may not exist yet — use chezmoi's own installer
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
  else
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
  fi
  export PATH="$HOME/.local/bin:$PATH"
fi

# ── 2. Run chezmoi-setup (installs Homebrew, 1Password, etc.) ────────────────
log "Running chezmoi-setup..."
chezmoi init --apply "$SETUP_REPO"

# ── 3. Apply personal/work dotfiles ─────────────────────────────────────────
log "Applying dotfiles from $CHEZMOI_REPO..."
chezmoi init --apply "$CHEZMOI_REPO"

log "Bootstrap complete! Open a new terminal to pick up all changes."
