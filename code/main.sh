#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: Ubuntu Setup Initial
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 10.09.2020
## RUN:
##      > chmod +x ./initial.sh && bash initial.sh
# ==============================================================================

# This option will make the script exit when there is an error
set -o errexit

# ==============================================================================
# VALUES
# ==============================================================================

# High Intensity
BLACK="\033[0;90m"       # Black
RED="\033[0;91m"         # Red
GREEN="\033[0;92m"       # Green
YELLOW="\033[0;93m"      # Yellow
BLUE="\033[0;94m"        # Blue
PURPLE="\033[0;95m"      # Purple
CYAN="\033[0;96m"        # Cyan
NC="\033[0;97m"          # White

VERSION="1.0.0"
START=$(date +%s)
OS=`uname`
[ "${OS}" = "Linux" ] && DATE_CMD="date" || DATE_CMD="gdate"
DATE_INFO=$(${DATE_CMD} +"%Y-%m-%d %T")
DATE_INFO_SHORT=$(${DATE_CMD} +"%A %B")
USER=$(whoami)

SUCESS=0
BAD=1

PYTHON_VERSION="3.8.2"
NVM_VERSION="0.35.3"
NODE_VERSION="12.18.3"
RUBY_VERSION="2.7.1"
GOLANG_VERSION="1.15.2"

source ./config/common.sh
source ./config/initial.sh
source ./packages/go.sh
source ./packages/hashicorp.sh
source ./packages/k8s.sh
source ./packages/node.sh
source ./packages/ruby.sh
source ./packages/ohmyzsh.sh
source ./packages/python.sh
source ./packages/general.sh

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function SetupSSH(){
  Status "👾 Setup SSH"
  eval $(ssh-agent)
  local files=(
    $HOME/.ssh/id_rsa_github
    $HOME/.ssh/id_rsa_gitlab
    $HOME/.ssh/id_rsa_gitlab_stefanini
    $HOME/.ssh/id_rsa_gitlab_stfcia
  )
  for file in "${files[@]}"; do
    Info "📝 SSH Add $file" && ssh-add $file
  done
  Info "📝 List SSH Add:" && ssh-add -l
}

function Main(){
  Status "👾 Home: $HOME"

  CheckShell

  InitialSetup

  CreateFolders
  CreateFiles
  CreateSSHFiles

  SetupSSH

  InstallCommonDependencies
  Welcome
  InstallDevDependencies
  Install

  SetupShell

  Verify
}

# ==============================================================================
# MAIN
# ==============================================================================

Main
