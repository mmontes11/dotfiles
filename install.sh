#!/bin/bash

# Command line tools
xcode-select --install

brew update
brew upgrade

brew tap vektra/tap

# Packages
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
    kind
    kubernetes-cli
    minikube
    mockery
    node
    nvm
    openssh
    sshfs
    tmux
    vim
    wget
    zsh
)

for i in "${!packages[@]}"; do
    package="${packages[$i]}"
    brew install "$package"
done

# Apps
apps=(
    dbeaver-community
    docker
    google-chrome
    iterm2
    menumeters
    mongodb-compass
    oracle-jdk
    osxfuse
    postman
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

# Oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"å
brew install romkatv/powerlevel10k/powerlevel10k
echo 'source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
