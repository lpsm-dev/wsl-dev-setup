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
# This option will make the script exit when are unset variables
set -o nounset

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

SUCESS=0
BAD=1
CURRENT_DIR="$(dirname "$0")"

source $CURRENT_DIR/common.sh
source $CURRENT_DIR/initial.sh
source $CURRENT_DIR/install.sh

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function SetupSSH(){
  Status "👾 Setup SSH"
  eval $(ssh-agent)
  local files=(
    ~/.ssh/id_rsa_github
    ~/.ssh/id_rsa_gitlab
    ~/.ssh/id_rsa_gitlab_stefanini
    ~/.ssh/id_rsa_gitlab_stfcia
  )
  for file in "${files[@]}"; do
    Info "📝 SSH Add $file" && ssh-add $file
  done
  Info "📝 List SSH Add:" && ssh-add -l
}

function Main(){
  Status "👾 Home: $HOME"
  InitialSetup
  CreateFolders
  CreateFiles
  CreateSSHFiles
  SetupSSH
  InstallCommonDependencies
  InstallDevDependencies
  Verify
}

# ==============================================================================
# MAIN
# ==============================================================================

Main
