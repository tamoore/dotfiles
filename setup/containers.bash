#!/usr/bin/env bash
set -e

declare -xg OSH_THEME="brainy"
declare WATCH_EXEC_VERSION="1.14.0"

update_apt() {
    # Update apt
    apt-get -y update
}

install_programs() {
    apt-get install wget

    # Download watch exec deb
    wget "https://github.com/watchexec/watchexec/releases/download/${WATCH_EXEC_VERSION}/watchexec-${WATCH_EXEC_VERSION}-x86_64-unknown-linux-gnu.deb" -O "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

    # Remove oh my bash
    rm -rf $HOME/.bash_it
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    $HOME/.bash_it/install.sh -f --silent

    # Install watchexec
    apt-get install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

    # Install programs
    apt-get install -y vim stow git-extras shellcheck git bash-completion
}

configure_environment() {
    # Ensure that local is added
    rm "$HOME/.bashrc"
    stow -d "$HOME/dotfiles" -t "$HOME" .local
    stow -d "$HOME/dotfiles" -t "$HOME" bash
    stow -d "$HOME/dotfiles" -t "$HOME" containers
    stow -d "$HOME/dotfiles" -t "$HOME" .local
    stow -d "$HOME/dotfiles" -t "$HOME" .config
}

main() {
    update_apt
    install_programs
    configure_environment
}

main "$@"
