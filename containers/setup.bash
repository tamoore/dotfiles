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

    # Install oh my bash
    rm -rf ~/.oh-my-bash || true
    bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

    # Install watchexec
    apt-get install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

    # Install programs
    apt-get install -y vim stow git-extras shellcheck git bash-completion
}

configure_environment() {
    # Ensure that the dotfiles gitconfig is included
    git config --global include.path "$HOME/dotfiles/git/.gitconfig"

    # Copy profile to $HOME
    cp "$HOME/dotfiles/containers/.profile" "$HOME/"

    # Ensure that local is added
    stow -d "$HOME/dotfiles" .local

    # Add bashrc
    ln -sf "$HOME/dotfiles/bash/.oh-my-bash.rc" "$HOME/.bashrc"
}

main() {
    update_apt
    install_programs
    configure_environment
}

main "$@"
