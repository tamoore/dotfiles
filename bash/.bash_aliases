#!/usr/bin/env bash
## ll='ls -alF'
## la='ls -A'
## l='ls -CF'
## g='git' 
# OSX ----
#O con="cd ~/Projects/99designs/contests || true"
#O prj="cd ~/Projects/99designs/projects || true"
#O nn="cd ~/Projects/99designs || true"
#O tam="cd ~/Projects/tamoore || true"
#O p="cd ~/Projects || true"

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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
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
    alias con="cd ~/Projects/99designs/contests || true"
    alias prj="cd ~/Projects/99designs/projects || true"
    alias nn="cd ~/Projects/99designs || true"
    alias tam="cd ~/Projects/tamoore || true"
    alias p="cd ~/Projects || true"
else
    true
fi