#!/bin/bash

if [[ -f "$HOME/.ssh/id_rsa" ]]; then

    # if no added key
    if ! ssh-add -l &> /dev/null; then
        # try to use macOS's keychain to add
        # will take ~0.25 seconds
        ssh-add -K "$HOME/.ssh/id_rsa" &> /dev/null
    fi

    # use Linux's keychain if any
    if [[ -x "$(command -v keychain)" ]]; then
        keychain --quiet ~/.ssh/id_rsa
        . "$HOME/.keychain/$(hostname)-sh"
    fi

fi
