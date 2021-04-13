#!/usr/bin/env bash
set -e

declare -xg OSH_THEME="brainy"
declare WATCH_EXEC_VERSION="1.14.0"
declare RIPGREP_VERSION="12.1.1"

update_apt() {
    # Update apt
    apt-get -y update
}

install_git_extras() {
    git clone https://github.com/tj/git-extras.git
    cd git-extras || true
    git checkout $(git describe --tags $(git rev-list --tags --max-count=1))
    make install
}

install_programs() {
    apt-get install wget

    # Download watch exec deb
    wget "https://github.com/watchexec/watchexec/releases/download/${WATCH_EXEC_VERSION}/watchexec-${WATCH_EXEC_VERSION}-x86_64-unknown-linux-gnu.deb" -O "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"
    wget "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep_${RIPGREP_VERSION}_amd64.deb" -O "$HOME/ripgrep-${RIPGREP_VERSION}.deb"

    # Remove oh my bash
    rm -rf $HOME/.bash_it
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    $HOME/.bash_it/install.sh -f --silent

    # Install watchexec
    apt-get install "$HOME/watchexec-${WATCH_EXEC_VERSION}.deb"

    # Install ripgrep
    apt-get install "$HOME/ripgrep-${RIPGREP_VERSION}.deb"

    # Install git extras
    install_git_extras

    # Install programs
    apt-get install -y neovim stow shellcheck git bash-completion parallel
}

configure_environment() {
    # Ensure that local is added
    rm "$HOME/.bashrc"
    stow -d "$HOME/dotfiles" -t "$HOME" containers
    stow -d "$HOME/dotfiles" -t "$HOME" bash
    stow -d "$HOME/dotfiles" -t "$HOME" git
    stow -d "$HOME/dotfiles" -t "$HOME" xdg

    # Ensure vim plug is installed for neovim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

configure_git() {
    git config core.hooksPath "$HOME/.githooks"
}

main() {
    update_apt || true
    install_programs || true
    configure_environment || true
    configure_git || true
}

main "$@"
