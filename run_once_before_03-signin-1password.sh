#!/usr/bin/env bash
# Sign into 1Password CLI
set -euo pipefail

if op account list 2>/dev/null | grep -q .; then
  echo "Already signed into 1Password, refreshing session..."
  eval "$(op signin)"
else
  echo "==> Sign into 1Password CLI..."
  op signin
fi
