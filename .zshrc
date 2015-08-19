export TERM='xterm-256color'
export EDITOR=emacs

## coreutils
if [ -s $(brew --prefix coreutils) ]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

alias g=git
alias l='ls -al'
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

PROMPT='%n@%m %~ %# '
