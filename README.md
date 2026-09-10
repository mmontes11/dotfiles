# 🐧 dotfiles
Dotfiles and scripts to configure a brand new Ubuntu machine.

### Getting started

Setup dotfiles and install software:
``` bash
./dotfiles.sh
``` 

Install software only:
``` bash
sudo -u $USER bash install.sh
``` 

### Organization onboarding

Commit to an organization's repos with a dedicated git identity and clone them
with a dedicated SSH key, keeping them separate from the personal ones.

Provide these manually, where `<org>` is the SSH host alias of your choice: 

| File | Description |
| --- | --- |
| `~/.gitconfig.<org>` | git identity, see [.gitconfig.org](.gitconfig.org) |
| `~/.ssh/<org>` | SSH private key, added to the organization account |
| `~/.ssh/<org>.pub` | SSH public key |

Then set it up:
``` bash
./scripts/org.sh <org>
```

This adds the `<org>` host to `~/.ssh/config`, its host key to
`~/.ssh/known_hosts`, the identity to `~/.gitconfig`, fixes the key permissions
and verifies both SSH authentication and the resulting identity. It is safe to
re-run, and to run once per organization.

From then on, clone the organization repos through the alias:
``` bash
git clone git@<org>:<owner>/<repo>.git
```

The identity is selected by the remote URL rather than by the clone path, so it
applies wherever the repo is checked out. Selecting it by path would not cover
linked worktrees, whose `gitdir:` resolves to the real `.git` directory of the
main checkout instead of to the working tree.
