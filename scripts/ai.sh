#!/bin/bash

set -euo pipefail

echo "Installing uv..."
UV_VERSION=${UV_VERSION:-0.9.26}
curl -fsSL https://astral.sh/uv/${UV_VERSION}/install.sh | bash

echo "Installing ollama..."
OLLAMA_VERSION=${OLLAMA_VERSION:-0.15.1}
curl -fsSL https://ollama.com/install.sh | OLLAMA_VERSION=${OLLAMA_VERSION} bash

echo "Installing claude..."
CLAUDE_VERSION=${CLAUDE_VERSION:-2.1.7}
curl -fsSL https://claude.ai/install.sh | bash -s -- ${CLAUDE_VERSION}