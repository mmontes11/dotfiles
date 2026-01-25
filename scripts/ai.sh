#!/bin/bash

set -euo pipefail

echo "Installing uv..."
UV_VERSION=${UV_VERSION:-0.9.26}
curl -fsSL https://astral.sh/uv/${UV_VERSION}/install.sh | bash

echo "Installing claude..."
CLAUDE_VERSION=${CLAUDE_VERSION:-stable}
curl -fsSL https://claude.ai/install.sh | bash -s -- ${CLAUDE_VERSION}