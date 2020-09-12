#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: Ubuntu Setup
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 10.09.2020
## RUN:
##      > chmod +x ./setup.sh && bash setup.sh
# ==============================================================================

# This option will make the script exit when there is an error
set -o errexit
# This option will make the script exit when are unset variables
set -o nounset

# ==============================================================================
# VALUES
# ==============================================================================

# High Intensity
BLACK="\033[0;90m"       # Black
RED="\033[0;91m"         # Red
GREEN="\033[0;92m"       # Green
YELLOW="\033[0;93m"      # Yellow
BLUE="\033[0;94m"        # Blue
PURPLE="\033[0;95m"      # Purple
CYAN="\033[0;96m"        # Cyan
NC="\033[0;97m"          # White

VERSION="1.0.0"
START=$(date +%s)
OS=`uname`
[ "${OS}" = "Linux" ] && DATE_CMD="date" || DATE_CMD="gdate"
DATE_INFO=$(${DATE_CMD} +"%Y-%m-%d %T")
DATE_INFO_SHORT=$(${DATE_CMD} +"%A %B")
USER=$(whoami)

SUCESS=0
BAD=1
NODE_VERSION="v12.18.3"
RUBY_VERSION="2.7.1"
GOLANG_VERSION="1.15.2"

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function Status() {
  echo -e "\n[STATUS]: ${1}\n"
}

function Abort(){
  echo >&2 '
  ************************
  ***  ❌ ABORTED ❌  ***
  ************************
  '
  echo "An error has occurred - $1. Going out..." >&2
  exit ${BAD}
}

function Verify(){
  if [ $? -eq $SUCESS ]
  then
    Status "✅ Command executed with ${GREEN}success${NC}!"
  else
    Status "🚨 Return status not expected - Verify. Exit...${NC}" && Abort "General exception";
  fi
}

function Welcome() {
  echo -e "\n"
  echo "Setup Environment" | figlet
  echo -e "\n-------------------------------------------------"
  echo "* Welcome ${USER}! It's now ${DATE_INFO_SHORT}"
  echo -e "* ${DATE_INFO}"
  echo -e "* System - ${OS}"
  echo -e "*"
  echo -e "* Autor: ${YELLOW}Lucca Pessoa da Silva Matos${YELLOW}${NC}"
  echo -e "* Description: ${BLUE}This is my personal Ubuntu setup${BLUE}${NC}"
  echo -e "* Version: ${YELLOW}${VERSION}${YELLOW}${NC}"
  echo -e "-------------------------------------------------\n"
}

function InitialInstall(){
  Status "👾 Install initial dependencies"
  sudo apt install git curl figlet -y
}

function SetupGoLang(){
  if ! [ -x "$(command -v go)" ]; then
    Status "👾 Install Go"
    wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash
    source /home/lucca/.bashrc
  else
    Status "💀 Go alredy installed. Go Version: $(go version)... skipping"
  fi
}

function SetupNode(){
  if ! [ -d "$HOME/.nvm" ]; then
    Status "👾 Install Node Version Manager (NVM)"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  else
    Status "💀 NVM alredy installed... skipping"
  fi

  Status "👾 Config NVM"
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

  if [ $(node -v) == "v12.18.3" ]; then
    Status "💀 Node alredy installed. Node Version: $(node -v)... skipping"
  else
    Status "👾 Install Node $NODE_VERSION and NPM"
    nvm install $NODE_VERSION && nvm use $NODE_VERSION
  fi

  if ! [ -x "$(command -v yarn)" ]; then
    Status "👾 Install Yarn"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update
    sudo apt-get install yarn -y < /dev/null
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
  else
    Status "💀 Yarn alredy installed. Yarn Version: $(yarn -v)... skipping"
  fi
}

function SetupRuby(){
  if ! [ -x "$(which rbenv)" ]; then
    Status "👾 Install rbenv"
    sudo apt install rbenv -y
  else
    Status "💀 Rbenv alredy installed... skipping"
  fi

  if ! [ -x "$(which ruby-build)" ]; then
    Status "👾 Install ruby-build"
    sudo apt install ruby-build -y
  else
    Status "💀 Ruby-build alredy installed... skipping"
  fi

  if ! [ -x "$(which ruby)" ]; then
    Status "👾 Install ruby $RUBY_VERSION"
    rbenv install $RUBY_VERSION && rbenv global $RUBY_VERSION
  else
    Status "💀 Ruby alredy installed. Ruby Version: $(ruby -v)... skipping"
  fi
}

function SetupK8S(){
  if ! [ -x "$(command -v kubectl)" ]; then
    Status "👾 Install Helm 3"
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  else
    Status "💀 Helm 3 alredy installed... skipping"
  fi

  if ! [ -x "$(command -v kubectl)" ]; then
    Status "👾 Install Kubectl"
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl < /dev/null
  else
    Status "💀 Kubectl alredy installed... skipping"
  fi

  if ! [ -x "$(command -v kubeval)" ]; then
    Status "👾 Install K3D"
    curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
  else
    Status "💀 K3D alredy installed... skipping"
  fi

  if ! [ -x "$(command -v kubeval)" ]; then
    Status "👾 Install Kubeval"
    wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
    tar xf kubeval-linux-amd64.tar.gz && rm -rf kubeval-linux-amd64.tar.gz
    sudo mv kubeval /usr/local/bin
  else
    Status "💀 Kubeval alredy installed... skipping"
  fi

}

function CommonDependencies(){
  Status "👾 Install common dependencies"
  packages=" powerline fonts-powerline tree snapd fzf gnupg2 unzip s3cmd sqlite3 vim wget dconf-cli python3-pip fonts-firacode fontconfig mysql-client make"
  common="build-essential software-properties-common libssl-dev libffi-dev python3-dev apt-transport-https checkinstall zlib1g-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev"
  sudo apt install $packages $common -y

  SetupGoLang && SetupNode && SetupRuby && SetupK8S

  if ! [ -x "$(command -v zsh)" ]; then
    Status "👾 Install zsh"
    sudo apt install zsh -y
  else
    Status "💀 ZSH alredy installed... skipping"
  fi

  if [ ! -d ${HOME}/.oh-my-zsh ]; then
    Status "👾 Installing Oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
  else
    Status "💀 Oh-my-zsh already installed... skipping"
  fi

  if ! [ -x "$(command -v aws)" ]; then
    Status "👾 Install AWS CLI"
    sudo apt install awscli -y
  else
    Status "💀 AWS CLI alredy installed. AWS CLI Version: $(aws --version)... skipping"
  fi

  if ! [ -x "$(command -v terraform)" ]; then
    Status "👾 Install terraform"
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install terraform && terraform -install-autocomplete
  else
    Status "💀 Terraform alredy installed. Terraform Version: $(terraform -v)... skipping"
  fi

  if ! [ -x "$(command -v packer)" ]; then
    Status "👾 Install packer"
    sudo apt-get install packer
  else
    Status "💀 Packer alredy installed. Packer Version: $(packer -v)... skipping"
  fi

  if ! [ -x "$(command -v vault)" ]; then
    Status "👾 Install vault"
    sudo apt-get install vault
  else
    Status "💀 Vault alredy installed. Vault Version: $(vault -v)... skipping"
  fi
}

function OhMyZSHPlugins(){
  Status "👾 Config Oh My ZSH Plugins"
  declare -A repos_git_clone
  plugin_dir=$HOME/.oh-my-zsh/custom/plugins
  repos_git_clone=(
    ["zsh-autosuggestions"]="zsh-users/zsh-autosuggestions"
    ["zsh-syntax-highlighting"]="zsh-users/zsh-syntax-highlighting"
    ["fast-syntax-highlighting"]="zdharma/fast-syntax-highlighting"
    ["zsh-kubectl-prompt"]="superbrothers/zsh-kubectl-prompt"
  )
  for plugin in "${!repos_git_clone[@]}"; do
    if [ ! -d "$plugin_dir/$plugin" ]; then
      Status "👾 Plugin ${plugin} not exists, will clone it using git"
      git clone "https://github.com/${repos_git_clone[$plugin]}" "$plugin_dir/$plugin"
    else
      Status "💀 Plugin ${plugin} already exists, will skip it..."
    fi
  done

  sed -i "s/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-kubectl-prompt)/g" $HOME/.zshrc
  Status "👾 Given Permissions"
  sudo chmod 755 /home/lucca/.oh-my-zsh/custom/plugins/zsh*
}

function OhMyZSHThemes(){
  Status "👾 Config Oh My ZSH Themes"
  declare -A repos_git_clone
  plugin_dir=$HOME/.oh-my-zsh/custom/themes
  repos_git_clone=(
    ["powerlevel10k"]="romkatv/powerlevel10k"
  )
  for plugin in "${!repos_git_clone[@]}"; do
    if [ ! -d "$plugin_dir/$plugin" ]; then
      Status "👾 Theme ${plugin} not exists, will clone it using git"
      git clone "https://github.com/${repos_git_clone[$plugin]}" "$plugin_dir/$plugin"
    else
      Status "💀 Theme ${plugin} already exists, will skip it..."
    fi
  done
  sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
}

function Config(){

  # Use zsh as default shell
  Status "👾 Config ZSH"
  if [[ ! "$SHELL" =~ zsh ]]; then
    zsh_path="$( command -v zsh )"
    sudo chsh -s "$zsh_path" $USER
    Status "👾 Default shell changed to $zsh_path"
  fi

  OhMyZSHPlugins

  OhMyZSHThemes

  Status "💀 Remember exec: source /home/lucca/.zshrc and Set or kubeconfig for each cluster"

  Status "👾 Config Ruby"
  sudo gem install bundler rake yaml colorize OptionParser

  Status "👾 Config Python"

  sudo pip3 install GitLabRC

  Status "👾 Config Golang"

  if ! [ -x "$(command -v go)" ]; then
    Status "💀 Remember exec: source /home/lucca/.bashrc"
  else
    go get -u github.com/golang/lint/golint
    go get -u github.com/lpmatos/glabby
  fi
}

function Main(){
  Status "💀 My personal Ubuntu environment setup"
  CreateFolders
  CreateFiles
  InitialSetup
  InitialInstall
  Welcome
  CommonDependencies
  Config
}

# ==============================================================================
# MAIN
# ==============================================================================

Main

Verify
