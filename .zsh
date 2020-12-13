#!/bin/bash

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
