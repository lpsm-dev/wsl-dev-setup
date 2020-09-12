#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: SSH functions
## AUTHOR: Lucca Pessoa da Silva Matos
## DATE: 12.09.2020
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function GitHubSSH(){
  curl -u "$1:$2" --data "{\"title\": \"$3-$(date +'%m%d%Y')\", \"key\": \"$(cat ~/.ssh/$4.pub)\"}" https://api.github.com/user/keys
}

function GitLabSSH(){
  curl -d '{"title":"$1","key":"'"$(cat ~/.ssh/$2.pub)"'"}' -H "Content-Type: application/json" https://$3/api/v4/user/keys?private_token=$4
}

function TestSSH(){
  ssh -T git@$1
}

GITHUB_PASSWORD=""
GITLAB_TOKEN=""
GITLAB_STEFANINI_TOKEN=""
GITLAB_STFCIA_TOKEN=""

curl -u "lpmatos:5hRL23otL7v4" --data "{\"title\": \"github\", \"key\": \"$(cat ~/.ssh/id_rsa_github.pub)\"}" https://api.github.com/user/keys
curl -d '{"title":"gitlab","key":"'"$(cat ~/.ssh/id_rsa_gitlab.pub)"'"}' -H "Content-Type: application/json" https://gitlab.com/api/v4/user/keys?private_token=$GITLAB_TOKEN
curl -d '{"title":"gitlab-stefanini","key":"'"$(cat ~/.ssh/id_rsa_gitlab_stefanini.pub)"'"}' -H "Content-Type: application/json" https://git.stefanini.io/api/v4/user/keys?private_token=$GITLAB_STEFANINI_TOKEN
curl -d '{"title":"gitlab-stfcia","key":"'"$(cat ~/.ssh/id_rsa_gitlab_stfcia.pub)"'"}' -H "Content-Type: application/json" https://git.stfcia.com.br/api/v4/user/keys?private_token=$GITLAB_STFCIA_TOKEN
