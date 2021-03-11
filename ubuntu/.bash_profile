#!/usr/bin/env bash
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

declare -x GPG_TTY=$(tty)
declare -x EDITOR=nvim
declare -x NVM_DIR="$HOME/.nvm"
declare -x SSH_ENV="$HOME/.ssh/agent-environment"
declare -x DOCKER_UID=501
declare -x DOCKER_GID=20
declare -x COMPOSE_PROJECT_NAME=99dev
declare -x DNSMASQ_DOCKERVM_IP=127.0.0.1
declare -x DOTFILE_LOCATION="$HOME/.dotfiles"
declare -x PROJECTS_DIR="$HOME/Projects/99designs"
declare -x INTERNAL_DOCKER_HOST=host.docker.internal
declare NNDEV_DIR="$HOME/Projects/99designs/99dev"

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

# NVM related initialisation
# 99designs uses nvm for node version swapping
if [[ -n "$NVM_DIR" ]]; then
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"                                       # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
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

if [[ -d "$HOME/.bash_it" ]]; then
    . "$HOME"/.bash_it/bash_it.sh
fi