#!/usr/bin/env bash

declare WATCH_EXEC_VERSION="1.14.0"

# Update apt
sudo apt -y update

# Download watch exec deb
wget "https://github.com/watchexec/watchexec/releases/download/${WATCH_EXEC_VERSION}/watchexec-${WATCH_EXEC_VERSION}-x86_64-unknown-linux-gnu.deb" -O "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

# Install watchexec
sudo apt install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

# Install vim
sudo apt install -y vim

# Ensure that the dotfiles gitconfig is included
git config --global include.path "$HOME/dotfiles/git/.gitconfig"

# Install stow
sudo apt install -y stow

# Copy profile to $HOME
cp "$HOME/dotfiles/containers/.profile" "$HOME/"

# Ensure that local is added
stow -d "$HOME/dotfiles/.local" -t "$HOME/.local"

# Add git extras
sudo apt install -y git-extras
