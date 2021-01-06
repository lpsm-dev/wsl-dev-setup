# WSL Install Packages

## General

### Common

```bash
apt install curl figlet tree fzf unzip s3cmd make htop git-lfs -y
```

### Dev

```bash
apt software-properties-common build-essential libssl-dev libffi-dev \
    apt-transport-https zlib1g-dev libreadline-dev libyaml-dev \
    libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libedit-dev -y
```

## Terminal

### ZSH

```bash
apt install zsh
chsh -s $(which zsh)
```

#### Oh My ZSH

```bash
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
fi
```

#### Zinit

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
```

## Lint

### Shellcheck

```bash
apt-get install shellcheck
```

### Yaml

```bash
sudo apt-get install yamllint
```

## Security

### Gitleaks

```bash
VER="7.2.0"
wget https://github.com/zricethezav/gitleaks/releases/download/v$VER/gitleaks-linux-amd64
mv gitleaks-linux-amd64 gitleaks
chmod +x gitleaks
sudo mv gitleaks /usr/local/bin/
```

## Kubernetes

### Kubectl

```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

### Helm

```bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

### K3D

```bash
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
```

### Krew

```bash
(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/')" &&
  "$KREW" install krew
)
```

### Kind

```bash
wget https://github.com/kubernetes-sigs/kind/releases/download/v0.9.0/kind-linux-amd64
mv kind-linux-amd64 kind
chmod +x ./kind
mv ./kind /usr/local/bin
```

### Kubeval

```bash
wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
tar xf kubeval-linux-amd64.tar.gz
sudo mv kubeval /usr/local/bin
```

## Languages

### Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/en
```

### Golang

```bash
wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash
```

### Node

```bash
NODE_VERSION="14.15.4"
nvm install $NODE_VERSION --lts=Fermium --latest-npm && nvm use $NODE_VERSION
```

#### Nvm

```bash
VER="0.37.2"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$VER/install.sh | bash
```

#### Yarn

```bash
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install --no-install-recommends yarn -y < /dev/null
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
```

### Python

```bash
pyenv install -v 3.9.1 && pyenv global 3.9.1
```

#### Pyenv

```bash
curl https://pyenv.run | bash
```

### Ruby

```bash
RUBY_VERSION="3.0.0"
rvm install $RUBY_VERSION && rvm use $RUBY_VERSION
```

#### Rmv

```bash
curl -sSL https://get.rvm.io | bash
source /etc/profile.d/rvm.sh
```

## Git

```bash
apt install git
```

### GitHub CLI

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
```

### Lab

```bash
curl -s https://raw.githubusercontent.com/zaquestion/lab/master/install.sh | sudo bash
```

## Cloud

### Azure CLI

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### Google CLI

```bash
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk -y
```

### AWS CLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf ./aws
rm -rf ./awscliv2.zip
```

## Database

### MSSQL

```bash
pip install mssql-cli
```
