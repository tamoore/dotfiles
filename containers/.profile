#!/usr/bin/env bash

declare -x EDITOR

if [[ $EDITOR != "vim" ]]; then
    EDITOR="vim"
fi

if [[ -n $CARGO_HOME ]]; then
    PATH="${CARGO_HOME}/bin:$PATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        # shellcheck source=/dev/null
        . "$HOME/.bashrc"
    fi
fi
