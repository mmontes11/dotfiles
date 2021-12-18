#!/bin/bash

apt update

pkgs=(
  automake
  bison
  build-essential
  byacc
  ca-certificates
  curl
  fzf
  git
  gnupg
  htop
  jq
  libevent-dev
  libncurses5-dev
  lsb-release
  pkg-config
  snapd
  vim
  wget
  zsh
)

for i in "${!pkgs[@]}"; do
  apt install "${pkgs[$i]}" -y
done

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# set zsh as default shell
chsh -s $(which zsh)

apt autoremove -y
