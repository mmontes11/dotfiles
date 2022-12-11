#!/bin/bash

set -euo pipefail

source ./scripts/lib.sh

USER_HOME=$(get_user_home)

curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list

apt update
apt install -y gcc libgtk-3-dev libayatana-appindicator3-dev tailscale

tailscale up
tailscale status