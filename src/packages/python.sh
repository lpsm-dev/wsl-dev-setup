#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: Python functions
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 12.09.2020
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InstallPyenv(){
  type pyenv &> /dev/null

  if [ $? -eq 0 ]; then
    Status "💀 Pyenv alredy installed... skipping"
  else
    Status "👾 Install Pyenv"
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
  fi
}

function InstallPython(){
  if [[ `python --version` == "Python $PYTHON_VERSION" ]]; then
    Status "💀 Python alredy installed - Version $(python --version)... skipping"
  else
    Info "📝 Check if pyenv alredy installed"
    type pyenv &> /dev/null
    if [ $? -eq 0 ]; then
      Status "👾 Install Python with Pyenv - Version $PYTHON_VERSION"
      pyenv install $PYTHON_VERSION && pyenv global $PYTHON_VERSION
      Status "👾 Upgrade pip"
      pip install --upgrade pip
    else
      Status "🚨 Pyenv not installed" && exit $BAD
    fi
  fi
}

function Python(){
  InstallPyenv
  InstallPython
}
