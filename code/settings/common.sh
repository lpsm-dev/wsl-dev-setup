#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: Common functions
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 12.09.2020
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function Status() {
  echo -e "\n[STATUS]: ${1}\n"
}

function Info() {
  echo -e "[INFO]: ${1}"
}

function Abort(){
  echo >&2 '
  ************************
  ***  ❌ ABORTED ❌  ***
  ************************
  '
  echo "An error has occurred - $1. Going out..." >&2
  exit ${BAD}
}

function Verify(){
  if [ $? -eq $SUCESS ]
  then
    Status "✅ Command executed with ${GREEN}success${NC}!"
  else
    Status "🚨 Return status not expected - Verify. Exit...${NC}" && Abort "General exception";
  fi
}

function Welcome() {
  echo -e "\n"
  echo "Setup Environment" | figlet
  echo -e "\n-------------------------------------------------"
  echo "* Welcome ${USER}! It's now ${DATE_INFO_SHORT}"
  echo -e "* ${DATE_INFO}"
  echo -e "* System - ${OS}"
  echo -e "*"
  echo -e "* Autor: ${YELLOW}Lucca Pessoa da Silva Matos${YELLOW}${NC}"
  echo -e "* Description: ${BLUE}This is my personal Ubuntu setup${BLUE}${NC}"
  echo -e "* Version: ${YELLOW}${VERSION}${YELLOW}${NC}"
  echo -e "-------------------------------------------------\n"
}
