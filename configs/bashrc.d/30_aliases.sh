#!/bin/bash

# text stream rocks!

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
          --exclude-dir build \
          -s -n -H"

if [[ "$(uname)" == "Darwin" ]]; then
    alias zcat='gzcat'
fi

# file management

# make the behavior consistent between systems
alias file='file -h'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias ls='ls --color=auto'
alias l='ls -F'
alias la='ls -A'  # will be expanded to `ls --color=auto -A`
alias ll='ls -aFh -l'

# fn: from `find -name ...`, an easy version of the fd
fn() {
    find "${@:2}" \
         -not -path '*.pyc' \
         -not -path '*/__pycache__/*' \
         -not -path '*/.ipynb_checkpoints/*' \
         -not -path '*/.mypy_cache/*' \
         -not -path '*/.git/*' \
         -not -path '*/build/*' \
         -name "*$1*"
}

alias df='df -h'

alias du='du -h'
alias du0='du -d 0'
alias du1='du -d 1'

alias rsync='rsync -v -h --progress'

# handy highlighting

alias hl='highlight -s molokai -O xterm256'
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

# bash stuff

alias hi='history'

# Python rocks!

alias py2='python2'
alias ipy2='ipython2'
alias pym2='python2 -m'
alias pdb2='python2 -m pdb'
alias ipdb2='python2 -m ipdb'
alias pip2='pip2'
# \mypy to use original mypy
alias mypy2='\mypy -2 --ignore-missing-imports'

alias py3='python3'
alias pym3='python3 -m'
alias pdb3='python3 -m pdb'
alias ipdb3='python3 -m ipdb'
alias ipy3='ipython3'
alias pip3='pip3'
alias mypy3='\mypy --ignore-missing-imports'

alias py='python'
alias ipy='ipython'
alias pym='python -m'
alias pdb='python -m pdb'
alias ipdb='python -m ipdb'
alias pip='pip'
alias mypy='\mypy --ignore-missing-imports'

alias pyp='pipenv run python'
alias ipyp='pipenv run ipython'
alias pymp='pipenv run python -m'
alias pdbp='pipenv run python -m pdb'
alias ipdbp='pipenv run python -m ipdb'

# 79 is used by the standard library
# I do love single quotes in Python
alias black='black --line-length 79 --skip-string-normalization'

# Vim rocks!

alias vim='vim -p'
alias vi='vim'

# Git rocks!

alias gst='git status'
alias gdi='git diff'
alias gad='git add'
alias gadp='git add -p'
alias gdic='git diff --cached'
alias gdis='git diff --staged'
alias gci='git commit'
alias gcim='git commit -m'
alias gsw='git show'
alias glg='git log --oneline --decorate -10'

alias gbr='git branch'
alias gco='git checkout'
alias gcob='git checkout -b'

alias gamend='git commit --amend'
alias gunstage='git reset HEAD'
alias guncommit='git reset --soft HEAD^'
