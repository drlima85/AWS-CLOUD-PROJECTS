#!/usr/bin/env bash

set +e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok=0
fail=0

check_command() {
  local name="$1"
  local command_name="$2"
  local version_command="$3"

  printf "%-28s" "$name"

  if command -v "$command_name" >/dev/null 2>&1; then
    echo -e "${GREEN}INSTALADO${NC}"
    eval "$version_command" 2>/dev/null | head -3
    ((ok++))
  else
    echo -e "${RED}NÃO INSTALADO${NC}"
    ((fail++))
  fi
  echo
}

echo "=================================================="
echo "        AZURE UBUNTU DEVOPS LAB - CHECK"
echo "=================================================="
echo
echo "Data:        $(date)"
echo "Hostname:    $(hostname)"
echo "Usuário:     $(whoami)"
echo "Sistema:     $(. /etc/os-release; echo "$PRETTY_NAME")"
echo "Kernel:      $(uname -r)"
echo "Arquitetura: $(uname -m)"
echo

echo "---------------- Serviços ----------------"
printf "%-28s" "xRDP"
if systemctl is-active --quiet xrdp; then
  echo -e "${GREEN}ATIVO${NC}"
  ((ok++))
else
  echo -e "${RED}INATIVO/NÃO INSTALADO${NC}"
  ((fail++))
fi

printf "%-28s" "Porta 3389"
if ss -lnt 2>/dev/null | grep -q ':3389'; then
  echo -e "${GREEN}LISTEN${NC}"
  ((ok++))
else
  echo -e "${RED}NÃO ESTÁ ESCUTANDO${NC}"
  ((fail++))
fi

printf "%-28s" "Docker daemon"
if systemctl is-active --quiet docker; then
  echo -e "${GREEN}ATIVO${NC}"
  ((ok++))
else
  echo -e "${RED}INATIVO/NÃO INSTALADO${NC}"
  ((fail++))
fi
echo

echo "---------------- Ferramentas ----------------"
check_command "Git" git "git --version"
check_command "Firefox" firefox "firefox --version"
check_command "Google Chrome" google-chrome "google-chrome --version"
check_command "VS Code" code "code --version"
check_command "DBeaver" dbeaver "dbeaver --version"
check_command "Docker" docker "docker --version"
check_command "Docker Compose" docker "docker compose version"
check_command "Azure CLI" az "az version"
check_command "AWS CLI" aws "aws --version"
check_command "Terraform" terraform "terraform version"
check_command "kubectl" kubectl "kubectl version --client"
check_command "Helm" helm "helm version"
check_command "PowerShell" pwsh "pwsh -NoLogo -NoProfile -Command '\$PSVersionTable.PSVersion'"

printf "%-28s" "Azure Storage Explorer"
if snap list storage-explorer >/dev/null 2>&1; then
  echo -e "${GREEN}INSTALADO${NC}"
  snap list storage-explorer
  ((ok++))
else
  echo -e "${RED}NÃO INSTALADO${NC}"
  ((fail++))
fi
echo

echo "---------------- Docker ----------------"
if command -v docker >/dev/null 2>&1; then
  if groups "$USER" | grep -qw docker; then
    echo -e "Grupo docker: ${GREEN}USUÁRIO ADICIONADO${NC}"
  else
    echo -e "Grupo docker: ${YELLOW}USUÁRIO NÃO ADICIONADO${NC}"
  fi

  if docker info >/dev/null 2>&1; then
    echo -e "Acesso ao daemon: ${GREEN}OK${NC}"
    if docker run --rm hello-world >/dev/null 2>&1; then
      echo -e "Container de teste: ${GREEN}OK${NC}"
      ((ok++))
    else
      echo -e "Container de teste: ${RED}FALHOU${NC}"
      ((fail++))
    fi
  else
    echo -e "Acesso ao daemon: ${RED}FALHOU${NC}"
    echo "Saia completamente da sessão e entre novamente."
    ((fail++))
  fi
fi
echo

echo "---------------- Recursos ----------------"
free -h
echo
df -h /
echo

echo "---------------- Rede ----------------"
if curl -fsS --max-time 10 https://www.google.com >/dev/null; then
  echo -e "Internet: ${GREEN}OK${NC}"
  ((ok++))
else
  echo -e "Internet: ${RED}FALHOU${NC}"
  ((fail++))
fi
echo

echo "=================================================="
echo -e "Sucessos: ${GREEN}${ok}${NC}"
echo -e "Falhas:   ${RED}${fail}${NC}"
echo "=================================================="

if (( fail > 0 )); then
  exit 1
fi
