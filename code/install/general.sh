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
  sudo apt install git curl figlet zsh tree fzf unzip s3cmd make -y
}

function InstallDevDependencies(){
  Status "👾 Install initial dev Dependencies"
  sudo apt install build-essential libssl-dev libffi-dev apt-transport-https zlib1g-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev -y
}

function Install(){
  InstallNVM
  InstallNode
  InstallYarn

  InstallRenv
  InstallRubyBuild
  InstallRuby

  InstallGo
}
