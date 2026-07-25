#!/usr/bin/env bash
set -Eeuo pipefail

if command -v az >/dev/null 2>&1; then
  echo "==> Azure CLI já está instalada."
  az version
  exit 0
fi

echo "==> Instalando Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

az version
