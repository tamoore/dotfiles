#!/usr/bin/env bash
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

GPG_TTY=$(tty)
EDITOR=nvim
SSH_ENV="$HOME/.ssh/agent-environment"
DOTFILE_LOCATION="$HOME/Projects/tamoore/dotfiles"
PROJECTS_DIR="$HOME/Projects/99designs"
DOCKER_BUILDKIT=1
COMPOSE_DOCKER_CLI_BUILD=1
DISPLAY="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0"
LIBGL_ALWAYS_INDIRECT=1
NNDEV_DIR="$HOME/Projects/99designs/99dev"
COMPOSE_PROJECT_NAME=99dev

export GPG_TTY
export EDITOR
export SSH_ENV
export DOTFILE_LOCATION
export PROJECTS_DIR
export DOCKER_BUILDKIT
export COMPOSE_DOCKER_CLI_BUILD
export DISPLAY
export NNDEV_DIR
export COMPOSE_PROJECT_NAME

# set DISPLAY variable to the IP automatically assigned to WSL2

if [[ -f "$HOME/.bash_common" ]]; then
    . "$HOME/.bash_common"
fi 

# Source bash git completions
if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
    . "/usr/local/etc/profile.d/bash_completion.sh"
fi

# set PATH to include linuxbrew
if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
    PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# Add 99dev to path
if [[ -d "$HOME/Projects/99designs/99dev/bin" ]]; then
    PATH="$NNDEV_DIR/bin:$PATH"
fi

# Ensure that brew vars are added to path
if [[ -d "/usr/local/bin" ]]; then 
    PATH="/usr/local/bin:$PATH"
fi

if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# NVM related initialisation
# 99designs uses nvm for node version swapping
if [[ -n "$NVM_DIR" ]]; then
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"                                       # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
fi
