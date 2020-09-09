#!/usr/bin/env bash

declare WATCH_EXEC_VERSION="1.14.0"

# shellcheck disable=SC2016
echo 'export GPG_TTY=$(tty)' >>"$HOME/.profile"

# Download watch exec deb
wget "https://github.com/watchexec/watchexec/releases/download/${WATCH_EXEC_VERSION}/watchexec-${WATCH_EXEC_VERSION}-x86_64-unknown-linux-gnu.deb" -O "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

# Install watchexec
sudo apt install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

# Install vim and set it to be our editor
sudo apt install --yes vim
echo 'export EDITOR=vim' >>"$HOME/.profile"
