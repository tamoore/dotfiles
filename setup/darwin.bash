#!/usr/bin/env bash
set -e

declare PKG_INSTALLER
declare -a GNU_DEPS
declare DOTFILE_LOCATION

DOTFILE_LOCATION=${DOTFILE_LOCATION:-"$HOME/.dotfiles"}
PKG_INSTALLER='brew'

[  !  -x  "$(command  -v  stow)"        ]  &&  GNU_DEPS+=('stow')
[  !  -x  "$(command  -v  git)"         ]  &&  GNU_DEPS+=('git')
[  !  -x  "$(command  -v  shellcheck)"  ]  &&  GNU_DEPS+=('shellcheck')
[  !  -x  "$(command  -v  socat)"       ]  &&  GNU_DEPS+=('socat')
[  !  -x  "$(command  -v  git-extras)"  ]  &&  GNU_DEPS+=('git-extras')
[  !  -x  "$(command  -v  nvim)"        ]  &&  GNU_DEPS+=('neovim')

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

if [[ ! -d "$DOTFILE_LOCATION" ]]; then
  ln -s "$PWD/../" "$HOME/.dotfiles"
fi

if [[ ! -d "$DOTFILE_LOCATION" ]]; then
  ln -s "$PWD/../" "$HOME/.dotfiles"
fi

if [[ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]]; then
  # Ensure vim plug is installed for neovim
  sh -c 'curl -fLo ' \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Stow packages into correct locations
stow -d "$DOTFILE_LOCATION" -t "$HOME" bash
stow -d "$DOTFILE_LOCATION" -t "$HOME" darwin
stow -d "$DOTFILE_LOCATION" -t "$HOME" git
stow -d "$DOTFILE_LOCATION" -t "$HOME" .local
stow -d "$DOTFILE_LOCATION" -t "$HOME" .config
