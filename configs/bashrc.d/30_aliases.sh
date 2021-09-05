#!/bin/bash

# bash stuff

alias hi='history'

# text stream rocks!

if [[ "$(uname)" == "Darwin" ]]; then
    alias zcat='gzcat'
fi

alias h='head'
alias t='tail'
alias c='cut'  # = cut -dTAB
alias s='sed'
alias a='awk'
# if ends with a space, then the next word is also checked for alias expansion
alias x='xargs '

alias grep='grep --color=auto'

alias g='grep'
# -s: silent
# -n: line number
# -H: filename
alias gr="g -R \
          --binary-files=without-match \
          --exclude-dir __pycache__ \
          --exclude-dir .ipynb_checkpoints \
          --exclude-dir .mypy_cache \
          --exclude-dir .git \
          -s -n -H"

# file management

alias ls='ls --color=auto'
alias la='ls -A'  # will be expanded to `ls --color=auto -A`
alias l='ls -F'
alias ll='ls -aFh -l'

# grep-style find
fr() {
    find -L \
         "${@:2}" \
         -not -path '*.pyc' \
         -not -path '*/__pycache__/*' \
         -not -path '*/.ipynb_checkpoints/*' \
         -not -path '*/.mypy_cache/*' \
         -not -path '*/.git/*' \
         -path "*$1*"
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias df='df -h'

alias du='du -h'
alias du0='du -d 0'
alias du1='du -d 1'

alias rsync='rsync -v -h --progress'

# make the behavior consistent between systems
alias file='file -h'

# handy highlighting

alias hl='highlight -s solarized-dark -O xterm256'
alias hls='hl -S'
alias hlpy='hl -S python'
alias hlhtml='hl -S html'
alias hljs='hl -S js'
alias hlcss='hl -S css'
alias hljson='hl -S json'
alias hldiff='hl -S diff'

alias vipy="vi +':set ft=python' -"
alias vihtml="vi +':set ft=html' -"
alias vijs="vi +':set ft=javascript' -"
alias vicss="vi +':set ft=css' -"
alias vijson="vi +':set ft=json' -"

# Python rocks!

alias py2='python2'
alias ipy2='ipython2'
alias pym2='python2 -m'
alias pdb2='python2 -m pdb'
alias ipdb2='python2 -m ipdb'
alias pip2='pip2'
alias mypy2='mypy -2'

alias py3='python3'
alias pym3='python3 -m'
alias pdb3='python3 -m pdb'
alias ipdb3='python3 -m ipdb'
alias ipy3='ipython3'
alias pip3='pip3'
alias mypy3='\mypy'  # use original mypy

alias py='python'
alias ipy='ipython'
alias pym='python -m'
alias pdb='python -m pdb'
alias ipdb='python -m ipdb'
alias pip='pip'
alias mypy='\mypy'  # use original mypy

alias pyp='pipenv run python'
alias ipyp='pipenv run ipython'
alias pymp='pipenv run python -m'
alias pdbp='pipenv run python -m pdb'
alias ipdbp='pipenv run python -m ipdb'

# Vim rocks!

alias vim='vim -p'
alias vi='vim'

# Git rocks!

alias gst='git status'
alias gdi='git diff'
alias gdiw='git diff --word-diff=color'
alias gdis='git diff --stat'
alias gad='git add'
alias gadp='git add -p'
alias gdic='git diff --cached'
alias gdicw='git diff --cached --word-diff=color'
alias gdics='git diff --cached --stat'
alias gci='git commit'
alias gcim='git commit -m'
alias gsw='git show'
alias gsws='git show --stat'
alias glg='git log --oneline --decorate -10'
alias glgau='git log --oneline --decorate -10 --author'

alias gbr='git branch'
alias gbra='git branch -a'
alias gbravv='git branch -avv'
alias gco='git checkout'
alias gcob='git checkout -b'

alias gamend='git commit --amend'
alias gunstage='git reset HEAD'
alias guncommit='git reset --soft HEAD^'
