#!/usr/bin/env bash
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

declare -x GPG_TTY

# Specifically for newer mac OS versions that are now using zsh as the default
# shell
declare -x BASH_SILENCE_DEPRECATION_WARNING
declare -x DOTFILE_LOCATION
declare -x EDITOR
declare -x NNDEV_DOCKER_FOR_MAC
declare -x NVM_DIR
declare -x SSH_ENV
declare -x BASTION_BACKEND_SPA
declare -x PROJECTS_DIR
declare NNDEV_DIR

SSH_ENV="$HOME/.ssh/agent-environment"
GPG_TTY=$(tty)
BASH_SILENCE_DEPRECATION_WARNING=1
EDITOR=nvim
NNDEV_DOCKER_FOR_MAC=TRUE
DOTFILE_LOCATION="$HOME/Projects/tamoore/dotfiles"
NVM_DIR="$HOME/.nvm"
BASTION_BACKEND_SPA="http://host.docker.internal:3000"
PROJECTS_DIR="$HOME/Projects/99designs"

# if running bash
if [[ -n "$BASH_VERSION" ]]; then
    # include .bashrc if it exists
    if [[ -f "$HOME/.bashrc" ]]; then
        # shellcheck source=/dev/null
        . "$HOME/.bashrc"
    fi

    # Source oh-my-bash
    if [[ -f "$HOME/.oh-my-bash.rc" ]]; then
        . "$HOME/.oh-my-bash.rc"
    fi
fi

# Source bash git completions
if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
    . "/usr/local/etc/profile.d/bash_completion.sh"
fi

if [[ -f "$HOME/.secrets_env" ]]; then
    # shellcheck source=/dev/null
    . "$HOME/.secrets_env"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH to include linuxbrew
if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
    PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# Add 99dev to path
if [[ -d "Projects/99designs/99dev/bin" ]]; then
    PATH="$NNDEV_DIR/bin:$PATH"
fi

# Ensure that brew vars are added to path
if [[ -d "/usr/local/bin" ]]; then 
    PATH="/usr/local/bin:$PATH"
fi
