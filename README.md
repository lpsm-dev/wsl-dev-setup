# wsl-dev-setup

💻 My personal environment setup in WSL2 (Ubuntu 20.4)

## Stack

* Ubuntu
* ZSH
* Git
* Node, Yarn, NVM
* Ruby, Renv
* GoLang
* OH MY ZSH + Zinit + Plugins + Themes

### Kraw Install

```
(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://storage.googleapis.com/krew/v0.2.1/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install \
    --manifest=krew.yaml --archive=krew.tar.gz
)

# Then append the following to your .zshrc or bashrc
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Then source your shell to pick up the path
source ~/.zshrc # or ~/.bashrc
```

* kubectl krew install ctx
* kubectl krew install ns

### YQ install

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64
sudo add-apt-repository ppa:rmescandon/yq
sudo apt update
sudo apt install yq -y
```
