# WSL Install Packages

Lista com todos os pacotes utilizados por mim.

## General

#### NVM

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

## Kubernetes

#### Kubectl

```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

#### Helm

```bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

#### K3D

```bash
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
```

#### Krew

```bash
(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/')" &&
  "$KREW" install krew
)
```

## Languages

#### Golang

```bash
wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash
```

#### Node

```bash
NODE_VERSION="14.15.4"
nvm install $NODE_VERSION --lts=Fermium --latest-npm && nvm use $NODE_VERSION
```

## Git

#### GitHub CLI

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
```

#### Lab

```bash
curl -s https://raw.githubusercontent.com/zaquestion/lab/master/install.sh | sudo bash
```

## Security

#### Gitleaks

```bash
VER="7.2.0"
wget https://github.com/zricethezav/gitleaks/releases/download/v$VER/gitleaks-linux-amd64
mv gitleaks-linux-amd64 gitleaks
chmod +x gitleaks
sudo mv gitleaks /usr/local/bin/
```
