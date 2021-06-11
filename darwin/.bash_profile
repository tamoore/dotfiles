#!/usr/bin/env bash
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

BASH_SILENCE_DEPRECATION_WARNING=1
GPG_TTY=$(tty)
EDITOR=nvim
NVM_DIR="$HOME/.nvm"
SSH_ENV="$HOME/.ssh/agent-environment"
DOCKER_UID=501
DOCKER_GID=20
COMPOSE_PROJECT_NAME=99dev
DNSMASQ_DOCKERVM_IP=127.0.0.1
DOTFILE_LOCATION="$HOME/.dotfiles"
PROJECTS_DIR="$HOME/Projects/99designs"
INTERNAL_DOCKER_HOST=host.docker.internal
MACHINE_DRIVER=amazonec2
DOCKER_BUILDKIT=1
COMPOSE_DOCKER_CLI_BUILD=1

export BASH_SILENCE_DEPRECATION_WARNING
export GPG_TTY
export EDITOR
export NVM_DIR
export SSH_ENV
export DOCKER_UID
export DOCKER_GID
export COMPOSE_PROJECT_NAME
export DNSMASQ_DOCKERVM_IP
export DOTFILE_LOCATION
export PROJECTS_DIR
export INTERNAL_DOCKER_HOST
export MACHINE_DRIVER
export DOCKER_BUILDKIT
export COMPOSE_DOCKER_CLI_BUILD

if [[ -f "$HOME/.bash_common" ]]; then
    # shellcheck source=/Users/toddmoore/.bash_common
    . "$HOME/.bash_common"
fi 

# source the ssh agent startup script
if [[ -f "$HOME/.agent.bash" ]]; then
    . "$HOME/.agent.bash"
fi 

# Source bash git completions
if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
    . "/usr/local/etc/profile.d/bash_completion.sh"
fi

# Add 99dev to path
if [[ -d "Projects/99designs/99dev/bin" ]]; then
    PATH="$NNDEV_DIR/bin:$PATH"
fi

# Ensure that brew vars are added to path
if [[ -d "/usr/local/bin" ]]; then 
    PATH="/usr/local/bin:$PATH"
fi

eval $(docker-machine env $(99dev machine-name))
