#!/bin/sh
# Programmatic exports
export PYTHONSTARTUP=$HOME/.local/config/sh/pythonrc.py
export HTOPRC=$HOME/.local/config/htop/htoprc

export TERM="xterm-256color"
export PATH=$PATH:~/.local/bin
alias vim='nvim'
alias ls='ls -lsrth --color'
alias tlmgr='tllocalmgr'
alias df='df -h'
alias z="zathura --config-dir=$HOME/.local/config/ --fork > /dev/null"
. "$HOME/.cargo/env"
alias wslvpn="wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit start"
