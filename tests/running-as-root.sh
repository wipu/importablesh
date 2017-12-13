import userconf-username
import runtest

test-start "Asserting we are running as root"

log "whoami:"
whoami

require-root
