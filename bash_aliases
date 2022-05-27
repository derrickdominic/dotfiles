#!/usr/bin/env bash

# List files in `pwd` with permissions and human-readable sizes.
alias l="ls -hl"

# Open with default application.
open() {
  nohup xdg-open $1 > /dev/null 2>&1 &
}

# Emacs
alias ec="emacsclient -c -n"
alias et="emacsclient -t"
alias E='SUDO_EDITOR="emacsclient" sudo -e'
alias ET='SUDO_EDITOR="emacsclient -t" sudo -e'

# Clear terminal.
alias c="clear"

# Reload ~/.bashrc.
alias sb="source ~/.bashrc"

# Default editor
# export EDITOR="nano"
export EDITOR='emacsclient -t'
# export VISUAL='emacsclient -c -n'
