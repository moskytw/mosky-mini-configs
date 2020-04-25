#!/bin/bash

# bash stuff

alias hi='history'

# text stream rocks!

alias h='head'
alias t='tail'
alias c='cut'
alias cds="cut -d' '"
alias cdc="cut -d:"
alias cdp="cut -d/"
alias s='sed'
alias sn='sed -n'
alias a='awk'
# if ends with a space, then the next word is also checked for alias expansion
alias x='xargs '
alias xi='xargs -I{} '

alias grep='grep --color=auto'

alias g='grep'
alias gf='g -F'
alias ge='g -E'
alias g80='ge -v ".{81,}"'
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

alias ga='g --color=always'
alias gfa='gf --color=always'
alias gea='ge --color=always'
alias gra='gr --color=always'

# file management

alias ls='ls --color=auto'
alias la='ls -A'  # will be expanded to `ls --color=auto -A`
alias l='ls -F'
alias ll='ls -aFh -l'

# grep-style find
fr() {
    find -L "${@:2}" \
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

if [[ -x $(command -v nvim) ]]; then
    alias vi='nvim -p'
    alias vim='nvim -p'
    alias view='nvim -R'
    alias vimdiff='nvim -d'
else
    alias vim='vim -p'
    alias vi='vim'
fi

# Git rocks!

# TODO: just use bash aliases instead of git aliases
alias st='git st'
alias di='git di'
alias diw='git diw'
alias dis='git dis'
alias ad='git ad'
alias adp='git adp'
alias dic='git dic'
alias dicw='git dicw'
alias dics='git dics'
alias ci='git ci'
alias cim='git cim'
alias sw='git sw'
alias sws='git ss'
alias lg='git lg'
alias lgau='git lgau'

alias br='git br'
alias bra='git bra'
alias bravv='git bravv'
alias co='git co'
alias cob='git cob'

alias amend='git amend'
alias unstage='git unstage'
alias uncommit='git uncommit'

# go git root
alias r='cd `git rev-parse --show-toplevel 2> /dev/null`'
