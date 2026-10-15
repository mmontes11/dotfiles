#!/bin/bash

install_scripts=(
  "scripts/app.sh"
  "scripts/apt.sh"
  "scripts/bin.sh"
  "scripts/docker.sh"
  "scripts/go.sh"
  "scripts/kubernetes.sh"
  "scripts/nvm.sh"
  "scripts/tailscale.sh"
  "scripts/tmux.sh"
)

for i in "${!install_scripts[@]}"; do
  source "${install_scripts[$i]}"
done

# set zsh as default shell
chsh -s $(which zsh)
