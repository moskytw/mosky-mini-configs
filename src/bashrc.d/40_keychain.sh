#!/bin/bash

# Linux's keychain if any

if [[ -x "$(command -v keychain)" ]] && [[ -f "$HOME/.ssh/id_rsa" ]]; then
    keychain --quiet ~/.ssh/id_rsa
    . "$HOME/.keychain/$(hostname)-sh"
fi
