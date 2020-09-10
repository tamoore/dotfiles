#!/usr/bin/env bash

declare WATCH_EXEC_VERSION="1.14.0"

# shellcheck disable=SC2016
echo 'export GPG_TTY=$(tty)' >>"$HOME/.profile"

# Update apt
sudo apt -y update

# Download watch exec deb
wget "https://github.com/watchexec/watchexec/releases/download/${WATCH_EXEC_VERSION}/watchexec-${WATCH_EXEC_VERSION}-x86_64-unknown-linux-gnu.deb" -O "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

# Install watchexec
sudo apt install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

# Install vim
sudo apt install -y vim

# Set it to be our main editor
echo 'export EDITOR=vim' >>"$HOME/.profile"

# Ensure that the dotfiles gitconfig is included
git config --global include.path "$HOME/dotfiles/git/.gitconfig"

# Disable signing however
git config -f "$HOME/dotfiles/git/.gitconfig" --unset commit.gpgsign

# Install stow
sudo apt install -y stow

# Setup gpg-agent
cd "$HOME/dotfiles" || exit
stow gnupg

cd "$HOME" || exit
