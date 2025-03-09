#!/bin/bash

# repos
wget https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb
apt install ./synaptics-repository-keyring.deb
rm ./synaptics-repository-keyring.deb

apt update

pkgs=(
  apache2-utils
  arandr
  arping
  autojump
  automake
  bison
  build-essential
  byacc
  ca-certificates
  cmatrix
  conntrack
  curl
  displaylink-driver
  fzf
  g15daemon
  gawk
  git
  gnupg
  hollywood
  htop
  iftop
  iotop
  iperf3
  jq
  libevent-dev
  libncurses5-dev
  libvirt-daemon
  libvirt-daemon-system
  lsb-release
  net-tools
  network-manager
  nfs-common
  nload
  nmap
  openssh-server
  openssl
  pavucontrol
  pkg-config
  qemu-kvm
  qrencode
  rpi-imager
  sed
  snapd
  socat
  speedtest-cli
  sshfs
  systemd
  tcpdump
  traceroute
  vim
  wget
  xsel
  zsh
)

apt install -y "${pkgs[@]}"

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# git-delta
wget https://github.com/dandavison/delta/releases/download/0.11.3/git-delta_0.11.3_amd64.deb
apt install ./git-delta_0.11.3_amd64.deb
rm git-delta_0.11.3_amd64.deb

# set zsh as default shell
chsh -s $(which zsh)

apt autoremove -y
