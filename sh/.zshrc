source $HOME/.profile

unsetopt BEEP

autoload -U colors && colors

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $HOME/.cache/zsh/zcompdump
_comp_options+=(globdots)

bindkey -v
export KEYTIMEOUT=1

# vim selection
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# ctrl + f launches tmux sessionizer
bindkey -s ^f "$HOME/.local/bin/tmux-sessionizer.sh\n"


autoload -Uz vcs_info
precmd() { 
	vcs_info 
}
setopt prompt_subst
zstyle ':vcs_info:*' enable git 
zstyle ':vcs_info:*' unstagedstr '[%F{red}%Bx%b%f]'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '∈%B%F{blue}%r/%b%f%%b%u %S'
PROMPT='%F{green}%n%f@%F{yellow}%M%f${vcs_info_msg_0_:- %~} %# '
RPROMPT='[%*]'
