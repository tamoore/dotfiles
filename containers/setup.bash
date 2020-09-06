#!/usr/bin/env bash

# Install homebrew for some packages that use homebrew instead of apt or some
# other linux package manager
if [ ! -x "$(command -v brew)" ]; then
   echo -e "\u001b[33m==> Installing homebrew on linux\u001b[0m"
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "export GPG_TTY=$(tty)" >>/root/.profile
