#!/bin/bash

function configureOhMyZsh() {
  # powerlevel10k
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  # zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  # zsh-completions
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

  # zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

function configureDotfiles() {
  rsync --exclude ".git/" \
    --exclude "scripts/" \
    --exclude "*.sh" \
    --exclude "README.md" \
    --exclude "LICENSE" \
    -avh --no-perms . ~

  # oh-my-zsh
  configureOhMyZsh

  # tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

echo "Installing software..."
sudo -u $USER bash install.sh

echo "Configuring dotfiles..."
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  configureDotfiles
else
  read -p "This may overwrite existing dotfiles in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    configureDotfiles
  fi
fi

echo "Sourcing .zshrc..."
echo "source ~/.zshrc" >> ~/.bashrc

unset configureDotfiles
unset configureOhMyZsh
