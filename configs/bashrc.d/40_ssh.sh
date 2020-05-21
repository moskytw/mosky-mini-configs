#!/bin/bash

if [[ -f "$HOME/.ssh/id_rsa" ]] && ! ssh-add -l > /dev/null; then
    ssh-add
fi
