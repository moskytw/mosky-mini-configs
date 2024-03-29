#!/bin/bash

# PS1

echo_ps1_git_branch_part() {
    local branch="$(git symbolic-ref --short HEAD 2> /dev/null)"
    if [[ -n "$branch" ]]; then
        echo " ($branch)"
    fi
}

# \[: begins a sequence of non-printing characters
# \]: ends a sequence of non-printing characters
# \w: the currency working directory
# \$: if the effective uid is 0, #, otherwise $
# `\e[0;33m`: fg yellow
# `\e[0m`: reset all
PS1="\[$HOST_ALIAS_COLOR\]$HOST_ALIAS\[\e[0m\] \w"\
"\[\e[0;33m\]"'$(echo_ps1_git_branch_part)'"\[\e[0m\] \\$ "

# \e: an escape character
# set xterm title, iterm will show it in title
PS1="\[\e]0;$HOST_ALIAS \w\a\]$PS1"

# macOS

if [[ "$(uname)" == "Darwin" ]]; then

    # for getting the notification from iTerm
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

    # for Homebrew
    PATH="/usr/local/sbin:$PATH"

    # consider `$ man sed` without `$ brew install gnu-sed`
    MANPATH="$(manpath):$MANPATH"

    # $ brew install grep
    PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

    # $ brew info coreutils
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

    # $ brew info findutils
    PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"

    # $ brew info gnu-sed
    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

    # https://apple.stackexchange.com/a/371998
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # make `tree` have colors
    export CLICOLOR=1

fi

# both macOS and Linux
if command -v pyenv &> /dev/null; then
    if [[ -n "$(pyenv --version 2> /dev/null | grep 'pyenv 1' -o)" ]]; then
        eval "$(pyenv init -)"
    else
        # https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv
        export PYENV_ROOT="$HOME/.pyenv"
        PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init --path)"
    fi
fi
PATH="$HOME/.poetry/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.bin:$PATH"
PYTHONPATH="$HOME/.pythonpath${PYTHONPATH:+:}$PYTHONPATH"
PYTHONIOENCODING='utf-8'
MYPYPATH="$PYTHONPATH"  # $ mypy
CLASSPATH="./build${CLASSPATH:+:}$CLASSPATH"

LC_ALL='en_US.UTF-8'
LANG="$LC_ALL"  # mute the warning of pipenv

TERM='xterm-256color'
EDITOR='vim'

FIGNORE='.pyc'
HISTSIZE=50000
HISTFILESIZE=50000

# make C-s work
stty -ixon
# enable `ls **` for bash >= 4
shopt -s globstar 2> /dev/null

# remove the trailing colon if any
PATH="${PATH%:}"
MANPATH="${MANPATH%:}"

# export to child processes

export PATH
export MANPATH
export PYTHONPATH
export PYTHONIOENCODING
export MYPYPATH
export CLASSPATH

export LC_ALL
export LANG
