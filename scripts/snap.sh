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
  slack
  spotify
  telegram-desktop
  vlc
  whatsapp-for-linux
  zoom-client
)

for i in "${!apps[@]}"; do
  snap install --classic "${apps[$i]}"
done
