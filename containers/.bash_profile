#!/usr/bin/env bash
declare -x EDITOR

if [[ -f "$HOME/.bash_common" ]]; then
    # shellcheck source=/Users/toddmoore/.bash_common
    . "$HOME/.bash_common"
fi 

# Set default editor
if [[ $EDITOR != "vim" ]]; then
    EDITOR="vim"
fi

# Rust cargs
if [[ -n $CARGO_HOME ]]; then
    PATH="${CARGO_HOME}/bin:$PATH"
fi

# Add .local/bin to the PATH
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="${HOME}/.local/bin:$PATH"
fi

# Add go path to PATH if it exists
if [[ -d "/usr/local/go/bin" ]]; then
    PATH="/usr/local/go/bin:$PATH"

    # Add gopath bin to PATH if exists
    if [[ -n $WORKSPACE_USER ]]; then
        PATH="/home/$WORKSPACE_USER/go/bin:$PATH"
    fi

    # Add local go path to PATH if it exists
    if [[ -d "/go/bin" ]]; then
        PATH="/go/bin:$PATH"
    fi
fi

# Add npm-global if that path exists
if [[ -d "/usr/local/share/npm-global/bin" ]]; then
    PATH="/usr/local/share/npm-global/bin:$PATH"
fi

# If the parameter $WORKSPACE_PATH has a lenght then set the node_modules
# bin directory to be included on the path
if [[ -n $WORKSPACE_PATH ]]; then
    if [[ -d "$WORKSPACE_PATH/node_modules/.bin" ]]; then
        PATH="$WORKSPACE_PATH/node_modules/.bin:$PATH"
    fi
fi