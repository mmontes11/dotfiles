#!/bin/bash

K9S_VERSION=v0.25.15
KUBECTX_VERSION=v0.9.4
KIND_VERSION=v0.11.1

# k9s
K9S_SOURCE=k9s_Linux_x86_64.tar.gz
wget -q https://github.com/derailed/k9s/releases/download/$K9S_VERSION/$K9S_SOURCE
mkdir -p /tmp/k9s
tar -C /tmp/k9s -zxvf $K9S_SOURCE
chmod +x /tmp/k9s/k9s
mv /tmp/k9s/k9s /usr/local/bin/k9s
rm -rf /tmp/k9s $K9S_SOURCE

# kubectx + kubens
curl -Lo kubectx https://github.com/ahmetb/kubectx/releases/download/$KUBECTX_VERSION/kubectx
chmod +x kubectx
mv kubectx /usr/local/bin/kubectx

curl -Lo kubens https://github.com/ahmetb/kubectx/releases/download/$KUBECTX_VERSION/kubens
chmod +x kubens
mv kubens /usr/local/bin/kubens

# kind
curl -Lo kind https://kind.sigs.k8s.io/dl/$KIND_VERSION/kind-linux-amd64
chmod +x kind
mv kind /usr/local/bin/kind
