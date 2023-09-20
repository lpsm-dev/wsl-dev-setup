#!/usr/bin/env bash

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InstallOhMyZSH(){
  if [ ! -d ${HOME}/.oh-my-zsh ]; then
    Status "👾 Install Oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
  else
    Status "💀 Oh-my-zsh already installed... skipping"
  fi
}

function InstallZinit(){
  if ! [ -f "$HOME/.zinit/bin/zinit.zsh" ]; then
    Status "👾 Install Zinit"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  else
    Status "💀 Zinit alredy installed... skipping"
  fi
}
