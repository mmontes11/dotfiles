#!/bin/bash

# yq
YQ_VERSION=v4.18.1
YQ_BINARY=yq_linux_amd64
wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY} -O /usr/bin/yq
chmod +x /usr/bin/yq
