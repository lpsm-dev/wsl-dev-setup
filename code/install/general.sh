#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: Install functions
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 12.09.2020
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InstallCommonDependencies(){
  Status "👾 Install initial common dependencies"
  local dependencies="git curl figlet zsh tree fzf unzip s3cmd make awscli htop"
  sudo apt install $dependencies -y
}

function InstallDevDependencies(){
  Status "👾 Install initial dev Dependencies"
  local dependencies="build-essential libssl-dev libffi-dev \
    apt-transport-https zlib1g-dev libreadline-dev libyaml-dev \
    libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libedit-dev"
  sudo apt install $dependencies
}

function Install(){
  Python
  Node
  Ruby
  Go
  Hashicorp
  K8S
  InstallZinit
}
