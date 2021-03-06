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
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    $HOME/.bash_it/install.sh --silent

    # Install watchexec
    apt-get install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

    # Install programs
    apt-get install -y vim stow git-extras shellcheck git bash-completion
}

configure_environment() {
    local home
    if [[ "$(whoami)" == "root" ]]; then
        home="/root"
    else 
        home="/home/$(whoami)"
    fi

    rm "$home/.bashrc"
    rm "$home/.bash_profile"
    stow -d "$home/dotfiles" -t "$home" .local
    stow -d "$home/dotfiles" -t "$home" bash
    stow -d "$home/dotfiles" -t "$home" containers
    stow -d "$home/dotfiles" -t "$home" git
    stow -d "$home/dotfiles" -t "$home" .local
    stow -d "$home/dotfiles" -t "$home" .config
}

main() {
    update_apt
    install_programs
    configure_environment
}

main "$@"
