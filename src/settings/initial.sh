#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: Initial functions
## AUTHOR: Lucca Pessoa da Silva Matos
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InitialSetup () {
  echo "👾 Initial setup - update and upgrade system"
  sudo apt-get -y update
  sudo apt-get -y upgrade
  sudo apt-get -y dist-upgrade
  sudo apt-get -y clean
  sudo apt-get -y remove
  sudo apt-get -y autoremove
}

function CreateFolders(){
  echo "👾 Creating Folders"
  dirs=(
    "$HOME/.kube"
    "$HOME/.ssh"
    "$HOME/.config"
    "$HOME/go"
    "$HOME/study"
    "$HOME/playground"
    "$HOME/git/gitlab"
    "$HOME/git/github"
    "$HOME/git/work/nuageit"
    "$HOME/git/work/stefanini"
  )
  for dir in "${dirs[@]}"; do 
    if [[ -d "$dir" ]]; then
      echo "🚧 Directory $dir alredy exist"
    else 
      echo "📝 Create directory $dir" && mkdir -p "$dir"
    fi
  done
}

function CreateFiles(){
  echo "👾 Creating Files"
  files=(
    "$HOME/.gitconfig"
    "$HOME/.ssh/config"
    "$HOME/.config/aliasrc"
    "$HOME/.config/setup-bash"
    "$HOME/.config/setup-zsh"
    "$HOME/git/work/stefanini/.gitconfig"
  )
  for file in "${files[@]}"; do
    if [ -f "$file" ]; then
      echo "🚧 File $file alredy exist"
    else
      echo "📝 Create file $file" && touch $file
    fi
  done
}

function CreateSSHFiles(){
  echo "👾 Creating SSH Files"
  declare -A ssh
  ssh=(
    ["$HOME/.ssh/id_rsa_github"]="luccapessoamatos@gmail.com"
    ["$HOME/.ssh/id_rsa_gitlab"]="luccapsm@gmail.com"
    ["$HOME/.ssh/id_rsa_gitlab_stefanini"]="lpmatos@stefanini.com"
    ["$HOME/.ssh/id_rsa_gitlab_stfcia"]="lpmatos@stefanini.com"
  )
  for file in "${!ssh[@]}"; do
    if [ -f "$file" ]; then
      echo "🚧 SSH File $file alredy exist"
    else
      echo "📝 Create SSH file $file" && ssh-keygen -f $file -t rsa -b 4096 -C ${ssh[${file}]} -q -N ""
    fi
  done
}
