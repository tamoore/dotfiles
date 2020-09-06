#!/usr/bin/env bash

declare WATCH_EXEC_VERSION="1.14.0"

# Install homebrew for some packages that use homebrew instead of apt or some
# other linux package manager
if [ ! -x "$(command -v brew)" ]; then
    echo -e "\u001b[33m==> Installing homebrew on linux\u001b[0m"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# shellcheck disable=SC2016
echo 'export GPG_TTY=$(tty)' >>"$HOME/.profile"
# shellcheck disable=SC2016
echo 'PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>"$HOME/.profile"

# Setup gpg to work with containers, although at the moment they don't actually
# work with them which will need to be looked at.
mkdir -p "$HOME/.gnupg"
echo 'pinentry-program /usr/bin/pinentry-tty' >"$HOME/.gnupg/gpg-agent.conf"

# Download watch exec deb
wget "https://github.com/watchexec/watchexec/releases/download/${WATCH_EXEC_VERSION}/watchexec-${WATCH_EXEC_VERSION}-x86_64-unknown-linux-gnu.deb" -O "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

# Install
sudo apt install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"
