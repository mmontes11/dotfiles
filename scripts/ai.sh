#!/bin/bash

set -euo pipefail

echo "Installing uv..."
UV_VERSION=${UV_VERSION:-0.9.26}
curl -fsSL https://astral.sh/uv/${UV_VERSION}/install.sh | bash

echo "Installing ollama..."
OLLAMA_VERSION=${OLLAMA_VERSION:-0.16.1}
curl -fsSL https://ollama.com/install.sh | OLLAMA_VERSION=${OLLAMA_VERSION} bash

echo "Installing opencode..."
OPENCODE_VERSION=${CLAUDE_VERSION:-1.2.4}
curl -fsSL  https://opencode.ai/install | VERSION=${OPENCODE_VERSION} bash