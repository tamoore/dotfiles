#!/usr/bin/env bash
set -e

declare WATCH_EXEC_VERSION="1.14.0"

update_apt() {
    # Update apt
    sudo apt -y update
}

install_programs() {
    # Download watch exec deb
    wget "https://github.com/watchexec/watchexec/releases/download/${WATCH_EXEC_VERSION}/watchexec-${WATCH_EXEC_VERSION}-x86_64-unknown-linux-gnu.deb" -O "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

    # Install watchexec
    sudo apt install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

    # Install vim
    sudo apt install -y vim

    # Install stow
    sudo apt install -y stow

    # Add git extras
    sudo apt install -y git-extras

    # Get shellcheck
    sudo apt install -y shellcheck
}

configure_environment() {
    # Ensure that the dotfiles gitconfig is included
    git config --global include.path "$HOME/dotfiles/git/.gitconfig"

    # Copy profile to $HOME
    cp "$HOME/dotfiles/containers/.profile" "$HOME/"

    # Ensure that local is added
    stow -d "$HOME/dotfiles" .local
}

main() {
    update_apt
    install_programs
    configure_environment
}

main "$@"
