###############################################################################
# ENV
###############################################################################
export TERM='xterm-256color'
export EDITOR=emacs
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SBT_OPTS="-Xms2048M -Xmx2048M"

###############################################################################
# coreutils
###############################################################################
# if [ -s $(brew --prefix coreutils) ]; then
#     PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#     MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# fi

###############################################################################
# asdf
###############################################################################
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

###############################################################################
# alias
###############################################################################
alias g=git
alias l='ls -lF --color'
alias la='ls -laF --color'
alias here='open .'

# browsers
alias chrome='open -a google\ chrome'
alias edge='open -a Microsoft\ Edge'
alias firefox='open -a firefox'
alias safari='open -a safari'

###############################################################################
# ui
###############################################################################
stty stop undef # enable C-s
setopt auto_cd
setopt auto_pushd # cd -<TAB>
setopt pushd_ignore_dups

###############################################################################
# prompt
###############################################################################
function git-names() {
    GIT_NAME=`git config user.name`
    GIT_EMAIL=`git config user.email`
}
function precmd_git_names() {
    git-names
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_git_names
autoload -Uz colors
colors
autoload -Uz vcs_info
zstyle ':vcs_info:' check-for-changes true
precmd () { vcs_info }
setopt prompt_subst
PROMPT='${fg[white]}  $GIT_NAME($GIT_EMAIL)@%m %~${vcs_info_msg_0_}
>%{${reset_color}%} '

###############################################################################
# history
###############################################################################
setopt extended_history
setopt share_history
setopt inc_append_history
HISTSIZE=100000 # on memory
SAVEHIST=100000 # on file
HISTFILE=~/.histfile
function history-all { history -E 1 }
alias hag='history-all | grep'

###############################################################################
# fzf
###############################################################################
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

function fzf-ghq-cd() {
    local repodir=$(ghq list | fzf -1 +m --layout=reverse)
    if [ -n "$repodir" ]; then
        BUFFER="cd $(ghq root)/$repodir"
        zle accept-line
    fi
    zle redisplay
}
zle -N fzf-ghq-cd
stty -ixon
bindkey '^q' fzf-ghq-cd

###############################################################################
# peco
###############################################################################
# function peco-branch () {
#     local branch=$(git branch -a | peco | tr -d ' ' | tr -d '*')
#     if [ -n "$branch" ]; then
#         if [ -n "$LBUFFER" ]; then
#             local new_left="${LBUFFER%\ } $branch"
#         else
#             local new_left="$branch"
#         fi
#         BUFFER="git checkout ${new_left}${RBUFFER}"
#         CURSOR=${#new_left}
#         zle accept-line
#     fi
#     zle redisplay
# }
# zle -N peco-branch
# bindkey '^xb' peco-branch

###############################################################################
# completions
###############################################################################
# fpath=(/usr/local/share/zsh-completions $fpath)
# autoload -Uz compinit
# compinit

###############################################################################
# misc
###############################################################################
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# if (which zprof > /dev/null) ;then
#     zprof
# fi
