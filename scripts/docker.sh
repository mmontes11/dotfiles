#!/bin/bash

source ./scripts/lib.sh

USER_HOME=$(get_user_home)
COMPOSE_VERSION=v2.2.2

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor --batch --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

apt update
apt install docker-ce docker-ce-cli containerd.io -y

groupadd docker
usermod -aG docker $USER

# docker compose
mkdir -p $USER_HOME/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-linux-x86_64 -o $USER_HOME//.docker/cli-plugins/docker-compose
chmod +x $USER_HOME/.docker/cli-plugins/docker-compose
