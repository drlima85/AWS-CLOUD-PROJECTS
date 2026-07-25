#!/usr/bin/env bash
set -Eeuo pipefail

if command -v dbeaver >/dev/null 2>&1; then
  echo "==> DBeaver já está instalado."
  dbeaver --version || true
  exit 0
fi

tmp_deb="$(mktemp --suffix=.deb)"
trap 'rm -f "$tmp_deb"' EXIT

echo "==> Baixando DBeaver Community..."
wget -qO "$tmp_deb" https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$tmp_deb"

dbeaver --version || true
