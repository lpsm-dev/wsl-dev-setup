#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: Go functions
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 12.09.2020
# ==============================================================================

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
