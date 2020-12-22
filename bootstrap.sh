#!/bin/bash

git pull origin main

if [ "$1" == "--install" -o "$1" == "-i" ]; then
	. install.sh
fi

function syncDotfiles() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "install.sh" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		-avh --no-perms . ~

	for file in ~/.{zsh,exports,aliases}; do
		[ -r "$file" ] && [ -f "$file" ] && echo "source $file" >>~/.zshrc
	done
	unset file
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	syncDotfiles
else
	read -p "This may overwrite existing dotfiles in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		syncDotfiles
	fi
fi
unset syncDotfiles
