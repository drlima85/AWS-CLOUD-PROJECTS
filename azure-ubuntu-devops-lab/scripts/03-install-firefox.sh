#!/usr/bin/env bash
set -Eeuo pipefail

if command -v firefox >/dev/null 2>&1 && ! snap list firefox >/dev/null 2>&1; then
  echo "==> Firefox já está instalado fora do Snap."
  firefox --version || true
  exit 0
fi

echo "==> Removendo Firefox Snap, caso exista..."
sudo snap remove firefox 2>/dev/null || true

echo "==> Adicionando o repositório Mozilla Team..."
sudo add-apt-repository ppa:mozillateam/ppa -y

sudo tee /etc/apt/preferences.d/mozilla-firefox >/dev/null <<'EOF'
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y firefox

firefox --version
