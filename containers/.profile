#!/usr/bin/env bash

declare -x EDITOR

if [[ $EDITOR != "vim" ]]; then
    EDITOR="vim"
fi

if [[ -f /etc/bash.bashrc ]]; then
    # shellcheck source=/dev/null
    . "/etc/bash.bashrc"
fi
