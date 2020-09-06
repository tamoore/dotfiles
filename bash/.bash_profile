#!/usr/bin/env bash
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

declare -x GPG_TTY

if [ -z "$GPG_TTY" ]; then
    GPG_TTY=$(tty)
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
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
