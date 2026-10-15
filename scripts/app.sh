#!/bin/bash

source ./scripts/lib.sh

ARCH=$(get_architecture)

# apt
pkgs=(
  default-jdk
  vlc
)

apt install -y "${pkgs[@]}"

# vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list >/dev/null

# slack (amd64 only)
wget -qO- https://packagecloud.io/slacktechnologies/slack/gpgkey | gpg --dearmor > /etc/apt/keyrings/slack-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/slack-archive-keyring.gpg] https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" | tee /etc/apt/sources.list.d/slack.list >/dev/null

# spotify (amd64 only)
curl -fsSL https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | gpg --dearmor --yes -o /etc/apt/keyrings/spotify.gpg
echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/spotify.gpg] https://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list >/dev/null

apt update
apt install -y code slack-desktop spotify-client

# dbeaver
DBEAVER_VERSION=$(curl -s https://dbeaver.io/files/ | grep -oE 'href="/files/[0-9]+\.[0-9]+\.[0-9]+/"' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
if [ "$ARCH" == "arm64" ]; then
  DBEAVER_ARCH=aarch64
else
  DBEAVER_ARCH=x86_64
fi
wget "https://dbeaver.io/files/${DBEAVER_VERSION}/dbeaver-ce-${DBEAVER_VERSION}-linux-${DBEAVER_ARCH}.deb"
apt install -y ./dbeaver-ce-${DBEAVER_VERSION}-linux-${DBEAVER_ARCH}.deb
rm dbeaver-ce-${DBEAVER_VERSION}-linux-${DBEAVER_ARCH}.deb

# discord (amd64 only)
wget -O discord.deb "https://discord.com/api/download?platform=linux"
apt install -y ./discord.deb
rm discord.deb

# github cli
GH_VERSION=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | jq -r .tag_name | tr -d v)
wget "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${ARCH}.deb"
apt install -y ./gh_${GH_VERSION}_linux_${ARCH}.deb
rm gh_${GH_VERSION}_linux_${ARCH}.deb

# goland
GOLAND_VERSION=$(curl -sIL "https://data.services.jetbrains.com/products/download?code=GO&platform=linux" | grep -ioE 'location: .*goland-[0-9]+(\.[0-9]+)+\.tar\.gz' | head -1 | sed 's/.*goland-//; s/\.tar\.gz//')
rm -rf /opt/goland-${GOLAND_VERSION}
curl -Lo goland.tar.gz "https://data.services.jetbrains.com/products/download?code=GO&platform=linux"
tar -C /opt -xzf goland.tar.gz
rm goland.tar.gz
ln -sf /opt/goland-${GOLAND_VERSION}/bin/goland.sh /usr/local/bin/goland

# postman
if [ "$ARCH" == "arm64" ]; then
  POSTMAN_URL=https://dl.pstmn.io/download/latest/linux_arm64
else
  POSTMAN_URL=https://dl.pstmn.io/download/latest/linux64
fi
wget -O postman.deb "$POSTMAN_URL"
apt install -y ./postman.deb
rm postman.deb

# telegram-desktop (x86_64 only)
wget -O telegram.tar.xz "https://telegram.org/dl/desktop/linux"
rm -rf /opt/Telegram
tar -C /opt -xf telegram.tar.xz
rm telegram.tar.xz
ln -sf /opt/Telegram/Telegram /usr/local/bin/telegram-desktop

# zoom (amd64 only)
wget https://zoom.us/client/latest/zoom_amd64.deb
apt install -y ./zoom_amd64.deb
rm zoom_amd64.deb
