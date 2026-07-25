#!/usr/bin/env bash
set -Eeuo pipefail

if command -v helm >/dev/null 2>&1; then
  echo "==> Helm já está instalado."
  helm version
  exit 0
fi

tmp_script="$(mktemp)"
trap 'rm -f "$tmp_script"' EXIT

curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
  -o "$tmp_script"

chmod 700 "$tmp_script"
"$tmp_script"

helm version
