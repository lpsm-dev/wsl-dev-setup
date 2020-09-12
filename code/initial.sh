#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: Initial functions
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 12.09.2020
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InitialSetup () {
  Status "👾 Initial setup - update and upgrade system"
  sudo apt-get -y update
  sudo apt-get -y upgrade
  sudo apt-get -y dist-upgrade
  sudo apt-get -y clean
  sudo apt-get -y remove
  sudo apt-get -y autoremove
}

function CreateFolders(){
  Status "👾 Creating Folders"
  dirs=(
    "$HOME/gitlab"
    "$HOME/github"
    "$HOME/work/stefanini"
    "$HOME/work/stfcia"
    "$HOME/work/personal"
    "$HOME/study"
    "$HOME/playground"
    "$HOME/go"
    "$HOME/.kube"
    "$HOME/.ssh"
    "$HOME/.config"
  )
  for dir in "${dirs[@]}"; do Info "📝 Create folder $dir" && mkdir -p "$dir"; done
}

function CreateFiles(){
  Status "👾 Creating Files"
  local files=(
    "$HOME/.kube/config"
    "$HOME/.kube/config-aws-prod"
    "$HOME/.kube/config-aws-stage"
    "$HOME/.kube/config-aws-sandbox"
    "$HOME/.kube/config-aws-develop"
    "$HOME/.kube/config-aws-labs"
    "$HOME/.kube/config-cnb-prod"
    "$HOME/.kube/config-gcp-develop"
    "$HOME/.ssh/config"
    "$HOME/.gitconfig"
  )
  for file in "${files[@]}"; do
    [ -f "$file" ] && Info "🚧 File $file alredy exist"; continue || Info "📝 Create file $file"; touch $file
  done
}

function CreateSSHFiles(){
  Status "👾 Creating SSH Files"
  declare -A ssh
  ssh=(
    ["$HOME/.ssh/id_rsa_github"]="luccapessoamatos@gmail.com"
    ["$HOME/.ssh/id_rsa_gitlab"]="luccapsm@gmail.com"
    ["$HOME/.ssh/id_rsa_gitlab_stefanini"]="lpmatos@stefanini.com"
    ["$HOME/.ssh/id_rsa_gitlab_stfcia"]="lpmatos@stefanini.com"
  )
  for file in "${!ssh[@]}"; do
    [ -f "$file" ] && Info "🚧 SSH File $file alredy exist"; continue || Info "📝 Create SSH file $file"; ssh-keygen -f $file -t rsa -b 4096 -C ${ssh[${file}]} -q -N ""
  done
}
