#!/bin/bash

apps=(
  code
  dbeaver-ce
  gh
  goland
  helm
  kubectl
  kustomize
  node
  openjdk
  postman
  spotify
  telegram-desktop
  vlc
  whatsapp-for-linux
)

for i in "${!apps[@]}"; do
  snap install --classic "${apps[$i]}"
done
