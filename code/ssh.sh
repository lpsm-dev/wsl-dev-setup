GITHUB_PASSWORD=""
GITLAB_TOKEN=""
GITLAB_STEFANINI_TOKEN=""
GITLAB_STFCIA_TOKEN=""

if ! [ -f $HOME/.ssh/id_rsa_github ]; then
  ssh-keygen -f $HOME/.ssh/id_rsa_github -t rsa -b 4096 -C "luccapessoamatos@gmail.com" -q -N ""
else
  echo "SSH to GitHub alredy exist"
fi

if ! [ -f $HOME/.ssh/id_rsa_gitlab ]; then
  ssh-keygen -f $HOME/.ssh/id_rsa_gitlab -t rsa -b 4096 -C "luccapsm@gmail.com" -q -N ""
else
  echo "SSH to GitLab alredy exist"
fi

if ! [ -f $HOME/.ssh/id_rsa_gitlab_stefanini ]; then
  ssh-keygen -f $HOME/.ssh/id_rsa_gitlab_stefanini -t rsa -b 4096 -C "lpmatos@stefanini.com" -q -N ""
else
  echo "SSH to GitLab Stefanini alredy exist"
fi

if ! [ -f $HOME/.ssh/id_rsa_gitlab_stfcia ]; then
  ssh-keygen -f $HOME/.ssh/id_rsa_gitlab_stfcia -t rsa -b 4096 -C "lpmatos@stefanini.com" -q -N ""
else
  echo "SSH to GitLab STFCIA alredy exist"
fi

eval $(ssh-agent)
ssh-add -D
ssh-add -l

ssh-add ~/.ssh/id_rsa_github  
ssh-add ~/.ssh/id_rsa_gitlab  
ssh-add ~/.ssh/id_rsa_gitlab_stefanini  
ssh-add ~/.ssh/id_rsa_gitlab_stfcia  

curl -u "lpmatos:$GITHUB_PASSWORD" --data "{\"title\": \"github\", \"key\": \"$(cat ~/.ssh/id_rsa_github.pub)\"}" https://api.github.com/user/keys
curl -d '{"title":"gitlab","key":"'"$(cat ~/.ssh/id_rsa_gitlab.pub)"'"}' -H "Content-Type: application/json" https://gitlab.com/api/v4/user/keys?private_token=$GITLAB_TOKEN
curl -d '{"title":"gitlab-stefanini","key":"'"$(cat ~/.ssh/id_rsa_gitlab_stefanini.pub)"'"}' -H "Content-Type: application/json" https://git.stefanini.io/api/v4/user/keys?private_token=$GITLAB_STEFANINI_TOKEN
curl -d '{"title":"gitlab-stfcia","key":"'"$(cat ~/.ssh/id_rsa_gitlab_stfcia.pub)"'"}' -H "Content-Type: application/json" https://git.stfcia.com.br/api/v4/user/keys?private_token=$GITLAB_STFCIA_TOKEN

ssh -T git@github.com
ssh -T git@gitlab.com
ssh -T git@git.stefanini.io
ssh -T git@git.stfcia.com.br
