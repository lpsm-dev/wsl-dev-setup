#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: K8S functions
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 12.09.2020
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function InstallKubectl(){
  if ! [ -x "$(command -v kubectl)" ]; then
    Status "👾 Install Kubectl"
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update && sudo apt-get install -y kubectl < /dev/null
  else
    Status "💀 Kubectl alredy installed... skipping"
  fi
}

function InstallHelm(){
  if ! [ -x "$(command -v helm)" ]; then
    Status "👾 Install Helm 3"
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  else
    Status "💀 Helm 3 alredy installed... skipping"
  fi
}

function InstallKubeval(){
  if ! [ -x "$(command -v kubeval)" ]; then
    Status "👾 Install kubeval"
    wget -P /tmp https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
    sudo tar xf /tmp/kubeval-linux-amd64.tar.gz -C /usr/local/bin && sudo rm -rf /tmp/kubeval-linux-amd64.tar.gz
  else
    Status "💀 Kubeval alredy installed... skipping"
  fi
}

function InstallKrew(){
  if [ "$(kubectl krew version)" == "" ]; then
    Status "👾 Install krew"
    (
      set -x; cd "$(mktemp -d)" && curl -fsSLO "https://storage.googleapis.com/krew/v0.2.1/krew.{tar.gz,yaml}" &&
      tar zxvf krew.tar.gz && ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install --manifest=krew.yaml --archive=krew.tar.gz
    )
  else
    Status "💀 Krew alredy installed... skipping"
  fi
}

function K8S(){
  InstallKubectl
  InstallHelm
  InstallKubeval
  InstallKrew
}
