#!/usr/bin/env bash

declare -x EDITOR

if [[ $EDITOR != "vim" ]]; then
    EDITOR="vim"
fi

if [[ -n $CARGO_HOME ]]; then
    PATH="${CARGO_HOME}/bin:$PATH"
fi
