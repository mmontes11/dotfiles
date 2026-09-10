#!/bin/bash

set -euo pipefail

ORG=${1:-}

GITCONFIG=$HOME/.gitconfig
SSH_DIR=$HOME/.ssh
SSH_CONFIG=$SSH_DIR/config
SSH_CONFIG_TPL=$(dirname "$(dirname "$(realpath "$0")")")/.ssh/config.tpl

function usage() {
  echo "Usage: ./scripts/org.sh <org>"
  echo ""
  echo "Configures a per-organization git identity and SSH key, where '<org>' is"
  echo "the SSH host alias used to clone the organization repos."
  echo ""
  echo "Provide these manually beforehand:"
  echo "  ~/.gitconfig.<org>  git identity for the organization, see .gitconfig.org"
  echo "  ~/.ssh/<org>        SSH private key for the organization"
  echo "  ~/.ssh/<org>.pub    SSH public key for the organization"
}

function check_prerequisites() {
  local missing=0

  for file in "$GITCONFIG_ORG" "$SSH_KEY" "$SSH_KEY.pub"; do
    if [ ! -f "$file" ]; then
      echo "Missing '$file'"
      missing=1
    fi
  done

  if [ $missing -ne 0 ]; then
    echo ""
    usage
    exit 1
  fi

  if [ ! -f "$SSH_CONFIG_TPL" ]; then
    echo "Missing SSH config template '$SSH_CONFIG_TPL'"
    exit 1
  fi
}

# Appending to a file that does not end with a newline would otherwise
# concatenate onto its last line, silently corrupting it.
function ensure_trailing_newline() {
  local file=$1
  if [ -s "$file" ] && [ -n "$(tail -c1 "$file")" ]; then
    echo "" >>"$file"
  fi
}

function configure_ssh_key() {
  echo "Configuring SSH key '$SSH_KEY'..."
  chmod 700 "$SSH_DIR"
  chmod 600 "$SSH_KEY"
  chmod 644 "$SSH_KEY.pub"
}

function configure_ssh_config() {
  if [ -f "$SSH_CONFIG" ] && grep -qE "^Host[[:space:]]+$ORG$" "$SSH_CONFIG"; then
    echo "Host '$ORG' already in '$SSH_CONFIG', skipping"
    return
  fi

  echo "Adding host '$ORG' to '$SSH_CONFIG'..."
  touch "$SSH_CONFIG"
  ensure_trailing_newline "$SSH_CONFIG"
  sed "s/\borg\b/$ORG/g" "$SSH_CONFIG_TPL" >>"$SSH_CONFIG"
  ensure_trailing_newline "$SSH_CONFIG"
  chmod 600 "$SSH_CONFIG"
}

function get_hostname() {
  awk -v org="$ORG" '
    tolower($1) == "host" { block = ($2 == org) }
    block && tolower($1) == "hostname" { print $2; exit }
  ' "$SSH_CONFIG"
}

function configure_known_hosts() {
  local hostname
  hostname=$(get_hostname)

  if [ -z "$hostname" ]; then
    echo "No HostName for host '$ORG' in '$SSH_CONFIG', skipping known hosts"
    return
  fi

  if ssh-keygen -F "$hostname" >/dev/null 2>&1; then
    echo "Host key for '$hostname' already known, skipping"
    return
  fi

  echo "Adding host key for '$hostname' to '$SSH_DIR/known_hosts'..."
  if ! ssh-keyscan -H "$hostname" >>"$SSH_DIR/known_hosts" 2>/dev/null; then
    echo "Could not fetch the host key for '$hostname', skipping"
  fi
  chmod 600 "$SSH_DIR/known_hosts"
}

function configure_gitconfig() {
  if grep -qF "path = .gitconfig.$ORG" "$GITCONFIG"; then
    echo "Identity '.gitconfig.$ORG' already in '$GITCONFIG', skipping"
    return
  fi

  echo "Adding identity '.gitconfig.$ORG' to '$GITCONFIG'..."
  ensure_trailing_newline "$GITCONFIG"
  cat >>"$GITCONFIG" <<EOF
[includeIf "hasconfig:remote.*.url:git@$ORG:*/*"]
path = .gitconfig.$ORG
EOF
}

function verify() {
  echo "Verifying SSH authentication for '$ORG'..."
  if ssh -o BatchMode=yes -T "git@$ORG" 2>&1 | grep -q "successfully authenticated"; then
    echo "SSH authentication succeeded"
  else
    echo "SSH authentication failed, is '$SSH_KEY.pub' added to the organization account?"
  fi

  echo "Verifying git identity for '$ORG'..."
  local dir origin
  dir=$(mktemp -d)
  git -C "$dir" init -q 2>/dev/null
  git -C "$dir" remote add origin "git@$ORG:$ORG/verify.git"
  origin=$(git -C "$dir" config --show-origin --get user.email | cut -f1)
  if [ "$origin" == "file:$GITCONFIG_ORG" ]; then
    echo "Repos cloned from 'git@$ORG:' commit as $(git -C "$dir" config --get user.email)"
  else
    echo "Identity resolved from '$origin' instead of '$GITCONFIG_ORG'"
  fi
  rm -rf "$dir"
}

if [ -z "$ORG" ]; then
  usage
  exit 1
fi

GITCONFIG_ORG=$HOME/.gitconfig.$ORG
SSH_KEY=$SSH_DIR/$ORG

check_prerequisites
configure_ssh_key
configure_ssh_config
configure_known_hosts
configure_gitconfig
verify

echo ""
echo "Done. Clone the organization repos as 'git@$ORG:<owner>/<repo>.git'"
