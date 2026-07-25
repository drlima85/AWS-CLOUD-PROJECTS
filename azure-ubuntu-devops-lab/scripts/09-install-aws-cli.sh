#!/usr/bin/env bash
set -Eeuo pipefail

arch="$(uname -m)"
case "$arch" in
  x86_64) url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" ;;
  aarch64|arm64) url="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" ;;
  *) echo "Arquitetura não suportada por este script: $arch"; exit 1 ;;
esac

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

echo "==> Baixando AWS CLI v2..."
curl -fsSL "$url" -o "$tmp_dir/awscliv2.zip"
unzip -q "$tmp_dir/awscliv2.zip" -d "$tmp_dir"

if command -v aws >/dev/null 2>&1; then
  sudo "$tmp_dir/aws/install" --update
else
  sudo "$tmp_dir/aws/install"
fi

aws --version
