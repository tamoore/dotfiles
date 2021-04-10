#!/usr/bin/env bash

palias() {
  echo "==> Bash Aliases"
  grep "^##" "${BASH_SOURCE[${#BASH_SOURCE[@]}-1]}" | cut -c 4-
  if is_osx; then
    grep "^#O" "${BASH_SOURCE[${#BASH_SOURCE[@]}-1]}" | cut -c 4-
  fi
  echo ""
  echo "==> Git Aliases"
  git alias
}

function is_osx() {
    [[ -d /Users/toddmoore ]]
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
## ll='ls -alF'
alias ll='ls -alF'
## la='ls -A'
alias la='ls -A'
## l='ls -CF'
alias l='ls -CF'
## g='git' 
alias g='git'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi

if is_osx; then
#O con="cd ~/Projects/99designs/contests || true"
alias con="cd ~/Projects/99designs/vscode-dev-containers/github.com/99designs/contests || true"
#O nn="cd ~/Projects/99designs || true"
alias nn="cd ~/Projects/99designs || true"
#O tam="cd ~/Projects/tamoore || true"
alias tam="cd ~/Projects/tamoore || true"
#O vctm="cd ~/Projects/tamoore/vscode-dev-containers || true"
alias vctm="cd ~/Projects/tamoore/vscode-dev-containers || true"
#O prj="cd ~/Projects/99designs/projects || true"
alias prj="cd ~/Projects || true"
else
    true
fi