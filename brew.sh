#!/usr/bin/env bash

brew update
brew upgrade

brew tap vektra/tap

packages=(
    bash
    coreutils
    gh
    git
    git-delta
    go
    grep
    helm
    htop
    jq
    kubernetes-cli
    minikube
    mockery
    node
    nvm
    openssh
    tmux
    vim
    wget
    zsh
)

for i in "${!packages[@]}"; do
    package="${packages[$i]}"
    brew install "$package"
done

apps=(
    dbeaver-community
    docker
    google-chrome
    iterm2
    menumeters
    mongodb-compass
    oracle-jdk
    postman
    sequel-pro
    slack
    spotify
    telegram
    visual-studio-code
    vlc
    whatsapp
    zoomus
)

for i in "${!apps[@]}"; do
    app="${apps[$i]}"
    brew install --cask "$app"
done

brew cleanup