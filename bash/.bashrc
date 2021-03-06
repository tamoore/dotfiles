#!/usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

declare force_color_prompt

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Source fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;

esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f "$HOME/.bash_aliases" ]; then
    # shellcheck source=/dev/null
    . "$HOME/.bash_aliases"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        # shellcheck source=/usr/share/bash-completion/bash_completion
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        # shellcheck source=/etc/bash_completion
        . /etc/bash_completion
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ -f "$HOME/.secrets_env" ]]; then
    # shellcheck source=/dev/null
    . "$HOME/.secrets_env"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if [[ -d "$HOME/.bash_it" ]]; then
    if [[ -n "$BASH_IT" ]]; then
        # shellcheck source=/Users/toddmoore/.bash_it/bash_it.sh
        . "$BASH_IT"/bash_it.sh
    fi
fi

## output all the hotkeys for skhd
pskhd() {
    grep "##" -A 2  "$HOME/.config/skhd/skhdrc" | sed '/^--$/d'
}

## Auth 1password session
auth_1password() {
    eval $(op signin my)
}

## Attach a github token to the current session
attach_gh_token() {
    export ${1:-GITHUB_TOKEN}="$(op list items | jq -r '.[] | select(.overview.title=="Github PAT") | .uuid' | xargs -I {} op get item {} | jq -r '.details.password')"
}

## fd - cd to selected directory
fd() {
  local dir
  dir=$(find "$HOME/Projects" -name "${1}" -type d -print 2> /dev/null | head -n 1) &&
  cd "$dir"
}

## [K]ill [a]all [d]ocker [c]ontainers
kadc() {
    docker container ls -q | xargs -I {} docker container stop {}
    docker container prune -f
}

## Output all the bashrc commands
pcmds() {
  echo -e "==> My Commands \n"
  grep -A 1 "^##" "${BASH_SOURCE[${#BASH_SOURCE[@]}-1]}" | sed 's/{//' | colorize_output
}

## Reset Projects folder permissions
rsperms() {
    echo -e "==> Stopping all docker containers and removing them"
    kadc

    echo -e "==> Reseting $PROJECTS_DIR permissions"
    if [[ -n $PROJECTS_DIR ]]; then
        sudo chown -R "$USER:$USER" "$PROJECTS_DIR"
    fi
}

# mostly just for pcmds
colorize_output() {
	while read -r line; do
		echo "$line" |
			sed ''/\#\#/s//"$(printf "\033[32m>\033[0m")"/'' |
			sed ''/--/s///'' 
	done
}