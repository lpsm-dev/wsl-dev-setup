#!/usr/bin/env bash

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InstallGo(){
  if ! [ -x "$(command -v go)" ]; then
    Status "👾 Install Go"
    wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash
    Status "✨ Remember run: $ source ~/.bashrc && exec $SHELL"
    read -rn 1 -p "Do you want run source and exec? [y/N]: " CONDITIONAL
    if [[ $CONDITIONAL =~ ^([Yy])$ ]]; then
      Status "🚨 This action will create a new shell and this script will not complete"
      source ~/.bashrc && exec /bin/bash
    fi
  else
    Status "💀 Go alredy installed - Version: $(go version)... skipping"
  fi
}

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InstallGitLeaks(){
  if ! [ -x "$(command -v gitleaks)" ]; then
    Status "👾 Install GitLeaks"
    GO111MODULE=on go get github.com/zricethezav/gitleaks/v6
  else
    Status "💀 GitLeaks alredy installed... skipping"
  fi
}

function Go(){
  InstallGo
  InstallGitLeaks
}
