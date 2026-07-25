#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

scripts=(
  "01-install-base.sh"
  "02-install-xfce-xrdp.sh"
  "03-install-firefox.sh"
  "04-install-google-chrome.sh"
  "05-install-vscode.sh"
  "06-install-dbeaver.sh"
  "07-install-docker.sh"
  "08-install-azure-cli.sh"
  "09-install-aws-cli.sh"
  "10-install-terraform.sh"
  "11-install-kubectl.sh"
  "12-install-helm.sh"
  "13-install-powershell.sh"
  "14-install-storage-explorer.sh"
)

echo "=================================================="
echo "   INSTALAÇÃO COMPLETA DO LABORATÓRIO DEVOPS"
echo "=================================================="

for script in "${scripts[@]}"; do
  echo
  echo "--------------------------------------------------"
  echo "Executando: ${script}"
  echo "--------------------------------------------------"
  bash "${SCRIPT_DIR}/${script}"
done

echo
echo "=================================================="
echo "Instalação concluída."
echo "Encerre a sessão e entre novamente para aplicar"
echo "a associação do usuário ao grupo docker."
echo
echo "Depois execute:"
echo "  ${SCRIPT_DIR}/check-lab.sh"
echo "=================================================="
