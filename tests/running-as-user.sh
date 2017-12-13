import die
import log
import runtest

test-start "Asserting we are running as normal user"

log "whoami:"
whoami

is-root && die "Dropping root privileges didn't work!" || log "Ok, root privileges dropped, running as $USER"
