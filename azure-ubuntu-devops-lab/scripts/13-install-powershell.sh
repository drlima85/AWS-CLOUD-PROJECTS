#!/usr/bin/env bash
set -Eeuo pipefail

if command -v pwsh >/dev/null 2>&1; then
  echo "==> PowerShell já está instalado."
  pwsh -NoLogo -NoProfile -Command '$PSVersionTable.PSVersion'
  exit 0
fi

source /etc/os-release
ubuntu_version="${VERSION_ID}"

tmp_deb="$(mktemp --suffix=.deb)"
trap 'rm -f "$tmp_deb"' EXIT

wget -qO "$tmp_deb" \
  "https://packages.microsoft.com/config/ubuntu/${ubuntu_version}/packages-microsoft-prod.deb"

sudo dpkg -i "$tmp_deb"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y powershell

pwsh -NoLogo -NoProfile -Command '$PSVersionTable.PSVersion'
