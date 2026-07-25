#!/usr/bin/env bash
set -Eeuo pipefail

if command -v code >/dev/null 2>&1; then
  echo "==> VS Code já está instalado."
  code --version | head -1
  exit 0
fi

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y wget gpg apt-transport-https

wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/packages.microsoft.gpg >/dev/null

echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
  | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y code

code --version | head -1
