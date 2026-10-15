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
  gh
  git
  gnupg
  graphviz
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
  linux-modules-evdi-oem-26.04
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
  qrencode
  rpi-imager
  sed
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

apt autoremove -y
