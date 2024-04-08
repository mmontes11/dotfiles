#!/bin/bash

set -euo pipefail

KUBE_SCRIPTS_VERSION=v0.0.15
curl -sfL https://raw.githubusercontent.com/mmontes11/k8s-scripts/$KUBE_SCRIPTS_VERSION/kubernetes.sh | bash -s -