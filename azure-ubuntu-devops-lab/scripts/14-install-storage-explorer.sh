#!/usr/bin/env bash
set -Eeuo pipefail

if snap list storage-explorer >/dev/null 2>&1; then
  echo "==> Azure Storage Explorer já está instalado."
  snap info storage-explorer | sed -n '1,12p'
  exit 0
fi

if ! command -v snap >/dev/null 2>&1; then
  sudo apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y snapd
  sudo systemctl enable --now snapd.socket
fi

sudo snap install storage-explorer

echo "==> Azure Storage Explorer instalado."
echo "Abra pelo menu gráfico ou execute: storage-explorer"
