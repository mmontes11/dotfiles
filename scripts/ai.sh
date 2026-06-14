#!/bin/bash

set -euo pipefail

echo "Installing uv..."
UV_VERSION=${UV_VERSION:-0.9.26}
curl -fsSL https://astral.sh/uv/${UV_VERSION}/install.sh | bash

echo "Installing opencode..."
OPENCODE_VERSION=${OPENCODE_VERSION:-1.2.4}
curl -fsSL  https://opencode.ai/install | VERSION=${OPENCODE_VERSION} bash