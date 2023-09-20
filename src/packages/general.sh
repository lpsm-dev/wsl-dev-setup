#!/usr/bin/env bash

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InstallCommonDependencies(){
  Status "👾 Install initial common dependencies"
  local dependencies="git curl figlet zsh tree fzf unzip s3cmd make awscli htop git-lfs"
  sudo apt install $dependencies -y
}

function InstallDevDependencies(){
  Status "👾 Install initial dev Dependencies"
  local dependencies="software-properties-common build-essential libssl-dev libffi-dev \
    apt-transport-https zlib1g-dev libreadline-dev libyaml-dev \
    libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libedit-dev"
  sudo apt install $dependencies
}

function InstallLab(){
  if ! [ -x "$(command -v lab)" ]; then
    Status "👾 Install Lab"
    curl -s https://raw.githubusercontent.com/zaquestion/lab/master/install.sh | sudo bash
  else
    Status "💀 Lab alredy installed... skipping"
  fi
}

function Install(){
  InstallLab
  Python
  Node
  Ruby
  Go
  Hashicorp
  K8S
  InstallZinit
}
