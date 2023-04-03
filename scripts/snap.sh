#!/bin/bash

apps=(
  code
  dbeaver-ce
  gh
  goland
  node
  openjdk
  postman
  slack
  spotify
  telegram-desktop
  vlc
  zoom-client
)

for i in "${!apps[@]}"; do
  snap install --classic "${apps[$i]}"
done
