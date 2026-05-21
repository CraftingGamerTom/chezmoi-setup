#!/usr/bin/env bash
# Sign into 1Password CLI
set -euo pipefail

# Ensure brew-installed binaries (op on macOS) are on PATH
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v op &>/dev/null; then
  echo "op (1Password CLI) not on PATH. Did step 02 succeed?" >&2
  exit 1
fi

if op account list 2>/dev/null | grep -q .; then
  echo "Already signed into 1Password, refreshing session..."
  eval "$(op signin)"
else
  echo "==> Sign into 1Password CLI..."
  op signin
fi
