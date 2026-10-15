#!/bin/bash

source ./scripts/lib.sh

ARCH=$(get_architecture)

# jdk
apt install default-jdk

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

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

# zoom (amd64 only)
wget https://zoom.us/client/latest/zoom_amd64.deb
apt install -y ./zoom_amd64.deb
rm zoom_amd64.deb

# git-delta
wget https://github.com/dandavison/delta/releases/download/0.11.3/git-delta_0.11.3_amd64.deb
apt install ./git-delta_0.11.3_amd64.deb
rm git-delta_0.11.3_amd64.deb

# postman
rm -rf /opt/Postman
tar -C /tmp/ -xzf <(curl -L https://dl.pstmn.io/download/latest/linux64) && mv /tmp/Postman /opt/
tee /usr/share/applications/postman.desktop << END
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
END

# vlc with rstp support (apt does not have live555, snap does not work in Ubuntu 26.04)
# see: https://askubuntu.com/questions/1469388/upgraded-to-22-04-2-lts-now-vlc-cant-open-rtsp-stream
apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.videolan.VLC
tee /usr/share/applications/vlc.desktop << END
[Desktop Entry]
Encoding=UTF-8
Name=VLC
Comment=VLC
Exec=flatpak run org.videolan.VLC %U
Icon=Icon=org.videolan.VLC
Terminal=false
Type=Application
Categories=AudioVideo;Video;Player;
END

update-desktop-database /usr/share/applications 2>/dev/null || true
