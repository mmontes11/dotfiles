# zsh
export ZSH="/Users/martin/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"

plugins=(
  docker
  docker-compose
  git
  golang
  helm
  iterm2
  kubectl
  node
  npm
  npx
  nvm
  osx
  tmux
)

source $ZSH/oh-my-zsh.sh

# pk10
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# env
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#docker
export DOCKER_USERNAME='mmontes11'

# go
export GOPATH="$HOME/go"
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# git
export GITPATH=/usr/local/git
export PATH=$PATH:$GITPATH/bin

# k8s
export KUBECONFIG="$HOME/.kube/config"

# nvm
export NVM_DIR="/Users/martin/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"                    # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# other
export EDITOR="vi"
