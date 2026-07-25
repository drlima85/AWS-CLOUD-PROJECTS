#!/usr/bin/env bash
set -Eeuo pipefail

echo "==> Instalando XFCE e xRDP..."

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  xfce4 \
  xfce4-goodies \
  xrdp \
  xorgxrdp \
  dbus-x11

echo "xfce4-session" > "${HOME}/.xsession"

sudo cp -n /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.bkp || true

sudo tee /etc/xrdp/startwm.sh >/dev/null <<'EOF'
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
exec startxfce4
EOF

sudo chmod +x /etc/xrdp/startwm.sh
sudo adduser xrdp ssl-cert || true
sudo systemctl enable xrdp
sudo systemctl restart xrdp

echo "==> Status do xRDP:"
sudo systemctl --no-pager --full status xrdp || true
sudo ss -lntp | grep ':3389' || true

echo "==> XFCE e xRDP configurados."
