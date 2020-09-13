#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: Node functions
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 12.09.2020
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InstallNVM(){
  if [ -d "$HOME/.nvm" ]; then
    Status "👾 Force config NVM"
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  fi

  type nvm &> /dev/null

  if [ $? -eq 0 ]; then
    Status "💀 NVM alredy installed - Version $NVM_VERSION... skipping"
  else
    Status "👾 Install Node Version Manager (NVM) - Version $NVM_VERSION"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash
    Status "✨ Remember run: $ source ~/.bashrc && exec $SHELL"
    read -rn 1 -p "Do you want run source and exec? [y/N]: " CONDITIONAL
    if [[ $CONDITIONAL =~ ^([Yy])$ ]]; then
      Status "🚨 This action will create a new shell and this script will not complete"
      source ~/.bashrc && exec /bin/bash
    fi
    Status "👾 Config NVM"
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  fi
}

function InstallNode(){
  if ! [ -x "$(command -v node)" ]; then
    Info "📝 Check if NVM alredy installed"
    if ! [ -x "$(command -v nvm)" ]; then
      Status "👾 Install Node with NVM - Version $NODE_VERSION"
      nvm install $NODE_VERSION && nvm use $NODE_VERSION
    else
      Status "👾 Install Node LTS - Version 12.x"
      curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
      sudo apt-get install -y nodejs
    fi
  else
    Status "💀 Node alredy installed - Version $(node -v)... skipping"
  fi
}

function InstallYarn(){
  if ! [ -x "$(command -v yarn)" ]; then
    Status "👾 Install Yarn"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install --no-install-recommends yarn -y < /dev/null
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
  else
    Status "💀 Yarn alredy installed - Version $(yarn -v)... skipping"
  fi
}
