#!/usr/bin/env bash
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

declare -x GPG_TTY

# Specifically for newer mac OS versions that are now using zsh as the default
# shell
declare -x BASH_SILENCE_DEPRECATION_WARNING
declare -x NNDEV_DOCKER_FOR_MAC
declare -x DOTFILE_LOCATION
declare -x EDITOR
declare -x NVM_DIR
declare -x BASTION_BACKEND_SPA
declare NNDEV_DIR
declare SSH_ENV

SSH_ENV="$HOME/.ssh/agent-environment"
GPG_TTY=$(tty)
BASH_SILENCE_DEPRECATION_WARNING=1
EDITOR=nvim
NNDEV_DOCKER_FOR_MAC=TRUE
DOTFILE_LOCATION="$HOME/Projects/tamoore/dotfiles"
NVM_DIR="$HOME/.nvm"
BASTION_BACKEND_SPA="http://host.docker.internal:3000"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        # shellcheck source=/dev/null
        . "$HOME/.bashrc"
    fi
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

# Starts an ssh agent on login of shell. Ensures that if the agent is already
# running that it does not open a second agent instance.
function start_agent() {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' >"${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    # shellcheck source=/dev/null
    . "${SSH_ENV}" >/dev/null
    /usr/bin/ssh-add
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    # shellcheck source=/dev/null
    . "${SSH_ENV}" >/dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep "${SSH_AGENT_PID}" | grep ssh-agent$ >/dev/null || {
        start_agent
    }
else
    start_agent
fi

# Add 99dev to path
if [[ -d "Projects/99designs/99dev/bin" ]]; then
    PATH="$NNDEV_DIR/bin:$PATH"
fi
