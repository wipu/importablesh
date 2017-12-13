#!/bin/bash

set -eu

export IMPORTABLESH=$(readlink -f "$(dirname "$0")"/..)
. "$IMPORTABLESH/functions/import.sh"

import log
log "Starting as $(whoami): $0 $@"

SCRIPT=$(readlink -f "$1")
USER_TO_DROP_TO=${2:-}

import userconf-username

read-userconf-username

if [ "" == "$USER_TO_DROP_TO" ]; then
    log "Sourcing $SCRIPT as current user"
    . "$SCRIPT"
else
    log "Dropping privileges to $UNIX_USERNAME and rerunning"
    su - "$UNIX_USERNAME" -c "IMPORTABLESH_USERDIR='$IMPORTABLESH_USERDIR' '$0' '$SCRIPT'"
fi
