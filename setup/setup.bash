#!/usr/bin/env bash

declare PKG_INSTALLER
declare -a GNU_DEPS

[ -x "$(command -v brew)" ] && PKG_INSTALLER='brew'
[ -x "$(command -v apt)" ] && PKG_INSTALLER='apt'
[ ! -x "$(command -v stow)" ] && GNU_DEPS+=('stow')
[ ! -x "$(command -v git)" ] && GNU_DEPS+=('git')
[ ! -x "$(command -v shellcheck)" ] && GNU_DEPS+=('shellcheck')
[ ! -x "$(command -v socat)" ] && GNU_DEPS+=('socat')

echo "==> Deps to install: ${GNU_DEPS[*]}"
echo "==> Package installer: ${PKG_INSTALLER}"

# Update apt before install
sudo apt update -y

# Install deps that are required
for dep in "${GNU_DEPS[@]}"; do
  echo -e "\u001b[33m==> Install ${dep}\u001b[0m"
  sudo apt install -y "${dep}"
  echo -e "\u001b[32m==> Installed ${dep}\u001b[0m"
done

# Install homebrew for some packages that use homebrew instead of apt or some
# other linux package manager
if [ ! -x "$(command -v brew)" ]; then
  if [ "$(expr substr "$(uname -s)" 1 5)" == "Linux" ]; then
    echo -e "\u001b[33m==> Installing homebrew on linux\u001b[0m"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
fi
