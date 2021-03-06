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
    rm -rf ~/.oh-my-bash || true
    bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)" || true

    # Install watchexec
    apt-get install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

    # Install programs
    apt-get install -y vim stow git-extras shellcheck git bash-completion
}

configure_environment() {
    # Ensure that local is added
    stow -d "$HOME/dotfiles" -t "$HOME" .local
    stow -d "$DOTFILE_LOCATION" -t "$HOME" bash
    stow -d "$DOTFILE_LOCATION" -t "$HOME" containers
    stow -d "$DOTFILE_LOCATION" -t "$HOME" git
    stow -d "$DOTFILE_LOCATION" -t "$HOME" .local
    stow -d "$DOTFILE_LOCATION" -t "$HOME" .config
}

main() {
    update_apt
    install_programs
    configure_environment
}

main "$@"
