#!/usr/bin/env bash
set -Eeuo pipefail

echo "==> Atualizando o sistema e instalando dependências básicas..."

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  wget \
  unzip \
  gnupg \
  lsb-release \
  software-properties-common \
  git \
  jq \
  tree \
  htop \
  net-tools

echo "==> Dependências básicas instaladas."
