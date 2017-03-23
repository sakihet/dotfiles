## ENV
export TERM='xterm-256color'
export EDITOR=emacs
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

## coreutils
if [ -s $(brew --prefix coreutils) ]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

## rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

## pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

alias g=git
alias l='ls -lF --color'
alias la='ls -laF --color'
alias s=ssh
alias v=vim
alias x=exit
alias tm=tmux
alias tl='tmux list-sessions'
alias tn='tmux new -s' #tn <name>: create a session named <name>
alias ta='tmux attach -t' #ta <name>: attach to a session named <name>
alias tkill='tmux kill-session -t' #tkill <name>: kill a session named <name>
alias em='emacs -nw'
alias here='open .'
alias chrome='open -a google\ chrome'
alias firefox='open -a firefox'
alias safari='open -a safari'

## ui
stty stop undef # enable C-s

## prompt
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
function history-all { history -E 1 }
alias hag='history-all | grep'

## peco
function peco-src() {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${GOPATH}/src/${selected_dir}"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-src
stty -ixon
bindkey '^q' peco-src

function peco-select-history() {
    typeset tac
    if which tac > /dev/null; then
        tac=tac
    else
        tac='tail -r'
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-select-history
bindkey '^r' peco-select-history

source ~/.zshrc.local

# if (which zprof > /dev/null) ;then
#     zprof
# fi
