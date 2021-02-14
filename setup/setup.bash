#!/usr/bin/env bash
set -e

declare PKG_INSTALLER
declare -a GNU_DEPS
declare DOTFILE_LOCATION

# TODO: Totally need to refactor this to be a mac installer exclusively

DOTFILE_LOCATION="$HOME/Projects/src/github.com/tamoore/dotfiles"
PKG_INSTALLER='brew'
[ ! -x "$(command -v stow)" ] && GNU_DEPS+=('stow')
[ ! -x "$(command -v git)" ] && GNU_DEPS+=('git')
[ ! -x "$(command -v shellcheck)" ] && GNU_DEPS+=('shellcheck')
[ ! -x "$(command -v socat)" ] && GNU_DEPS+=('socat')
[ ! -x "$(command -v git-extras)" ] && GNU_DEPS+=('git-extras')
[ ! -x "$(command -v nvim)" ] && GNU_DEPS+=('neovim')

echo "==> Deps to install: ${GNU_DEPS[*]}"
echo "==> Package installer: ${PKG_INSTALLER}"

# Install deps that are required
for dep in "${GNU_DEPS[@]}"; do
  echo -e "==> Install ${dep}"
  "$PKG_INSTALLER" install "${dep}" || {
    echo "=> Failed to install ${dep}"
    exit 1
  }
  echo -e "==> Installed ${dep}"
done

# Ensure ssh folder exists
mkdir -p "$HOME/.ssh"

# Stow packages into correct locations
stow -d "$DOTFILE_LOCATION" -t "$HOME" bash
stow -d "$DOTFILE_LOCATION" -t "$HOME" git
stow -d "$DOTFILE_LOCATION" -t "$HOME" .local
stow -d "$DOTFILE_LOCATION" -t "$HOME" .config
