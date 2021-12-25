#!/bin/bash

install_scripts=(
  "scripts/apt.sh"
  "scripts/snap.sh"
  "scripts/go.sh"
  "scripts/docker.sh"
  "scripts/kubernetes.sh"
  "scripts/tmux.sh"
)

for i in "${!install_scripts[@]}"; do
  source "${install_scripts[$i]}"
done
