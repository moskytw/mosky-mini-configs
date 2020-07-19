#!/bin/bash

HOST_ALIAS='unknown'
HOST_ALIAS_COLOR='\e[0;31m'  # fg red

if [[ "$HOST_ALIAS" == 'unknown' ]] && [[ -f "$HOME/.host_alias" ]]; then
    HOST_ALIAS="$(cat $HOME/.host_alias)"
fi

if [[ "$HOST_ALIAS" == 'unknown' ]]; then
    HOST_ALIAS="$(hostname)"
fi

if [[ -f "$HOME/.host_alias_color_green" ]]; then
    HOST_ALIAS_COLOR='\e[0;32m'  # fg green
fi
