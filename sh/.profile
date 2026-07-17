#!/bin/sh
# Programmatic exports
export PYTHONSTARTUP=$HOME/.local/config/sh/pythonrc.py
export HTOPRC=$HOME/.local/config/htop/htoprc
export EDITOR="nvim"
export TERM="xterm-256color"
export PATH=$PATH:~/.local/bin:/usr/lib/emscripten:~/.cargo/bin:/opt/mssql-tools18/bin
alias vim='nvim'
alias ls='ls -lsrth --color'
alias tlmgr='tllocalmgr'
alias df='df -h'
alias z="zathura --config-dir=$HOME/.local/config/ --fork > /dev/null"
alias clanker="claude"

alias wslvpn="wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit start"
. "$HOME/.cargo/env"


export NVM_DIR="$HOME/.nvm"
nvm() { unset -f nvm node npm npx; . "$NVM_DIR/nvm.sh"; nvm "$@"; }
node() { unset -f nvm node npm npx; . "$NVM_DIR/nvm.sh"; node "$@"; }
npm() { unset -f nvm node npm npx; . "$NVM_DIR/nvm.sh"; npm "$@"; }
npx() { unset -f nvm node npm npx; . "$NVM_DIR/nvm.sh"; npx "$@"; }
#source ~/.env-extra
