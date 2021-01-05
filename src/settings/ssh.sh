#!/usr/bin/env bash

# ==============================================================================
## DESCRIPTION: SSH functions
## AUTHOR: Lucca Pessoa da Silva Matos
# ==============================================================================

GITHUB_PASSWORD=""
GITLAB_TOKEN=""
GITLAB_STEFANINI_TOKEN=""
GITLAB_STFCIA_TOKEN=""

# ==============================================================================
# FUNCTIONS
# ==============================================================================

function GitHubSSH(){
  curl -u "$1:$2" --data "{\"title\": \"$3-$(date +'%m%d%Y')\", \"key\": \"$(cat ~/.ssh/$4.pub)\"}" https://api.github.com/user/keys
}

function GitLabSSH(){
  curl -d '{"title":"gitlab","key":"'"$(cat ~/.ssh/$1.pub)"'"}' -H "Content-Type: application/json" https://$2/api/v4/user/keys?private_token=$3
}

function TestSSH(){
  ssh -T git@$1
}

function Main(){
  GitHubSSH "lpmatos" $GITHUB_PASSWORD "github" "id_rsa_github"
  GitLabSSH "id_rsa_gitlab" "gitlab.com" $GITLAB_TOKEN
  GitLabSSH "id_rsa_gitlab_stefanini" "git.stefanini.io" $GITLAB_STEFANINI_TOKEN
  GitLabSSH "id_rsa_gitlab_stfcia" "git.stfcia.com.br" $GITLAB_STFCIA_TOKEN
}

