#!/usr/bin/env bash
set -Eeuo pipefail

arch="$(dpkg --print-architecture)"
case "$arch" in
  amd64|arm64) ;;
  *) echo "Arquitetura não suportada: $arch"; exit 1 ;;
esac

version="$(curl -L -s https://dl.k8s.io/release/stable.txt)"
tmp_file="$(mktemp)"
trap 'rm -f "$tmp_file"' EXIT

echo "==> Instalando kubectl ${version}..."
curl -fsSL "https://dl.k8s.io/release/${version}/bin/linux/${arch}/kubectl" \
  -o "$tmp_file"

curl -fsSL "https://dl.k8s.io/release/${version}/bin/linux/${arch}/kubectl.sha256" \
  -o "${tmp_file}.sha256"

echo "$(cat "${tmp_file}.sha256")  ${tmp_file}" | sha256sum --check

sudo install -o root -g root -m 0755 "$tmp_file" /usr/local/bin/kubectl
rm -f "${tmp_file}.sha256"

kubectl version --client
