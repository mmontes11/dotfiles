#!/bin/bash

TMUX_VERSION=3.2a

apt update

mkdir -p /tmp/tmux
cd /tmp/tmux

git clone https://github.com/tmux/tmux.git
cd tmux
git checkout $TMUX_VERSION

sh autogen.sh
./configure && make
make install

cd -
rm -rf /tmp/tmux
