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

# Add .local/bin to the PATH
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="${HOME}/.local/bin:$PATH"
fi

# Add go path to PATH if it exists
if [[ -d "/usr/local/go/bin" ]]; then
    PATH="/usr/local/go/bin:$PATH"
fi

# Add local go path to PATH if it exists
if [[ -d "/go/bin" ]]; then
    PATH="/go/bin:$PATH"
fi

# Add npm-global if that path exists
if [[ -d "/usr/local/share/npm-global/bin" ]]; then
    PATH="/usr/local/share/npm-global/bin:$PATH"
fi
