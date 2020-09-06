#!/usr/bin/env bash

# Install homebrew for some packages that use homebrew instead of apt or some
# other linux package manager
# if [ ! -x "$(command -v brew)" ]; then
#    echo -e "\u001b[33m==> Installing homebrew on linux\u001b[0m"
#    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# fi

# shellcheck disable=SC2016
echo 'export GPG_TTY=$(tty)' >>"$HOME/.profile"

mkdir -p "$HOME/.gnupg"
echo 'pinentry-program /home/linuxbrew/.linuxbrew/bin/pinentry-tty' >"$HOME/.gnupg/gpg-agent.conf"
