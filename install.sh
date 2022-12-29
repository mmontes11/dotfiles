#!/bin/bash

install_scripts=(
  "scripts/apt.sh"
  "scripts/bin.sh"
  "scripts/docker.sh"
  "scripts/go.sh"
  "scripts/kubernetes.sh"
  "scripts/nvm.sh"
  "scripts/snap.sh"
  "scripts/tailscale.sh"
  "scripts/tmux.sh"
)

for i in "${!install_scripts[@]}"; do
  source "${install_scripts[$i]}"
done
