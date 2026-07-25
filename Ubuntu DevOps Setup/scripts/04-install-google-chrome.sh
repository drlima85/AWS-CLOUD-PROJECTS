#!/usr/bin/env bash
set -Eeuo pipefail

if command -v google-chrome >/dev/null 2>&1; then
  echo "==> Google Chrome já está instalado."
  google-chrome --version
  exit 0
fi

tmp_deb="$(mktemp --suffix=.deb)"
trap 'rm -f "$tmp_deb"' EXIT

echo "==> Baixando Google Chrome..."
wget -qO "$tmp_deb" \
  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$tmp_deb"

google-chrome --version
