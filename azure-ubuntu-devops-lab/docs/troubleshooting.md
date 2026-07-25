# Troubleshooting

## Docker: permission denied em `/var/run/docker.sock`

Confirme se o usuário está no grupo:

```bash
groups
```

Adicione o usuário:

```bash
sudo usermod -aG docker "$USER"
```

Encerre completamente a sessão SSH/RDP e entre novamente. Como alternativa temporária:

```bash
newgrp docker
```

Teste:

```bash
docker run --rm hello-world
```

## xRDP conecta e fecha a sessão

Confirme o conteúdo:

```bash
cat /etc/xrdp/startwm.sh
```

Esperado:

```sh
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
exec startxfce4
```

Reinicie:

```bash
sudo systemctl restart xrdp
sudo systemctl status xrdp --no-pager
```

## Porta 3389 não responde

Na VM:

```bash
sudo ss -lntp | grep 3389
```

No Azure, confirme se o NSG permite TCP 3389 somente a partir do seu IP público.

## Firefox apresenta erro de Snap cgroup

Remova o Snap e execute novamente o script do Firefox:

```bash
sudo snap remove firefox
./scripts/03-install-firefox.sh
```

## AWS CLI informa sessão expirada

Para SSO:

```bash
aws sso login --profile NOME_DO_PROFILE
```

Confira os profiles:

```bash
aws configure list-profiles
```

## Ver logs do cloud-init

```bash
sudo cloud-init status --long
sudo less /var/log/cloud-init-output.log
sudo less /var/log/cloud-init.log
```

## Verificar serviços

```bash
sudo systemctl status xrdp --no-pager
sudo systemctl status docker --no-pager
```
