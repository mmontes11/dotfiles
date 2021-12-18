#!/bin/bash

set -e

function configureDotfiles() {
  rsync --exclude ".git/" \
    --exclude "scripts/" \
    --exclude "*.sh" \
    --exclude "README.md" \
    --exclude "LICENSE" \
    -avh --no-perms . ~

  # oh my zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  # tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  configureDotfiles
else
  read -p "This may overwrite existing dotfiles in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    configureDotfiles
  fi
fi
unset configureDotfiles
