import log
import die
import userconf-username
import xterm-title

run-test() {
    local SCRIPT=$1
    local USER_TO_DROP_TO=${2:-}
    log
    log "============"
    log "Running test $SCRIPT"
    log "============"
    log
    xterm-title "Running test $SCRIPT"
    "$IMPORTABLESH/scripts/runtest.sh" "$SCRIPT" "$USER_TO_DROP_TO" && log "OK: $SCRIPT" || die "FAILURE: $SCRIPT"
}

run-test-as-user() {
    read-userconf-username
    run-test "$@" "$UNIX_USERNAME"
}

run-test-as-root() {
    run-test "$@"
}


test-start() {
    log ""
    log "Test starting: $@"
    log ""
}
