export TERM='xterm-256color'
export EDITOR=emacs

## coreutils
if [ -s $(brew --prefix coreutils) ]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

## rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias g=git
alias l='ls -lF --color'
alias la='ls -laF --color'
alias s=ssh
alias v=vim
alias x=exit
alias tm=tmux
alias tls='tmux list-sessions'
alias em=emacs
alias here='open .'
alias chrome='open -a google\ chrome'
alias firefox='open -a firefox'
alias safari='open -a safari'

autoload -Uz vcs_info
zstyle ':vcs_info:' check-for-changes true
precmd () { vcs_info }
setopt prompt_subst
PROMPT='%n@%m %~${vcs_info_msg_0_} %# '

## history
setopt extended_history
setopt share_history
setopt inc_append_history
HISTSIZE=100000 # on memory
SAVEHIST=100000 # on file
HISTFILE=~/.histfile
