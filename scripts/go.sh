#!/bin/bash

GO_VERSION=1.20
GO_SOURCE=go$GO_VERSION.linux-amd64.tar.gz

wget https://go.dev/dl/$GO_SOURCE

rm -rf /usr/local/go

tar -C /usr/local -xzf $GO_SOURCE

rm $GO_SOURCE
