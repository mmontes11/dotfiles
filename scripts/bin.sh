#!/bin/bash

source ./scripts/lib.sh

# yq
YQ_VERSION=v4.18.1
YQ_URL=https://github.com/mikefarah/yq/releases/download/$YQ_VERSION/yq_linux_amd64

install_bin yq $YQ_URL
