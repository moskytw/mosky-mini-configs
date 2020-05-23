#!/bin/bash

if [[ -f "$HOME/.ssh/id_rsa" ]]; then

    # try to use `-K` (macOS's keychain) to add the key
    if ! ssh-add -l &> /dev/null; then
        # takes ~0.25 seconds
        ssh-add -K "$HOME/.ssh/id_rsa" &> /dev/null
    fi

    # use Linux's keychain if any
    if [[ -x "$(command -v keychain)" ]]; then
        keychain --quiet ~/.ssh/id_rsa
        . "$HOME/.keychain/$(hostname)-sh"
    fi

fi
