# Azure Ubuntu DevOps Lab

Este laboratório Ubuntu 24.04 foi criado no Azure preparado para estudos de Azure, AWS, Docker, Terraform e Kubernetes.
Toda a estrutura funciona em ubuntu, independente do vendor (AWS, Azure, OCI, GCP, on-promisses e etc). Importante conferir a documentação oficial de cada pacote de instalação.

## Estrutura

```text
azure-ubuntu-devops-lab/
├── README.md
├── LICENSE
├── .gitignore
├── scripts/
│   ├── 01-install-base.sh
│   ├── 02-install-xfce-xrdp.sh
│   ├── 03-install-firefox.sh
│   ├── 04-install-google-chrome.sh
│   ├── 05-install-vscode.sh
│   ├── 06-install-dbeaver.sh
│   ├── 07-install-docker.sh
│   ├── 08-install-azure-cli.sh
│   ├── 09-install-aws-cli.sh
│   ├── 10-install-terraform.sh
│   ├── 11-install-kubectl.sh
│   ├── 12-install-helm.sh
│   ├── 13-install-powershell.sh
│   ├── 14-install-storage-explorer.sh
│   ├── check-lab.sh
│   └── install-all.sh
├── cloud-init/
│   └── cloud-init.yaml
└── docs/
    └── troubleshooting.md
```

## Pré-requisitos

- Ubuntu Server 24.04 LTS
- Usuário com permissão `sudo`
- Acesso à internet
- Porta TCP 3389 liberada no NSG apenas para o seu IP público, caso utilize RDP

## Execução completa

```bash
git clone URL_DO_SEU_REPOSITORIO
cd azure-ubuntu-devops-lab
chmod +x scripts/*.sh
./scripts/install-all.sh
```

Após a instalação, encerre completamente a sessão SSH/RDP e entre novamente para aplicar o grupo `docker`.

## Execução individual

```bash
chmod +x scripts/07-install-docker.sh
./scripts/07-install-docker.sh
```

## Validar o ambiente

```bash
chmod +x scripts/check-lab.sh
./scripts/check-lab.sh
```

## Observações

- O script do xRDP configura o XFCE como desktop da sessão remota.
- O Firefox é instalado pelo repositório Mozilla Team, evitando o pacote Snap.
- O Azure Storage Explorer é instalado via Snap.
- O script completo não executa autenticação nas contas Azure ou AWS.
- Nunca publique chaves, senhas, arquivos `.pem`, secrets ou credenciais no GitHub.

## Testes manuais após a instalação

```bash
az login
aws configure
docker run --rm hello-world
terraform version
kubectl version --client
helm version
pwsh -Command '$PSVersionTable'
```

## **Autor:** Danilo Lima — Senior Tech Lead, Cloud & Infrastructure
