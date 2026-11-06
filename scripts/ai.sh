#!/bin/bash

set -euo pipefail

REPO_ROOT=$(dirname "$(dirname "$(realpath "$0")")")

echo "Installing uv..."
UV_VERSION=${UV_VERSION:-0.9.26}
curl -fsSL https://astral.sh/uv/${UV_VERSION}/install.sh | bash

echo "Installing opencode..."
# The installer is served per major version at /v<major>/install (e.g. /v2/install).
# /v1/install does not exist, so major < 2 uses the unversioned /install.
OPENCODE_VERSION=${OPENCODE_VERSION:-2.2.5}
major="${OPENCODE_VERSION%%.*}"
if [ "$major" -lt 2 ]; then
  install_url="https://opencode.ai/install"
else
  install_url="https://opencode.ai/v${major}/install"
fi
curl -fsSL "$install_url" | bash -s -- --version "${OPENCODE_VERSION}"

echo "Installing multica..."
MULTICA_VERSION=${MULTICA_VERSION:-0.8.0}
ARCH=$(dpkg --print-architecture | sed 's/aarch64/arm64/')
curl -fsSL "https://github.com/multica-ai/multica/releases/download/v${MULTICA_VERSION}/multica-cli-${MULTICA_VERSION}-linux-${ARCH}.tar.gz" -o /tmp/multica.tar.gz
tar -xzf /tmp/multica.tar.gz -C /tmp multica
mkdir -p ~/.local/bin
mv /tmp/multica ~/.local/bin/multica
rm /tmp/multica.tar.gz

echo "Configuring opencode..."
mkdir -p ~/.config/opencode
cp "$REPO_ROOT/opencode.json" ~/.config/opencode/opencode.json
