#!/bin/bash

for file in ~/.{zsh,exports,aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
