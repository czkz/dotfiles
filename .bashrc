# .bashrc

# If not running interactively or from vim, don't do anything
[[ $- != *i* ]] && [[ -z "$VIM" ]] && return
[[ -n "$VIM" ]] && shopt -s expand_aliases

# Config ───────────────────────────────────────────────────────────────────────

PATH=$HOME/.bin:$PATH

export VISUAL=vim
export EDITOR=$VISUAL
export MAKEFLAGS='-j4'

# Don't save duplicates and commands that start with spaces
export HISTCONTROL=ignoreboth

[ -z "$SSH_CONNECTION" ] && PS1_COMPACT="" # comment out to show "user@host"
PS1="${PS1_COMPACT-\[\033[38;5;5m\]\u@\h }"'\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;'"$([ $(whoami) = 'root' ] && echo 1 || echo 2)"'m\]\$\[$(tput sgr0)\] '
unset PS1_COMPACT

# Aliases ──────────────────────────────────────────────────────────────────────

alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'

alias gs='git status'
alias gl='git log'
alias gd='git diff'


[ "$XDG_CURRENT_DESKTOP" = "GNOME" ] && alias mpv='gnome-session-inhibit mpv'
alias mpa='mpv --no-video --ytdl-format=bestaudio'
function mpvs() { mpv "ytdl://ytsearch1:$*"; }
function mpas() { mpa "ytdl://ytsearch1:$*"; }

# sd DIR [CMD [ARGS]] - run CMD or bash with cwd=DIR
function sd() { (cd "$1" && shift && "${@:-bash}") }

# like sd, but into a temp dir (removed afterwards)
function sdtmp() { (d="$(mktemp -d)" && cd "$d" && { "${@:-bash}"; rm -rfv "$d"; } ) }

# `mkdir && cd` or `sdtmp`
function mkcd() { [ "$#" = 0 ] && sdtmp || mkdir "$1" && cd "$1"; }

# xargs with input from terminal
function bulk() { while printf '> ' && read; do $@ $REPLY; done; echo; }

# Void Linux package manager aliases
if [ ! -x /usr/bin/xi ]; then
    alias xi='sudo xbps-install -S'
    alias xrs='xbps-query -Rs'
    alias xls='xbps-query -Rf'
    alias xq='xbps-query -R'
    function xpkg() { xbps-query -ms '' | sed 's/-[^-]*$//'; }
fi
function xilogm() { xbps-query -p install-date -s '' | grep -Fwf <(xbps-query -m) | sed 's/-[^-]*: /;/' | sort -t\; -k2 | column -ts\;; }

# Dotfiles management ──────────────────────────────────────────────────────────

# See https://wiki.archlinux.org/title/Dotfiles#Tracking_dotfiles_directly_with_Git
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
if [ -r /usr/share/bash-completion/completions/git ]; then
    source /usr/share/bash-completion/completions/git
    __git_complete config __git_main
fi

# Cloning:
# git clone --bare <git-repo-url> $HOME/.dotfiles
# alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# config config status.showUntrackedFiles no
# cd && config checkout

# Colors ───────────────────────────────────────────────────────────────────────

alias ls='ls --color=auto -h --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias tree='CLICOLOR=1 tree'

export LESS=-R-S--incsearch
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Integrations ─────────────────────────────────────────────────────────────────

# Better Ctrl+R if fzf is installed
if command -v fzf &> /dev/null
then
    if [ -r /usr/share/fzf/completion.bash ]
    then # void
        source /usr/share/fzf/completion.bash
        source /usr/share/fzf/key-bindings.bash

    elif [ -r /usr/share/doc/fzf/examples/completion.bash ]
    then # debian
        source /usr/share/doc/fzf/examples/completion.bash
        source /usr/share/doc/fzf/examples/key-bindings.bash
    fi
    if type rg &> /dev/null; then
        export FZF_DEFAULT_COMMAND='rg --files'
    fi
fi

# Bash-completion for xtools
if [ -r /usr/share/bash-completion/completions/xbps ]
then
    . <(sed -E -e '/^\s*(\S+)\)/{
        s/xbps-install/\0 | xi/;
        s/xbps-query/\0 | xrs/;
        s/xbps-query/\0 | xq/;
        s/xbps-query/\0 | xls/;
        s/xbps-query/\0 | xgrep/;
        s/xbps-query/\0 | xmandoc/;
    }' /usr/share/bash-completion/completions/xbps)
    complete -F _xbps_complete xi xrs xq xls xgrep xmandoc
fi
